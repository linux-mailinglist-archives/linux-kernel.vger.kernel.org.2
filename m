Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458B634D186
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhC2Njj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhC2NjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:39:11 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B6EC061756
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:39:11 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso5182084pjh.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PTI+L6ax+/N+yMG1MXdvXBKRXCBtboFyHdTE1wtJx+k=;
        b=pWIp11nHFW7KdnNAiA9K1BL1Od6BgMAM7GRbTXqtMPyZ7gtqHQXCOkLdSG3wcT5UJE
         aj2G6x+OC5ELOVlMUvospOx5QDhace1cy5WW2FUoRbaZaR4/HCepnU+gIuH1c2TuEhVL
         zFN+UEnXJikrfluMdBrX6+RTs8xYNzSJNUR7fTnFypB8a892d27IAYuTudTMWxB8dteU
         mkABKWFlCP8rzp1OI1TAimg+bL9zTuKU9vcLC31IYPzWTZGvXkmeacqdy1Qh7Qt/MAlL
         Y7GrMMkjCj8hIP9UtDRnsCcyXjdQ9ObiX0sZEq2PlNof1lR62WjpGp1rOGY3PC5EFnXn
         AlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PTI+L6ax+/N+yMG1MXdvXBKRXCBtboFyHdTE1wtJx+k=;
        b=sTfFCW1byC6LrNCrDuJERfuML/3jDwAVHWNStGZvxet66JnCv5dtM7jsagt/qfCeMb
         weD5un0COVcVGI7IMxLy9Bvh0Dwt5fA09WTM3GMuP5idzxycd/WWkiL35Mvbpimam9Yr
         IzThXZGkKFzsfLAokoj3JQc4g0dciNbHw0N+MGo2L3Jf/3iqaF6vtSTLy6ftZlXv6o+2
         fKSlFvqujcz38lSOTQe2EIgr14A4NR+aYkgC579g9K6hTBQ67YreAVy1+SnIUyckzpAq
         /s6zWSm4rEnura/clb96MqR4+0kyu8IV/8EgnjnzC02aJIXg/x2H6pG8KHEMKAUJtZYk
         7GUQ==
X-Gm-Message-State: AOAM531oKNsjnKOZ09eOc+ceiiqrFerQQHf+SOiEgo8J6FyAr8U6EZ8b
        mDJSpsmGg+nI3bZUUWSQZEJz+NOskKcYiA==
X-Google-Smtp-Source: ABdhPJzuj3M/DsqXiV9zd8IxnhRo608IcZgTiobsDDdPzYZif5V8Z1u24W8jhK9cloHgqxbQJPdjAQ==
X-Received: by 2002:a17:90a:9f43:: with SMTP id q3mr26582711pjv.50.1617025150517;
        Mon, 29 Mar 2021 06:39:10 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 8sm15739525pjj.53.2021.03.29.06.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 06:39:10 -0700 (PDT)
Subject: Re: [PATCH -next 1/2] mtip32xx: use DEFINE_SPINLOCK() for spinlock
To:     Shixin Liu <liushixin2@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210329095349.4170870-1-liushixin2@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <11e068c7-0022-8c7e-23d9-c1bd8ee90896@kernel.dk>
Date:   Mon, 29 Mar 2021 07:39:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210329095349.4170870-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 3:53 AM, Shixin Liu wrote:
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().

Applied both, thanks.

-- 
Jens Axboe

