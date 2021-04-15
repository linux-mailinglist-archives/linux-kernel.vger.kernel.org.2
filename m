Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D869D360E24
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhDOPK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:10:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:19338 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235221AbhDOPAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:00:36 -0400
IronPort-SDR: C+6jaPYv7xLvlvCUkkNzCsF/QAzsGwIMRLvQnYL4XFYRXoz3L/H6QT9XPQU0KOIKGjlkPwcjqJ
 guq7F92dcAAw==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="215373453"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="215373453"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 07:58:47 -0700
IronPort-SDR: 0nMXSfFbe91SryOjvqsvyC+/22ba/E+TNwYUTtABQl+fmjgKBz11ZK/b6m42ARhRz0lNAweFQc
 Ds0NeXR0XR3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="461643535"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 15 Apr 2021 07:58:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1807A12A; Thu, 15 Apr 2021 17:59:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] tee: optee: Provide special parameter field for UUID values
Date:   Thu, 15 Apr 2021 17:58:57 +0300
Message-Id: <20210415145857.34183-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dereferencing something to uuid_t value is not good idea strictly speaking.
Provide a special parameter field for UUID values and drop ugly casting.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tee/optee/call.c      | 2 +-
 drivers/tee/optee/optee_msg.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 1f0a68381656..d50cff7a9406 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -241,7 +241,7 @@ int optee_open_session(struct tee_context *ctx,
 	memcpy(&msg_arg->params[0].u.value, arg->uuid, sizeof(arg->uuid));
 	msg_arg->params[1].u.value.c = arg->clnt_login;
 
-	rc = tee_session_calc_client_uuid((uuid_t *)&msg_arg->params[1].u.value,
+	rc = tee_session_calc_client_uuid(&msg_arg->params[1].u.uuid,
 					  arg->clnt_login, arg->clnt_uuid);
 	if (rc)
 		goto out;
diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
index 81ff593ac4ec..df095a974f3f 100644
--- a/drivers/tee/optee/optee_msg.h
+++ b/drivers/tee/optee/optee_msg.h
@@ -144,6 +144,7 @@ struct optee_msg_param_value {
  * @tmem:	parameter by temporary memory reference
  * @rmem:	parameter by registered memory reference
  * @value:	parameter by opaque value
+ * @uuid:	parameter by UUID
  *
  * @attr & OPTEE_MSG_ATTR_TYPE_MASK indicates if tmem, rmem or value is used in
  * the union. OPTEE_MSG_ATTR_TYPE_VALUE_* indicates value,
@@ -157,6 +158,7 @@ struct optee_msg_param {
 		struct optee_msg_param_tmem tmem;
 		struct optee_msg_param_rmem rmem;
 		struct optee_msg_param_value value;
+		uuid_t uuid;
 	} u;
 };
 
-- 
2.30.2

