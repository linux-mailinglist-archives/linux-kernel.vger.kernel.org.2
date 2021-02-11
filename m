Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F743193F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhBKUHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhBKUCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:02:11 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA61C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:01:30 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h16so5061574qth.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 12:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BkNbbxb6k/17zzJxBEIrJhvukJWdWW3RjEBbcBFX430=;
        b=aLSfsFswKuq9oi6QHQPnxX1RgBgaK69pFL1L25ki5cIqOfjEXzg3hvSdsjnS+kj2nU
         SZUlACzn16zviRTySn580vyva3PmeMoLeehw98PdlRD0Iufjhzo89I1MomR+ZyGWutwU
         55PH3cGa2gTrKT4ShFyFJ1xbwW+RuRAAXmT0nJu4F5iucnr/NhiPblSuT+LM4D/10aSM
         iaRJdyC8H3gAJ2UmO+bY9iVlz/invqKTzrCk4bU/DexCpblvFSiQrLPTbQiQeGfuc0qF
         AaPCG77p3y0SNk3p70KVfaoxx2Vq/zmjUnzGgBhnWx/A52fWk+0LJz/fL9zaYMrJ62rC
         4OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BkNbbxb6k/17zzJxBEIrJhvukJWdWW3RjEBbcBFX430=;
        b=IoGn+PUbK5uMsYCgywjVks+Puh0mTIDvhPlVzlFW9UatOkyUz84VPXFEjiUNe87/di
         +B6fb4rh1nrEoycVUUmM00VW6Itwb5ema05e2cIaF2mMmx9fPV1BUY1fOw9AZM+N6hCs
         sA6/AT2IEUliZ/OS50kF27iXdF3Xp0lEkYdkjbp7RaWfyqTl0c3+3vJ1bluIrN51EnAB
         BbEYZrDPCUqn36DUiW+qQKmuV48BGz+E4vEgnFdQzBvhxMKbnSImeQFEaU5a/Z3yOIx1
         WmcOeLK6WJ0NwBXqNJeASHZ2T5Kf0JPPgcuSza2IIXWB9YpwKyNw8vcwS9rPINoqqLCL
         Hk4g==
X-Gm-Message-State: AOAM531zAfZyJnbM6LMcoHUuFDGsisq75sJcRIJpYqjBRFrySCmwgZKN
        JaUPXIPjI8VIiQM57Ab56+DtjQ==
X-Google-Smtp-Source: ABdhPJyhZPMV/JVASbPhZYWUvvWTHlMWbdSWvCWNUcXYOkDnLsz++l0fljwyUxPk+ksF+atBW3GdCQ==
X-Received: by 2002:ac8:51c7:: with SMTP id d7mr9020352qtn.302.1613073689253;
        Thu, 11 Feb 2021 12:01:29 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id 17sm4496243qtu.23.2021.02.11.12.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 12:01:28 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/11] Regression fixes/clean ups in the Qualcomm crypto engine driver
Date:   Thu, 11 Feb 2021 15:01:17 -0500
Message-Id: <20210211200128.2886388-1-thara.gopinath@linaro.org>
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

v6->v7:
	- Fixed sparse warning in patch 4 as pointed out by Herbert Xu.
	  This means the checking if any two keys are same for triple
	  des algorithms has been reverted back to using conditional OR
	  instead of using bitwise OR.
	- Rebased to 5.11-rc7.

v5->v6:
	- Return 0 for zero length messages instead of -EOPNOTSUPP in the
	  cipher algorithms as pointed out by Eric Biggers.
	- Remove the wrong TODO in patch 6 which implied that AES CBC can
	  do partial block sizes when it is actually CTS mode that can as
	  pointed out my Eric Biggers.

v4->v5:
	- Fixed build warning/error in patch for wrong assignment of const
	  pointer as reported by kernel test robot <lkp@intel.com>.
	- Rebased to 5.11-rc6.
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
*** BLURB HERE ***

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
  crypto: qce: Remover src_tbl from qce_cipher_reqctx
  crypto: qce: Remove totallen and offset in qce_start

 drivers/crypto/qce/cipher.h   |   1 -
 drivers/crypto/qce/common.c   |  25 +++---
 drivers/crypto/qce/common.h   |   3 +-
 drivers/crypto/qce/sha.c      | 143 +++++++++++++---------------------
 drivers/crypto/qce/skcipher.c |  69 +++++++++++++---
 5 files changed, 126 insertions(+), 115 deletions(-)

-- 
2.25.1

