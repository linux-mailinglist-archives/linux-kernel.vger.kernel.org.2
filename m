Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532EA32BF79
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577934AbhCCSBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444125AbhCCPBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:01:20 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CA2C06121F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:34:56 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d15so8689765wrv.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L1RbVwNozbMEhIlYozwqO6QzTGoV7UQM4uCG//6rsVY=;
        b=L04HIeeFpp9qpeDcZe17XsnDPRYOxXbuL/gti0bbZINWR8fjhoFO6oA+icoYSdUbJU
         qJv+GlOdvdTpBGY3eJyGOE5HFCKGgbsdcfuQoqpRmitfWZZTx5etug6AJqLE9Zpo+MIF
         e7f82hcLy4d1aMZ4d/W0Tq4G/+lhPk+6zg5vxWsjN3bIthd0No7wyOXswPKPFzhQZhbd
         sMsBsZ67uS8sUU0YQemEAenQzFd2I2bnzBx/CcaewbfmrweHYeNVanzhhq/qr0/xKl2g
         ROXG+FZZ57NPM0CM3grm+pe5Y0NqCLU5IgVnFhG+cZR9MpbvWhrphZaJxct3OCDx6kcc
         XzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L1RbVwNozbMEhIlYozwqO6QzTGoV7UQM4uCG//6rsVY=;
        b=JCkE5qZPuDpUONDZdnzt9MDBZ7+wcG3rv/9/dK9AnMTTSAtBUlMmMH7BY3R9TRKuT3
         OYi3N9bLWBdp5lLGWUjc+3jpGAQtljq/QJkHSG36D9pRPHFH8NPCv+zhxI1H6EmhZuG+
         W5Uxd0+RsU2LTPBBSpNUMqZfAAB/syNoq9uDPVJdd/rOmPLl/iJxsOMEvAi8/Pi1xqxl
         LJvxuv+ehEbiZMwzGIa6X1yZF7GCaBdZiv29kGXG1itc9pwgskOYHMv9BnSW206keJwH
         1Y/iXPDOfqRiuQZpgJ9JjcFVUVB+eSNgn1HRSbAr33tzE1hs7erHrwWdADEU74fBusbz
         HAag==
X-Gm-Message-State: AOAM530ihs7cZSbQezYb0XukdMQROGU7xQWOfEhuihDZx6NvWvkVxhyO
        KhPF6zvBkjr8kyGLyc9cYC4XhQ==
X-Google-Smtp-Source: ABdhPJy/WNSjeAnc02Hh3KWLAXBxgB9kMs5eRjeHAQRlqgWIOlgEM2POuDGFU/Cws9/8rs2j+YABoQ==
X-Received: by 2002:adf:dbc2:: with SMTP id e2mr26741212wrj.227.1614782093784;
        Wed, 03 Mar 2021 06:34:53 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id f16sm31475923wrt.21.2021.03.03.06.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:34:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andreas Westin <andreas.westin@stericsson.com>,
        Atul Gupta <atul.gupta@chelsio.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Berne Hebark <berne.herbark@stericsson.com>,
        =?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Declan Murphy <declan.murphy@intel.com>,
        Harsh Jain <harsh@chelsio.com>,
        Henrique Cerri <mhcerri@br.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Jitendra Lulla <jlulla@chelsio.com>,
        Joakim Bech <joakim.xx.bech@stericsson.com>,
        Jonas Linde <jonas.linde@stericsson.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Kent Yoder <yoder1@us.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Manoj Malviya <manojmalviya@chelsio.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        M R Gowda <yeshaswi@chelsio.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Niklas Hernaeus <niklas.hernaeus@stericsson.com>,
        Paul Mackerras <paulus@samba.org>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        Rob Rice <rob.rice@broadcom.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        Shujuan Chen <shujuan.chen@stericsson.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Zaibo Xu <xuzaibo@huawei.com>
