Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92A5356648
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbhDGIS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:18:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233801AbhDGISZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:18:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D70FB611AF;
        Wed,  7 Apr 2021 08:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617783496;
        bh=uf8+dE2AP3tAU5ZxCGlJFGZ8FUljPywASKktP/5uv7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmUKRAUr1LSYH+6TwXqBHM3UUTx0obo9XpWipLPSJMDMNQDgKIJ91xgt2dcJx3Xiy
         0o2tyP1quRAyFofzMREmbkoP1o31f1bxCTOsXcTd5NgO4NwvLpanKY+2lPtnxY7UKz
         m2c53lVM7MDF8OWHbofn7EA9OwfF0hObfLDJ0FUc=
Date:   Wed, 7 Apr 2021 10:18:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v3] staging: rtl8723bs: hal: Remove
 camelcase in Hal8723BReg.h
Message-ID: <YG1qxdRtNIIVK3fX@kroah.com>
References: <20210406160037.27225-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406160037.27225-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 06:00:37PM +0200, Fabio M. De Francesco wrote:
> Remove camelcase in some symbols defined in Hal8723BReg.h. These symbols
> are not used anywhere else, therefore this patch does not break the driver.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> Patch v3 changes nothing with respect to v2 and v1. It exists only to cc some recipients that were missing in the header of the previous email.
> 
>  drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

This patch does not apply to my tree right now.  Can you refresh and
rebase your copy of my branch and rebase it and resend?

thanks,

greg k-h
