Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1535632FF49
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 07:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhCGGgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 01:36:21 -0500
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com ([40.107.94.61]:29281
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229964AbhCGGfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 01:35:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AItMVVsAgQejE4rHW3GpglGZi+98zFOYDl3g6uysFK6e4lCBoSzDvXcuIeCXEfh65gZ31Dwos6gyC5JM89ZF9+Qta1NdVMfIGOLX6+DmKBLwA11GJapMGezeLDIyOzm5zqMItwN7R/VU5uTglCJa7r1rGfpTGNjdTl5sOQ565ycHn9JQ9XU0oR+UnmBJfEX+PaC+12QKOOaRNDYAAIy6t5ZT+JD7CtTXcEKafnufBNZId/V7T19zg3s0mMiLQP/wxX7dYXFbWHKNzW6X9Z7nMpDUmh0N06j+usIWWV4G89ecS7Bz+8tz2LACJo7SYZV3LDLfIi+3cQPRv19qClEZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kLbt34xz5n1HCJcYrU0vmLKxSXdSGX/yxSb8kzS7Pg=;
 b=ha3fMVRtPSiKuERaxOCSlnS5zfX9Au9jcjGOmkOaxsgfhN4b6ubyPlBc9kIDrvt7SQ0NAN/n1LgHpju94WiYu9TSARsYPgKX/2H3jy4SRgLkCrjpi1iuKNiIJ34oifA3QkqmZ+7zrPqxcqzvR0CH+hLVdzQHuFKXtOlfFe67YMah7gHFKNXyYLLi1oRLPFYAbkI6TTtsUr+byd4YSHaEGN8SzuWZjc3W+Of2BEgcdHp1CpAXdeIt1B5EDhJAYsogI1DG28eGvSHvDLgROQ/ZrgKMtGD3RZapE+ObI/U/0ibXyJSf2k7ywy9iu4rIwsoMUMp48F0FWRo2akcHon8VGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kLbt34xz5n1HCJcYrU0vmLKxSXdSGX/yxSb8kzS7Pg=;
 b=xzKwQMOpvIG6AhtC7BwzIRMImFQk24WkD92U2uA4u0TsLUZDsk02GQjCXGC2jlmGye0vt+qTX0+/79WkkxM5GzIlj7GwjVKeSYJ/jQIcuqYIso0urxGiwm/YEScHD+j1g60N35/EJAOse2BxpP/uw2x2Xnzu6xu90I86owbfvbw=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25)
 by SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Sun, 7 Mar
 2021 06:35:48 +0000
