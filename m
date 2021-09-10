Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D620B4072B5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 22:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhIJUwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbhIJUv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:51:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CFDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:50:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m9so4393172wrb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rccd+FaDPVuDVeT3ukG1P6kvqoGb4ZgC6X7OYACoy/s=;
        b=cER3bO29OcgSodf61vRqIvHUBKosrXwEHSCrlWi02cr3+6CKJxgyu85jqtaMe6W1ee
         /byGcMOhvnZQ3KdjahfAwtB+lttckYtDeKnipUZKsnX+I4Rcc/RryIF6hYvYpxAYDEEd
         NLmA2J85CD7qGJK765ZP0k6+xiH9rukkVMsT8qTFBoYAYasKcnk5GnljdaYe0wefsFaZ
         qPRdmHnlpZcIx9wGAKLi5GidA87wNRS2yTHb9zeoxBnYnB8fH7et3YcbICxgRK+JwI6y
         umTCDdhsy68K0mQ5VK4uH/5H57sXq2Gk5b+ei4G6eamtv6DuCIW2pZMp55IKeNKwOMvo
         09UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rccd+FaDPVuDVeT3ukG1P6kvqoGb4ZgC6X7OYACoy/s=;
        b=c371BeAuGGXM+objFpEAuEuPzwkp7HckDKm7hVZl4oJSiEmNKuTlrHElrxZrO3efru
         UYyGWc0NQpWiEyua2R5FxuKg7yR3k7PAVWhrz2bCp+/emXZleFuEdAAJMR4lakJTitjV
         HFF4cVmbF4cqqczLwDtrHuQnLcfbG1KddSiLCnCxsx07YIm5Lj44a5krcWLP3qnxiZBe
         6ztD0hvjaXnp4JXp+P3spvhzv4FmHbif7QxbAcW7JhYFpvz+N81ZR+97JlLhP5qMmg2v
         Ui/LwNWy2bKlzMbKu4Ugu1kEvpbTOBQH9Zrp1rJK3CGKM/zw3I5gC9TORLEQJ2WjF66S
         fzsg==
X-Gm-Message-State: AOAM531UMHeY1s++vCyoHH709oh1GE608HwBSBFLrdw//eHW9aRrPaB/
        nMhpwGfecEaYqKtWUvUddw4=
X-Google-Smtp-Source: ABdhPJzIzcb1KBsTMTxM9lVfQOfg2ZnjsBwcWGfoUEi5Ppy63exjH+qlsqqhScjjK1Zpke/3AHaUkA==
X-Received: by 2002:adf:e44f:: with SMTP id t15mr4031973wrm.394.1631307045259;
        Fri, 10 Sep 2021 13:50:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id g11sm5592427wrx.30.2021.09.10.13.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:50:44 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/7] remove pointers from struct hal_ops
Date:   Fri, 10 Sep 2021 22:50:26 +0200
Message-Id: <20210910205033.3778-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes some more pointers from struct hal_ops and
removes the function rtl8188e_set_hal_ops() that is empty after
the removals.

Michael Straube (7):
  staging: r8188eu: remove mgnt_xmit from struct hal_ops
  staging: r8188eu: remove hal_xmit from struct hal_ops
  staging: r8188eu: remove read_bbreg from struct hal_ops
  staging: r8188eu: remove write_bbreg from struct hal_ops
  staging: r8188eu: remove read_rfreg from struct hal_ops
  staging: r8188eu: remove write_rfreg from struct hal_ops
  staging: r8188eu: remove rtl8188e_set_hal_ops()

 drivers/staging/r8188eu/core/rtw_debug.c      |  8 +--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  8 +--
 drivers/staging/r8188eu/core/rtw_mp.c         | 10 ++--
 drivers/staging/r8188eu/core/rtw_xmit.c       |  9 ++--
 drivers/staging/r8188eu/hal/hal_intf.c        | 51 -------------------
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  2 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  7 ---
 drivers/staging/r8188eu/hal/usb_halinit.c     |  5 --
 drivers/staging/r8188eu/include/hal_intf.h    | 29 -----------
 .../staging/r8188eu/include/rtl8188e_hal.h    |  2 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 24 ++++-----
 11 files changed, 31 insertions(+), 124 deletions(-)

-- 
2.33.0

