Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463DE40124A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 03:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbhIFBCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 21:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhIFBCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:02:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BA2C061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 18:01:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u9so7272899wrg.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 18:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IxVSICxK8PQP1FYYvNRrNOeSxuOM7OpgcICzexNV9SY=;
        b=CAm2NHed49wvF0JySFhg4iw3OETEskCLBSIXuKa02VEBcTV6iDZddAAM+V3etu5foV
         rrOymaoioPzUFdGE1PW8+2IrZUZsID0VFwkUePHn89dfIP+nHF7WHuKARtQO3Ihsnlit
         rRqeDNPdG0wXt4UaoiiLP6kFf2rlv/eY2XKETDS5F7O2uWgaLbuoYXQ/XILpcRkd4QjU
         7UnPMICW0XvNkjY8KPwTcKA4td29e96uprVX1akE/IF2SRTS5MGLJMgSq3nZxiol09jL
         WaTTHSxIPpgOM/9IGW542JRT2usykql6PbjLq1mrXCQFpwZaQO+tJTr8HIVcLWE+Fupp
         Q/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IxVSICxK8PQP1FYYvNRrNOeSxuOM7OpgcICzexNV9SY=;
        b=RE0JntJ3lAb3vGNqtu7CjIXvqmt/gyQKvcfAPvCRPEfxe/qtPyJYGNgiFjG7j1EWiT
         LsoJx6RnAOikGark7783LLQET00N9g2ZrdCQN70N9IRGK1SIR+Po40Bz74a8UuQ+aLaU
         D7ZItzrb7n9gFhHLgXVFUETc9lThUINv9q2+SIufk8Z02FrIfincEvOZRIpEfq8KA7s0
         +b2OF+Bx4NERmkcRopZjQOIkY0k9rZyCfvHbXKAn1/ZYjrl/XbpHNaqEf5Bwb9bsKSZ4
         fzorvNCCF02dc1NoWEq8AfDsklDGs4+AKsWxasHybDX/ICNApb+EHK//0BZ5fxiXs8gy
         ncOg==
X-Gm-Message-State: AOAM530li7A5AAikz1UjRT+Bk1qUPMdNkgbYVA8Ck5XJgvEaM1YF5O/Z
        KUWhlD5KxubfVJeTOvhsm+sYtQ==
X-Google-Smtp-Source: ABdhPJyTjsl9TrWGf9NZYJoqGy6BLRSS3pG9D6sm8br50kxyVIs4ozNrPsPPO3LTQlU1BNHY66oQcA==
X-Received: by 2002:a5d:64e3:: with SMTP id g3mr10590349wri.396.1630890069653;
        Sun, 05 Sep 2021 18:01:09 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r25sm5151232wrc.26.2021.09.05.18.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 18:01:09 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 00/14] staging: r8188eu: cleanup unset pointers in
Date:   Mon,  6 Sep 2021 02:00:52 +0100
Message-Id: <20210906010106.898-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes all remaining pointers from struct hal_ops that are
never set anywhere else in the driver. As a part of this, it also takes
out the wrapper functions and their callers, given that they mostly never
end up calling/returning the function pointer value as they check for
NULL.

There are two exceptions to this however, and therefore this series also
fixes two potentially triggerable NULL pointer dereference bugs.

Phillip Potter (14):
  staging: r8188eu: remove rtw_hal_reset_security_engine function
  staging: r8188eu: remove hal_reset_security_engine from struct hal_ops
  staging: r8188eu: remove rtw_hal_enable_interrupt function
  staging: r8188eu: remove enable_interrupt from struct hal_ops
  staging: r8188eu: remove rtw_hal_disable_interrupt function
  staging: r8188eu: remove disable_interrupt from struct hal_ops
  staging: r8188eu: remove rtw_hal_interrupt_handler function
  staging: r8188eu: remove interrupt_handler from struct hal_ops
  staging: r8188eu: remove rtw_hal_xmitframe_enqueue function
  staging: r8188eu: remove hal_xmitframe_enqueue from struct hal_ops
  staging: r8188eu: remove Efuse_PgPacketWrite_BT function
  staging: r8188eu: remove Efuse_PgPacketWrite_BT from struct hal_ops
  staging: r8188eu: remove rtw_hal_c2h_id_filter_ccx function
  staging: r8188eu: remove c2h_id_filter_ccx from struct hal_ops

 drivers/staging/r8188eu/core/rtw_cmd.c     |  9 +----
 drivers/staging/r8188eu/core/rtw_efuse.c   | 13 +------
 drivers/staging/r8188eu/core/rtw_recv.c    |  2 -
 drivers/staging/r8188eu/hal/hal_intf.c     | 44 ----------------------
 drivers/staging/r8188eu/include/hal_intf.h | 19 ----------
 5 files changed, 3 insertions(+), 84 deletions(-)

-- 
2.31.1

