Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AB83F85EE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241829AbhHZK5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241491AbhHZK5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:57:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B376960FC1;
        Thu, 26 Aug 2021 10:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629975391;
        bh=QwwuKLC/H2ON9lhWkQA52Z5MbQH0ekQVSIV4EvIGbYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BvofJWeFySmDgyaRk5PeNjdIQT5EZf0jFmafFvmRwawYxxpWvhT4xjf5BRmKbPbbP
         UHHMiQAvaSuxeg+aQ7+ded/l4K27hAXt423DF1/7FRYKhWOGewizpDJD9p+SA9wpVc
         AzI8+6r4SFMDguXrgpIdxrLel1y8EqiU81qbJcyE=
Date:   Thu, 26 Aug 2021 12:56:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Add dri-devel for component.[hc]
Message-ID: <YSdzWthRL+C9/LMN@kroah.com>
References: <20210826091343.1039763-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826091343.1039763-1-daniel.vetter@ffwll.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 11:13:43AM +0200, Daniel Vetter wrote:
> dri-devel is the main user, and somehow there's been the assumption
> that component stuff is unmaintained.
> 
> References: https://lore.kernel.org/dri-devel/CAAEAJfDWOzCJxZFNtxeT7Cvr2pWbYrfz-YnA81sVNs-rM=8n4Q@mail.gmail.com/
> Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ac58d0032abd..7cdc19815ec4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5707,6 +5707,11 @@ F:	Documentation/admin-guide/blockdev/
>  F:	drivers/block/drbd/
>  F:	lib/lru_cache.c
>  
> +DRIVER COMPONENT FRAMEWORK
> +L:	dri-devel@lists.freedesktop.org
> +F:	drivers/base/component.c
> +F:	include/linux/component.h

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
