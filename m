Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6B93A8BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 00:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFOWiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 18:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhFOWiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 18:38:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239B7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:36:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id y13-20020a1c4b0d0000b02901c20173e165so533715wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeDnHq8ZJBiwEwWDSRdqHUmE3/dIBI2cdiaVs08gMLo=;
        b=epOWaywLJRBPSH71XG3Vle6CE6NTtTCbAqFfsszHrqBIjjnK9wfKEdnbhvK3aeMDX1
         00TuqDY+i0CObbK59pTM99vKCmIueuAIBR2udvbMqu4XOl1x/5Y1HFijX1sScw4WfXvV
         CRzhaw4TnuGwA4kpSEOlZRCh+3k4gm04KINdnqw6rN5l9ZgzXUhiP5BEqpmzfiLkc65f
         gWG/OXPNYW9VY4jIfPmG48fluyr4uXMQSAs6+Gq7LxZBjYlDI/BsKQRf3ppnTaK0gMw4
         lYPVnNvo+o7MxIwAueXo+smfuvJFRPP1NtLkl73GRX4ZF77Wzt1ZoAlD4hUQU0Cz+kbH
         3TTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeDnHq8ZJBiwEwWDSRdqHUmE3/dIBI2cdiaVs08gMLo=;
        b=CCjCoAyb6cNraeD7YmQ4KYff8pdWXZ+6Y4JYXHw6nrHoilOyok+tIS7zyul60UD3VN
         +ZnGOQF/9jr3/cvxGkhH4DkA2mNMVffFgHXlVG2TZJAmfzU9UC4rL0bfv33WvjUPs1E3
         RDN5Nr4PNuZFaeD5hJDoHnzrGucI7FZxEfzwhnPLeQRiTKXG1D81usMhsJdkDoP/TOm2
         CMcxCyM35eYv19ZeGRX15bTLgmFeBgXPC0ursWiqsvCdjU+gjHCKla9vBVEC2yiswUH1
         mc/pVqc3B+DbESPQpue6FnJLd7faGDL0dSHWmeZN+hZArZq/UQEBr0dCzHsyhErPhrWD
         TWAw==
X-Gm-Message-State: AOAM530I/NKn194qNWdxFDAegMIgEuvZMc1KRDJWJA4LxRq+bvwFNpyY
        eoh65m3B591hhrOReTv7KM09VJE/t/m2vTVY
X-Google-Smtp-Source: ABdhPJwk1z6ArKvPyCqIhocjUyi3ERhMpYt1WNwYo3S3cQqtshPrUgpdKiEOgfzCNCgZLnaa0VRKtQ==
X-Received: by 2002:a05:600c:20d:: with SMTP id 13mr1667903wmi.174.1623796572710;
        Tue, 15 Jun 2021 15:36:12 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id m23sm3934791wml.27.2021.06.15.15.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:36:12 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 0/7] Fixup unused variables and warnings
Date:   Tue, 15 Jun 2021 23:36:00 +0100
Message-Id: <20210615223607.13863-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes an empty goto label by removing it and converting its
associated goto to a return. It also changes a decrement operator to
prefix to make it clearer, and provide expected behaviour. Finally, it
removes a lot of unused variables warned about by the kernel test robot,
which are a result of my previous DBG_88E removal series, and removes an
entire function as well which is surplus to requirements.

Phillip Potter (7):
  staging: rtl8188eu: remove empty label from
    mlmeext_joinbss_event_callback
  staging: rtl8188eu: use prefix decrement operator on trycnt variable
  staging: rtl8188eu: remove unused variables from core/rtw_efuse.c
  staging: rtl8188eu: remove unused variables from core/rtw_mlme_ext.c
  staging: rtl8188eu: remove unused variable from os_dep/ioctl_linux.c
  staging: rtl8188eu: remove unused variables from hal/rtl8188e_cmd.c
  staging: rtl8188eu: remove _dbg_dump_tx_info function

 drivers/staging/rtl8188eu/core/rtw_efuse.c    | 11 ++--------
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 20 +++++--------------
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c  |  4 ----
 drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c | 17 ----------------
 .../staging/rtl8188eu/hal/rtl8188eu_xmit.c    |  1 -
 drivers/staging/rtl8188eu/hal/usb_halinit.c   |  2 +-
 .../staging/rtl8188eu/include/rtl8188e_xmit.h |  3 ---
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    |  3 ---
 8 files changed, 8 insertions(+), 53 deletions(-)

-- 
2.30.2

