Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA10B45750D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 18:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbhKSRNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhKSRNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:13:51 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC99DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 09:10:49 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso11508216pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 09:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xn9oHtNBIj0lOv649NxoHmuiSB+2dU7pyhrYAjPsSC0=;
        b=SdnZDSecqh2GX5AD1hZPPmDLPvIgbBoayss7fCg8ZdOCm2O4xy3WvqYUwT5gYPlwL5
         bnnpUfP+dnrFAy1eZCQAd98U6rka6XDKXRkjHElpuhqU5o0aoTbAXGZefwycvaz4Puja
         pkmxjGFPEPgA8RYk4E3Qt44bHgnQKfVqqcqVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xn9oHtNBIj0lOv649NxoHmuiSB+2dU7pyhrYAjPsSC0=;
        b=VYmoBUP5ImQo7k9p5o+MZev5SkKhyZtf9RlmGknpQsUG0TSoUd22kulwnuwvdOmQ80
         zR4jgxk4gE0bEJiA8Ey5XuOSC3Xyz60xYKyhDbBVXQorpnMY3435Z44BYuf9cEKw9xrt
         KEuDP6HunUl9FLYIJqJLbKRsdQBRcHJC3t1RHJjcNWLGgrxp1rfalPwxrlEHv3BJy6Kg
         Zyub8m+18QMsPH68xleqzWXAX89uKUF8FE2qEsXCyUSdvlGBzkBp+5kLKgNlQUOJvAnV
         QmBColTcY3oO3TBlMqcmntwDooU2QidhOAcIHJLng2hjTqhEspGw8bbDtcYxsbus7FUt
         973Q==
X-Gm-Message-State: AOAM533MNYHxdGWddu2iLIMq8gWXLz4STVo+Zg+MZiejiiolk7iE68BM
        ZHNhizOVbZJ6LCeU4x1CQD4Ejw==
X-Google-Smtp-Source: ABdhPJy3xGNw4sOzzuv9YSkO0mTP+i2PafIoXeEyImX1WorlzIkRPvugnYaIB9TOE9BatRvpteHGcw==
X-Received: by 2002:a17:90b:3b43:: with SMTP id ot3mr1369497pjb.205.1637341849326;
        Fri, 19 Nov 2021 09:10:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g13sm205781pjc.39.2021.11.19.09.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 09:10:49 -0800 (PST)
Date:   Fri, 19 Nov 2021 09:10:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, mark.rutland@arm.com, will@kernel.org,
        ndesaulniers@google.com
Subject: Re: [PATCH 2/3] x86: Use -mindirect-branch-cs-prefix for RETPOLINE
 builds
Message-ID: <202111190910.73331E48D@keescook>
References: <20211119165023.249607540@infradead.org>
 <20211119165630.276205624@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119165630.276205624@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 05:50:25PM +0100, Peter Zijlstra wrote:
> In order to further enable commit:
> 
>   bbe2df3f6b6d ("x86/alternative: Try inline spectre_v2=retpoline,amd")
> 
> add the new GCC flag -mindirect-branch-cs-prefix:
> 
>   https://gcc.gnu.org/g:2196a681d7810ad8b227bf983f38ba716620545e
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102952
>   https://bugs.llvm.org/show_bug.cgi?id=52323
> 
> to RETPOLINE=y builds. This should allow fully inlining retpoline,amd
> for GCC builds.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
