Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DA630DCD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhBCOdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhBCOdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:33:50 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB98C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:33:10 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id h16so16544265qth.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hFVpsPmskX5v5OqYWeZ4v5kCJDeC7TSVZUZ0ux0+ShY=;
        b=BFaYS9tA+mKRULFIRN2SY/lioEm3Rj8LTAXQOMEsgMJilhbHf0kKrlgQeNdZuIaCSr
         VHhzrEHqc9v0u+Re5pvN28/nfwJmte7sl0hi/pIXmu5GlHSL1K6EAhgYVBN0b2Mq+ERI
         d8fZ525GvTMXQCfMcB9bCKCtDYHW0MKWC6/NoRQm+Te3o5rd2yVNu5JGiofwbOtRVISf
         g65Y4Ry/eMxuQWZibn2XEMM5Koy5fwaCv2QiSQJdn1kwmtZ9ONpRdftOxLHm6OqQpUWj
         GWbJjZz9VY/XYVZJMBihRCLBolUIqi3p9Zk08G+Pxwcu8momnEJNgPHjSs0Sk07jt347
         r+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hFVpsPmskX5v5OqYWeZ4v5kCJDeC7TSVZUZ0ux0+ShY=;
        b=RwfMz8P1imI46reXr94yp+pcrtszAoIkt8epM8gJZ+dVQBaZKOFhDsu1KqrfLV0x3o
         Xszqfe7hn5X7VGVCbFB8BDl/vLYhW5xRA86e1ADBwLN9aId2GedZ/A02iEJx1w1TmDL8
         EogSpSVn2Qv/NKdALf3x5Vi88kwCSJtmhWZLX3i1f/RFSiSqa9Bz/3mYYNzFvpw7biuc
         AZMPUaEbJh/UDzBIFu1DzIk0+og4yVKuZOZo5Ghiiu2tyv9c3lKO+LeQtPQS10x/RaQE
         YcPKoQUNG3MDv+RWIl7yePNEWPcu2VeTHHMPN7LzUtytytZoAzXNL7C8N4bLlK4IDUMa
         r1ew==
X-Gm-Message-State: AOAM531/v2IAbqd4tpg97wmlHbrf0Zfxh/M0Jf9UYKxvS94m8SYRpqOF
        YxPB3nt7WP4wKpK4F8POTY4OYg==
X-Google-Smtp-Source: ABdhPJyfZxQNM91CdsDsqtG41dB+ZodLg8UgqzIPM2N3SrqT4/okWdUTCx1q8lgTzUwX/bc4b1wgig==
X-Received: by 2002:ac8:4990:: with SMTP id f16mr2608167qtq.184.1612362789340;
        Wed, 03 Feb 2021 06:33:09 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id v15sm1775433qkv.36.2021.02.03.06.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:33:08 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/11] Regression fixes/clean ups in the Qualcomm crypto engine driver
Date:   Wed,  3 Feb 2021 09:32:56 -0500
Message-Id: <20210203143307.1351563-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a result of running kernel crypto fuzz tests (by
enabling CONFIG_CRYPTO_MANAGER_EXTRA_TESTS) on the transformations
currently supported via the Qualcomm crypto engine on sdm845.  The first
nine patches are fixes for various regressions found during testing. The
last two patches are minor clean ups of unused variable and parameters.

v3->v4:
	- Fixed the bug where only two bytes of byte_count were getting
	  saved and restored instead of all eight bytes. Thanks Bjorn for
	  catching this.
	- Split patch 3 "Fix regressions found during fuzz testing" into
	  6 patches as requested by Bjorn.
	- Dropped crypto from all subject headers.
	- Rebased to 5.11-rc5
v2->v3:
        - Made the comparison between keys to check if any two keys are
          same for triple des algorithms constant-time as per
          Nym Seddon's suggestion.
        - Rebased to 5.11-rc4.
v1->v2:
        - Introduced custom struct qce_sha_saved_state to store and restore
          partial sha transformation.
        - Rebased to 5.11-rc3.

Thara Gopinath (11):
  crypto: qce: sha: Restore/save ahash state with custom struct in
    export/import
  crypto: qce: sha: Hold back a block of data to be transferred as part
    of final
  crypto: qce: skcipher: Return unsupported if key1 and key 2 are same
    for AES XTS algorithm
  crypto: qce: skcipher: Return unsupported if any three keys are same
    for DES3 algorithms
  crypto: qce: skcipher: Return error for zero length messages
  crypto: qce: skcipher: Return error for non-blocksize data(ECB/CBC
    algorithms)
  crypto: qce: skcipher: Set ivsize to 0 for ecb(aes)
  crypto: qce: skcipher: Improve the conditions for requesting AES
    fallback cipher
  crypto: qce: common: Set data unit size to message length for AES XTS
    transformation
  drivers: crypto: qce: Remover src_tbl from qce_cipher_reqctx
  crypto: qce: Remove totallen and offset in qce_start

 drivers/crypto/qce/cipher.h   |   1 -
 drivers/crypto/qce/common.c   |  25 +++---
 drivers/crypto/qce/common.h   |   3 +-
 drivers/crypto/qce/sha.c      | 143 +++++++++++++---------------------
 drivers/crypto/qce/skcipher.c |  72 ++++++++++++++---
 5 files changed, 129 insertions(+), 115 deletions(-)

-- 
2.25.1

