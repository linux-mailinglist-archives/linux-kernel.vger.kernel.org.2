Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDED30F1BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbhBDLML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbhBDLLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:11:34 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02138C061797
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:11 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m1so2640247wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9PQJyorI7NSFOmBlzU3qYIYb38rUcKuWau7MQ0QjGLc=;
        b=FSr/KZivxIq+H/JsqxnJyXqNIN1K1v9CM8MSNUgKhBPSIYQoO9U08WhO3MexdqcSzu
         gpILk81W/zf9kGFNHKPWIuVEZNPAcRAw39QXhu6cW1zh0dTinkZbWbc4dd09ItE6twgb
         Fmhnwo5w4g0oDXtBu38c0voaX/yr0AlkAIvqVbWlfwz88N7myvfqTLv6to2OZDpMuZag
         L6R6aj7lbNhQ6WkdObOHke2kK/qaRDeB4HhnJRr3rkqdCWcAr3qA4O7H9ATKSwDZ6DPy
         CZaxYueFvtlzAd5KvpTMazQG34Ws82FZ6ActFk41KPqJJi48ARBHtoeY03glTGrZ1fSN
         GN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9PQJyorI7NSFOmBlzU3qYIYb38rUcKuWau7MQ0QjGLc=;
        b=mwKATFIzOz135F57CUAk1u8iYeZA8evll9L2fwyGwoZ0htK+9rVDUx/nxBd/81XliB
         ApRJ++CVFQctBT5nsg0g9UBN/h3xL4teJUJZ26VGLEm0SypKVkDlMSk6zmnLlzUxbSFS
         /JGDDIf1Qcxs1026fnfXO17uxqVShZChPKtcvPF2+oJnXzJk+i1/O81BfMB2d5CapuF/
         vDUcYpcCaF0gzZFM6rrYv0HiGb7RJXV4w7an0m4TlQllzixhNv8fRNv4huaDgf+jJa8v
         Gi2YD1FXKBfjJ6dVvkBw6PRRqymIN6Yw+7paqrX/wP8xlhBrg9cbsRXRyPf6r2QGm/zI
         N5SQ==
X-Gm-Message-State: AOAM533PFksbsP8eRVfSUFH7JtKZwnyKo/RgQtILhTJ8QoufyBJNMiiN
        UMMnRBYnDTCM3CblzQAiz7R0Xw==
X-Google-Smtp-Source: ABdhPJw0oFT5FZf9Plohvjcn/VRefliidr4eJiCyxMnCCg5f/bFrZ7r6V1nVsPxpSfSXwXt+rvWBjA==
X-Received: by 2002:a05:600c:230e:: with SMTP id 14mr7003253wmo.161.1612437009685;
        Thu, 04 Feb 2021 03:10:09 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 05/20] crypto: bcm: spu: Fix formatting and misspelling issues
Date:   Thu,  4 Feb 2021 11:09:45 +0000
Message-Id: <20210204111000.2800436-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/bcm/spu.c:464: warning: Excess function parameter 'Return' description in 'spum_gcm_ccm_pad_len'
 drivers/crypto/bcm/spu.c:524: warning: Function parameter or member 'iv_len' not described in 'spum_aead_ivlen'
 drivers/crypto/bcm/spu.c:524: warning: expecting prototype for spu_aead_ivlen(). Prototype was for spum_aead_ivlen() instead
 drivers/crypto/bcm/spu.c:556: warning: Function parameter or member 'alg_digest_size' not described in 'spum_digest_size'
 drivers/crypto/bcm/spu.c:556: warning: Function parameter or member 'alg' not described in 'spum_digest_size'
 drivers/crypto/bcm/spu.c:556: warning: Function parameter or member 'htype' not described in 'spum_digest_size'
 drivers/crypto/bcm/spu.c:583: warning: bad line:
 drivers/crypto/bcm/spu.c:927: warning: Function parameter or member 'is_inbound' not described in 'spum_cipher_req_finish'
 drivers/crypto/bcm/spu.c:927: warning: Excess function parameter 'isInbound' description in 'spum_cipher_req_finish'

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/bcm/spu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/bcm/spu.c b/drivers/crypto/bcm/spu.c
index 007abf92cc05b..6283e8c6d51d3 100644
--- a/drivers/crypto/bcm/spu.c
+++ b/drivers/crypto/bcm/spu.c
@@ -457,7 +457,7 @@ u16 spum_hash_pad_len(enum hash_alg hash_alg, enum hash_mode hash_mode,
  * @cipher_mode:	Algo type
  * @data_size:		Length of plaintext (bytes)
  *
- * @Return: Length of padding, in bytes
+ * Return: Length of padding, in bytes
  */
 u32 spum_gcm_ccm_pad_len(enum spu_cipher_mode cipher_mode,
 			 unsigned int data_size)
@@ -510,10 +510,10 @@ u32 spum_assoc_resp_len(enum spu_cipher_mode cipher_mode,
 }
 
 /**
- * spu_aead_ivlen() - Calculate the length of the AEAD IV to be included
+ * spum_aead_ivlen() - Calculate the length of the AEAD IV to be included
  * in a SPU request after the AAD and before the payload.
  * @cipher_mode:  cipher mode
- * @iv_ctr_len:   initialization vector length in bytes
+ * @iv_len:   initialization vector length in bytes
  *
  * In Linux ~4.2 and later, the assoc_data sg includes the IV. So no need
  * to include the IV as a separate field in the SPU request msg.
@@ -543,9 +543,9 @@ enum hash_type spum_hash_type(u32 src_sent)
 /**
  * spum_digest_size() - Determine the size of a hash digest to expect the SPU to
  * return.
- * alg_digest_size: Number of bytes in the final digest for the given algo
- * alg:             The hash algorithm
- * htype:           Type of hash operation (init, update, full, etc)
+ * @alg_digest_size: Number of bytes in the final digest for the given algo
+ * @alg:             The hash algorithm
+ * @htype:           Type of hash operation (init, update, full, etc)
  *
  * When doing incremental hashing for an algorithm with a truncated hash
  * (e.g., SHA224), the SPU returns the full digest so that it can be fed back as
@@ -580,7 +580,7 @@ u32 spum_digest_size(u32 alg_digest_size, enum hash_alg alg,
  * @aead_parms:   Parameters related to AEAD operation
  * @data_size:    Length of data to be encrypted or authenticated. If AEAD, does
  *		  not include length of AAD.
-
+ *
  * Return: the length of the SPU header in bytes. 0 if an error occurs.
  */
 u32 spum_create_request(u8 *spu_hdr,
@@ -911,7 +911,7 @@ u16 spum_cipher_req_init(u8 *spu_hdr, struct spu_cipher_parms *cipher_parms)
  * setkey() time in spu_cipher_req_init().
  * @spu_hdr:         Start of the request message header (MH field)
  * @spu_req_hdr_len: Length in bytes of the SPU request header
- * @isInbound:       0 encrypt, 1 decrypt
+ * @is_inbound:      0 encrypt, 1 decrypt
  * @cipher_parms:    Parameters describing cipher operation to be performed
  * @data_size:       Length of the data in the BD field
  *
-- 
2.25.1

