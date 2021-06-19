Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41283ADA4A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 16:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbhFSOMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 10:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbhFSOMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 10:12:16 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1191C061756
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 07:10:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j10so626167wms.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 07:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IEJvDnbb5J82kUV/Mhgm+HBZUSJpapkINClf1DyhHz4=;
        b=BiRg+KsYxrK2ZSxYi0k94je7EFev/qrRv7IBDtkLfZh7rOaZFdO/BLFwzOnQ5ZskaJ
         72zWXrl7G3Q4DnUPynlRF4bQwjHiZVt9FieuuvZ1rDDNjk55+EBpUIA4FlvgUTdNep29
         owPdVYb1S+m4GiBednhI2C7+/IqRVRKJcWtqsA33Ms3SHYXPWS3glH5yDtfhJXTk7tzs
         MnpmtjRcukY5avAcbtxBopJXtZtN5nhyL6v+K9stcE9UTCs4m0SMmp2UO1TQrnnTncNc
         iBQyYCFHSQjbDWqeGbed2RqIW5h1lfk+xa0vRqAPDsUPcRE0A1TmIfaZ+jgYC8BrtMXn
         EtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IEJvDnbb5J82kUV/Mhgm+HBZUSJpapkINClf1DyhHz4=;
        b=erQmgAxawSvmKi3on5z7m2Zwr9sf3m0x5eHyZqvqEQJuBHlKMsCEiG6e2DSARfE1Pe
         AvBZ4+vW6/j7HqaSiNK9Db5CEBtlXUgmqDUvzb/qQ0IMqKsgIRs3RIUZHxiucRIPkpvh
         p5BjKeyHbE8Tl8ZWSCv72Wbffqr/nElRiReULuZbyIdZsng9n2eP1NqBhUBhXuDF0Yul
         t5wTZI2sb4ZyrssiOGtQskmnRUlg0Y0xSVke4ELf3vpx5lTnhH9IqgWMeOFN3bPKsGyD
         iR4A+tCgAXl/SN31zRkvOVHHCRU0h6JRYl3LPPgiJSOO7jvBvcIvL2YERNsF45whRm6o
         DoHg==
X-Gm-Message-State: AOAM532kIc8uYs7ToqzgJua8hxkd5Y/VJ0Lf8PmzTt+s5lYYYGeg7g3X
        AasXAKR3qEeUeeX9SSB0VUoUuw==
X-Google-Smtp-Source: ABdhPJxffM8ZYybJdI95deDigEGdfCqFUJhx64SzQ+E59Mkh9KchZ4WimlUwayMULKjNoBVjTS6RKQ==
X-Received: by 2002:a1c:32c6:: with SMTP id y189mr16496359wmy.54.1624111803520;
        Sat, 19 Jun 2021 07:10:03 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id y16sm8379350wrp.51.2021.06.19.07.10.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jun 2021 07:10:02 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mariottiluca1@hotmail.it, holger@applied-asynchrony.com,
        pedroni.pietro.96@gmail.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH FIXES/IMPROVEMENTS 0/7] block, bfq: preserve control, boost throughput, fix bugs
Date:   Sat, 19 Jun 2021 16:09:41 +0200
Message-Id: <20210619140948.98712-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
this series contains an already proposed patch by Luca, plus six new
patches. The goals of these patches are summarized in the subject of
this cover letter. I'm including Luca's patch here, because it enabled
the actual use of stable merge, and, as such, triggered an otherwise
silent bug. This series contains also the fix for that bug ("block,
bfq: avoid delayed merge of async queues"), tested by Holger [1].

Thanks,
Paolo

[1] https://lkml.org/lkml/2021/5/18/384

Luca Mariotti (1):
  block, bfq: fix delayed stable merge check

Paolo Valente (5):
  block, bfq: let also stably merged queues enjoy weight raising
  block, bfq: consider also creation time in delayed stable merge
  block, bfq: avoid delayed merge of async queues
  block, bfq: check waker only for queues with no in-flight I/O
  block, bfq: reset waker pointer with shared queues

Pietro Pedroni (1):
  block, bfq: boost throughput by extending queue-merging times

 block/bfq-iosched.c | 68 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 15 deletions(-)

--
2.20.1
