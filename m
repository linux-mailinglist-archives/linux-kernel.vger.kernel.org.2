Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FA9447364
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 15:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbhKGPCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 10:02:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229520AbhKGPCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 10:02:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB14360E97;
        Sun,  7 Nov 2021 14:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636297175;
        bh=rl6yakBEu1ifk8r8II2v1Q4OUBLKEmviaxZ5p2qc/vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gR0qhWoooIKoN/L64XUbtT9t7DSj52/4D5ftZqnpbvKTxFbvuAOA8KbGRruzqRk0r
         BXX9F5/M01CB6Y1VrN9qgLZrS4XzyvWt8MC5ysCoACCxIADi8ki4/s0F9pzzJw4XBR
         OlR03K1Qp1y3CgqgHvdAjPPvEON6HrZIgEyGJo+8=
Date:   Sun, 7 Nov 2021 15:59:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     tiwai@suse.de, stable-commits@vger.kernel.org
Subject: Re: Patch "ALSA: pci: rme: Set up buffer type properly" has been
 added to the 5.14-stable tree
Message-ID: <YYfp1McHg9s62scO@kroah.com>
References: <163629655751249@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163629655751249@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2021 at 03:49:17PM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     ALSA: pci: rme: Set up buffer type properly
> 
> to the 5.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      alsa-pci-rme-set-up-buffer-type-properly.patch
> and it can be found in the queue-5.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> >From 0899a7a23047f106c06888769d6cd6ff43d7395f Mon Sep 17 00:00:00 2001
> From: Takashi Iwai <tiwai@suse.de>
> Date: Mon, 9 Aug 2021 09:18:28 +0200
> Subject: ALSA: pci: rme: Set up buffer type properly
> 
> From: Takashi Iwai <tiwai@suse.de>
> 
> commit 0899a7a23047f106c06888769d6cd6ff43d7395f upstream.
> 
> Although the regression of the mmap was fixed in the recent commit
> dc0dc8a73e8e ("ALSA: pcm: Fix mmap breakage without explicit buffer
> setup"), RME9652 and HDSP drivers have still potential issues with
> their mmap handling.  Namely, they use the default mmap handler
> without the standard buffer preallocation, and PCM core wouldn't use
> the coherent DMA mapping.  It's practically OK on x86, but on some
> exotic architectures, it wouldn't work.
> 
> This patch addresses the potential breakage by replacing the buffer
> setup with the proper macro.  It also simplifies the source code,
> too.
> 
> Link: https://lore.kernel.org/r/20210809071829.22238-3-tiwai@suse.de
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  sound/pci/rme9652/hdsp.c    |    6 ++----
>  sound/pci/rme9652/rme9652.c |    6 ++----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> --- a/sound/pci/rme9652/hdsp.c
> +++ b/sound/pci/rme9652/hdsp.c
> @@ -4518,8 +4518,7 @@ static int snd_hdsp_playback_open(struct
>  	snd_pcm_set_sync(substream);
>  
>          runtime->hw = snd_hdsp_playback_subinfo;
> -	runtime->dma_area = hdsp->playback_buffer;
> -	runtime->dma_bytes = HDSP_DMA_AREA_BYTES;
> +	snd_pcm_set_runtime_buffer(substream, hdsp->playback_dma_buf);
>  
>  	hdsp->playback_pid = current->pid;
>  	hdsp->playback_substream = substream;
> @@ -4595,8 +4594,7 @@ static int snd_hdsp_capture_open(struct
>  	snd_pcm_set_sync(substream);
>  
>  	runtime->hw = snd_hdsp_capture_subinfo;
> -	runtime->dma_area = hdsp->capture_buffer;
> -	runtime->dma_bytes = HDSP_DMA_AREA_BYTES;
> +	snd_pcm_set_runtime_buffer(substream, hdsp->capture_dma_buf);
>  
>  	hdsp->capture_pid = current->pid;
>  	hdsp->capture_substream = substream;
> --- a/sound/pci/rme9652/rme9652.c
> +++ b/sound/pci/rme9652/rme9652.c
> @@ -2279,8 +2279,7 @@ static int snd_rme9652_playback_open(str
>  	snd_pcm_set_sync(substream);
>  
>          runtime->hw = snd_rme9652_playback_subinfo;
> -	runtime->dma_area = rme9652->playback_buffer;
> -	runtime->dma_bytes = RME9652_DMA_AREA_BYTES;
> +	snd_pcm_set_runtime_buffer(substream, rme9652->playback_dma_buf);
>  
>  	if (rme9652->capture_substream == NULL) {
>  		rme9652_stop(rme9652);
> @@ -2339,8 +2338,7 @@ static int snd_rme9652_capture_open(stru
>  	snd_pcm_set_sync(substream);
>  
>  	runtime->hw = snd_rme9652_capture_subinfo;
> -	runtime->dma_area = rme9652->capture_buffer;
> -	runtime->dma_bytes = RME9652_DMA_AREA_BYTES;
> +	snd_pcm_set_runtime_buffer(substream, rme9652->capture_dma_buf);
>  
>  	if (rme9652->playback_substream == NULL) {
>  		rme9652_stop(rme9652);
> 
> 
> Patches currently in stable-queue which might be from tiwai@suse.de are
> 
> queue-5.14/alsa-pci-rme-set-up-buffer-type-properly.patch
> queue-5.14/alsa-pcm-check-mmap-capability-of-runtime-dma-buffer-at-first.patch
> queue-5.14/alsa-pci-cs46xx-fix-set-up-buffer-type-properly.patch

This patch breaks the build, so I will drop it.

Can you provide a working backport?

thanks,

greg k-h
