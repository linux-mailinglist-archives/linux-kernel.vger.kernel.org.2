Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4A232E30B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 08:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhCEHhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 02:37:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhCEHhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 02:37:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D83CF64F59;
        Fri,  5 Mar 2021 07:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614929851;
        bh=bvUeCgMjKXHMnR9wZzhu5hhG5YUMC0Dr0Im0Q7UCMbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ME6LsTuSFPZ6hKMAHos4aDNqZdYlA+yV1W605eGsrMCjan1eedf9MSPak5MD3ecX
         F/PD3E8Uk7jz2GTaDk+7IrDYapQmscvuBY8+u1G4nevAti8EM7AMB84EdZP+OX2EnY
         2r8PrzcfJN5W1CTAHEBbYI5M5m4h3F+F5xxxW9WA=
Date:   Fri, 5 Mar 2021 08:37:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chien Kun Niu <rickyniu@google.com>
Cc:     stern@rowland.harvard.edu, erosca@de.adit-jv.com,
        gustavoars@kernel.org, a.darwish@linutronix.de, oneukum@suse.com,
        Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Wei <jameswei@google.com>
Subject: Re: [PATCH] ANDROID: usb: core: Send uevent when USB TOPO layer over
 6
Message-ID: <YEHfuCFGSpm5ldl0@kroah.com>
References: <20210226091612.508639-1-rickyniu@google.com>
 <YDi/+TN6AYXropf7@kroah.com>
 <CADRPvQubTEjKeJc=+LQ2jb0L=N4mxY8n21Bf8U-tS1stpB_eGw@mail.gmail.com>
 <YD9SYklmQq5amDA7@kroah.com>
 <CADRPvQtbbxKhvmE1OZ=GRSmfejk5tXYADo=jw52EQdkj1nN78w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADRPvQtbbxKhvmE1OZ=GRSmfejk5tXYADo=jw52EQdkj1nN78w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 03:17:37PM +0800, Chien Kun Niu wrote:
> Greg KH <gregkh@linuxfoundation.org> 於 2021年3月3日 週三 下午5:10寫道：
> >
> > On Wed, Mar 03, 2021 at 05:03:25PM +0800, Chien Kun Niu wrote:
> > > Hi , Greg
> > >
> > > What tool will "catch" this?  Where is that code located at?
> > > => I prepare merge the code to Android phone , so I used Android HLOS
> > > to catch this uevent.
> >
> > Very odd quoting style, perhaps you might want to read up on how to do
> > this properly at:
> >         https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
> >
> > > uevents are not for stuff like this, you are trying to send "error
> > > conditions" to userspace, please use the "proper" interfaces like this
> > > and not abuse existing ones.
> > > => Sorry , I am not sure what is the "proper" interfaces your mean.
> > >      Could you please give me more description?
> >
> > How does the kernel normally send error conditions that it detects in
> > hardware to userspace?
> >
> 
> I will create a sysfs attribute to record the hub status.
> If there is a new hub with over 6 USB TOPO layer connected, I will use
> the sysfs_notify to send the "error conditions" to userspace.
> Is it a proper interfaces to delivery "error conditions"?

Maybe, it all depends on what you are wanting to show here.  Try it out
and see, it's easier to review patches that you have shown work properly
for your use case than it is to try to discuss general issues.

thanks,

greg k-h
