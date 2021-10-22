Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5F64379B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhJVPS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbhJVPSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:18:45 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74BDC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:16:27 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so4802316ott.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=ANjxMyzEaBerOwzLK0Q3RxHvXsNIIMRJZ4VhyjUE2w8=;
        b=Um61NSl9XZjxdivHLbY9cyH91To30EM1MV27+M0ag4zCerhQSBBvzx1BRSBoHD6Vu7
         NJy+RmfZJ7bdbaMjkyaUbT2mKri6WdrUNzA/5s1Ab25uWmeNmfEqRa6CoZMRzcv4pAnW
         GqG4yWcCLcl+b1P6/mXuBprj0JiQzSfEfm7op605Qg+C4BnrvkZthiuK4P+Hh6YBev+i
         S+LHJUy3hnl+GrLAfnleLK8RjDegxB6WzfRslI1sEu4869lFJcADzxfcTFz23+dxroRV
         OaX1gIYVqHHhZ1Vvejvi5Wkow+QtUwGJ16Cg6KHA2PwABXN5QvlxxcWk2uN7/lAtlV4y
         r3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ANjxMyzEaBerOwzLK0Q3RxHvXsNIIMRJZ4VhyjUE2w8=;
        b=r5I7SiDgYoTgnbwi+K+NmEGBIir6cOFQmS+kyucSrcYw84XzQXIXWg7rUSiQOTnIhT
         lWtjTuD9yWKH3xxptiA9Cj4HD86MpO7Mx8LdFPBGpJNLrNvE4diJPyQeWOI35C/u4/oQ
         ZftSPSDE1Hon+gs6PWHGXrcSJhEeRgKAC1fSsWemakOu2zHlqm/dHjbdL9kMCEbntk7J
         ness/Hh9TwY96xfe1o9I9a2JKAduYJRlaAxRfmc/wbmbhn0aqZ/IRgeMx3lLVdrcpcMg
         SJ/1r3Bid9sGdBMRxcYi6GTXbMOsVdu9TZhEmSER+oJCnqi95CgQCnVIvnJ5Vq+X+jfN
         VtTQ==
X-Gm-Message-State: AOAM53205vMOlYY7787sGTg2M5wh4O+qwbwZOio3E9LfaehwZ48hI0JE
        3+JIkbEZwVwqrlD36F8atJzHQA==
X-Google-Smtp-Source: ABdhPJxVF1FPp4NIY23klw94VQMWmGA8+pwcyTnKttWZaIi0nOTHXtGUy6TNbgHv3LBU/WCQXWfbyQ==
X-Received: by 2002:a9d:7644:: with SMTP id o4mr397173otl.270.1634915786523;
        Fri, 22 Oct 2021 08:16:26 -0700 (PDT)
Received: from [127.0.1.1] (rrcs-24-173-18-66.sw.biz.rr.com. [24.173.18.66])
        by smtp.gmail.com with ESMTPSA id y5sm1733409otg.52.2021.10.22.08.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 08:16:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     John Garry <john.garry@huawei.com>
Cc:     ming.lei@redhat.com, anders.roxell@linaro.org,
        naresh.kamboju@linaro.org, linux-block@vger.kernel.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org
In-Reply-To: <1634890340-15432-1-git-send-email-john.garry@huawei.com>
References: <1634890340-15432-1-git-send-email-john.garry@huawei.com>
Subject: Re: [PATCH] blk-mq-sched: Don't reference queue tagset in blk_mq_sched_tags_teardown()
Message-Id: <163491578487.92334.5273496329606212281.b4-ty@kernel.dk>
Date:   Fri, 22 Oct 2021 09:16:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2021 16:12:20 +0800, John Garry wrote:
> We should not reference the queue tagset in blk_mq_sched_tags_teardown()
> (see function comment) for the blk-mq flags, so use the passed flags
> instead.
> 
> This solves a use-after-free, similarly fixed earlier (and since broken
> again) in commit f0c1c4d2864e ("blk-mq: fix use-after-free in
> blk_mq_exit_sched").
> 
> [...]

Applied, thanks!

[1/1] blk-mq-sched: Don't reference queue tagset in blk_mq_sched_tags_teardown()
      commit: 8bdf7b3fe1f48a2c1c212d4685903bba01409c0e

Best regards,
-- 
Jens Axboe


