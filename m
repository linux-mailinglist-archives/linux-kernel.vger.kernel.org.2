Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B8F343E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhCVKmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhCVKly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:41:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B101C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 03:41:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z2so16123917wrl.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 03:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Npq1QcnHn4NxnPlHvpzS6pWYN5f2LOT+P71d2a5rXTQ=;
        b=IhXmDG7Bxq4BkoKH4a6LDJC5RSY0lxat1pOjpIvaXSi24aIejkN4Py0jDMMiD1SbSz
         0U8XlFB5HJNxiwVR6Ee4rG6zwKZHDL7wPLN+3AaS3j7oBKPMaWiTcDxtTLDx0JXhUatS
         Qm5l0ixurOqOiiuh4Jq6wGYcWNWiyP1XBRsHmrz6UAEGHYd6zluu/LRSe5TaMkEsn/f/
         NipPdeIWdU5xa6Mw29OtPMikf6SlJvaRaT5lx2AR37JEzkMl/4DCKchbVnJ5rsUcPIp9
         8o1vcmGzn/h81Nv57b0lVt3v2DsFJP7NlYvE+eZhoHkOTkZC/vTDyjzXxYgbI1bOtLyg
         v3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Npq1QcnHn4NxnPlHvpzS6pWYN5f2LOT+P71d2a5rXTQ=;
        b=dPNuMX1vXgg+fFrQGO+3pY31Gx5jL2l+RkIHAdHhN7LkSgynbZi/WEmb7UwHFfJPdh
         5/xp3jT52NssfJt+d1BNb3LlJ3K2nfGvEjitJY44lZ4ayU6GOp7Wh3leWMVjQxpfCL/w
         MkNuxAObRHBG3w3c22m6gdOSZbrU5U4ed/0Cf0suzHo8VSK801GgLpagZ2qmcmb4vZ1U
         NfiENdtbf71OiQxLwSg3/9NU8OO4/fJx+AebcDKTH+z/yJ5rQSPSxmWKfRO4lqT3036d
         9LRdj8ET8/ZcyG2PHi1wcJlrfGBGtH546CPsAZILj50XRJwJJ9gOiA5+NIKx5FGrhhMT
         I97w==
X-Gm-Message-State: AOAM530cfYK/K3BTu0kM5AxMH1YPrmtEu2GvPePuEJU9MXXMDtYMsJGX
        ygXvpBHLmX0Y0Ms+x8+Nez0gZqQbd17tP+99Gfv1mw==
X-Google-Smtp-Source: ABdhPJyscdvHiNyvgIe9jJbxBI55j23D9klRDzzq6vYQHcB1x3PpiG3xyziyFlUxUza9SQdFBPs+eA==
X-Received: by 2002:a5d:4341:: with SMTP id u1mr17576927wrr.88.1616409712100;
        Mon, 22 Mar 2021 03:41:52 -0700 (PDT)
Received: from matebook.home ([2a01:e0a:269:e210:2cc0:79ea:be45:b806])
        by smtp.gmail.com with ESMTPSA id f2sm19495741wrq.34.2021.03.22.03.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:41:51 -0700 (PDT)
From:   Jerome Forissier <jerome@forissier.org>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>
Subject: [PATCH 1/1] tee: optee: do not check memref size on return from Secure World
Date:   Mon, 22 Mar 2021 11:40:37 +0100
Message-Id: <f452049bc900365dd9183081a4bb8cf4a4d5a434.1616409291.git.jerome@forissier.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1616409291.git.jerome@forissier.org>
References: <cover.1616409291.git.jerome@forissier.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Secure World returns, it may have changed the size attribute of the
memory references passed as [in/out] parameters. The GlobalPlatform TEE
Internal Core API specification does not restrict the values that this
size can take. In particular, Secure World may increase the value to be
larger than the size of the input buffer to indicate that it needs more.

Therefore, the size check in optee_from_msg_param() is incorrect and
needs to be removed. This fixes a number of failed test cases in the
GlobalPlatform TEE Initial Configuratiom Test Suite v2_0_0_0-2017_06_09
when OP-TEE is compiled without dynamic shared memory support
(CFG_CORE_DYN_SHM=n).

Suggested-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jerome Forissier <jerome@forissier.org>
---
 drivers/tee/optee/core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 319a1e701163..ddb8f9ecf307 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -79,16 +79,6 @@ int optee_from_msg_param(struct tee_param *params, size_t num_params,
 				return rc;
 			p->u.memref.shm_offs = mp->u.tmem.buf_ptr - pa;
 			p->u.memref.shm = shm;
-
-			/* Check that the memref is covered by the shm object */
-			if (p->u.memref.size) {
-				size_t o = p->u.memref.shm_offs +
-					   p->u.memref.size - 1;
-
-				rc = tee_shm_get_pa(shm, o, NULL);
-				if (rc)
-					return rc;
-			}
 			break;
 		case OPTEE_MSG_ATTR_TYPE_RMEM_INPUT:
 		case OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT:
-- 
2.25.1

