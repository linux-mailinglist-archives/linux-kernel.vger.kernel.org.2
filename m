Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10FE401DF5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243601AbhIFQCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhIFQCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:02:05 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D615DC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 09:01:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n39so3212692wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=TW4/79yCgvrlw+tkLKQH1bxVes98LMtbsbABHptP2V8=;
        b=FAkeO+lrghkM0ll4XTVrgNhXIlSP1tX+71CILYw/8sZU+Ac108gH0cCG3ViCvIw+ql
         nnYlexZP297RSjaWfFWa2jAn+u6AQWGp9m299LA9HYXVdhVNJf5Dbj0qPnfK7ZKNffH9
         JeA2aRoxbTA04ORGMHvfhgsrIoLf77drCYjUjr9iS47MsHvO33Dtlg8Lr8OyVNfpcGTg
         dPUthxTgtIAB0bT41m5pP9crn03hBqml3CFayyFsoDULB6sdU31vfHvrxzNb90xnczmw
         kuiSKPjG1FGQ7Z60KHNK1YEhI79kXfN38xUA/Ny5RXd+5iJsyaEiSwyO5F7igxY4Xg+N
         v/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TW4/79yCgvrlw+tkLKQH1bxVes98LMtbsbABHptP2V8=;
        b=ap1XfBX10c9fwlHO5IPNrfco2wVCRAzRNEiEzvy7Fi8dpyEwn17aTDVwELp14XAmSR
         Vx8BTtL/+nwGbasUFy60TrLxu2IP0C/VBAyK6v5Duzktus7wlrDmYDRQ0glB1xWWxYF+
         VLl7JDsKIDjvMquT3YlQCKOGINtZK02zT1gAKWyQnJVgGckB227+zNV3Qgm+DrvIpsxx
         yGFZ1fN9Bz7hvj43OJvSTII1e8hEKYxkkBAIW3hSR+xJLrZqMTPDTbmfdTK2NscDLzDA
         58umokxZKGSJFOwXALlaqzGuIjjLUav/FsQ4NO1cYdzbK5V+G4UJoJ7a+Eg5ooTM8/Wk
         5u9g==
X-Gm-Message-State: AOAM5336PUtd09PI469PkC38HChYlyIydO56weu+noBsztBhFtcz1tSX
        JVGF5SRb9LEhI/ZKhfTYL4HE2w==
X-Google-Smtp-Source: ABdhPJy/Rid20aBl8sgW1pzhBxqz50C0u+A3j5YwZEfUoDBFAPox/YxnbiGh/YcwrAfYkZMILez0nA==
X-Received: by 2002:a05:600c:1d29:: with SMTP id l41mr11987897wms.177.1630944059342;
        Mon, 06 Sep 2021 09:00:59 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id n13sm2139202wmq.3.2021.09.06.09.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 09:00:58 -0700 (PDT)
Date:   Mon, 6 Sep 2021 17:00:56 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [GIT PULL] kgdb changes for v5.15
Message-ID: <20210906160056.j42y4rrtmvjb37hc@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.15-rc1

for you to fetch changes up to f8416aa29185468e0d914ba4b2a330fd53ee263f:

  kernel: debug: Convert to SPDX identifier (2021-09-06 14:31:11 +0100)

----------------------------------------------------------------
kgdb patches for 5.15

Changes for kgdb/kdb this cycle are dominated by a change from
Sumit that removes as small (256K) private heap from kdb. This is
change I've hoped for ever since I discovered how few users of this
heap remained in the kernel, so many thanks to Sumit for hunting
these down. Other change is an incremental step towards SPDX headers.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Cai Huoqing (1):
      kernel: debug: Convert to SPDX identifier

Sumit Garg (5):
      kdb: Get rid of custom debug heap allocator
      kdb: Rename struct defcmd_set to struct kdb_macro
      kdb: Get rid of redundant kdb_register_flags()
      kdb: Simplify kdb_defcmd macro logic
      kdb: Rename members of struct kdbtab_t

 include/linux/kdb.h             |  27 +-
 kernel/debug/debug_core.c       |   5 +-
 kernel/debug/gdbstub.c          |   5 +-
 kernel/debug/kdb/kdb_bp.c       |  72 ++---
 kernel/debug/kdb/kdb_debugger.c |   1 -
 kernel/debug/kdb/kdb_main.c     | 626 ++++++++++++++++++----------------------
 kernel/debug/kdb/kdb_private.h  |  18 --
 kernel/debug/kdb/kdb_support.c  | 329 ++-------------------
 kernel/trace/trace_kdb.c        |  12 +-
 samples/kdb/kdb_hello.c         |  20 +-
 10 files changed, 387 insertions(+), 728 deletions(-)
