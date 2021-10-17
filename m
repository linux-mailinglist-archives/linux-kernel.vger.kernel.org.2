Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC94430945
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 15:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343670AbhJQNLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 09:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242253AbhJQNLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 09:11:30 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB58DC061768
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 06:09:20 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id i11so12109373ila.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 06:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5bsYD8Em0D7Z3gYVmo2trDqgQl0aMsvKApwpq9ahAcU=;
        b=xV4hT0T6CA4y0A3k3ANvNHqG8G3/93XCm9r4UjDQnqMmbGbDZ8BcV9MX2rnHPAZTlC
         Mf9dfxvuRNdx2l4UcAh+s6/Wa7lkYJhtg8iEaon8cIwWGsQMgLpgABbC1J7TX9C3Laxu
         4pcnpprCAH+lu1slTXQo7eY4eqEbQRTSsELPI1oKPf06TPHkAN4bo9122FuiyxMxeXzA
         KbEJb0HEhoNaL5bkPBX+qngyGrktcVkhboWlHk/rRzuHnNMuJVpVKOwZ8bJDh5ZP66m8
         473ZoVnE7xV7Kn2s7ml+js/dPTeDdc9L363liKEkmxxy/YjDhjx+LBq0lzkKGGo52/RD
         Pg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5bsYD8Em0D7Z3gYVmo2trDqgQl0aMsvKApwpq9ahAcU=;
        b=R4EIdOeqDeXGwIrmPqmNrCuDQYTOV99sLSMkNY9NujIlLiKeZZswHzKA6R8X89BNAD
         Lhst50XYXElmDGUcdNWth+t0yGJ0U3xGR4/j8IuEl1A0PTha4fFefUCEh+1i+uJxJRhg
         tN8qFppaHC7FrzpMKBUuLOgYIIwmK4Ue9FpBk69kn79PSocxHsa0Ep8YVsgngP3Rd7cp
         qIbI6HXsOMnHcb+bRha6oRnuG/DqJWK9sM3f9uhop3qGee87V79R7BoHwQcYCLY+zU/B
         RxlZ12fZOt6OWhfnkC4BtoL3WPrHx+Ty3E+4KljlSgmhogaxwYfy1zfBquV2ajNIpQt5
         ThBA==
X-Gm-Message-State: AOAM5323/3FnbcpJW8G99YmmAv0NujY0oZ6nvCJFJcaFOWmArzKBsos6
        SIceu0f0nV0T9FMRgu0blHRaGw==
X-Google-Smtp-Source: ABdhPJzMjZuszotY3Z5QEy3aD5WIuRw83kUGxnkiQsViN8asi/AEYugAnFvKiE2DVcKl3Zpcj2wg9Q==
X-Received: by 2002:a05:6e02:6c2:: with SMTP id p2mr10732481ils.104.1634476160121;
        Sun, 17 Oct 2021 06:09:20 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id h5sm2543282ili.12.2021.10.17.06.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 06:09:19 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@infradead.org, ming.lei@redhat.com,
        Yu Kuai <yukuai3@huawei.com>, josef@toxicpanda.com
Cc:     Jens Axboe <axboe@kernel.dk>, nbd@other.debian.org,
        yi.zhang@huawei.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [patch v8 0/7] handle unexpected message from server
Date:   Sun, 17 Oct 2021 07:09:15 -0600
Message-Id: <163447615283.94076.10393742236297251525.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20210916093350.1410403-1-yukuai3@huawei.com>
References: <20210916093350.1410403-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 17:33:43 +0800, Yu Kuai wrote:
> This patch set tries to fix that client might oops if nbd server send
> unexpected message to client, for example, our syzkaller report a uaf
> in nbd_read_stat():
> 
> Call trace:
>  dump_backtrace+0x0/0x310 arch/arm64/kernel/time.c:78
>  show_stack+0x28/0x38 arch/arm64/kernel/traps.c:158
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x144/0x1b4 lib/dump_stack.c:118
>  print_address_description+0x68/0x2d0 mm/kasan/report.c:253
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x134/0x2f0 mm/kasan/report.c:409
>  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
>  __asan_load4+0x88/0xb0 mm/kasan/kasan.c:699
>  __read_once_size include/linux/compiler.h:193 [inline]
>  blk_mq_rq_state block/blk-mq.h:106 [inline]
>  blk_mq_request_started+0x24/0x40 block/blk-mq.c:644
>  nbd_read_stat drivers/block/nbd.c:670 [inline]
>  recv_work+0x1bc/0x890 drivers/block/nbd.c:749
>  process_one_work+0x3ec/0x9e0 kernel/workqueue.c:2147
>  worker_thread+0x80/0x9d0 kernel/workqueue.c:2302
>  kthread+0x1d8/0x1e0 kernel/kthread.c:255
>  ret_from_fork+0x10/0x18 arch/arm64/kernel/entry.S:1174
> 
> [...]

Applied, thanks!

[1/7] nbd: don't handle response without a corresponding request message
      commit: b5644a3a79bf3be5f1238db1b2f241374b27b0f0
[2/7] nbd: make sure request completion won't concurrent
      commit: d14b304f558f8c8f53da3a8d0c0b671f14a9c2f4
[3/7] nbd: check sock index in nbd_read_stat()
      commit: dbd73178da676945d8bbcf6afe731623f683ce0a
[4/7] nbd: don't start request if nbd_queue_rq() failed
      commit: a83fdc85365586dc5c0f3ff91680e18e37a66f19
[5/7] nbd: clean up return value checking of sock_xmit()
      commit: 6157a8f489909db00151a4e361903b9099b03b75
[6/7] nbd: partition nbd_read_stat() into nbd_read_reply() and nbd_handle_reply()
      commit: 961e9f50be9bb47835b0ac7e08d55d2d0a45e493
[7/7] nbd: fix uaf in nbd_handle_reply()
      commit: 52c90e0184f67eecb00b53b79bfdf75e0274f8fd

Best regards,
-- 
Jens Axboe


