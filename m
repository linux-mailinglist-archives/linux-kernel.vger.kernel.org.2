Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70C63D69B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 00:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhGZWDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 18:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhGZWDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 18:03:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8BCC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 15:44:19 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ca5so2657417pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 15:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vtVNL33R8d7qtky+KI0bgK32lin5Li2gSRggnf2yzDM=;
        b=uBqMld5v1g9hLq8D47Lj7kMlua6t2vOPyCGdR8ebLz3bj5kAUFYkY834nBufsHun+f
         pTCyCH1UGaaYPcXhrgRNJGIKo0KFUK3Sap4xKtIJGdXUznKAV5B90QLiz1p/wtidOGPo
         kkf2ENB38kaX5SdU+ea09h/aTcLhIzLmYcOncUVQaC/ustyr/6orZN+CKKBoDpLV3V/q
         WbZY4t9aspdv7FUKykuGnsBhQTwkZ9f+cPvU01guWKMjrB9AhaXsAB+Q4zG4olPD624o
         IrkTK4a6Flchy+AIGmtT11BQsxmL5GNT4/QarB48cDSdkR3Z9LyJKUq69hrafjOTARs6
         AjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=vtVNL33R8d7qtky+KI0bgK32lin5Li2gSRggnf2yzDM=;
        b=oEkecCSFvT1af4vRe5ZDlwEe5d0daT7haMb5b/GFsFv+znUSKyge3NeQCkC1VQoP73
         aGAbUxJ+0MbsU95n3cuMvuh5T4HEahFTGFI6RstiNS744pQHIpwN9Z6FOaF5Zgme81/H
         tucytAXaUJHoaQAqm0X9zOt89jj7FAqpxa3vaOw4ROGiQXvJLRQ1B/D6YtryACje4pCg
         j40SG1tYK+Ac3bIY1yOg6RIdZkNKlea1r9X7aHGAfimw03RpU/go2gfSEiG0IN9FIhZp
         fOFRApuNHFtBdykq91qtOV8TJPDRoVcG+bW7is/4L5ybTaVt0W75roSCKb/s5RYXcdh/
         Gp2g==
X-Gm-Message-State: AOAM533NGr6jlw5SR6KXAfGDMPzHv/JhooRNNBURcnk6MHUwhZy7wmSZ
        W/N3YpKX77zD6WMzwj6c7mc=
X-Google-Smtp-Source: ABdhPJwSKx1nQ7rpFaRuxmDZBKheSe7zGzmdQ3B01BW2oIUJz4EiftcVgB5SLESaFYItiAzrOGhw5g==
X-Received: by 2002:a17:90b:4d0b:: with SMTP id mw11mr1222426pjb.122.1627339458473;
        Mon, 26 Jul 2021 15:44:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:428])
        by smtp.gmail.com with ESMTPSA id k11sm977562pgc.30.2021.07.26.15.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 15:44:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Jul 2021 12:44:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] workqueue fixes for v5.14-rc4
Message-ID: <YP86vmYY0n64hGRe@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

One commit to fix use-after-free in allocation failure handling path.

Thanks.

The following changes since commit 8cae8cd89f05f6de223d63e6d15e31c8ba9cf53b:

  seq_file: disallow extremely large seq buffer allocations (2021-07-19 17:18:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.14-fixes

for you to fetch changes up to b42b0bddcbc87b4c66f6497f66fc72d52b712aa7:

  workqueue: fix UAF in pwq_unbound_release_workfn() (2021-07-21 06:42:31 -1000)

----------------------------------------------------------------
Yang Yingliang (1):
      workqueue: fix UAF in pwq_unbound_release_workfn()

 kernel/workqueue.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
tejun
