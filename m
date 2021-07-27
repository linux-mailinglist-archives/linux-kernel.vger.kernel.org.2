Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DAA3D835F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 00:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhG0WpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 18:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhG0WpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:45:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E49C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 15:45:07 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso7053834pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 15:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F2VzMT246wGHVuc/C9Yr3QO5HUyDdP84+0q/UDf2X6g=;
        b=PwMkTFH/H7ItHM5Ni1u4MMEdqyaBLO3/VCima4M0PnAJqoTXJkRnqf6kAoBsGyb4He
         CH+fDf5FHRa1L7Lvsgyi55s00bbJGF+1nNsmYyw3kRz+7EodZ/BrJZ170fbhB3YYXplM
         dUyuKmzDp7/lQP8hLTbBeaZB93HGv/yXHBdckuVS/55YrydpcymOulVx9NCuTaP9G8Tn
         i/pTPmxsEIIcQ3xwtrCTEK3XvwMKXiOXXpkMFneL3ON90V0YJPQCM4O34sWDL+AZPAdn
         K4RXRaoxejlfTO+5nZEidGO5gs3m8TorFdA9hXkY3M1SxBQJvkgOc6sLawTavyxwegEI
         u2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F2VzMT246wGHVuc/C9Yr3QO5HUyDdP84+0q/UDf2X6g=;
        b=dx51TAFEnqpVpFLaUR3Dx6ZEXaOQCawh8+4mH98zhksc4uG/eUCy+y2Llbv6RnS9Ez
         3bjcflXaTwobkYb6y38RngIwdRh6iydzp9yQoApK/Etqn2RbFpUAVrEV9+bHzG7zF1U/
         yZ4zvno7tKnbVK3qeGYbunaHBUnT5ncGhvFmX4i+GlTr/lqE5TJ8SdNHO6dlL9ksHBzJ
         woMPe1yACIIBOHXHOmpLjkNXRSoGdCp0ToC4tpj2703ni6bec2uiqTOhYKp6HdI/FofU
         nSwcscWFXOc3S1aJ6WrVPJ1M5+UtYv9vhYbwEJssxuzV21kRfO4a9mE0WOXIfxlzTKgy
         qOfg==
X-Gm-Message-State: AOAM533u29sX/cGJJmoNX6QotdlKxuYObStf267YtZ4GvWI4eJjYzJh2
        cNPaIW+C9/t30+gU+Fpw1N6X1g==
X-Google-Smtp-Source: ABdhPJxmOmDQDNgdJdifQ1zu56tZWRU5l55FFo7Zhy4Tpksm8CM6OcOcJ8W2SgFMIbm/SMTffkshtw==
X-Received: by 2002:a17:902:fe87:b029:12a:ef40:57a2 with SMTP id x7-20020a170902fe87b029012aef4057a2mr20597385plm.81.1627425906358;
        Tue, 27 Jul 2021 15:45:06 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id f4sm5288861pgi.68.2021.07.27.15.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 15:45:05 -0700 (PDT)
Subject: Re: [PATCH] blk-mq-sched: Fix blk_mq_sched_alloc_tags() error
 handling
To:     John Garry <john.garry@huawei.com>
Cc:     osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com
References: <1627378373-148090-1-git-send-email-john.garry@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <20fb9978-af00-0bc6-33d2-c41bfb129cb4@kernel.dk>
Date:   Tue, 27 Jul 2021 16:44:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1627378373-148090-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/21 3:32 AM, John Garry wrote:
> If the blk_mq_sched_alloc_tags() -> blk_mq_alloc_rqs() call fails, then we
> call blk_mq_sched_free_tags() -> blk_mq_free_rqs().
> 
> It is incorrect to do so, as any rqs would have already been freed in the
> blk_mq_alloc_rqs() call.
> 
> Fix by calling blk_mq_free_rq_map() only directly.

Applied, thanks.

-- 
Jens Axboe