Received: from SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::c32:245b:4812:ee03]) by SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::c32:245b:4812:ee03%3]) with mapi id 15.20.3912.024; Sun, 7 Mar 2021
 06:35:47 +0000
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tee: amdtee: unload TA only when its refcount becomes 0
Date:   Sun,  7 Mar 2021 12:05:01 +0530
Message-Id: <4fafc43b8b6bb779fea87ecc5579afaab8a5f3ad.1615097779.git.Rijo-john.Thomas@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::24) To SN6PR12MB4719.namprd12.prod.outlook.com
 (2603:10b6:805:e9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from andbang6.amd.com (165.204.156.251) by MA1PR01CA0130.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Sun, 7 Mar 2021 06:35:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81766b6f-fdf2-4b79-0c81-08d8e1333e06
X-MS-TrafficTypeDiagnostic: SN6PR12MB2814:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2814845316D472DB1742A165CF949@SN6PR12MB2814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 77Sh6itRkba1cQOvrbmVLvvo+f/Tey/HxtyM/JvyAq5MgEYtIfJYOXCmcV+WGVnMhYUFKMbyb0C7UnP8mnHW22PVazsEZyfnETU21hUvt0veq244gJnJfoQE4Jrknw5nmUoFgXiM2zYTz/0pgp95UikRV2irrhLcRcdHpDHMnzl7rpAu4tqwJER9sf3z9vMv0gXVpEkq6/UU9kHPnWmI0/9q01r9LmErCxl7ltsvFN8JtNrrxg6HXU80VR1ZPVI76Qi5uvIr5MzyQWJjqGHPX7hr59kbLMqfFmMIi6YohtW+QTVHnPfYTMfTXZZJ8+F53uYJp4ttM8vI4ZkgEC8eHuxFx6wtDJGVFnAxnbQrLno+PFjrZMurPqTeHqMpz9Ivoiz/0JwGhlqNjHG2mzFPmitrsDrR2eHFQ0CNOZL9Trlq+xWpQMVUopkKzacFBjafijap+OlDRQxfTrOK8t15wI5QITBs1D+ZhU/09sYDCkiaR3zlDqHTFNYmVYF3e1kYvmfVC8GGn02E02w9xPWOxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(83380400001)(6666004)(316002)(86362001)(478600001)(8676002)(36756003)(4326008)(6486002)(8936002)(7696005)(66946007)(66556008)(2906002)(186003)(26005)(956004)(2616005)(66476007)(110136005)(54906003)(5660300002)(52116002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5DKBltETMOoLSoNAbmkDNRkCrJT73NL2l6iPpkO+gwN9EEI1TZxEDfLX2oY4?=
 =?us-ascii?Q?+El7KWGK/Xxpdv3xGQCqaaGYxHKIfp3r4DBut7haUuXslzAAkHf28aQs2E/C?=
 =?us-ascii?Q?e1IM5N0xja4pQR2UB+6CfJ1dVbCdrbq+/rliSsMn/FqSUsa7cbIaj7RDVFPo?=
 =?us-ascii?Q?ORPgpvolRNi8hpC6zOgZdpdpRV7t0jcvZI6wthbyAbIBdMycq21e6SzT1ki6?=
 =?us-ascii?Q?KwngQ0K8r7FZrQJ+BafE7JBXZcmwLY9mPwHFOzrpN3XEX8awF1MIzOA28oFl?=
 =?us-ascii?Q?YQTSaCVh75eYxZ329/EZ/63l3BshPRAGN0Y5G4NtkkjngsyiZeQTw7clZMti?=
 =?us-ascii?Q?knm2JoStUqnt5wnKlylmzfsGQMrAWuuBhtbtbyJt6k47lDxbZZ8qHWwzUT5Q?=
 =?us-ascii?Q?cPI3YxGcajFecaoyItDYeJ0qu/MLoDXhNYNZ1+QNZHtkCyg66E5Abg+QOtWd?=
 =?us-ascii?Q?wIFefokGJ61rdYxiEyYVaHF0EGi2VG3PhHgCE+XUuWv54O+iBWieE1cU3GjF?=
 =?us-ascii?Q?66a9tOaRQbE2qe47n1VNTTpy8MGFcglB6w4IUhN4r9jbPAQP4Io9afGdF/PF?=
 =?us-ascii?Q?sIA7foKMYjBzbjCHZiX2W2WwqdHPMHSvQqsKzIbPh5DwHxIXLmZWdOxa/NA1?=
 =?us-ascii?Q?++zUw6tQEg9xqSQ0P7MyvQTMQEPeXx8AQHbyqPLObfrKDpVDRjTLV+wNmy9Y?=
 =?us-ascii?Q?n1sjpDdam0dRJ8KfxAthIJmGka6Xuz5iL0z1cZngRfWNL/C62ODEBmw6QGRQ?=
 =?us-ascii?Q?bLcXWWuO8veMK5kxnA9e6iqacXQz7JbCki7Z5tvkrwyIsASMW5OIG3i8zKpG?=
 =?us-ascii?Q?AbOtStNM2Z/Apvp2s2OcmRP0XlKXUjWOt6lVJUXUQ4uhAjvhc/1m6xQSvqms?=
 =?us-ascii?Q?fUia4ucnJKKC4D+5uQYJKqJWDw18VVgoeXLiVyrcbGWG1GLHRXKPLVWw0JTp?=
 =?us-ascii?Q?s1/036TpOJhrbT3h7M0tBsfPS0Fry6psruldMpeRviTxYAdwYioDFlyjg/Ca?=
 =?us-ascii?Q?CHTOmxPj65Ewx2h4scHkhN97aZEhM5Sf70cXfbK2NFkXTL5oWlpe+sjQfaK2?=
 =?us-ascii?Q?O9x9yqYwgV/pWX/5nK2uig8PWHfDXTJaLV9ht+TFuDAIb7lREC8ji6zFagbp?=
 =?us-ascii?Q?xw6MVYjrt248NTdpGiRT/7NdPMuW7gYidB28015rJymOyuVCmdCpxdbMdHyi?=
 =?us-ascii?Q?0fC9eA6ZSlhgamG1waFC7uu+b8XXaCUe4uDb2Yk9rmuFxUG38x0eHXZiq3fU?=
 =?us-ascii?Q?NRcIWHSdZ5RPC/5hBYHV/tovb7/QV3s2YSICb3PMytpLrbMPx0Jv/JrV83Yc?=
 =?us-ascii?Q?qDsvTxZv595x8uvwBYBOjdd+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81766b6f-fdf2-4b79-0c81-08d8e1333e06
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2021 06:35:47.6978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErjXfsH0Kg4pAzXQRCN3GdfvIR1J4Zihg8pwx7phxb0iwES0jNv+hiD6BiCuZWuapcH8o8hGXoILb93Wme6Udg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same Trusted Application (TA) can be loaded in multiple TEE contexts.

If it is a single instance TA, the TA should not get unloaded from AMD
Secure Processor, while it is still in use in another TEE context.

Therefore reference count TA and unload it when the count becomes zero.

Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
 drivers/tee/amdtee/amdtee_private.h | 13 +++++
 drivers/tee/amdtee/call.c           | 73 +++++++++++++++++++++++++++--
 drivers/tee/amdtee/core.c           | 15 +++---
 3 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdtee_private.h
index 337c8d82f74e..6d0f7062bb87 100644
--- a/drivers/tee/amdtee/amdtee_private.h
+++ b/drivers/tee/amdtee/amdtee_private.h
@@ -21,6 +21,7 @@
 #define TEEC_SUCCESS			0x00000000
 #define TEEC_ERROR_GENERIC		0xFFFF0000
 #define TEEC_ERROR_BAD_PARAMETERS	0xFFFF0006
+#define TEEC_ERROR_OUT_OF_MEMORY	0xFFFF000C
 #define TEEC_ERROR_COMMUNICATION	0xFFFF000E
 
 #define TEEC_ORIGIN_COMMS		0x00000002
@@ -93,6 +94,18 @@ struct amdtee_shm_data {
 	u32     buf_id;
 };
 
+/**
+ * struct amdtee_ta_data - Keeps track of all TAs loaded in AMD Secure
+ *			   Processor
+ * @ta_handle:	Handle to TA loaded in TEE
+ * @refcount:	Reference count for the loaded TA
+ */
+struct amdtee_ta_data {
+	struct list_head list_node;
+	u32 ta_handle;
+	u32 refcount;
+};
+
 #define LOWER_TWO_BYTE_MASK	0x0000FFFF
 
 /**
diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
index 096dd4d92d39..e10601417ea3 100644
--- a/drivers/tee/amdtee/call.c
+++ b/drivers/tee/amdtee/call.c
@@ -121,15 +121,69 @@ static int amd_params_to_tee_params(struct tee_param *tee, u32 count,
 	return ret;
 }
 
+static DEFINE_MUTEX(ta_refcount_mutex);
+static struct list_head ta_list = LIST_HEAD_INIT(ta_list);
+
+static u32 get_ta_refcount(u32 ta_handle)
+{
+	struct amdtee_ta_data *ta_data;
+	u32 count = 0;
+
+	/* Caller must hold a mutex */
+	list_for_each_entry(ta_data, &ta_list, list_node)
+		if (ta_data->ta_handle == ta_handle)
+			return ++ta_data->refcount;
+
+	ta_data = kzalloc(sizeof(*ta_data), GFP_KERNEL);
+	if (ta_data) {
+		ta_data->ta_handle = ta_handle;
+		ta_data->refcount = 1;
+		count = ta_data->refcount;
+		list_add(&ta_data->list_node, &ta_list);
+	}
+
+	return count;
+}
+
+static u32 put_ta_refcount(u32 ta_handle)
+{
+	struct amdtee_ta_data *ta_data;
+	u32 count = 0;
+
+	/* Caller must hold a mutex */
+	list_for_each_entry(ta_data, &ta_list, list_node)
+		if (ta_data->ta_handle == ta_handle) {
+			count = --ta_data->refcount;
+			if (count == 0) {
+				list_del(&ta_data->list_node);
+				kfree(ta_data);
+				break;
+			}
+		}
+
+	return count;
+}
+
 int handle_unload_ta(u32 ta_handle)
 {
 	struct tee_cmd_unload_ta cmd = {0};
-	u32 status;
+	u32 status, count;
 	int ret;
 
 	if (!ta_handle)
 		return -EINVAL;
 
+	mutex_lock(&ta_refcount_mutex);
+
+	count = put_ta_refcount(ta_handle);
+
+	if (count) {
+		pr_debug("unload ta: not unloading %u count %u\n",
+			 ta_handle, count);
+		ret = -EBUSY;
+		goto unlock;
+	}
+
 	cmd.ta_handle = ta_handle;
 
 	ret = psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA, (void *)&cmd,
@@ -137,8 +191,12 @@ int handle_unload_ta(u32 ta_handle)
 	if (!ret && status != 0) {
 		pr_err("unload ta: status = 0x%x\n", status);
 		ret = -EBUSY;
+	} else {
+		pr_debug("unloaded ta handle %u\n", ta_handle);
 	}
 
+unlock:
+	mutex_unlock(&ta_refcount_mutex);
 	return ret;
 }
 
@@ -357,14 +415,23 @@ int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *arg)
 	cmd.low_addr = lower_32_bits(blob);
 	cmd.size = size;
 
