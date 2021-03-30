Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5F934EAC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhC3Ooo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:44:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232065AbhC3Oo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:44:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61658619C2;
        Tue, 30 Mar 2021 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617115466;
        bh=N1/Oupz12E3cK5fXtPXFfWQXRED0XsUmO3OmdJXvtYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i5dJnbrL1I5okQCaZEYln/fI7irWrqBLJ8I1anwFRv5rsdbNhcZzsMyFXqPTeMubz
         74U03L9dLaGjQ7CECzx3225b2VF87EYFzGajlaQYldwmrqP8vFtrBsHP5HxtPPWdSy
         bP/tZcdI6WUks7ACnFnLPwhKzpmSp2sSEaNONNeKHnZiLfFQgj17GX/qIeWwmflmEJ
         o+b5IEC1s5WjDDuVuAgHq0Vlwjkv7f1auoSc2rgQK4zUNOOon+n/72N9rzxpVpJMZO
         IQDJN9ZjYJtW2dAxaxDSV0zj++VZJNlCiUPWIO48IgtCOneIYc9EA2UDw92oWIQL3S
         ZYSLT8f0QMHew==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFbs-0002Qi-22; Tue, 30 Mar 2021 16:44:48 +0200
Date:   Tue, 30 Mar 2021 16:44:48 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/7] USB: serial: xr: use a table for device-specific
 settings
Message-ID: <YGM5YMjusx214+pl@hovoldconsulting.com>
References: <cover.1616571453.git.mchehab+huawei@kernel.org>
 <7b6ff07fbf88783950ab7155e3d4529731383c6b.1616571453.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b6ff07fbf88783950ab7155e3d4529731383c6b.1616571453.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 08:41:06AM +0100, Mauro Carvalho Chehab wrote:
> The same driver is used by a wide range of MaxLinear devices.
> 
> Other models are close enough to use the same driver, but they
> use a different register set.
> 
> So, instead of having the registers hardcoded at the driver,
> use a table. This will allow further patches to add support for
> other devices.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/usb/serial/xr_serial.c | 151 ++++++++++++++++++++++++---------
>  1 file changed, 113 insertions(+), 38 deletions(-)
 
>  static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
>  {
> +	struct xr_port_private *port_priv;
> +
>  	/* Don't bind to control interface */
>  	if (serial->interface->cur_altsetting->desc.bInterfaceNumber == 0)
>  		return -ENODEV;
>  
> +	port_priv = kzalloc(sizeof(*port_priv), GFP_KERNEL);
> +	if (!port_priv)
> +		return -ENOMEM;

For historical reasons, you cannot allocate memory in probe() directly
(unless using devres) or this can leak on later probe errors.

Instead interface-wide allocations are done in attach() and released in
release(), while port-specific allocations are done in port_probe() and
released in port_remove().

Johan
