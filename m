Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02D33F1990
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 14:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbhHSMh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 08:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhHSMh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 08:37:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E70C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 05:37:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nt11so4855805pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 05:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7bTAAAg/tSsrf+D8xI/Og4ucIPc2yXEtddxl3LKJlfo=;
        b=cEXhG+Ao9ul84iqgEzwLvcUXXrwwuMZwPfq0z0giT5U1QbqaMEh+OVWJq46XSj28wF
         DMekvEHMZP3g5KZIyrnoLS9o57GAd+qTwfLHivANfJhQxwoFuv6li0knpUvNdVmRzHr7
         vGK1oMd5hiMNuwBODV7JrR+gw9Ir79RBycTZ5T4d8trSAw7yrmwHGAIkkMha1lIgqiPd
         agrUIInE2IOsJud91iPsQ/NTvwA2Qg8Xr0qm/vGDYBTlx/q0zBToN0HAm7FQH/Dn/IBf
         XWN7HHorrqtYd+QXP3zl0XA7+oD23qMpgiz7ZFxEeA2fAMArJEA/sMO3DfX1cQsAP420
         JnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7bTAAAg/tSsrf+D8xI/Og4ucIPc2yXEtddxl3LKJlfo=;
        b=UTdBVHT/iccwAEDdAlMa+1GnI6CRLKt1VtvbRa4DEYnvDuxt2Z2dJZ7jNvNK8ZO4cd
         HasvkiUdIlVgtYTdVRfgSsNMJpFitBQyRDmaXxsOZpOLupRLWoSoddH6yqx7qotQQ/1k
         IDroRz+hHU4sZZ2aZu+vmGD8ogjENdCuGKkeOIsyH1e6qH+xDiQTtHSCYaGvrfR6YYuI
         rRWy60ZrKahSMTP60U6OifLJGMfygtpwGlPG5ugFCT9SrRpgx9PqfULCQGMVh2LrTUdW
         NwMjPbQFEXNlouBypObFpQWQVeFlm4A/Iqgto4XQDlMvGFQomk+GMsIGv2iYYxI5CCE9
         BSzw==
X-Gm-Message-State: AOAM533mpL5FW4XD9lv8OnoGs1dwzuAAi2odujMRcHbubk1gXxwl+Kdp
        1L/jEsxf46GVht7At0F6hMhRyA==
X-Google-Smtp-Source: ABdhPJz6i/rouwXLVzKVQ0cKW9jH3P17xaE3a6k7aLKspKYXFi8nENwtkGg3qgU2QrSMrc+N3qBupQ==
X-Received: by 2002:a17:90a:a581:: with SMTP id b1mr4918393pjq.153.1629376640330;
        Thu, 19 Aug 2021 05:37:20 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id r8sm3859964pgp.30.2021.08.19.05.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 05:37:19 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     jarkko@kernel.org
Cc:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [RESEND] crypto: public_key: fix overflow during implicit conversion
Date:   Thu, 19 Aug 2021 20:37:10 +0800
Message-Id: <20210819123710.1170050-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hit kernel warning like this, it can be reproduced by verifying 256
bytes datafile by keyctl command, run script:
RAWDATA=rawdata
SIGDATA=sigdata

modprobe pkcs8_key_parser

rm -rf *.der *.pem *.pfx
rm -rf $RAWDATA
dd if=/dev/random of=$RAWDATA bs=256 count=1

openssl req -nodes -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem \
  -subj "/C=CN/ST=GD/L=SZ/O=vihoo/OU=dev/CN=xx.com/emailAddress=yy@xx.com"

KEY_ID=`openssl pkcs8 -in key.pem -topk8 -nocrypt -outform DER | keyctl \
  padd asymmetric 123 @s`

keyctl pkey_sign $KEY_ID 0 $RAWDATA enc=pkcs1 hash=sha1 > $SIGDATA
keyctl pkey_verify $KEY_ID 0 $RAWDATA $SIGDATA enc=pkcs1 hash=sha1

Then the kernel reports:
 WARNING: CPU: 5 PID: 344556 at crypto/rsa-pkcs1pad.c:540
   pkcs1pad_verify+0x160/0x190
 ...
 Call Trace:
  public_key_verify_signature+0x282/0x380
  ? software_key_query+0x12d/0x180
  ? keyctl_pkey_params_get+0xd6/0x130
  asymmetric_key_verify_signature+0x66/0x80
  keyctl_pkey_verify+0xa5/0x100
  do_syscall_64+0x35/0xb0
  entry_SYSCALL_64_after_hwframe+0x44/0xae

The reason of this issue, in function 'asymmetric_key_verify_signature':
'.digest_size(u8) = params->in_len(u32)' leads overflow of an u8 value,
so use u32 instead of u8 for digest_size field. And reorder struct
public_key_signature, it saves 8 bytes on a 64-bit machine.

Thanks to Jarkko Sakkinen for suggestions.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/crypto/public_key.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 47accec68cb0..f603325c0c30 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -38,9 +38,9 @@ extern void public_key_free(struct public_key *key);
 struct public_key_signature {
 	struct asymmetric_key_id *auth_ids[2];
 	u8 *s;			/* Signature */
-	u32 s_size;		/* Number of bytes in signature */
 	u8 *digest;
-	u8 digest_size;		/* Number of bytes in digest */
+	u32 s_size;		/* Number of bytes in signature */
+	u32 digest_size;	/* Number of bytes in digest */
 	const char *pkey_algo;
 	const char *hash_algo;
 	const char *encoding;
-- 
2.25.1

