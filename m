Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CDC38B93D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhETV4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhETV4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:56:13 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B06C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:54:51 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id y12so13922062qtx.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y058D5s1aDlxoLa6lWe5lsMtbmCwzdd1iYMkmI52agI=;
        b=kXlwSCKAVeCSzRdSPoDivXQpi2ETc4pb+vySXIyQaForiY9w7JNaaGSr7bUSJM4g4s
         ntksfhfyqfD2AykY5JsR9O7xtyOGzRTjNwxX4bH8350ODSZPscQzp2a6G3Jic6id7deb
         TpB3m8DSUkVhS2capFXw7m42hCrQQ6kTBejTjrJA6UMEZcxvH/ktiCT27AVvOXllni0+
         EHR+pG6XJ0sp3g2cObQnCcm1n6x7FjLWMiTrgF60gm/phi+O0MKUe7yfhLcgTyP1EHPp
         Lm3SA+wVgtYRrDuqkiEs0PFmzhaEcDhRCXE5B+F4WL/tk6WMhNSTD/+mTEieqN/1UmEx
         RhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Y058D5s1aDlxoLa6lWe5lsMtbmCwzdd1iYMkmI52agI=;
        b=EPcpJBDEXiJ9epmnWx/LJI7RWigsZCdXVZ6k6TwQPqnfZAMa5t/1mQU2Ih5r+se1XN
         QCxqU3nUa1dCxQhhCXN1TI32jxP3Im+VLlvmKkGDOG1JlJZV9eH9VzYp7gYoon7D4bwV
         8LLFUeeKqmD22C8dQdNMvcguSCWhEQ7gxO4AZJ2eXbKLmsJWGym5s1wMAtJHEYxxBadr
         zvvv5yHZymA/rt911wXdwFvTYB6ZXI04F37HDYZRLH76jDZ9TZi6BRvNJFFNDLS3x9Mq
         yMcxcryQtZD8L+lQAygjeb4L7mj7K+O3lInA62Ml0Z3JsdS0uhQK6uVkUcGBS44D+mrP
         STSw==
X-Gm-Message-State: AOAM533wwRq3rzjUQODKYuWfdIOJpNFGdU2vKBxLMgSs8PPt9tpBCftI
        Uye1DTuIShuZyZVA8VH6I+U=
X-Google-Smtp-Source: ABdhPJxY4uQxivvv9gQV6i256GtZWp1rLiTO5/0Y5uhRA0cGNmnvNo/w9liuHnoQBT47zarSgHyp5A==
X-Received: by 2002:ac8:4256:: with SMTP id r22mr7888597qtm.207.1621547690726;
        Thu, 20 May 2021 14:54:50 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id k24sm2864677qtq.49.2021.05.20.14.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 14:54:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 May 2021 17:54:49 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2] blk-throttle: fix race between submitter and
 throttler thread
Message-ID: <YKbaqfTwdxkLaSUD@slm.duckdns.org>
References: <20210520194413.3977-1-dmtrmonakhov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520194413.3977-1-dmtrmonakhov@yandex-team.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 07:44:13PM +0000, Dmitry Monakhov wrote:
> Changes since v1:
>   - Improve comments
> 
> Currently we call bio_set_flag(bio, BIO_THROTTLED) unconditionally
> at the end of blk_throtl_bio w/o queue_lock. But once we drop queue_lock,
> bio may already be processed by thottler thread, so both threads
> may update bio->flags concurently
> 
> Dipite that race window is tiny, it happens in real life under heavy load.
> It looks like follows:
> 
> SUBMITTER_THREAD (CPU1)                  THROTTLER_THREAD (CPU2)
>  ->blk_throtl_bio
>    ->throtl_add_bio_tg
> (1)   bio_set_flag(bio, BIO_THROTTLED);
>    spin_unlock_irq(q->queue_lock);
>                                          ->blk_throtl_dispatch_work_fn
>                                           (2)spin_lock_irq(q->queue_lock);
> 					   ->generic_make_request
> 					     ->blk_queue_split
>                                                (3)bio_set_flag(bio, BIO_CHAINED)
> 
> (4) bio_set_flag(bio, BIO_THROTTLED);
> 
> Since bio->bi_flags is not atomic it will be cached on each CPU
> CPU1 will cache it at the step (1), and changes from step(3) is not visiable,
> so BIO_CHAINED flag will be lost and rewritten at step(4).
> This result in ->bi_end_io() will be called multiple times once for each
> chained bio and once for parent bio.
> 
> Bug#2: submit_bio_checks() call blkcg_bio_issue_init() for throttled bio,
> but at this moment bio may be already be completed and freed by throttler thread
> 
> In order to fix both issues we should modify throttled bio under queue_lock only.
> 
> Fixes: 111be88398174 ("block-throttle: avoid double charge")
> Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
