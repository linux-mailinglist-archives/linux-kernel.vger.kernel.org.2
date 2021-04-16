Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5FE361F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbhDPMKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhDPMKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:10:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CFFC061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 05:09:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id nk8so718458pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 05:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kalm4mobUMbEi2fiGq9fxLO7hrBXdcxOMDLAzJOaJgw=;
        b=GHzhAEh0ZJSuP3B9e6gxFZV9WFShFbszVgYKTb2p5OyrE2z3u0USPMEJuGOyvuUJsW
         adGYgCUh8e8PaLMwrDzfQfDhM9zsYRCOwlkLi4P8aXFvTHKhOo3pqkZV6wOfoXnv9wHI
         8oZsk63Z6eFCpEI+GEl7Ta83PBMOJ2HMr5m1dO9L5pyS+wmIXW1KqxvpdEwCo6wNLAvS
         t2YdiBKkMU3oHJqCtJFSiMyZTeq8UypLGJPadbM1Uek8kHShAotw21QIX0nxmDoNHWk0
         YCbFwSCXxfvGVrunaUWMEwEyaTVv6kG827MmgEINwXg8Grsi4y7v0NKsOgXJXAGo5oks
         N/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kalm4mobUMbEi2fiGq9fxLO7hrBXdcxOMDLAzJOaJgw=;
        b=YBr9AdnZ/1IwcpPJCGedF2zd1BDjq0YE9iqeQ9DH+a6G9ugisPqmgkx46Zhh16Vwrg
         3MAYt+ziemcsfltLKE7H2f6IsnBTbEaa3Zc2QpX706NKr7NrgKsAC7zYh7CM+qwOw27j
         tmMaxy/mIApxdPGcn41TdK6cUx38X+IQwsEyMe5s9ZFvBpbqKPEnLntmTJABLC0T23S5
         zN8Pf4k+cs/aKM9I+G+gzFsicDLwO1YKvZF2J+hw5ZelLcErwAIXVfh2+uAxjh8fyZvq
         SXm14bAkZuLJj7yHZcMnjYBgS2rpZLHQoFyumXVNHVGm36lhS9lo4vXAahtgQkKB0Qk/
         klsQ==
X-Gm-Message-State: AOAM533IeduIqAGQAzjKYtnA2PnqjUPEGHXmGkviqjVOs3j5km470TKH
        a0ResQDoslaufl5YNGUWgMjvTJVvigxtWA==
X-Google-Smtp-Source: ABdhPJylUhsIG3VFFpchvfgdpDQMlyoUHJCWyGL+z9R6gHxRFrqDkPaGSumQwmrQN6wr70fY1y/JRg==
X-Received: by 2002:a17:902:edc4:b029:eb:159f:32b7 with SMTP id q4-20020a170902edc4b02900eb159f32b7mr9277104plk.11.1618574980806;
        Fri, 16 Apr 2021 05:09:40 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i17sm4726472pfd.84.2021.04.16.05.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 05:09:40 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] bfq/mq-deadline: remove redundant check for
 passthrough request
To:     Lin Feng <linf@wangsu.com>, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210415034326.214227-1-linf@wangsu.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2ac2fd8d-08df-9412-c551-35f34bf7333b@kernel.dk>
Date:   Fri, 16 Apr 2021 06:09:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210415034326.214227-1-linf@wangsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/21 9:43 PM, Lin Feng wrote:
> Since commit 01e99aeca39796003 'blk-mq: insert passthrough request into
> hctx->dispatch directly', passthrough request should not appear in
> IO-scheduler any more, so blk_rq_is_passthrough checking in addon IO
> schedulers is redundant.
> 
> (Notes: this patch passes generic IO load test with hdds under SAS
> controller and hdds under AHCI controller but obviously not covers all.
> Not sure if passthrough request can still escape into IO scheduler from
> blk_mq_sched_insert_requests, which is used by blk_mq_flush_plug_list and
> has lots of indirect callers.)

Applied, with the bfq bits hand edited to apply for 5.13.

-- 
Jens Axboe

