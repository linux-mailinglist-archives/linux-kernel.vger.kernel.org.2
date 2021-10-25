Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2045D43901B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhJYHNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229727AbhJYHNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:13:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0093C60F9C;
        Mon, 25 Oct 2021 07:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635145882;
        bh=zv7F1LA7Fms6yxvpguqNfdWuHpNohuOAsRTrq30c1d0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s3VgcqACqayBTTxp3SV44sWxkLQ2KlbSaMNY3Ol3aKHGfGuiMETYur7yLcphVBhZ6
         GeT/eXKzAh94+3g5kgq2JGsUu2hloQxyiZ4p5xWA12sVlXR3lqQ1AU//IVfHFyrnQd
         /cUjQIKzcuUjQO+qOujyS4HNmlf4UL8yV3WCFtsk=
Date:   Mon, 25 Oct 2021 09:11:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaston Gonzalez <gascoar@gmail.com>
Cc:     linux-staging@lists.linux.dev, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] staging: vchiq_core.h: use preferred kernel types
Message-ID: <YXZYmP0lCae+iDdE@kroah.com>
References: <20211024212524.370078-1-gascoar@gmail.com>
 <20211024212524.370078-5-gascoar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024212524.370078-5-gascoar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 06:25:20PM -0300, Gaston Gonzalez wrote:
> Change types from uint32_t and uint64_t to the preferred ones u32 and
> u64.
> 
> Reported by checkpatch.pl, with the exception of the one in function
> vchiq_log_dump_mem().
> 
> Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
> ---
>  .../vc04_services/interface/vchiq_arm/vchiq_core.h   | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> index 383c3bcf787e..a107c72ce3a6 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> @@ -74,7 +74,7 @@
>  	((fourcc) >>  8) & 0xff, \
>  	(fourcc) & 0xff
>  
> -typedef uint32_t BITSET_T;
> +typedef u32 BITSET_T;

This is fine for now, but you should also work to get rid of this
unneeded typedef entirely.

thanks,

greg k-h
