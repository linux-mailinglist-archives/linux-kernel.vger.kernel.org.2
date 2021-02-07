Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06198312308
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 10:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhBGJSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 04:18:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhBGJSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 04:18:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9361B64E22;
        Sun,  7 Feb 2021 09:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612689486;
        bh=M+7Vjj0l8SWkkCAfHsTiuFeZisfU3zkOxBiol6f8cvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JzWhpLNn2V57naiWxS4uA4F/40eR6CV/py3pinOi1yXfpWjytSpfXty7e+qvs6oqC
         4nUaKQtfIPxH/RHs8A0JHDTn8dR5ov8SAQlbXeJamysGtCeQuZ42D/o07NcGc7rDX9
         M9joDAf8O1qqPXUmc4rRwFcdSiqZ0dL6mBS8J/lI=
Date:   Sun, 7 Feb 2021 10:18:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v3] staging: emxx_udc: Make incorrectly defined global
 static
Message-ID: <YB+wSYgNABzNWFfb@kroah.com>
References: <YB+qDND2OmY8WwA0@kroah.com>
 <20210207085911.270746-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207085911.270746-1-memxor@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 02:29:12PM +0530, Kumar Kartikeya Dwivedi wrote:
> The global gpio_desc pointer and int vbus_irq were defined in the header,
> instead put the definitions in the translation unit and make them static as
> there's only a single consumer, and these symbols shouldn't pollute the
> global namespace.
> 
> This fixes the following sparse warnings for this driver:
> drivers/staging/emxx_udc/emxx_udc.c: note: in included file:
> drivers/staging/emxx_udc/emxx_udc.h:23:18: warning: symbol 'vbus_gpio' was not
> declared. Should it be static?  drivers/staging/emxx_udc/emxx_udc.h:24:5:
> warning: symbol 'vbus_irq' was not declared. Should it be static?
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
> Changes in v1:
> Switch to variable with static linkage instead of extern
> Changes in v2:
> Resend a versioned patch
> Changes in v3:
> Include version changelog below the marker

Much better, thanks, now queued up.

greg k-h
