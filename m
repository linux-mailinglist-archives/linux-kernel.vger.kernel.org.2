Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD0832612B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhBZKV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:21:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhBZKVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:21:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A61CC64EC4;
        Fri, 26 Feb 2021 10:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614334837;
        bh=iWoZ9kHmPVIJSFXhHK4exoa0+baGdJRJwmGpiqNK+/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vkSxfb1LL2dxJG2mqrUt7S7SoeFC66rpgkblbUXYtmiAlNUBUzaptcDXgjYjTzJbD
         1f84Ihy8HQQiYdp6/p0BCWqB6nPl4AyPKKObowfYamz8qlslOVMIDEjbErFCryQ9FJ
         dCFsRMJoDc1RZ+Ixw5PAQA8GMl8oIxuYltKd7hck=
Date:   Fri, 26 Feb 2021 11:20:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] USB: serial: xr: fix NULL-deref on disconnect
Message-ID: <YDjLckoJ6q6JYwIV@kroah.com>
References: <20210226100826.18987-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226100826.18987-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 11:08:26AM +0100, Johan Hovold wrote:
> Claiming the sibling control interface is a bit more involved and
> specifically requires adding support to USB-serial core for managing
> either interface being unbound first, something which could otherwise
> lead to a NULL-pointer dereference.
> 
> Similarly, additional infrastructure is also needed to handle suspend
> properly.
> 
> Since the driver currently isn't actually using the control interface,
> we can defer this for now by simply not claiming the control interface.
> 
> Fixes: c2d405aa86b4 ("USB: serial: add MaxLinear/Exar USB to Serial driver")
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
