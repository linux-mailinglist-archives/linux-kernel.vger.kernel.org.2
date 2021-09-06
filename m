Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5FF401F65
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbhIFSDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhIFSDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:03:21 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13BCC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:02:16 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id a5so4405751qvq.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7QsvEICZ6OB0fLFnC4FGlJhtsxVgGBKEFw5SvTXHfEI=;
        b=Dolg4JolVnEztHeytNLimxQtQibFjkEEgeGh2DrD2n5utyQHmpY0rW7Aa7RvdbLZyx
         htdW0QUcxgNVoPX3TVkx7UtCrRe1wndaUc9fM1VLickdBxSBWIxzNCx0wSH/VqHEbreg
         ZXqqsMDUdgyV7mUp6V9KB68fXzfG/RsBD5SbPSo2tPY8RXrQWD5Rz1fDwoIqqHb3oscD
         HD99GcGrmcrPSQ8SGfYc95NDh4zhZAD939xdk5veyw4CjbtZ1LnBnqD95I4dkMuqrLST
         z46SGG+J6jGMfA4bwQAXelj/9oYExjERTIpXQqFj5Y5nPLGOjm5W8HKkxKO5HbowpB43
         vswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7QsvEICZ6OB0fLFnC4FGlJhtsxVgGBKEFw5SvTXHfEI=;
        b=amAyi7bBXqU31XXJSALMT+yWK/xjmIPN66T0FdmqUwoknplATBdL9mNgRH06+bw+vF
         NGejprtFU5+1Hl67NO/ZS76prHCRDtsuZApEJ6SHSiWANFqH98uSWspAk1C1udWbizFh
         7L0aF5gnBmP7U7UbUFvIN8T68Z0XmShFtHgVLw4Keb5af/JYtwf3CFefjXXIRn8swxkN
         HKjgb758M2DhW/1fduXHFZfTLYN47RbMx9T3GG3HeeTUT43U3R/qo3dG4mfgaNtflgus
         4BaKAVoQHu4QEXj53hkQOGx2xCMlDu5CDZ1fLL7L3SEgO0y4IONTAmKiXKkP7Iu9MNt6
         +IaQ==
X-Gm-Message-State: AOAM530lk0ipRfxWjW6ew2H9yE81GQ69fJMpfj+0C7H8Iuvyjhg3+3uq
        G8lcuectAWIir4V4wNmKTslCRp9q7jmr6Q==
X-Google-Smtp-Source: ABdhPJw8C/DJi23iRWb+S2Gm8MQkvmuym+U2CinI0a06j2yWb0Mmzv8JajOm3tVSXkYOAyh7hJM0zw==
X-Received: by 2002:a0c:9010:: with SMTP id o16mr7241792qvo.49.1630951329852;
        Mon, 06 Sep 2021 11:02:09 -0700 (PDT)
Received: from localhost ([2605:a601:a650:b700:5999:364b:aaba:7f89])
        by smtp.gmail.com with ESMTPSA id d129sm7067264qkf.136.2021.09.06.11.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:02:09 -0700 (PDT)
From:   Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date:   Mon, 6 Sep 2021 14:02:09 -0400
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: [GIT PULL] NTB bug fixes for v5.15
Message-ID: <20210906180209.GA14486@athena.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Here are a few NTB bug fixes for v5.15.  Please consider pulling them.

Thanks,
Jon



The following changes since commit 7d2a07b769330c34b4deabeed939325c77a7ec2f:

  Linux 5.14 (2021-08-29 15:04:50 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.15

for you to fetch changes up to 38de3afffb7257176978dfa9b3ab67d0c29af95c:

  NTB: switch from 'pci_' to 'dma_' API (2021-09-05 18:08:14 -0400)

----------------------------------------------------------------
Bug fixes and clean-ups for Linux v5.15

----------------------------------------------------------------
Christophe JAILLET (1):
      NTB: switch from 'pci_' to 'dma_' API

Colin Ian King (1):
      ntb: ntb_pingpong: remove redundant initialization of variables msg_data and spad_data

Dave Jiang (1):
      ntb: intel: remove invalid email address in header comment

Yang Li (2):
      NTB: Fix an error code in ntb_msit_probe()
      NTB: perf: Fix an error code in perf_setup_inbuf()

 drivers/ntb/hw/amd/ntb_hw_amd.c     | 12 ++----------
 drivers/ntb/hw/idt/ntb_hw_idt.c     | 15 ++-------------
 drivers/ntb/hw/intel/ntb_hw_gen1.c  | 12 ++----------
 drivers/ntb/hw/intel/ntb_hw_intel.h |  3 ---
 drivers/ntb/test/ntb_msi_test.c     |  4 +++-
 drivers/ntb/test/ntb_perf.c         |  1 +
 drivers/ntb/test/ntb_pingpong.c     |  2 +-
 7 files changed, 11 insertions(+), 38 deletions(-)
