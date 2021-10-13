Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544F542C55A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhJMPze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhJMPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:55:33 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E768CC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:53:29 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id q205so206928iod.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WRJYysWcjfnhv+GGO7EufUUE7nH4i6VwgRDsf0WXS/U=;
        b=TjGSQml7qFm6Y4IuqWI6mSd/8Oo/OKtaBfu6edw7RdaxWuCGM9dwhP3mphBy0xMvyZ
         cx1ORJ2cKLo+CyeqC8hyUHzVgKejilvpUvf7tzFgqgIsB1YXAbgOeFmo5CSF5r3sdPCh
         8VUlX0911vaun3co/17ISn72BmMO11STpUAoei0Vnkvkgk+DwakrAn59UkMEoSZL9jUy
         JK9liHqsFeVAbmt19jm7hSORei+Tlzgkl+nswVUI00iFkP5z79/zteUaHZovoBUqpf4m
         7cfDgHIBWyPVyz30593ERjoRsdUn/hdsUoPG171gEwy0LYAeM5RrqFb1SvK7DwYamzqs
         mugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WRJYysWcjfnhv+GGO7EufUUE7nH4i6VwgRDsf0WXS/U=;
        b=CCIonoWtFfPvz1CXqwGmG2fNj0/KwFx5YTa9+CpmOhaDpD6+e5Bu40LmLXOUijpUB2
         EjhOouGgADrZ8pzIysp7gjjrqEj3G2agZZek1/n6/gLDIpv9ThtdZyUAHfH1jFZOvWnH
         dvl5Ep/URVV/9Jmid7xQt2+wYroYRWQepVyrbnMc8ISmceD0bSqXBn2ljm8ZN7qBV9x3
         Ss6NFa9UTz7XTrewX3Y9mj9ya7OzlG9SntgSQdD/LTv6MLZ67SDoB7x3rYKg37QKxHWb
         eNopCXtxfLQC/82BDdj/5ZD3PntIlz/uLCGiTo9eOIUhP17C2dKISBnqZpe5nIK6VVEQ
         xtQA==
X-Gm-Message-State: AOAM533uC8mU/8zxNw3sg1k6p4pRfk0DvIrGVUxhUULAqE8FEdYEJhMt
        Z9aZVL2+3Bj07x1VXRilh1gTWQ==
X-Google-Smtp-Source: ABdhPJzOqkx0x0ea5U6PunzaCKZrhYE9jjoNZ+ajFlz4tqMgw5oKTgpVmXVX88Rkys/tkarSK6Q7Ow==
X-Received: by 2002:a05:6602:1504:: with SMTP id g4mr10396iow.133.1634140409335;
        Wed, 13 Oct 2021 08:53:29 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m1sm7003330ilc.75.2021.10.13.08.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 08:53:29 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Subject: Re: (subset) [PATCH v2 0/3] on top of for-5.16/block
Date:   Wed, 13 Oct 2021 09:53:21 -0600
Message-Id: <163414039197.962778.8154450791755434803.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1634115360.git.asml.silence@gmail.com>
References: <cover.1634115360.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 09:57:10 +0100, Pavel Begunkov wrote:
> ./io_uring -d32 -s32 -c32 -b512 -p1 /dev/nullb0
> ~3.3 MIOPS vs 3.5 MIOPS, so gives around extra ~4-5%.
> 
> The main part is caching struct block_device + some inlining.
> 
> v2: without applied patches, merge previous 6/6 into the second patch
>     get rid of helpers (Jens, Christoph)
>     kill bdev_inode and move inode into bdev (Christoph)
> 
> [...]

Applied, thanks!

[1/3] block: cache bdev in struct file for raw bdev IO
      commit: 82f652990a4ade2df9d6475ad82f4dd22a3265f6
[3/3] blk-mq: optimise *end_request non-stat path
      commit: e945e2edb67048c42527089cd9938454ae4f9c04

Best regards,
-- 
Jens Axboe


