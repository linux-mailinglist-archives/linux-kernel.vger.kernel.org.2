Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5030D41B242
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbhI1Omv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241270AbhI1Omt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:42:49 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703C4C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:41:10 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r75so27680899iod.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1ZhaZG/tQlxzocEQfHY1+FVhcMM4RpIdjkL8eV4PXdU=;
        b=EaaYZoLQyJe7lvJ2ke7VRkgD6vuBZuvRMzI/kJLnPozn8pxop5b/6uoLDitG3KpJBJ
         vVxcIFJNQ4sbxvuv+djjfhyGk6yYoBm7LPKgkxxuNRvAbbZtpFWkK1/bjYd9xgDY4u2i
         xu0THGW7dpad+h27yHcQGfBvgxrHy3peFhgPx6oKDYV3Zn6ag83EIzJCgSB4vWvEjtNP
         Wk4omfWxlvjbwvoWDu+w1w8qvTo1CFAYzq+iwellg7sll8fm10PtJ+5/S+xv64b0mNmL
         WR21XV2jLhsOynlPRI4/USfxDlwfJAPD8GuE9OgECejqMc97A18Uy6LGX7ccS6pTAtGK
         hY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1ZhaZG/tQlxzocEQfHY1+FVhcMM4RpIdjkL8eV4PXdU=;
        b=aYxCb0Relp7+hri+GUY8bKkbCwPssg3E1AsVNWL7padq2/HtuEB6CKwMj7wNMebTnA
         ZG7mGrLkjkpbT+s3ogVKOLojdgM//CLf7pM1E/NJjwS7ppZD1qy428DM3xGTsAKFE0at
         qdcglOe+k70bEIcv4yME4qu/3b6XWDdeeSpS1nDKGJ7XeCxkOI0HjKv9X4e7jmK9eHBZ
         tjjEot3RihsaJy0R53OrbsdI0n9bKhsk1xX6qUlHGvCCM0W4FPRfU64S3bOLS9zFWgQo
         ulUvjXsRoQCgubXuqm6eeJXq60CX98EOJXMDm0MQtzt7FtjJYj+Pki7GoJ2nsXsivFjK
         Uvmg==
X-Gm-Message-State: AOAM530aA8N9Q95OrXll5aJoDdt8Bq3lKIEHx5lMoiMKc5JUo/nJ2Kkm
        Z9AiIHLpVCc0EvuuAOaw7YP+4w==
X-Google-Smtp-Source: ABdhPJzzqH3iPkshxUx6/WFfh3BcxwrV5dAebi1fz4A563SllOxpOSqNgPD19EjcESLy3iq9PXXgeA==
X-Received: by 2002:a02:5d45:: with SMTP id w66mr4952789jaa.82.1632840069746;
        Tue, 28 Sep 2021 07:41:09 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 67sm10855624iou.4.2021.09.28.07.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 07:41:09 -0700 (PDT)
Subject: Re: sched: Remove pointless preemption disable in sched_submit_work()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Peter Oskolkov <posk@posk.io>,
        Tejun Heo <tj@kernel.org>
References: <87sfxoai2l.ffs@tglx>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <87d7b153-11a6-2f47-a5ed-abe10a294df3@kernel.dk>
Date:   Tue, 28 Sep 2021 08:41:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87sfxoai2l.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/21 8:30 AM, Thomas Gleixner wrote:
> Neither wq_worker_sleeping() nor io_wq_worker_sleeping() require to be invoked
> with preemption disabled:
> 
>   - The worker flag checks operations only need to be serialized against
>     the worker thread itself.
> 
>   - The accounting and worker pool operations are serialized with locks.
> 
> which means that disabling preemption has neither a reason nor a
> value. Remove it.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

