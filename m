Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C973C615C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 19:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhGLRFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 13:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbhGLRFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 13:05:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC6AC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 10:02:50 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t9so18922237pgn.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 10:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ky1ue84KgGwfreyhLvw/BDOYfpBZ+Y8ifvh6z3HWvzc=;
        b=ecQD2maUFmXVDkbOiTsKUtJQ0fGBkTTVEGRFRo5SXBXwSdr7ICGGSX59fX8uJipPr+
         nz1DEijHp2ILSoHDhLXg4afr+V1PdNjN2JZiKCicEvPxHSYyNf4SVK/cQXgUq2GD7Bgx
         L5cnspMCFSeWN686i4kKVzBynaw44ejTyJDL+EGSoh0pPu106LhmrAf7qBlUD2x84DmF
         QpekJSqfTgp1s7rN9+brvFvCdSxAt0ipXYwBZLlS6/aQ7ACGkSdmXfXBFMX2lW6VEfyp
         m2HV/FTHranm+jBvunDzTc8kJ3yOhIuUT9d1Scl835mXxsNlWvNzLuI5Kuhjqnm7Z0K8
         n4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ky1ue84KgGwfreyhLvw/BDOYfpBZ+Y8ifvh6z3HWvzc=;
        b=AbiB79mmpiToQ7YbxLSaTZcMdOn1rBglh+CZhtDtdVG1M73hpJk6rju3QSSPO3e+gV
         w9r4bo7qb2aBJVcqOQDCdBCbi3Cd7LwrxfZsDWQceeBx5z0pQlqLkLhmxICwg+P1Pxcw
         72ZkTfABiC0iB86yWqE2pQLB4TtNYCUuRyWnNPLmeJWawAzxng2E9EbckzUJaQSU/J8+
         IDfiIeeCZLBa14ZMn7xLFW06DE3RD8eL5KN52DvM8HaIqFbEC4+fBxhLDgOh/9Yhvnf0
         bBrYA6SqK/sQ/BpiY1DEqLHebkNZr32wdZnutC4xq4VP8w6yha+gGCfd6AIh4C5BpQTV
         Mi/w==
X-Gm-Message-State: AOAM5311yNJqb6mGDILwZgw2prW3U15QpV0MMNr8j//qEgSOL1bs+hKe
        GOcP4q83tqPw11lynhCUO06iZg==
X-Google-Smtp-Source: ABdhPJyuYYHC9Rny2vCYmH80gfiLvlPOz8T/09NIAxw0S5tx3hoINt7Ax4YAl/JH8lJgV/WpRTQJag==
X-Received: by 2002:a05:6a00:1a4b:b029:315:77ff:b5c3 with SMTP id h11-20020a056a001a4bb029031577ffb5c3mr190909pfv.21.1626109369657;
        Mon, 12 Jul 2021 10:02:49 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id w5sm16362920pfq.130.2021.07.12.10.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:02:48 -0700 (PDT)
Date:   Mon, 12 Jul 2021 11:02:46 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, al.grant@arm.com,
        anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, peterz@infradead.org, Tamas.Zsoldos@arm.com,
        will@kernel.org
Subject: Re: [PATCH 0/5] coresight: TRBE and Self-Hosted trace fixes
Message-ID: <20210712170246.GB1777012@p14s>
References: <20210712113830.2803257-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712113830.2803257-1-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 12:38:25PM +0100, Suzuki K Poulose wrote:
> This is a series of fixes addressing the issues in the way we handle
>   - Self-Hosted trace filter control register for ETM/ETE
>   - AUX buffer and event handling of TRBE at overflow.
> 
> The use of TRUNCATED flag on an IRQ for the TRBE driver is
> something that needs to be rexamined. Please see Patch 3 for
> more details.
> 
> Suzuki K Poulose (5):
>   coresight: etm4x: Save restore TRFCR_EL1
>   coresight: etm4x: Use Trace Filtering controls dynamically
>   coresight: trbe: Keep TRBE disabled on overflow irq
>   coresight: trbe: Move irq_work queue processing
>   coresight: trbe: Prohibit tracing while handling an IRQ
> 
>  .../coresight/coresight-etm4x-core.c          | 109 ++++++++++++++----
>  drivers/hwtracing/coresight/coresight-etm4x.h |   7 +-
>  drivers/hwtracing/coresight/coresight-trbe.c  |  91 ++++++++++-----
>  3 files changed, 149 insertions(+), 58 deletions(-)

Anshuman - please have a look when you have a minutes.

Thanks,
Mathieu

> 
> -- 
> 2.24.1
> 
