Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C778360974
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 14:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhDOMc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 08:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhDOMcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:32:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EE156044F;
        Thu, 15 Apr 2021 12:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618489921;
        bh=RNLyWYivf1iCOu+XiSao9whpVt5jOI9e5kwCwe8J3pE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DALDjikH1xYjbgAE5ZFULhAmlzFpYm8GTppSG2ZGuDBqASeVmY7hS3mli9ZAIWm8m
         KTQfZwqZMT6wy5u+5KTdnLbYoa9sjYrHsbyr0WZRtdR3DrYdAWaZh44IM0+Pk/lTrs
         1Xgv6BAacZV5RpwD07Y4gE0xta0IKFoqx2ZJjFFA=
Date:   Thu, 15 Apr 2021 14:31:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     chris.chiu@canonical.com
Cc:     stern@rowland.harvard.edu, m.v.b@runbox.com, hadess@hadess.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] USB: Don't set USB_PORT_FEAT_SUSPEND on WD19's
 Realtek Hub
Message-ID: <YHgyP8tGNM1Wi5dJ@kroah.com>
References: <20210415114856.4555-1-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415114856.4555-1-chris.chiu@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 07:48:56PM +0800, chris.chiu@canonical.com wrote:
> From: Chris Chiu <chris.chiu@canonical.com>
> 
> Realtek Hub (0bda:5487) in Dell Dock WD19 sometimes fails to work
> after the system resumes from suspend with remote wakeup enabled
> device connected:
> [ 1947.640907] hub 5-2.3:1.0: hub_ext_port_status failed (err = -71)
> [ 1947.641208] usb 5-2.3-port5: cannot disable (err = -71)
> [ 1947.641401] hub 5-2.3:1.0: hub_ext_port_status failed (err = -71)
> [ 1947.641450] usb 5-2.3-port4: cannot reset (err = -71)

How does other operating systems handle this?  The hardware seems like
it does not follow the USB spec, how did it get "certified"?

> Information of this hub:
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 10 Spd=480  MxCh= 5
> D:  Ver= 2.10 Cls=09(hub  ) Sub=00 Prot=02 MxPS=64 #Cfgs=  1
> P:  Vendor=0bda ProdID=5487 Rev= 1.47
> S:  Manufacturer=Dell Inc.
> S:  Product=Dell dock
> C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=01 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms
> I:* If#= 0 Alt= 1 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=02 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms
> 
> The failure results from the ETIMEDOUT by chance when turning on
> the suspend feature for the target port of the hub. The port
> will be unresponsive and placed in unknown state. The hub_activate
> invoked during resume will fail to get the port stautus with -EPROTO.
> Then all devices connected to the hub will never be found and probed.
> 
> The USB_PORT_FEAT_SUSPEND is not really necessary due to the
> "global suspend" in USB 2.0 spec. It's only for many hub devices
> which don't relay wakeup requests from the devices connected to
> downstream ports. For this realtek hub, there's no problem waking
> up the system from connected keyboard.
> 
> This commit bypasses the USB_PORT_FEAT_SUSPEND for the quirky hub.

Can you make this only be allowed for hubs?  But why doesn't the nomal
"this can not suspend properly" bit work for this?  We have that for
other USB devices already.

thanks,

greg k-h
