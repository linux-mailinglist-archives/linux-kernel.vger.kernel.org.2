Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8740285A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344080AbhIGMTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:19:30 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33388
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242841AbhIGMT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:19:29 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 60C734015D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017102;
        bh=YRlo3nZk5ArGV6WwvlTiTe3l09axCD12jul04F8OPD4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=nzJtVJmbtzaqIcDkqC8KMC1uJbexdfbAydVpFsHbABcEbUA1AuqGNaMAyhgcBBbcS
         7TSFFzaOKRgUBtShpccXsXcLvL3BDWEqgJFWLE3pgTzWYWRU+kleg+cKeYl0KA0CN6
         qBYzhSUXjzLCSSlFGVCo8Rd6tnZR3HHxiMrVR9x0onW2wXaj4dJBeE5K7OLt6zG84W
         SSroVuzvxwq+Qevnhgd5k/YtwVjJ+V6vdy7SFJJT+mwhkd/xdFKz/jQZA8lSftv9Me
         phteiQe+KzXheg4EqTCkXmhZfnetUX4FE0BiDTo7bKS16SqRXvhukh266sBt9aFsex
         oztXPYn9dpUaQ==
Received: by mail-wm1-f72.google.com with SMTP id j33-20020a05600c48a100b002e879427915so3321303wmp.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 05:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YRlo3nZk5ArGV6WwvlTiTe3l09axCD12jul04F8OPD4=;
        b=JnzwamVh/I//ir5In9YrlUekVhOdndn+yyyiN6CL3NMPXncqxxKf0nhqd9jojRpS9a
         RlrRyaZ7tc5j0uGsG5g4EMNma0+MNxSFut4Lp0W9FDR1R+EXgsThDauW7JDauF5cek0z
         3v62MMxEfAvkQKXZPweO50IcFWRvyeDvmUTETm94USLxBWEQxEZf3phwC0w5tkqS0Oe9
         hdt4dLISxoOT7loovmRt5moeRbgLnJ6nbsdhMVxrsu1r5PEXBjEz5gE7xtpRj9Kbru/t
         idkgddU+o1DSp2KqX0cRaep5GfquOQtLyC3nHZPh8ruVs3+4XNT8tWCD+1sgfKxb/VJ9
         Gwhw==
X-Gm-Message-State: AOAM533u5ryZKRU3tGehH0PuyVhnD5kldEYC30RCOucbp+OPQR4mCTIF
        1YW8UlJ+tFSPsFeo8tYNfoq+mWAhPrbdweXoChXhk7Fp7g3IDP1dqdfO98yMEGpGxoDqrtlWBsT
        GsM14r3xmh2ubC3A/LqG8BJbStL7YAFsgRYclHtdM7A==
X-Received: by 2002:a5d:4043:: with SMTP id w3mr18531814wrp.15.1631017102045;
        Tue, 07 Sep 2021 05:18:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7BsAVATcBM4EgZcgR0syj5gOVbXmAk+X5F/H8PDMeYrVY2fTt9ht8q++8LSzCq0F5JNa9Eg==
X-Received: by 2002:a5d:4043:: with SMTP id w3mr18531794wrp.15.1631017101859;
        Tue, 07 Sep 2021 05:18:21 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id m3sm13525216wrg.45.2021.09.07.05.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:18:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] nfc: minor printk cleanup
Date:   Tue,  7 Sep 2021 14:18:01 +0200
Message-Id: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

No dependencies, patches can be picked up as is.

Best regards,
Krzysztof


Krzysztof Kozlowski (15):
  nfc: drop unneeded debug prints
  nfc: do not break pr_debug() call into separate lines
  nfc: nci: replace GPLv2 boilerplate with SPDX
  nfc: fdp: drop unneeded debug prints
  nfc: pn533: drop unneeded debug prints
  nfc: pn533: use dev_err() instead of pr_err()
  nfc: pn544: drop unneeded debug prints
  nfc: pn544: drop unneeded memory allocation fail messages
  nfc: s3fwrn5: simplify dereferencing pointer to struct device
  nfc: st-nci: drop unneeded debug prints
  nfc: st21nfca: drop unneeded debug prints
  nfc: trf7970a: drop unneeded debug prints
  nfc: microread: drop unneeded debug prints
  nfc: microread: drop unneeded memory allocation fail messages
  nfc: mrvl: drop unneeded memory allocation fail messages

 drivers/nfc/fdp/i2c.c          |  1 -
 drivers/nfc/microread/i2c.c    |  4 ----
 drivers/nfc/microread/mei.c    |  6 +-----
 drivers/nfc/nfcmrvl/fw_dnld.c  |  4 +---
 drivers/nfc/pn533/i2c.c        |  1 -
 drivers/nfc/pn533/pn533.c      |  4 +---
 drivers/nfc/pn544/mei.c        |  8 +-------
 drivers/nfc/s3fwrn5/firmware.c | 29 +++++++++++-----------------
 drivers/nfc/s3fwrn5/nci.c      | 18 +++++++----------
 drivers/nfc/st-nci/i2c.c       |  4 ----
 drivers/nfc/st-nci/ndlc.c      |  4 ----
 drivers/nfc/st-nci/se.c        |  6 ------
 drivers/nfc/st-nci/spi.c       |  4 ----
 drivers/nfc/st21nfca/i2c.c     |  4 ----
 drivers/nfc/st21nfca/se.c      |  4 ----
 drivers/nfc/trf7970a.c         |  8 --------
 net/nfc/hci/command.c          | 16 ----------------
 net/nfc/hci/llc_shdlc.c        | 35 +++++++++-------------------------
 net/nfc/llcp_commands.c        |  8 --------
 net/nfc/llcp_core.c            |  5 +----
 net/nfc/nci/core.c             |  4 ----
 net/nfc/nci/hci.c              |  4 ----
 net/nfc/nci/ntf.c              |  9 ---------
 net/nfc/nci/uart.c             | 16 ++--------------
 24 files changed, 34 insertions(+), 172 deletions(-)

-- 
2.30.2

