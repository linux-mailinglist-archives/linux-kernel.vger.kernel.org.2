Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F05439FE48
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbhFHR7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233386AbhFHR7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:59:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 411ED61278;
        Tue,  8 Jun 2021 17:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623175034;
        bh=WGRQrRGgomVfTCmBEwjuqIaIC2RxqlyNnzSwD42/np0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOJFiE5sYu77BNjLvoFFPOy5ch6q0yamjHmQzRvitXY3HcCDMUJinzSss1e72lBUk
         YHpURcNx/M24eyRaRtrlOEWqoyZysXSUz8GecsqyKjZN4/uizPp4WDoijffIiWHx25
         qyz5bYk0BkSlXzyVXKkn6hu45+vN1NdBcDjpYkgY=
Date:   Tue, 8 Jun 2021 19:57:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        ierturk@ieee.org
Subject: Re: Strange problem with USB device
Message-ID: <YL+veAlZSCrniOyl@kroah.com>
References: <cfc37ce0-823e-0d19-f5d7-fcd571a94943@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfc37ce0-823e-0d19-f5d7-fcd571a94943@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 12:41:23PM -0500, Larry Finger wrote:
> Hi,
> 
> In https://bugzilla.suse.com/show_bug.cgi?id=1186889, a user is reporting
> that his Bluetooth component of a Realtek RTL8822CE is not being found in
> openSUSE's kernel 5.3.18. His lsusb scan is as follows:
> 
> $ lsusb
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 001 Device 003: ID 13d3:56c9 IMC Networks HP TrueVision HD Camera
> Bus 001 Device 002: ID 045e:07fd Microsoft Corp. Nano Transceiver 1.1
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> The Bluetooth device is found and works in Windows 10, where the Device
> Manager reports hardware ID's of 0bda:b00c. This combination is in driver
> btusb.
> 
> Is there a bug in the USB bus scan in kernel 5.3.18 that has since been
> fixed, or is there still a bug that misses this device?

Loads of things have changed since 5.3.18, that was a long time ago :)

Are you sure this device doesn't need a "magic" command sent to it in
order for it to show up as a USB device on the bus?  That sometimes
happens :(

thanks,

greg k-h
