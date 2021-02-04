Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFB030F1B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhBDLLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbhBDLKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:10:46 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D024C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u14so3030380wri.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nlC+PhXfp+ifxVEhlW1JzBacSpYjJjXYHNmas4fv5Ds=;
        b=XJX470yfUpu4a/FA4lANKEzvueSTWsxfPj0W1Cfn9V3WbozDGwDKWnVRa6TIhBnVAs
         4LWFWuDhCanTjkjwrXkSW/2MYEzugl2aG9eyn1ApqjsEqgQsbgWpc2FusWzJoQV7lhdf
         zgWQJ21RrKQeKmi3XBHakKY9HNdswliGWOQZVaJKokVyRDEMZeAeKrhHLFc4VBaKOocu
         KQBrM54/2pMfprhRBw+7NqdnywjG7g/tY/8wvVBep3sQ58iJi853mTn7jBjGBv2pIKMO
         vgMX/GgphIpsy5g34uM4sT9YaB6sYhYzMtUDw6aM/0hUZx9YsmwRBmWHxDpVMNd0LARO
         Qncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nlC+PhXfp+ifxVEhlW1JzBacSpYjJjXYHNmas4fv5Ds=;
        b=JyKS0gIctk78ygXMRGW6nkuhNJHXb8UoUv/lK6bdetWSPcxu0V8+8rgvLEBhIzhzUo
         zWdM3/mQWFBwli1oo8nu/0SrQKgqMtjUR6NodlBtINfX2AOS2+eVZ7eiP7Tvqk+ncmtq
         cN1JDZdGppeRqdvxzwXUSZH26wA98dmEhbD3Bn4NJpHfZvMQswvbYCyr/lFawXbEfk3C
         gvPcA5ccc/QjFOnU+bFY9AQ2L1xygUwUPmswNwg/94eF1fYJU1TUj3FPMD642JwPpHe8
         9/DapuuPbwmcXn6hKTQCbTxLCz/MfNB5k3GqhyrO9nIXff8cnS9xXmx27/ueuZPaXI5E
         QMEQ==
X-Gm-Message-State: AOAM533vkJ7ol53kdvyW0eBL4v3qCVk51mlRa7BfgliDxoLA+GZm1lJz
        WVxEy1atQlZtPZj1PDHByvrCvjJ++01kIg==
X-Google-Smtp-Source: ABdhPJyLKDXyanH7L5GdxNPOqprdRtf1XwWUk17K9MS9MutmvHQHiDcu2KbNGqAlqOoC8tLO+lBQhg==
X-Received: by 2002:a05:6000:1105:: with SMTP id z5mr8634911wrw.15.1612437003994;
        Thu, 04 Feb 2021 03:10:03 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:03 -0800 (PST)
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
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
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
        Takashi Iwai <tiwai@suse.de>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Zaibo Xu <xuzaibo@huawei.com>
Subject: [PATCH 00/20] Rid W=1 warnings in Crypto
Date:   Thu,  4 Feb 2021 11:09:40 +0000
Message-Id: <20210204111000.2800436-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Lee Jones (20):
  crypto: hisilicon: sec_drv: Supply missing description for
    'sec_queue_empty()'s 'queue' param
  crypto: bcm: util: Repair a couple of documentation formatting issues
  crypto: chelsio: chcr_core: File headers are not good candidates for
    kernel-doc
  crypto: ux500: hash: hash_core: Fix worthy kernel-doc headers and
    remove others
  crypto: bcm: spu: Fix formatting and misspelling issues
  crypto: keembay: ocs-hcu: Fix incorrectly named functions/structs
  crypto: bcm: spu2: Fix a whole host of kernel-doc misdemeanours
  crypto: ux500: cryp: Demote some conformant non-kernel headers fix
    another
  crypto: ux500: cryp_irq: File headers are not good kernel-doc
    candidates
  crypto: chelsio: chcr_algo: Fix a couple of kernel-doc issues caused
    by doc-rot
  crypto: ux500: cryp_core: Fix formatting issue and add description for
    'session_id'
  crypto: atmel-ecc: Struct headers need to start with keyword 'struct'
  crypto: bcm: cipher: Provide description for 'req' and fix formatting
    issues
  crypto: caam: caampkc: Provide the name of the function
  crypto: caam: caamalg_qi2: Supply a couple of 'fallback' related
    descriptions
  crypto: vmx: Source headers are not good kernel-doc candidates
  crypto: nx: nx-aes-cbc: Headers comments should not be kernel-doc
  crypto: nx: nx_debugfs: Header comments should not be kernel-doc
  crypto: nx: Demote header comment and add description for 'nbytes'
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
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
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
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: Vinay Kumar Yadav <vinay.yadav@chelsio.com>
Cc: Zaibo Xu <xuzaibo@huawei.com>
-- 
2.25.1

