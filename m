Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7259C367C61
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbhDVISw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhDVISv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:18:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E88C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:18:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q123-20020a1c43810000b029012c7d852459so3775053wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=4MknbIT7CWhKfazUcArL9gVzlWhfw/gbr5rLiB4UULY=;
        b=KUQGn467FGS7Cc17n7B5Cei0400l5Y/+7iXKO/S25YkklcZ7Sdy8oeuoVFepS6pzqj
         0UiQY5oaDYRMNvkWRrhTY3VmVE3eJUk018cJpsg4V9l8Rhd6+QRjHXaCETMdvyRE/j0b
         0J54xHgYENwgVUkncDf62z6BM1/Fu6e1j85ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=4MknbIT7CWhKfazUcArL9gVzlWhfw/gbr5rLiB4UULY=;
        b=SgDFOa/sZHcd24Q96jW3QNSYRiPuIyJCSEO6PIm/kPma41tKQGu7jplrgzhmjDa5rt
         PQFiCGbHCGdtdFJ9td71gBmQkr3SI/ZTb0suShUvJ6m8gLbpSO/y5Wd3wpW7N7/1HINV
         kAF3d6bPVb/536gnsz4bd+PSri7ucJWf5GxpC4y9Gd22WKzf5K21diDC7UZOZVzwyiiW
         OYbjN2d3kuzEFPFFqNVu6EuyrgIgbaOul5iu+gdFUWE4PM4codyA408bvQhM9/SDmKjV
         uu9Os44ndTH9ICOrmdClpY7AjwvhGoCYG3euOtO3NBg3bBoFK/kEgKhng2R0Pc/TIsvT
         b14Q==
X-Gm-Message-State: AOAM530wzl2W0zV6FFyZ+u1jHq4333sHwx9w5LM8lJMsTcpw/gHYUUnL
        +x/XEnS+HUthnNVRv+QYwGUIIg==
X-Google-Smtp-Source: ABdhPJyYeg6+dBCeVaLicwbWWHGjEqMDmuiY+xd9mnZGLeW0ntlVLmyvlg4tFGdYnfahZaSVd24EWg==
X-Received: by 2002:a7b:c769:: with SMTP id x9mr14123572wmk.124.1619079494623;
        Thu, 22 Apr 2021 01:18:14 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id x2sm2474310wrg.31.2021.04.22.01.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 01:18:14 -0700 (PDT)
Date:   Thu, 22 Apr 2021 10:18:12 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/i915: Fix docbook descriptions for i915_cmd_parser
Message-ID: <YIExRAHQvZmgL5S+@phenom.ffwll.local>
Mail-Followup-To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        DRI <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210421120353.544518-1-maarten.lankhorst@linux.intel.com>
 <CAKMK7uFpoY7YMEMbftjq+P5XHR6L+F0KwFtbK7CtuUFy7HsLkQ@mail.gmail.com>
 <9ae96fa1-6c91-4ec1-422d-8e0a95251bb7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae96fa1-6c91-4ec1-422d-8e0a95251bb7@linux.intel.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 04:39:10PM +0200, Maarten Lankhorst wrote:
> Op 21-04-2021 om 16:32 schreef Daniel Vetter:
> > On Wed, Apr 21, 2021 at 2:03 PM Maarten Lankhorst
> > <maarten.lankhorst@linux.intel.com> wrote:
> >> Fixes the following htmldocs warnings:
> >> drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Excess function parameter 'trampoline' description in 'intel_engine_cmd_parser'
> >> drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Function parameter or member 'jump_whitelist' not described in 'intel_engine_cmd_parser'
> >> drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Function parameter or member 'shadow_map' not described in 'intel_engine_cmd_parser'
> >> drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Function parameter or member 'batch_map' not described in 'intel_engine_cmd_parser'
> >> drivers/gpu/drm/i915/i915_cmd_parser.c:1420: warning: Excess function parameter 'trampoline' description in 'intel_engine_cmd_parser'
> >>
> >> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> >> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >> ---
> >>  drivers/gpu/drm/i915/i915_cmd_parser.c | 16 +++++++++++++++-
> >>  1 file changed, 15 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/i915/i915_cmd_parser.c b/drivers/gpu/drm/i915/i915_cmd_parser.c
> >> index e6f1e93abbbb..afb9b7516999 100644
> >> --- a/drivers/gpu/drm/i915/i915_cmd_parser.c
> >> +++ b/drivers/gpu/drm/i915/i915_cmd_parser.c
> >> @@ -1369,6 +1369,18 @@ static int check_bbstart(u32 *cmd, u32 offset, u32 length,
> >>         return 0;
> >>  }
> >>
> >> +/**
> >> + * intel_engine_cmd_parser_alloc_jump_whitelist() - preallocate jump whitelist for intel_engine_cmd_parser()
> >> + * @batch_length: length of the commands in batch_obj
> >> + * @trampoline: Whether jump trampolines are used.
> >> + *
> >> + * Preallocates a jump whitelist for parsing the cmd buffer in intel_engine_cmd_parser().
> >> + * This has to be preallocated, because the command parser runs in signaling context,
> >> + * and may not allocate any memory.
> >> + *
> >> + * Return: NULL or pointer to a jump whitelist, or ERR_PTR() on failure. Use
> >> + * IS_ERR() to check for errors. Must bre freed() with kfree().
> > IS_ERR_OR_NULL or needs an actual bugfix in the code since we're not
> > consistent. Also s/bre/be/
> We're sort of consistent, NULL is a valid return code. IS_ERR is only on faliure. :)

Maybe explain that and then Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel

> > -Daniel
> >
> >> + */
> >>  unsigned long *intel_engine_cmd_parser_alloc_jump_whitelist(u32 batch_length,
> >>                                                             bool trampoline)
> >>  {
> >> @@ -1401,7 +1413,9 @@ unsigned long *intel_engine_cmd_parser_alloc_jump_whitelist(u32 batch_length,
> >>   * @batch_offset: byte offset in the batch at which execution starts
> >>   * @batch_length: length of the commands in batch_obj
> >>   * @shadow: validated copy of the batch buffer in question
> >> - * @trampoline: whether to emit a conditional trampoline at the end of the batch
> >> + * @jump_whitelist: buffer preallocated with intel_engine_cmd_parser_alloc_jump_whitelist()
> >> + * @shadow_map: mapping to @shadow vma
> >> + * @batch_map: mapping to @batch vma
> >>   *
> >>   * Parses the specified batch buffer looking for privilege violations as
> >>   * described in the overview.
> >> --
> >> 2.31.0
> >>
> >
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