Subject: [PATCH v2 00/10] Rid W=1 warnings in Crypto
Date:   Wed,  3 Mar 2021 14:34:39 +0000
Message-Id: <20210303143449.3170813-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

This is set 1 of 2 sets required to fully clean Crypto.

No functional changes since v1.

Lee Jones (10):
  crypto: hisilicon: sec_drv: Supply missing description for
    'sec_queue_empty()'s 'queue' param
  crypto: bcm: Fix a whole host of kernel-doc misdemeanours
  crypto: chelsio: chcr_core: Fix some kernel-doc issues
  crypto: ux500: hash: hash_core: Fix worthy kernel-doc headers and
    remove others
  crypto: keembay: ocs-hcu: Fix incorrectly named functions/structs
  crypto: atmel-ecc: Struct headers need to start with keyword 'struct'
  crypto: caam: caampkc: Provide the name of the function and provide
    missing descriptions
  crypto: vmx: Source headers are not good kernel-doc candidates
  crypto: nx: nx-aes-cbc: Repair some kernel-doc problems
  crypto: cavium: nitrox_isr: Demote non-compliant kernel-doc headers

 drivers/crypto/atmel-ecc.c                |  2 +-
 drivers/crypto/bcm/cipher.c               |  7 ++--
 drivers/crypto/bcm/spu.c                  | 16 ++++-----
 drivers/crypto/bcm/spu2.c                 | 43 +++++++++++++----------
 drivers/crypto/bcm/util.c                 |  4 +--
 drivers/crypto/caam/caamalg_qi2.c         |  2 ++
 drivers/crypto/caam/caampkc.c             |  3 +-
 drivers/crypto/cavium/nitrox/nitrox_isr.c |  4 +--
 drivers/crypto/chelsio/chcr_algo.c        |  8 ++---
 drivers/crypto/chelsio/chcr_core.c        |  2 +-
 drivers/crypto/hisilicon/sec/sec_drv.c    |  1 +
 drivers/crypto/keembay/ocs-hcu.c          |  6 ++--
 drivers/crypto/nx/nx-aes-cbc.c            |  2 +-
 drivers/crypto/nx/nx.c                    |  5 +--
 drivers/crypto/nx/nx_debugfs.c            |  2 +-
 drivers/crypto/ux500/cryp/cryp.c          |  5 +--
 drivers/crypto/ux500/cryp/cryp_core.c     |  5 +--
 drivers/crypto/ux500/cryp/cryp_irq.c      |  2 +-
 drivers/crypto/ux500/hash/hash_core.c     | 15 +++-----
 drivers/crypto/vmx/vmx.c                  |  2 +-
 20 files changed, 71 insertions(+), 65 deletions(-)

Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Andreas Westin <andreas.westin@stericsson.com>
Cc: Atul Gupta <atul.gupta@chelsio.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Ayush Sawal <ayush.sawal@chelsio.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Berne Hebark <berne.herbark@stericsson.com>
Cc: "Breno Leitão" <leitao@debian.org>
Cc: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Declan Murphy <declan.murphy@intel.com>
Cc: Harsh Jain <harsh@chelsio.com>
Cc: Henrique Cerri <mhcerri@br.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Jitendra Lulla <jlulla@chelsio.com>
Cc: Joakim Bech <joakim.xx.bech@stericsson.com>
Cc: Jonas Linde <jonas.linde@stericsson.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Kent Yoder <yoder1@us.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-crypto@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Manoj Malviya <manojmalviya@chelsio.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: M R Gowda <yeshaswi@chelsio.com>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Niklas Hernaeus <niklas.hernaeus@stericsson.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
Cc: Rob Rice <rob.rice@broadcom.com>
Cc: Rohit Maheshwari <rohitm@chelsio.com>
Cc: Shujuan Chen <shujuan.chen@stericsson.com>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: Vinay Kumar Yadav <vinay.yadav@chelsio.com>
Cc: Zaibo Xu <xuzaibo@huawei.com>
-- 
2.27.0

