Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731EE3FFFA5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 14:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349023AbhICMR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 08:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbhICMR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 08:17:56 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A408C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 05:16:57 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id u7so4994753ilk.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=09TsPIb4fXxY2VJx6kdGXIqWorLQ2YYQZCBibzSAYxI=;
        b=p1Sk/HqyZvS2/jQ16k+A7jzv5x5BnKiB/RxQegu2rH8Ld7j57FDdequtGt21jUW68/
         cuXINnFJsylSpRWjnRELUe+nZ8ANYCoTSF1kOYtUdXYCn/C/znxsaqt7oK0qFNlDJNPE
         XiaVaY4SvPTuk0/KwmryQz/hahFjlfh/RXsn0yLdvwn/r3RpWy6N2zyQ2fw4N7esGclw
         m5JJzZ/G3um+Izf6Wert7LUbilXZpPx7nKemuYG9EvJI5Fbq3WVaOO+xA3kZxbC4x5fr
         DRSL7v7NeMftcUxL1XqvKV0pCsOFaeiRdbORvzwe/uY2GxNkzTG9dpAjQVfoH3nKJ8B5
         51dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=09TsPIb4fXxY2VJx6kdGXIqWorLQ2YYQZCBibzSAYxI=;
        b=aBL5fULCEPB/h5nkhUUK3kmxYNXd/rnDQADlserM1ZXW2A2rwf33nMSHv4i5HdGQtI
         xb6jjmaY4N7wWUzO/ipveAXPY26nro3CBmg11HAQMLeJ+BAq3emHJAg4LO/LFhuIvq6p
         D6KTXY48sZzhyFYkb8e34lbm/gGcq6AECY3Cj10sOjmZmaiKT/4wmW98pMEGZT7wDhoB
         6ARe5cjn/xDYQyxcm+QElOypMySnV0egG4mmqsmm+TsmcoUcVsSIpy9NSfY4T1z0elsc
         cFDSjLOUnQ9Mfqo24zOl/727cF1YNsb7JcwKKEzN3dyeC5CmT0cGdlSPLsSln9fSqz64
         7krA==
X-Gm-Message-State: AOAM530bUtIZnIvU0WxO49zO4VZzGEZOaUtcNS58klt9oXrmJZls3gXC
        cFocl5+1o9kfd1+IRS4w03lLTbz9o2sRyA==
X-Google-Smtp-Source: ABdhPJzhrMWpgAMLYtf5fDP9/i+XboM6XjtDoWIc9/UebbNznBIVEADHycSo0YpoUxqaMuDE1qurIg==
X-Received: by 2002:a05:6e02:524:: with SMTP id h4mr2321673ils.203.1630671416183;
        Fri, 03 Sep 2021 05:16:56 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id z6sm2532738ilp.9.2021.09.03.05.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 05:16:55 -0700 (PDT)
Subject: Re: [PATCH][next] io_uring: Fix a read of ununitialized pointer tctx
To:     Colin King <colin.king@canonical.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210903113535.11257-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5e5e1bb9-c5d3-d668-8a61-f70538ef92df@kernel.dk>
Date:   Fri, 3 Sep 2021 06:16:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210903113535.11257-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/21 5:35 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the unlikely case where ctx->flags & IORING_SETUP_SQPOLL is true
> and sqd is NULL the pointer tctx is not assigned a valid value and
> can contain a garbage value when it is dereferenced. Fix this by
> initializing it to NULL.

Doh - thanks, I folded this one in.

-- 
Jens Axboe

