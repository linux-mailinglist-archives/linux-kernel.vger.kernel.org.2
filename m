Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441FD4163B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbhIWQ5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242348AbhIWQ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:56:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CF3C0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:55:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l6so4391483plh.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jSuBlBfaIy24uL2d9dpjMy481vp88ziEVtNAfshWA+8=;
        b=th5z0JoGd4uMzaOOpw2GWXG6BnS5J5+Q6L6EgLtuTtg16Yvv97wCBEXPOjTC+nnhOp
         QLAln4dQsAjgwh5Y6huB7Q0cfvyCbDW86ffUFnYvaM0ZcFS9fgFc+XRzjWUeIKq7mSm8
         AFYatwqK961Ii2bAHmDtq9a8vqm2MUgXtjPHh+MnGszxJZCBUlZ7ybghuvqAPHTBHmjj
         UShCHARPQsaK7nOBjNjY23jgWI6VCiAAgZ49H5x9HfJ71J8/puI8Mg/n7p420g93Hxg9
         ATNKB4bG9okmreogyv05qcz3TzL+QheyA86f7WWH6N+264pjPP6lgbFQYLHs3ywr1m2g
         8I8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jSuBlBfaIy24uL2d9dpjMy481vp88ziEVtNAfshWA+8=;
        b=R7+7xSv16rrelXth+B0oI+YI5s0gDPK3iEYvzOuSCPGXA2ayMU0BBqQqws36+uHO7u
         4UKmRxOWPJ4C2rcEQU4PmxkXvUWFWwb5VhzFD56jzU4v30a2vTKfLnHuv7wVKgZUmPBZ
         6ThpgYKCeSyLK3tHZIMXKoi8KRda3vJKEhenQWrPrDfdnQmgVY46WZTZ4SZWimJIWcnG
         y/W5D1YbSS71+DTQCPFuRRHCBe0zfCz89SAQeTaWw4dLx0Xc3s6lEOjbGY1ZcQZ8mzXT
         BatAq6IwYAVvirpcVKWfGefI7PGJcDeLy6380yFmkDB4MOWp7xqhpmyI3LYlE3C/7ZCB
         29Ag==
X-Gm-Message-State: AOAM533GsuGLjIHVU1ydaq/8mzzLx1TZjKsoq5zUhrUKG4gb4EDydGP5
        b0jcb+2G8yjTE/GWNcVXIcYhJg==
X-Google-Smtp-Source: ABdhPJwNCPazE/vKZcizYu/509I61fe9qoD1EEJrhgZfdj5K5kCX9W4S6gGXjtbwMZTFKfPq1oL82Q==
X-Received: by 2002:a17:90a:a087:: with SMTP id r7mr19295754pjp.84.1632416106768;
        Thu, 23 Sep 2021 09:55:06 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j11sm9994545pjd.45.2021.09.23.09.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 09:55:06 -0700 (PDT)
Date:   Thu, 23 Sep 2021 10:55:03 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] coresight: TRBE and Self-Hosted trace fixes
Message-ID: <20210923165503.GB2189675@p14s>
References: <20210923143919.2944311-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923143919.2944311-1-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 03:39:14PM +0100, Suzuki K Poulose wrote:
> Here is the updated patches from the v3 of the series [0], parts of which
> have been queued to coresight/next. This series now applies on the
> coresight/next branch.
> 
> Changes since v3:
>  - Split the spurious IRQ handling patch to :
>    a) coresight: trbe: irq handler: Do not disable TRBE if no action is needed
>    b) coresight: trbe: Fix handling of spurious interrupts
> 
>  - Added a helper to mark the ring buffer when there is WRAP event
>    and added a comment to explain.
> 
> [0] https://lkml.kernel.org/r/20210914102641.1852544-1-suzuki.poulose@arm.com
> 
> Suzuki K Poulose (5):
>   coresight: trbe: irq handler: Do not disable TRBE if no action is needed
>   coresight: trbe: Fix handling of spurious interrupts
>   coresight: trbe: Do not truncate buffer on IRQ
>   coresight: trbe: End the AUX handle on truncation
>   coresight: trbe: Prohibit trace before disabling TRBE
> 
>  .../coresight/coresight-self-hosted-trace.h   |  4 +-
>  drivers/hwtracing/coresight/coresight-trbe.c  | 96 ++++++++++++-------
>  2 files changed, 64 insertions(+), 36 deletions(-)

Applied and pushed - thanks for the modifications.

Mathieu

> 
> -- 
> 2.24.1
> 
