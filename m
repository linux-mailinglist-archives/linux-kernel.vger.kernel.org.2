Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227AB3D0F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbhGUM3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236709AbhGUM3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:29:12 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE50CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:09:44 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n4so1304840wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tHmB5kkgrWA99Mw1mjaFWztLpoqJ2vPxQBq9hPpb8a8=;
        b=l0XWIeTg4o/w9RqkkmMJYCfq/HlkvryFqjVUmN+vvlCUAAkjXMpABoEQ33ltaxt7V8
         JoCOOJgKL/XrKOBqI/yn4iVCfKpAaKR1glkip5mDKolTD+LxqzUQniB2u2lqkUNJhMX/
         qh71rPBI9ddJH5CUzAGBx1rC+EuBRSCE1fl3zllmikGQQAqBwAG0q1oDdhrzCIrIThCb
         pp2U9oxG4k6lqfxL88iSb5EUYs20ktodWtq/aEZotFQJDmLZWZjtCsrX9IHz8cWmN0fm
         95Gw+8i9v+etCXkRf6u5wL5NglQLUUjJaBHwYfdWVNALT9LfXNr8372o5bgQXIprMrGf
         yZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tHmB5kkgrWA99Mw1mjaFWztLpoqJ2vPxQBq9hPpb8a8=;
        b=O0DxEuQfXXMiJUsH9zbEy/yoTortQmaQtmeI435nShvG9eHVJJRfUgl7Z8gyUwShIF
         gKoU45z/+afduc50Iiwf3yMrOqZy+eVOaPooHDuPGJ5de1QBSviBLdfztobff+hnv7qw
         GI6tgdZ9rF8wpPJ9yGnVuGAaBR6F1GJzvd+mIAAugx4YoY8yIivOn8Z1n9qe4nBVDfJj
         CIFDEvqEfqtFw9qA+EdmfwgjXiwWkJ2Yb/WxqC7wpNDgHWd8aC6YLQS6g00Xxb9Wpi+m
         szj2s9+QdLs+3zPqfDLMaPyXRCSOq1yjpvpdU0+IFIfcosmnGSbyPvu7xWpjGqtMJH0E
         qzgQ==
X-Gm-Message-State: AOAM531IgQJJLqv/ukvdl7RFT6HN4JHsShn+F1vH9SK1AINjirIzM/NM
        xR2+SkGegFQJpa1kAosDQtef9A==
X-Google-Smtp-Source: ABdhPJx3wPg38RBMBbQF/Rsi2wcT8ZKhMHkIEVx7EnljhmNKpe2h6MTpceqzCmQ3UfLbNGXeBCTepA==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr37668757wmb.71.1626872983112;
        Wed, 21 Jul 2021 06:09:43 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:efb1:2fcc:e84:52ad])
        by smtp.gmail.com with ESMTPSA id t15sm26208998wrx.17.2021.07.21.06.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:09:42 -0700 (PDT)
Date:   Wed, 21 Jul 2021 14:09:39 +0100
From:   Quentin Perret <qperret@google.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        qais.yousef@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 1/2] sched: Fix UCLAMP_FLAG_IDLE setting
Message-ID: <YPgck3j01cI3VzqD@google.com>
References: <20210719161656.3833943-1-qperret@google.com>
 <20210719161656.3833943-2-qperret@google.com>
 <7ef85d3f-fd2b-a192-07ef-3431b33d06ce@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ef85d3f-fd2b-a192-07ef-3431b33d06ce@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On Wednesday 21 Jul 2021 at 12:07:04 (+0200), Dietmar Eggemann wrote:
> On 19/07/2021 18:16, Quentin Perret wrote:
> > The UCLAMP_FLAG_IDLE flag is set on a runqueue when dequeueing the last
> > active task to maintain the last uclamp.max and prevent blocked util
> 
> s/active/runnable ?

'active' should still be correct here no? We enter uclamp_rq_max_value()
-> uclamp_idle_value() when the last _active_ uclamp_se is decremented,
and when all the buckets are empty, so I think that works?

> > from suddenly becoming visible.
> > 
> 
> [...]
> 
> IMHO, the main argument in v3 to do the clearing outside
> uclamp_rq_inc_id() was a possible order change in `for_each_clamp_id()`.
> So setting/clearing `rq->uclamp_flags` (UCLAMP_FLAG_IDLE) on UCLAMP_MAX
> (currently the highest Uclamp constraint (UCLAMP_CNT-1)) could be
> incorrect when UCLAMP_MIN and UCLAMP_MAX change place because the
> same `rq->uclamp_flags` value is needed for both Uclamp constraint
> values.
> 
> What about decoupling rq->uclamp_flags` handling from UCLAMP_MAX and
> doing this for 'UCLAMP_CNT - 1', i.e. always on the highest Uclamp
> constraint?
> 
> #define for_each_clamp_id(clamp_id) \
>     for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
> 
> In this case the code change can be as easy as in your original v3.
> 
> Setting UCLAMP_FLAG_IDLE in uclamp_idle_value():
> 
>   uclamp_rq_dec_id() -> uclamp_rq_max_value() -> *uclamp_idle_value()*
> 
> Resetting UCLAMP_FLAG_IDLE in uclamp_idle_reset():
> 
>   uclamp_rq_inc_id()                          -> *uclamp_idle_reset()*  
> 
> This would be more symmetrical then uclamp_idle_value() and
> uclamp_rq_inc()/uclamp_rq_reinc_id().

Right, thanks for the suggestion but to be fair I feel like this is a
matter of personal preference at this point. I personally like the way
it is in this patch -- I find it easier to reason about, but maybe
that's because I wrote it ...

Do you feel strongly about it? If not I'd prefer to not re-spin this
another time if possible. Let me know what you think.

Cheers,
Quentin
