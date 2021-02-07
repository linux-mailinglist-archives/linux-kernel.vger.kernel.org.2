Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487683124BB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBGOkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhBGOk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:40:29 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0570FC061756
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:39:49 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d85so11940320qkg.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oxGs1yBu+RHlc7f/sQSTfaUp4aGAp+KSIV/KFpeORIA=;
        b=uTiCSSpc+2us0Sf62KQQXb9V1tJWZouXjNCJRweu7WIXEPrM+lLUBhwSJH5rtxZ5sC
         J9MME7WswVDWYUV9oJN1hEB3BuW9mVAL6btAnjIrDwVm5C5gbtADtlDSQ7+KnzIx/45Q
         qSZOhTUU2U1ZkIq7ljVkGWF4cXq0JDjCpdejNErswEpY1TejHZQwq133Tb/vqG28bd2d
         JUOO06zfItsWtO286BXh8aW+efnamudomJVn0PQQvj67GKLE2YI3LJ1H5P1e29fMKRbg
         qZ73fC4r7q3NMAEeA/hnFAUe6S82zjK0/TzDTuaHkLpDgMTNxw7g7j3VSso+YIxRzlcq
         URgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oxGs1yBu+RHlc7f/sQSTfaUp4aGAp+KSIV/KFpeORIA=;
        b=JQSEOqsWObYaJXkYCRt3N1qLbxcNRVgKhtUCs09dAM+nhozTB8TNkPdYPZUoMST6GE
         iBqwHTh8LsIVDpw2t1jQP3P2KLTKAQFNBBtDIO4OHXaj2ud62A4Fg9rka07KSowE/gLT
         rYri2QydviYylxF4D++S5CpaWXrYh3DVsWT5Pz3Pr4VFnNqf3WDLOgH2tgvnSpkUQQxi
         J+WiaNXu7axtxFn66Fdl9ipQii4rL3EBY3kCFUcZsVzhEvouzrD/tBKlbBOdKVAEaQx4
         9TbQOl30K0xsC9sbGi61rGGnL88L0aAgze7Gz4+qzhXVyemIvvPQOwfwBjk1ww39RFDT
         4FGw==
X-Gm-Message-State: AOAM5328u/WCEzx049lQA1IyOLFIjxpwvfhC2MuLMLmBtGwJQQTGaAIH
        fpra8FGZoQAFY7QBPvIT+CpJ+w==
X-Google-Smtp-Source: ABdhPJzAmh9+3F/MKZdGB32e2XCXtEL2AUBsOuZbIiBv/UvUM3QBqH7tKtLOBtdfxvt5tL5aQMtCuQ==
X-Received: by 2002:a05:620a:1485:: with SMTP id w5mr11750002qkj.201.1612708788069;
        Sun, 07 Feb 2021 06:39:48 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id c81sm13941493qkb.88.2021.02.07.06.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:39:47 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/11] Regression fixes/clean ups in the Qualcomm crypto engine driver
Date:   Sun,  7 Feb 2021 09:39:35 -0500
Message-Id: <20210207143946.2099859-1-thara.gopinath@linaro.org>
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

