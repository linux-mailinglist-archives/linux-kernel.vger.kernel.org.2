Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA10F3F7FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 03:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhHZBQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 21:16:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59712 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbhHZBQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 21:16:53 -0400
Received: from maud (unknown [IPv6:2600:8800:8c06:1000::c8f3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8DEC01F43E22;
        Thu, 26 Aug 2021 02:15:55 +0100 (BST)
Date:   Wed, 25 Aug 2021 21:15:45 -0400
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        alyssa.rosenzweig@collabora.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/cma-helper: Set VM_DONTEXPAND for mmap
Message-ID: <YSbrQUNXx8vIugF7@maud>
References: <1c68be0449aa3217e2bbc898dd8c7426748fc6b8.1629902585.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c68be0449aa3217e2bbc898dd8c7426748fc6b8.1629902585.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> drm_gem_cma_mmap() cannot assume every implementation of dma_mmap_wc()
> will end up calling remap_pfn_range() (which happens to set the relevant
> vma flag, among others), so in order to make sure expectations around
> VM_DONTEXPAND are met, let it explicitly set the flag like most other
> GEM mmap implementations do.
> 
> This avoids repeated warnings on a small minority of systems where the
> display is behind an IOMMU, and has a simple driver which does not
> override drm_gem_cma_default_funcs.

Apple system-on-chips have their display behind an IOMMU. Actually, a
separate IOMMU for each display, and a separate IOMMU for each display
controller -- so there are 4 IOMMUs total for display on the M1.

I've tested this patch against my work-in-progress display driver for
the M1. It indeed fixes the annoying warnings every frame (wayland) and
on mode setting (x11). So this is

	Tested-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

I've cherry-picked the patch into my M1 staging/downstream tree, so I
guess that's an Acked-by. I don't know anything about the vm_* stuff in
the kernel yet, though, since can't give a reviewed-by. Will leave that
one to the pro's.

I know you were trying to fix an HDLCD issue, but I needed this patch
too, so thank you! 😄
