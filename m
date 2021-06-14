Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319F53A714D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 23:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbhFNV1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 17:27:44 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40885 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbhFNV1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 17:27:40 -0400
Received: by mail-ot1-f54.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so12240215otr.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 14:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TO9Bs79gztMyICj6nDYaJ2faYwOyqme0BmKfJqudN6c=;
        b=MAlMTIYJrSzUkIynEKEvJwHNTEURmUDLEmfLyolB7+7KOSvPyvdbvzXvhlVTJX418q
         MeflEMUUNLOM9kQ7C7HFA/B98sdBltT4J35FkvBh50APvRRI5S6YO6HLVaLorvJBp+xq
         Tf+Re0kj57rPUQy6SOahNmYQfP32ogkJwaLhji4l+ON77/dd5jJI3r1eLHBEnFB2Xpzt
         UYdYM7ZY3I3j/Qb8w6kOaz1uZ8GYvy17yxSfpNCyuk0gav6UoIonOUH8fhHfqfU8dW54
         CO3Hsgx8RxPVW0FziWIfeZtibTVsZ3+xVp5cNxm6gLf/caBp/swj9dz/JPnuFPB1KTuy
         J85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TO9Bs79gztMyICj6nDYaJ2faYwOyqme0BmKfJqudN6c=;
        b=RGTjkKvjz759C9HfDKPGE9WDZWQs7HiUVtet9fXYmwrvCPUUXZ/HSBarW7x0uZidcz
         XBOVPNRvvkbtLDzoiARibhaS7JdoVCWvQV7+NY3Q5v0nuujrGbi9ixm8NRXcDucg8YPv
         6o0YCD5PYpNCJzdIukKSi59wTPLdtJeVGG3FTTriAlvBlCA6daX/1Q0irVTTKLeHr989
         gw0/Ow97gVg4AE6cUtMbWLvpmvCj+ksbbvsy+EyujIdi22K3jd5GjU76EFckc5/tlMsZ
         YSvY/FOtVX5XfCDAGc6ejIPl/5mSyDBapSl4JgB6h4H8yP43+cnHmqN0GoH9VKwhi2Ku
         Y74g==
X-Gm-Message-State: AOAM5315EnGfb3Xwp6ELLmXWXFOKqpVz0GRf6CIKxSZCFDucyCha8M0r
        FjRUTKgfQPDwJMHMDGYiVXcwgw==
X-Google-Smtp-Source: ABdhPJyVimCUo7TyjD1QtiSOvlaO50H3UWaKQNbqv2Mkg7HGo6Pv/DqgJiUMApOHpuLfp9sYNgWN+A==
X-Received: by 2002:a9d:6f0d:: with SMTP id n13mr14998451otq.168.1623705862290;
        Mon, 14 Jun 2021 14:24:22 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x2sm3295902oog.10.2021.06.14.14.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 14:24:21 -0700 (PDT)
Date:   Mon, 14 Jun 2021 16:24:19 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>, linux-sunxi@lists.linux.dev,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC PATCH] dt-bindings: hwlock: sun6i: Fix various warnings in
 binding
Message-ID: <YMfJA7bmFoIymctO@builder.lan>
References: <20210603144216.10327-1-s-anna@ti.com>
 <CAL_Jsq+mhJgFZniXYTVf5ZEM84APhm2w_ozLJg_pFtgz+W_wYw@mail.gmail.com>
 <cd7ab36e-76f3-3d13-6896-6d812c66b0e3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd7ab36e-76f3-3d13-6896-6d812c66b0e3@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Jun 14:15 CDT 2021, Suman Anna wrote:

> Hi Bjorn,
> 
> On 6/7/21 8:19 AM, Rob Herring wrote:
> > On Thu, Jun 3, 2021 at 9:42 AM Suman Anna <s-anna@ti.com> wrote:
> >>
> >> The allwinner,sun6i-a31-hwspinlock.yaml binding has a mismatched
> >> $id and fails to compile the example due to undefined args specifier
> >> values for clocks and resets. Fix both of these issues.
> >>
> >> Fixes: f9e784dcb63f ("dt-bindings: hwlock: add sun6i_hwspinlock")
> >> Signed-off-by: Suman Anna <s-anna@ti.com>
> >> ---
> >> Hi Wilken,
> >>
> >> This fixes the warnings for now on linux-next, but I think the example
> >> should be including sun6i-a31-ccu.h files instead to be accurate, and
> >> those files are missing the definitions for CLK_BUS_SPINLOCK and
> >> RST_BUS_SPINLOCK. Feel free to send a newer version or do an incremental
> >> patch on top.
> >>
> >> regards
> >> Suman
> >>
> >>  .../bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml      | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > 
> 
> Gentle ping, can you pick up this patch and the remoteproc pas binding
> indentations fixes please so that linux-next is sane w.r.t these?
> 

Sorry, I picked up some (biological) bug and haven't been of much use
the last couple of weeks. I've picked the two patches now, thank you
Suman!

Regards,
Bjorn
