Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EA0366E46
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243586AbhDUOdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243227AbhDUOdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:33:03 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A766C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:32:30 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id i26-20020a9d625a0000b02902a2119f7613so2307975otk.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KatKMRcorHaCB8knJAAJ9JHDSKXTyx9e9HLULQuHgrw=;
        b=Lk9mhpUltJNpMeMC/+MYMF5AVtHdMcxa/Gaf0vfsQCCCNJj9tDSD+Yt0gsFvik3kR2
         I1N0CxLCo6qJDWjfOHXnxmah+smujMVA5FU8CRp/HjbzUew2IJ4z238DWKHVzWQGQvAn
         bss0JKTo5oLvIuqC1kbc1BJqut9z24/EJO/4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KatKMRcorHaCB8knJAAJ9JHDSKXTyx9e9HLULQuHgrw=;
        b=Ni6JmS2/fZ+2BRxsPwmZl8jx87wr7NqlNZNu8cBDQlQW+PQ8jBRy5EOfj8GegsVhzD
         EANbwMkRu1mrEv91J2bVAzUSyXskDqwnuGnQRiPIPjaHOhYIozesFyzKKQ+B0PAdod/+
         3nlrdTjFTGiYVl+rM2f+Xfc9pSn8qf2CRlGbRVVRUNwXGx/55UAEd/wUc9tJl6zTWbhe
         p35HU0OUQcCpM6SudCo9puKS+z5qMmEWPCz4aV/otqDI8D88FedmlpTLX3e7uBJGw5+P
         2N10DrvweQnNjdDbtfVtH8dIQFxDGdnIY1kWbDsqo9cpjxvM/Snw2GW8c0Ua8w/++dsn
         SBMg==
X-Gm-Message-State: AOAM533t2JxNfOi56JoCUCZ1t64e2+qMrvh9jhOa67uWYX57UE51EB+V
        e/TZQvHrKVr8WB+xg/P1kJA7VZuEeSHKjJkbw/feBvFK+hI=
X-Google-Smtp-Source: ABdhPJzhesco6THmq6TsUiGIDC3hulWXQaMptXynVdEEkp0XyOzFvk6Agm/HhpxmFj31qNzTiQMCz5w39aqGVCzGpgs=
X-Received: by 2002:a05:6830:1398:: with SMTP id d24mr24080226otq.281.1619015549354;
 Wed, 21 Apr 2021 07:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210421120353.544518-1-maarten.lankhorst@linux.intel.com>
In-Reply-To: <20210421120353.544518-1-maarten.lankhorst@linux.intel.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 21 Apr 2021 16:32:18 +0200
Message-ID: <CAKMK7uFpoY7YMEMbftjq+P5XHR6L+F0KwFtbK7CtuUFy7HsLkQ@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Fix docbook descriptions for i915_cmd_parser
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 2:03 PM Maarten Lankhorst
<maarten.lankhorst@linux.intel.com> wrote:
>
> Fixes the following htmldocs warnings:
> drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Excess function parameter 'trampoline' description in 'intel_engine_cmd_parser'
> drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Function parameter or member 'jump_whitelist' not described in 'intel_engine_cmd_parser'
> drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Function parameter or member 'shadow_map' not described in 'intel_engine_cmd_parser'
> drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Function parameter or member 'batch_map' not described in 'intel_engine_cmd_parser'
> drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Excess function parameter 'trampoline' description in 'intel_engine_cmd_parser'
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/i915_cmd_parser.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_cmd_parser.c b/drivers/gpu/drm/i915/i915_cmd_parser.c
> index e6f1e93abbbb..afb9b7516999 100644
> --- a/drivers/gpu/drm/i915/i915_cmd_parser.c
> +++ b/drivers/gpu/drm/i915/i915_cmd_parser.c
> @@ -1369,6 +1369,18 @@ static int check_bbstart(u32 *cmd, u32 offset, u32 length,
>         return 0;
>  }
>
> +/**
> + * intel_engine_cmd_parser_alloc_jump_whitelist() - preallocate jump whitelist for intel_engine_cmd_parser()
> + * @batch_length: length of the commands in batch_obj
> + * @trampoline: Whether jump trampolines are used.
> + *
> + * Preallocates a jump whitelist for parsing the cmd buffer in intel_engine_cmd_parser().
> + * This has to be preallocated, because the command parser runs in signaling context,
> + * and may not allocate any memory.
> + *
> + * Return: NULL or pointer to a jump whitelist, or ERR_PTR() on failure. Use
> + * IS_ERR() to check for errors. Must bre freed() with kfree().

IS_ERR_OR_NULL or needs an actual bugfix in the code since we're not
consistent. Also s/bre/be/
-Daniel

> + */
>  unsigned long *intel_engine_cmd_parser_alloc_jump_whitelist(u32 batch_length,
>                                                             bool trampoline)
>  {
> @@ -1401,7 +1413,9 @@ unsigned long *intel_engine_cmd_parser_alloc_jump_whitelist(u32 batch_length,
>   * @batch_offset: byte offset in the batch at which execution starts
>   * @batch_length: length of the commands in batch_obj
>   * @shadow: validated copy of the batch buffer in question
> - * @trampoline: whether to emit a conditional trampoline at the end of the batch
> + * @jump_whitelist: buffer preallocated with intel_engine_cmd_parser_alloc_jump_whitelist()
> + * @shadow_map: mapping to @shadow vma
> + * @batch_map: mapping to @batch vma
>   *
>   * Parses the specified batch buffer looking for privilege violations as
>   * described in the overview.
> --
> 2.31.0
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
