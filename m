Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DB13BC94E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 12:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhGFKRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 06:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhGFKRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 06:17:51 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2137C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 03:15:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i94so25432406wri.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 03:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2y61eIOXeRoS1J9Ah3VdS858qMxJwWTMN0TN21jX/as=;
        b=p0owoCIm/1D1Bn0eTvL99Bxxwva6n+a38rPHcVMtZw6d6dYx0sYie63u+NxBV7lzQi
         y+xHnWpwfXWpI/05pDcRse84P0lKjyUQRW7k9enkV8m2MwZt1le5zS0GPxt34Utq64t8
         7vbC5d59QoqNbLEXA7iSG5nc9bzdjqEwyHFglRmLbttucjbPzhNpl3WyzGz+hTNJ72r5
         1n4tBV7+vr1PBvDWxF1gYcL24BS3KrW0hK+grwVg1vrsg+dRkYdjWFETa/uqwTVXfLDx
         oyctNcHSKQ2o4aO106IHzCTPXRVhECtNKnsArv31pFkosn2DZg/3iSg5QndSGYFsb6Qi
         4vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2y61eIOXeRoS1J9Ah3VdS858qMxJwWTMN0TN21jX/as=;
        b=KLOFjaVvuFCA46qNXIZx4Ia0nAKb14xYzzGqeyUP3GbLMd/BGMNXwGPfq0xD5FtYgh
         wCNiyBBhFiz1QeWrRGavps2tJoG/2/6cS7lAdjtQYXQmpKEkrtCuJh9hTUKoXuJw8ydO
         lbep88DudZVoNErPrhWcbnqaxKTFG5oeZMBBMndloy0R+X3yvlxmRkVT7NsIoXuqwjG3
         U3sVinFWiO3jubPiuu5isC6DThTpiUCWOxKcmUXb8h2gFMiJX557h5UDcxMDvXKsixPp
         bpvogQVcw3e7qrP8txwO7mFZ++cbtXsV0PypMXv9Mek9qq9TNYA8pgndcaeb0e94BMts
         uAqw==
X-Gm-Message-State: AOAM532cVxJwiNWxO+5PjcWNPpveO0GdNHkfrc/BR1mmW9O6xMJz/NLT
        IYDguQ3ufJ+5X3llbykSQ70lgQ==
X-Google-Smtp-Source: ABdhPJyhoBLX9YpczREivBIqkjXikuPUmLPhwlmXcBfMnD5Zk+VhqM4LkYkC3rCJFCXTwc7Q4mserA==
X-Received: by 2002:adf:d214:: with SMTP id j20mr16335482wrh.392.1625566510485;
        Tue, 06 Jul 2021 03:15:10 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id e9sm1931168wra.15.2021.07.06.03.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 03:15:09 -0700 (PDT)
Date:   Tue, 6 Jul 2021 11:15:08 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: [GIT PULL] kgdb changes for v5.14
Message-ID: <20210706101508.4jha4mm6kbcdpvdt@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8124c8a6b35386f73523d27eacb71b5364a68c4c:

  Linux 5.13-rc4 (2021-05-30 11:58:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.14-rc1

for you to fetch changes up to c8daba4640ac9619f9cb34ca7c314ff1eaff5f33:

  kgdb: Fix fall-through warning for Clang (2021-06-01 10:34:35 +0100)

----------------------------------------------------------------
kgdb patches for 5.14

This was a extremely quiet cycle for kgdb. This PR consists of two
patches that between them address spelling errors and a switch
fallthrough warning.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      kgdb: Fix fall-through warning for Clang

Zhen Lei (1):
      kgdb: Fix spelling mistakes

 include/linux/kgdb.h           | 8 ++++----
 kernel/debug/debug_core.c      | 3 ++-
 kernel/debug/kdb/kdb_main.c    | 8 ++++----
 kernel/debug/kdb/kdb_private.h | 2 +-
 4 files changed, 11 insertions(+), 10 deletions(-)
