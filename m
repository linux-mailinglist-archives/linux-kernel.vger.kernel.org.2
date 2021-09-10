Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E44406C76
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 14:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhIJMuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 08:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbhIJMuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:50:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA8BC061756
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 05:49:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f3-20020a17090a638300b00199097ddf1aso1443012pjj.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 05:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OruuubkQ8i3YLqb6+3r6RVE7e77MrkfQsER8optuCOM=;
        b=c7M0Om1a+77yc41d1QfC822W/3TI+8tUgsZ8+YDbYlDvNkRM5nV1Yt20zmxvhA7l0h
         eS7rYYVwukesan7zh6oTys6Trli56PR39GNbsaF+Tf2FZhCdH3CBdPdErKg9hLCy9jCf
         NPiumAjqQb5Ti8Ctdx0evhMLkvFkkLFzd7jpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OruuubkQ8i3YLqb6+3r6RVE7e77MrkfQsER8optuCOM=;
        b=LgNnl6uNrWi2ahajmDWYA/1f0VfgqVjXBKspNLcFqUaTceHsshqNuU9Qh1qU/G0JhB
         gBanumkERSSAyRhx7mXa9moL1q3Rt5f3TjGVYzwrWjTnFwlGZpwxIhgy49KaWimYiiXs
         nYoSSGprOEAvFrif+uDkIGLl+CkmNle8ZilibZFqBOl1Gwassro8XX5ffBlb00v5k3KK
         K1776ZdL0h3l1Bd3AHFmhodMxky0Mc6L3g7vBClKVs8Vj5030F/fMguvYR1xtiU+CsC/
         WwN64j8DoqkcNYA48idS8/xZqo9ieO1D9Qg93kzv8LCR2dHpDnF/1Aem9yDT6ehwbrnn
         rn9w==
X-Gm-Message-State: AOAM530fwM6+yqeSlPGmIg+A3UtBPcn9UbXbPFxqwNE/CRy43x1un8xj
        OehBpeMIXsouwPkVCCUwN04aWQ==
X-Google-Smtp-Source: ABdhPJyeQzjtxluE/5VxrHOJXu7FA9FgDVGp2E++lsR+iYm7Pj/7GTCIRRtL4FsW9NdS7b0m7PdXeQ==
X-Received: by 2002:a17:902:64d0:b0:13b:67b3:e2e8 with SMTP id y16-20020a17090264d000b0013b67b3e2e8mr2149434pli.10.1631278142262;
        Fri, 10 Sep 2021 05:49:02 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:7627:5944:d90:b374])
        by smtp.gmail.com with ESMTPSA id u24sm5474912pfm.81.2021.09.10.05.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 05:49:01 -0700 (PDT)
Date:   Fri, 10 Sep 2021 21:48:57 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v4l-compliance: re-introduce NON_COHERENT and cache
 hints tests
Message-ID: <YTtUOXF1qGbL+q0V@google.com>
References: <20210709092227.1051346-1-senozhatsky@chromium.org>
 <619afe51-4cba-95e0-69bc-bb96e1f88aae@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <619afe51-4cba-95e0-69bc-bb96e1f88aae@xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On (21/09/10 14:20), Hans Verkuil wrote:
> Hi Sergey,
> 
> I've applied the "[PATCHv6 0/8] videobuf2: support new noncontiguous DMA API" series
> to my kernel, and applied this patch to v4l-utils.
> 
> Running 'test-media vim2m' in contrib/test results in the following compliance failures:
> 
> Streaming ioctls:
>         test read/write: OK (Not Supported)
>         test blocking wait: OK
>         Video Capture: Captured 8 buffers
>         test MMAP (no poll): OK
>         Video Capture: Captured 8 buffers
>         test MMAP (select): OK
>         Video Capture: Captured 8 buffers
>         test MMAP (epoll): OK
>         Video Capture: Captured 8 buffers
>         test USERPTR (no poll): OK
>         Video Capture: Captured 8 buffers
>         test USERPTR (select): OK
>                 fail: v4l2-test-buffers.cpp(1869): !(flags & V4L2_BUF_FLAG_NO_CACHE_INVALIDATE)
>                 fail: v4l2-test-buffers.cpp(1932): setupDmaBuf(expbuf_node, node, q, exp_q)
>         test DMABUF (no poll): FAIL
>                 fail: v4l2-test-buffers.cpp(1869): !(flags & V4L2_BUF_FLAG_NO_CACHE_INVALIDATE)
>                 fail: v4l2-test-buffers.cpp(1932): setupDmaBuf(expbuf_node, node, q, exp_q)
>         test DMABUF (select): FAIL
> 
> The same happens with e.g. vivid, but vim2m is quicker to test.
> 
> I'm not sure whether this is a bug in this v4l2-compliance patch or whether it is
> a bug in the v6 series, but it should be checked.

Looking into it now. I ran v4l2-compliance, but not "contrib/test/test-media"
