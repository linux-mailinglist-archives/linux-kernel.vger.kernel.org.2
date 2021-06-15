Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C7F3A7DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFOMRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFOMR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:17:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D562C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:15:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f2so18078297wri.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=59bkyyYwA5Alndf1/hcekhkhVORqh2nyBj19xriGPQE=;
        b=uUFMKUyjVW1PYJkOHDZfWmvX5ib7kFcrGnDjM6xoyFBfRHIZjmYr/06XFIOoQqR8E5
         stfsdJHSQMU4Np03ccBzkAdX63SQef+y36cI+ri2hzH8GYJC5owNua1ifNNSPdy0FhQj
         mDa0opiBAaCj3pB3982JrvTJYTCZxEjnJMH3Gh6KatIHm2I4LbpOiJeaesr8OcwM7qy0
         w4Cx70ZVtXOhcoDlFCbDcFvcZ+HL2/2Da7riKLGKlOrD5VlrI/xeBHjaGOQ3CSaXw2QX
         9YOyXxmWcv3KwJtGrAHZY1YIVYoFkQZaJmc4MnmtFDO7teAthbNXkXJx8tMXjrav9tmp
         EzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=59bkyyYwA5Alndf1/hcekhkhVORqh2nyBj19xriGPQE=;
        b=a+vpIb8aNRHy3FmuJZ1BwNoiF4edWXWZvMmDoD71lfmSOuRZFj5AZ72iu4A4fqlHfF
         hE95Cg939vyjNwYna2oUQkAhi8CQqI7QXM2alt11ZRrbdhy1RmFo+aiYhjcvPtYpZeN6
         sHp6nYy/owPQR5nofGZQ6uI8fKD3BUjnCvJIWhbTyUmeOB29dSYHEsiPpeaFj4yTtt7Z
         rzCMXrovc+9HDMycI6xyUU0gtvTYfXgWk3g1Asd66RgdhLazPd9DuNfsXuXStno8fPiM
         iO1LwY9rfKpFH3YDfXe2pzNg4z08Gv7nyJuH12HWdu99Cqs4/GNiTpQmA1clSAczZxGM
         nQtQ==
X-Gm-Message-State: AOAM530Lc8A5PHpHedKgKS4AHyPTFvei7WQhlA25PecSgNdwVS4IFuIR
        IXMWBHsog31CBLuJbgKVQGVFVg==
X-Google-Smtp-Source: ABdhPJzz5oWcqNCv3FNjMZhWaoj2Syuw2ZcjSPc7eTfwtxyNu3l7ni927ofQfDvGy0cphJTvLqPSDQ==
X-Received: by 2002:a5d:6a82:: with SMTP id s2mr5443378wru.247.1623759322073;
        Tue, 15 Jun 2021 05:15:22 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id u15sm1977922wmq.48.2021.06.15.05.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 05:15:21 -0700 (PDT)
Date:   Tue, 15 Jun 2021 13:15:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     patches <patches@opensource.cirrus.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 9/9] mfd: ab8500-core: use DEVICE_ATTR_RO/RW macro
Message-ID: <YMiZ2FwsF6cNokLC@dell>
References: <20210602114339.11223-1-thunder.leizhen@huawei.com>
 <20210602114339.11223-10-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602114339.11223-10-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021, Zhen Lei wrote:

> Use DEVICE_ATTR_RO/RW macro helper instead of plain DEVICE_ATTR, which
> makes the code a bit shorter and easier to read.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/mfd/ab8500-core.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
