Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68AE324C81
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbhBYJLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbhBYJHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:07:09 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D066C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:06:29 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d12so650439pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F5muCWgN/fGzSabg6nu22qD5L7/WjvegxAVZGCfyJ9k=;
        b=vFPuPp2EUaKif3CZORpg6Mxzi8IhrUS39Km0EEJlXlMGKIunU6DyAKENqHVJ5wY5QJ
         fy3gHdeEwZEpJm+q0ET+XS0eWiOSMFwOvUhWVBWs6bJ0SUsAM7vikUobEBptvzEG4rac
         JUAwDMfC1x7dN5lmOLibJU3RGcQC2Qq/W9HgIYWyW5PrqwEIHzU7r8vNhWGwH4SdtdtK
         l3TcbJOWpvPt+d9mkf35h+54o++Bunu93ccMqZrK0uKVDNTc/KlMKY1mhQpMPSKBzY9q
         Y4pT0P0Zt2BDjSsptaLwXjBlnsXQMKJ444zk13hiC91ExGS8HH240VP1IHHGPeGi7fwS
         1OVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F5muCWgN/fGzSabg6nu22qD5L7/WjvegxAVZGCfyJ9k=;
        b=Z9wE/ahZuQJeI2mahaw6LURFsfmKZBVtXCHKQG2YgYwUZYYqMlvolZU9ZDcLNnBv3R
         Ppbl66lHcsmy2OqLk9X2Cq8Ki93Lc/mAdNKlbEKod8UYAu6958pSSNUfkmJ+V9L/KfgY
         W1FlPGnsm6PKNIyrOcxVHCMY/dV7kvexpVhExj/Ix8Gr4OBm+kn5nY6+oeTVAgWJgS9O
         7TNB5ERL5agXUZI4W0jzzSiXUS1208WhAbA+dCqk95Er/HjnsXFyrpNkvqcDGPNxYsgs
         v1Ypn3bF24LW4OR/MNKhT7o7Th/s/QC/wX/IXANGMp0NeCRelCiSdQkkxDpNYy9YUclD
         a4Qw==
X-Gm-Message-State: AOAM533b5ppE1dW9HKLjL/0cz/3o3PIl6JSKIcsLgUycZ0YzEXewJw/b
        bdQgoeJ3QAxG+cylqnIYcegYU5hRkqE=
X-Google-Smtp-Source: ABdhPJxxKlnvUkRwVovj0EQzjIlbGw9+GL7e3aKG+Nl8FikH/LcgW3lZ03PGKqWjJqRJ74EuYmo8lA==
X-Received: by 2002:a65:6a0c:: with SMTP id m12mr2096492pgu.161.1614243988891;
        Thu, 25 Feb 2021 01:06:28 -0800 (PST)
Received: from localhost.localdomain ([49.207.194.79])
        by smtp.gmail.com with ESMTPSA id n11sm5098373pgm.30.2021.02.25.01.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 01:06:28 -0800 (PST)
From:   Allen Pais <allen.lkml@gmail.com>
To:     jens.wiklander@linaro.org, zajec5@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Allen Pais <apais@linux.microsoft.com>
Subject: [PATCH v2 0/2] optee: fix OOM seen due to tee_shm_free()
Date:   Thu, 25 Feb 2021 14:36:08 +0530
Message-Id: <20210225090610.242623-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen Pais <apais@linux.microsoft.com>

The following out of memory errors are seen on kexec reboot
from the optee core.
    
[    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
[    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
    
tee_shm_release() is not invoked on dma shm buffer.
    
Implement .shutdown() in optee core as well as bnxt firmware driver
to handle the release of the buffers correctly.
    
More info:
https://github.com/OP-TEE/optee_os/issues/3637

v2:
  keep the .shutdown() method simple. [Jens Wiklander]

Allen Pais (2):
  optee: fix tee out of memory failure seen during kexec reboot
  firmware: tee_bnxt: implement shutdown method to handle kexec reboots

 drivers/firmware/broadcom/tee_bnxt_fw.c |  9 +++++++++
 drivers/tee/optee/core.c                | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.25.1

