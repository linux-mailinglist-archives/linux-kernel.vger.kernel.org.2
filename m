Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C844344E6C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 13:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhKLMti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 07:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbhKLMth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:49:37 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E266C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 04:46:46 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id i9so8819701ilu.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 04:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=zb40TZdAdzS0s+t5wZ4mp/GEeNfg4Dt14seLh4Kp6DU=;
        b=IOObxc3R+A4LYCkO7x+7r91aUUfJKbHzEnq+LTQBCZzPcsrwJKYnJQZz4uq8I7hby2
         XrhdmfYeyzgOFPiwwJss5sguua6/WCBc2AIAzWTmZRt+Ua2pliP7a+bC6cP934GdO8Dv
         j3jJCWoQ3Yx5Y+9OYq1PfA0UNSuEBcESOFIssTBIT2oMBH6w3HABEklDP8XSepEERU+v
         zKFfGqikAxllKoroqWuk8ihne1PIwtVSbED0oERRI2TAGcIHBoKcyLEuMzaPaRizJG0+
         uZL8h+ewzs3BpKALcPEniSWmi+TUJ+m66klTQIpA/X4lGeD+u52NPalEKPMo7Q+rfnbr
         hukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=zb40TZdAdzS0s+t5wZ4mp/GEeNfg4Dt14seLh4Kp6DU=;
        b=PjP+8TtWDAd4UbzejnblIBe5sFKNIxsQb1dSYqWSq3ASWIxjAOodH/IntKCtODjOC4
         JfmwK8cQo96gse2y/VQLHYszsJGJVH0MCiuIteg2wkL7cnTyRMbn0Uk9F8CBrKFazuMX
         FA4PtpOL1o1UltXgJKcjKuWmT5GzuBpMHo1VfoiFnDQpTZuwDH9ur++33SANWy1xVPwh
         r3GETuLOOPHftbTpcjVALI//FGxwxrAvK4N65jKc8WhU0CuNm7YXd8YmKe/cFDk6PMx3
         C8PKA+mR6m9UaSH1LEirm+QBPpJFki5WSc0mTq/L7noICK8no7RwqxCLVu+WS2TDbC+Q
         dUoQ==
X-Gm-Message-State: AOAM532F+1pABL5hR/Q0VbonWZPvCoTdPvDgcquBlUP5NXoXYv89c2OH
        HPoL3DDfJlqltkhRvJyr9Qae9kGWYKHJzDXq
X-Google-Smtp-Source: ABdhPJwBGVrC63/n6Z9aBEm9Bdp112tIF7Vome5nBL+d1EmDy3sX/k/xe031B4axtW7VvUHLFCHP8w==
X-Received: by 2002:a05:6e02:1526:: with SMTP id i6mr9328851ilu.3.1636721205820;
        Fri, 12 Nov 2021 04:46:45 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id x15sm4028508ill.20.2021.11.12.04.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 04:46:45 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     bo.liu@linux.alibaba.com, dennis@kernel.org, tj@kernel.org,
        linux-block@vger.kernel.org, josef@toxicpanda.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211112093354.3581504-1-qiulaibin@huawei.com>
References: <20211112093354.3581504-1-qiulaibin@huawei.com>
Subject: Re: [PATCH -next -V2] blkcg: Remove extra blkcg_bio_issue_init
Message-Id: <163672120421.12772.10166896593736880728.b4-ty@kernel.dk>
Date:   Fri, 12 Nov 2021 05:46:44 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 17:33:54 +0800, Laibin Qiu wrote:
> KASAN reports a use-after-free report when doing block test:
> 
> ==================================================================
> [10050.967049] BUG: KASAN: use-after-free in
> submit_bio_checks+0x1539/0x1550
> 
> [10050.977638] Call Trace:
> [10050.978190]  dump_stack+0x9b/0xce
> [10050.979674]  print_address_description.constprop.6+0x3e/0x60
> [10050.983510]  kasan_report.cold.9+0x22/0x3a
> [10050.986089]  submit_bio_checks+0x1539/0x1550
> [10050.989576]  submit_bio_noacct+0x83/0xc80
> [10050.993714]  submit_bio+0xa7/0x330
> [10050.994435]  mpage_readahead+0x380/0x500
> [10050.998009]  read_pages+0x1c1/0xbf0
> [10051.002057]  page_cache_ra_unbounded+0x4c2/0x6f0
> [10051.007413]  do_page_cache_ra+0xda/0x110
> [10051.008207]  force_page_cache_ra+0x23d/0x3d0
> [10051.009087]  page_cache_sync_ra+0xca/0x300
> [10051.009970]  generic_file_buffered_read+0xbea/0x2130
> [10051.012685]  generic_file_read_iter+0x315/0x490
> [10051.014472]  blkdev_read_iter+0x113/0x1b0
> [10051.015300]  aio_read+0x2ad/0x450
> [10051.023786]  io_submit_one+0xc8e/0x1d60
> [10051.029855]  __se_sys_io_submit+0x125/0x350
> [10051.033442]  do_syscall_64+0x2d/0x40
> [10051.034156]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> [...]

Applied, thanks!

[1/1] blkcg: Remove extra blkcg_bio_issue_init
      commit: b781d8db580c058ecd54ed7d5dde7f8270b25f5b

Best regards,
-- 
Jens Axboe