+	mutex_lock(&ta_refcount_mutex);
+
 	ret = psp_tee_process_cmd(TEE_CMD_ID_LOAD_TA, (void *)&cmd,
 				  sizeof(cmd), &arg->ret);
 	if (ret) {
 		arg->ret_origin = TEEC_ORIGIN_COMMS;
 		arg->ret = TEEC_ERROR_COMMUNICATION;
-	} else {
-		set_session_id(cmd.ta_handle, 0, &arg->session);
+	} else if (arg->ret == TEEC_SUCCESS) {
+		ret = get_ta_refcount(cmd.ta_handle);
+		if (!ret) {
+			arg->ret_origin = TEEC_ORIGIN_COMMS;
+			arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
+		} else {
+			set_session_id(cmd.ta_handle, 0, &arg->session);
+		}
 	}
+	mutex_unlock(&ta_refcount_mutex);
 
 	pr_debug("load TA: TA handle = 0x%x, RO = 0x%x, ret = 0x%x\n",
 		 cmd.ta_handle, arg->ret_origin, arg->ret);
diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index 8a6a8f30bb42..da6b88e80dc0 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -59,10 +59,9 @@ static void release_session(struct amdtee_session *sess)
 			continue;
 
 		handle_close_session(sess->ta_handle, sess->session_info[i]);
