Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F053DD184
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 09:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhHBHry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 03:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbhHBHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 03:47:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35899C061796
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 00:47:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l18so20321234wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 00:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iUhecmtOEFBOc/n8Ox/w9VyUCPFMQi2/vzz/bstOM4g=;
        b=ixzKpGkfHnM1TJkRFBHUhQdH/W4ackddH1I+yYxn6v7vZE1JIiGfQwWrRWv0uEg990
         teA+I9WXVILBiVqIHA5fSk3QPncnNuNdCqbRGcSMqMCMfyQudam2r3GtIkcZxXk8jT7b
         MNTkYQjQBs8aDMO0xSAy1X6xGkgWYik0x1eVoa0UkftQkVjn6klKNp04f4vthyUwnK7P
         XxL5umd+7jlis8eDau67azw/ljb7Q48NqKqEolijNF4UAqwPv9uU7P+ZldQV+X/3HAgg
         i36flnHC+WM1vL04Ri/jfqDUCMcDS93n7ICsvfsV8w4zmv6V0ztwds/m5rNPs5u1VuhI
         xVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iUhecmtOEFBOc/n8Ox/w9VyUCPFMQi2/vzz/bstOM4g=;
        b=SP9a2wush+8ISBtJn17JbzEI1KEdK0dsLWyUsh5fzsXw1IGK0GHFINjI8fMliQ2mly
         BBOkfXsyX7gYbcv0w4tHx2xaroGDUyPSNaKtT3UdKquIYzLFCA74+8Ay1m5PR/Jq7NFO
         oz/LIqrHcoxWPgvW7Y/KcXXRf53EXO+77GrYP5tiqkzkvWgUlS2URwXS3PjsHmghv0St
         Gv4hNLIBqya2Zmp3c0vdcMbj/mAni5jM07B7W8+pk1Hw8jA8DEs1zgXCbT4pX8xazihc
         1umq6oLR9tW6zXvZkcTXGYszJd25n3FMzSVIYfKnUsq3Xq/AtInn2xKj8/pqxiwj+PTd
         I0Ig==
X-Gm-Message-State: AOAM533OwOKLaOIm2qPSlO/BRtJK0BlBBPNKBCxY9CKSpjhY/CngVW3K
        yPLlJA4Qypb2lKXCs/dep0O+tA==
X-Google-Smtp-Source: ABdhPJw971iLzA6b1H5TxMDnRNFA5vYa4ieLVAtaXNg8xx2Cc3YPcHZRCRQrUKzvmPuLhmWy2FqsXA==
X-Received: by 2002:a05:6000:12c3:: with SMTP id l3mr15805272wrx.314.1627890462858;
        Mon, 02 Aug 2021 00:47:42 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id q17sm10214086wre.3.2021.08.02.00.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 00:47:42 -0700 (PDT)
Date:   Mon, 2 Aug 2021 08:47:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: db8500-prcmu: Handle missing FW variant
Message-ID: <YQejHNP1AzFHZ6gK@google.com>
References: <20210801233314.3150754-1-linus.walleij@linaro.org>
 <20210801233314.3150754-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210801233314.3150754-2-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Aug 2021, Linus Walleij wrote:

> There was an "unknown" firmware variant turning up in the wild
> causing problems in the clock driver. Add this missing variant
> and clarify that varian 11 and 15 are Samsung variants, as this
> is now very well known from released products.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: phone-devel@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Clock maintainers: could you please ACK this so Lee can take
> this into the MFD tree? The chances of merge collisions are
> zero, this code changes very seldom.
> ---
>  drivers/clk/ux500/u8500_of_clk.c | 3 ++-

>  drivers/mfd/db8500-prcmu.c       | 6 ++++--
>  include/linux/mfd/dbx500-prcmu.h | 3 ++-

Acked-by: Lee Jones <lee.jones@linaro.org>

>  3 files changed, 8 insertions(+), 4 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
