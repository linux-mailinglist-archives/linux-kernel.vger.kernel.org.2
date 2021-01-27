Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59979305047
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbhA0Dyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S317127AbhA0Bjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 20:39:54 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DC8C061788
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 17:39:05 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C146F240;
        Wed, 27 Jan 2021 02:37:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1611711442;
        bh=V9vA/sNlPmooK07pq3bXsoG2K/kwhxOi3TDZS5PulQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MokMB9WzOH0S16kD9nKJ478Pcdi0P6RqMAthVg6Z5QOV411+Sa39Zq5GnhPXopkCZ
         8M+G7DEYrH/vh/dhgrfqo1y72lN13VHXh3r1rZjy7OFXpAOqLUIUZDukJeNwrMFXQF
         5ifxQbLajiBR0PBW+SQ1IOcV705NuU/kJXxmuYUE=
Date:   Wed, 27 Jan 2021 03:37:02 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hyun Kwon <hyun.kwon@xilinx.com>
Cc:     linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: remove myself from the list
Message-ID: <YBDDvmLHrYpuTBkn@pendragon.ideasonboard.com>
References: <20210127011312.697159-1-hyun.kwon@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210127011312.697159-1-hyun.kwon@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hyun,

Thank you for the patch.

On Tue, Jan 26, 2021 at 05:13:12PM -0800, Hyun Kwon wrote:
> The email will become invalid soon.

Is there, by any chance, anyone at Xilinx would could help maintaining
these drivers ?

> Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> ---
>  MAINTAINERS | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 992fe3b0900a..4fc00c2da56d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6048,7 +6048,6 @@ F:	Documentation/gpu/xen-front.rst
>  F:	drivers/gpu/drm/xen/
>  
>  DRM DRIVERS FOR XILINX
> -M:	Hyun Kwon <hyun.kwon@xilinx.com>
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
> @@ -19577,7 +19576,6 @@ S:	Maintained
>  F:	drivers/tty/serial/uartlite.c
>  
>  XILINX VIDEO IP CORES
> -M:	Hyun Kwon <hyun.kwon@xilinx.com>
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  L:	linux-media@vger.kernel.org
>  S:	Supported
> @@ -19587,7 +19585,6 @@ F:	drivers/media/platform/xilinx/
>  F:	include/uapi/linux/xilinx-v4l2-controls.h
>  
>  XILINX ZYNQMP DPDMA DRIVER
> -M:	Hyun Kwon <hyun.kwon@xilinx.com>
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  L:	dmaengine@vger.kernel.org
>  S:	Supported

-- 
Regards,

Laurent Pinchart