+		handle_unload_ta(sess->ta_handle);
 	}
 
-	/* Unload Trusted Application once all sessions are closed */
-	handle_unload_ta(sess->ta_handle);
 	kfree(sess);
 }
 
@@ -224,8 +223,6 @@ static void destroy_session(struct kref *ref)
 	struct amdtee_session *sess = container_of(ref, struct amdtee_session,
 						   refcount);
 
-	/* Unload the TA from TEE */
-	handle_unload_ta(sess->ta_handle);
 	mutex_lock(&session_list_mutex);
 	list_del(&sess->list_node);
 	mutex_unlock(&session_list_mutex);
@@ -238,7 +235,7 @@ int amdtee_open_session(struct tee_context *ctx,
 {
 	struct amdtee_context_data *ctxdata = ctx->data;
 	struct amdtee_session *sess = NULL;
-	u32 session_info;
+	u32 session_info, ta_handle;
 	size_t ta_size;
 	int rc, i;
 	void *ta;
@@ -259,11 +256,14 @@ int amdtee_open_session(struct tee_context *ctx,
 	if (arg->ret != TEEC_SUCCESS)
 		goto out;
 
+	ta_handle = get_ta_handle(arg->session);
+
 	mutex_lock(&session_list_mutex);
 	sess = alloc_session(ctxdata, arg->session);
 	mutex_unlock(&session_list_mutex);
 
 	if (!sess) {
+		handle_unload_ta(ta_handle);
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -277,6 +277,7 @@ int amdtee_open_session(struct tee_context *ctx,
 
 	if (i >= TEE_NUM_SESSIONS) {
 		pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
+		handle_unload_ta(ta_handle);
 		kref_put(&sess->refcount, destroy_session);
 		rc = -ENOMEM;
 		goto out;
@@ -289,12 +290,13 @@ int amdtee_open_session(struct tee_context *ctx,
 		spin_lock(&sess->lock);
 		clear_bit(i, sess->sess_mask);
 		spin_unlock(&sess->lock);
+		handle_unload_ta(ta_handle);
 		kref_put(&sess->refcount, destroy_session);
 		goto out;
 	}
 
 	sess->session_info[i] = session_info;
-	set_session_id(sess->ta_handle, i, &arg->session);
+	set_session_id(ta_handle, i, &arg->session);
 out:
 	free_pages((u64)ta, get_order(ta_size));
 	return rc;
@@ -329,6 +331,7 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
 
 	/* Close the session */
 	handle_close_session(ta_handle, session_info);
+	handle_unload_ta(ta_handle);
 
 	kref_put(&sess->refcount, destroy_session);
 
-- 
2.17.1

