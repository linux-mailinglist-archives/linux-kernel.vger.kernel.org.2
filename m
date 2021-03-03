Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415B632BD01
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359817AbhCCPO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:14:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241117AbhCCK1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:27:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E402164EE1;
        Wed,  3 Mar 2021 09:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614762597;
        bh=rKzQViVrLLM19qCh+ONNHy/Oc+g0iNNTWOurFX2lbRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1IXpJQOnfIK9q+KHPeVPXtBrzKMVOQlB+wYpdid+B3vrLVuSL0an9+eFh6aA5Dh/l
         Xpuk53Fx+aEU5TKSb/ad0qMLX/1W/FlqE3nVJL3wtfhEHpW6eFgjav0Q8+z0jipVeb
         8xF12EplSBIFay0t2kUI5UyWb1J/TWhxYOiDmVUo=
Date:   Wed, 3 Mar 2021 10:09:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chien Kun Niu <rickyniu@google.com>
Cc:     stern@rowland.harvard.edu, erosca@de.adit-jv.com,
        gustavoars@kernel.org, a.darwish@linutronix.de, oneukum@suse.com,
        Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Wei <jameswei@google.com>
Subject: Re: [PATCH] ANDROID: usb: core: Send uevent when USB TOPO layer over
 6
Message-ID: <YD9SYklmQq5amDA7@kroah.com>
References: <20210226091612.508639-1-rickyniu@google.com>
 <YDi/+TN6AYXropf7@kroah.com>
 <CADRPvQubTEjKeJc=+LQ2jb0L=N4mxY8n21Bf8U-tS1stpB_eGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADRPvQubTEjKeJc=+LQ2jb0L=N4mxY8n21Bf8U-tS1stpB_eGw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 05:03:25PM +0800, Chien Kun Niu wrote:
> Hi , Greg
> 
> What tool will "catch" this?  Where is that code located at?
> => I prepare merge the code to Android phone , so I used Android HLOS
> to catch this uevent.

Very odd quoting style, perhaps you might want to read up on how to do
this properly at:
	https://en.wikipedia.org/wiki/Posting_style#Interleaved_style

> uevents are not for stuff like this, you are trying to send "error
> conditions" to userspace, please use the "proper" interfaces like this
> and not abuse existing ones.
> => Sorry , I am not sure what is the "proper" interfaces your mean.
>      Could you please give me more description?

How does the kernel normally send error conditions that it detects in
hardware to userspace?

> You just created a whole new sysfs class with no Documentation/ABI/
> update?
> => Yes, I will add it.
> 
> Wait, how did you even test this code?  This will not work if you have
> more than one hub in the system at a single time, right?
> => I build the test build which flash in Android phone and connect
> several hubs to try it.
>      When the new hub which met MAX_TOPO_LEVEL connected , it sent
> notify to user space.
> 
> Phone ------↓
>                  hub ------↓
>                              hub ------↓
>                                            ...------↓
>                                                     hub
> 
>      if (hdev->level == MAX_TOPO_LEVEL) {
>                 dev_err(&intf->dev,
>                         "Unsupported bus topology: hub nested too deep\n");
>                 hub_over_tier();
>                 return -E2BIG;
>      }
> 

But you only have a single hub variable, and a huge memory leak, did you
not detect that in your testing?

> So, proof that this works?  How did you test this?
> => I use the Pixel phone to verify the code , the framework received
> the uevent when the last connected hub over "MAX_TOPO_LEVEL".

Try it on a desktop as well, with many hubs and see what happens :(

> Also, you have a memory leak in this submission :(
> => Do you mean I should add device_destroy here ?

What do you think should be done?

> 
> hub_device =
> device_create(hub_class, NULL, MKDEV(0, 0), NULL, "usb_hub");
> +if (IS_ERR(hub_device))
> +               return PTR_ERR(hub_device);
> 
> void usb_hub_cleanup(void)
> {
> +if (!IS_ERR(hub_device))
> +device_destroy(hub_class, hub_device->devt);
> 
> if (!IS_ERR(hub_class))
> class_destroy(hub_class);

I don't think you are understanding that you can have multiple hubs in
the system at the same time :(

thanks,

greg k-h
