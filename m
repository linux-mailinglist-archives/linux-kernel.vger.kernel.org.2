Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482D242BF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 13:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhJMLxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhJMLxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:53:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256A6C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 04:51:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u18so7476658wrg.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 04:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=vki2MOpHiPRjF8WV03xObL8WLrTT/QCXIdeoymbkrg4=;
        b=HOpvbV/8VIT89xQR1G4qB0gn/wkeFr8tbi7t7Ej6scW9DiwHBv0LY+jJ7JSgoE6KyU
         ZKyYEyAPrAtFtBiWCENUNiCOHeHWltxgzVqvUv9juywA/4hMMtJV05+HobRwvzQ6gnfu
         YRNTwUtzRrjTIr12GISb0kYjCbUdwoXkepK6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=vki2MOpHiPRjF8WV03xObL8WLrTT/QCXIdeoymbkrg4=;
        b=PovOAWkJqtdaBe3cSmakMfg1+LCDSb1S0ZJTikxZitQWiqrwagW+Ai7C0XdO8Txc8B
         u9+eQx7kpwAgvHedirk9Kaa6JKRrJ1GjoUA5ilB7bhS7X5nRmLGGgj0m/2uXusC4bqy9
         VSXn3kIXp5qr73wt12rYiL4daYzT2ufvcv3i93bBpB8JM0gHsFUYRyZoVUh8DhRMRxSe
         aXeGaL9gflglMxi9itCOwIcz4B60j6+l8rP2Ktz1OIIOMfz+DdbIMxDSO3WIxojeX5OP
         TGCy40xMhzQhsn+tR/tVSV8Jvt0bRZl37sJ4ctV1VSDD01DDN6wjUSWpUpqhIRz0fLqc
         aQyA==
X-Gm-Message-State: AOAM532Y1xhbM9YQCsir4RnHQuQ7C65hPbweZ8roEqhrM3nqL9+H6DqL
        Ut1SUvns3oitLJKdZcYSB4XSCD0GP8e1uA==
X-Google-Smtp-Source: ABdhPJyqMmgpu2ql1/ClhZBIYGjM/oxKKvUtKMfYyVBZ/3VbeIdFLbpRezHwmnmwnj2CHBJT0vE0iA==
X-Received: by 2002:a05:600c:154a:: with SMTP id f10mr12123883wmg.184.1634125892773;
        Wed, 13 Oct 2021 04:51:32 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b10sm8533490wrf.68.2021.10.13.04.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 04:51:32 -0700 (PDT)
Date:   Wed, 13 Oct 2021 13:51:30 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Len Baker <len.baker@gmx.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Prefer struct_size over open coded arithmetic
Message-ID: <YWbIQmD1TGikpRm2@phenom.ffwll.local>
Mail-Followup-To: Jani Nikula <jani.nikula@linux.intel.com>,
        Len Baker <len.baker@gmx.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211003104258.18550-1-len.baker@gmx.com>
 <20211011092304.GA5790@titan>
 <87k0ihxj56.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0ihxj56.fsf@intel.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:24:05PM +0300, Jani Nikula wrote:
> On Mon, 11 Oct 2021, Len Baker <len.baker@gmx.com> wrote:
> > Hi,
> >
> > On Sun, Oct 03, 2021 at 12:42:58PM +0200, Len Baker wrote:
> >> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> >> and Conventions" documentation [1], size calculations (especially
> >> multiplication) should not be performed in memory allocator (or similar)
> >> function arguments due to the risk of them overflowing. This could lead
> >> to values wrapping around and a smaller allocation being made than the
> >> caller was expecting. Using those allocations could lead to linear
> >> overflows of heap memory and other misbehaviors.
> >>
> >> In this case these are not actually dynamic sizes: all the operands
> >> involved in the calculation are constant values. However it is better to
> >> refactor them anyway, just to keep the open-coded math idiom out of
> >> code.
> >>
> >> So, add at the end of the struct i915_syncmap a union with two flexible
> >> array members (these arrays share the same memory layout). This is
> >> possible using the new DECLARE_FLEX_ARRAY macro. And then, use the
> >> struct_size() helper to do the arithmetic instead of the argument
> >> "size + count * size" in the kmalloc and kzalloc() functions.
> >>
> >> Also, take the opportunity to refactor the __sync_seqno and __sync_child
> >> making them more readable.
> >>
> >> This code was detected with the help of Coccinelle and audited and fixed
> >> manually.
> >>
> >> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> >>
> >> Signed-off-by: Len Baker <len.baker@gmx.com>
> >> ---
> >>  drivers/gpu/drm/i915/i915_syncmap.c | 12 ++++++++----
> >>  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > I received a mail telling that this patch doesn't build:
> >
> > == Series Details ==
> >
> > Series: drm/i915: Prefer struct_size over open coded arithmetic
> > URL   : https://patchwork.freedesktop.org/series/95408/
> > State : failure
> >
> > But it builds without error against linux-next (tag next-20211001). Against
> > which tree and branch do I need to build?
> 
> drm-tip [1]. It's a sort of linux-next for graphics. I think there are
> still some branches that don't feed to linux-next.

Yeah we need to get gt-next in linux-next asap. Joonas promised to send
out his patch to make that happen in dim.
-Daniel

> 
> BR,
> Jani.
> 
> 
> [1] https://cgit.freedesktop.org/drm/drm-tip
> 
> 
> >
> > Regards,
> > Len
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
