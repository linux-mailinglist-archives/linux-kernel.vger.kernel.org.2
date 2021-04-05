Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2ED3540EE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhDEJnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 05:43:42 -0400
Received: from mail-mw2nam12on2061.outbound.protection.outlook.com ([40.107.244.61]:53976
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231883AbhDEJnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 05:43:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGRdfF+RTVphMX0wFvrjw2vWfKKTyDmPQEnp61qaeRUtqwgB62gO5zGZB/Nr1WVnpBRxV08Xh3JJ5WA2dVIzdscUjVJcqYGrJcEBTRpVuy3R81fXfzd4N0l3oAOcmjDEQTSSWe6YhPPRSpbm27pob+7NYCQD6vpka1eP37yjJxtlj0LHGIqWqVKDDTjZet1fS0hGNKYUYOLqrl9ejOqQeKgFzqQRVsyx9uW312KZYNstE2TKGSCXbK4r1PHy4nUmwW249d77pp3OaHBPfUBhk1DTPpfD2KjOlz3bVTU5njtWaTA2qXbJJyX5j2DG6c71uphJZNG/nTWpVfBE0MgDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOmM5/i0kgbuqlPlU/N/Kptmi6nA6GGknsej1HqfqhY=;
 b=g87zZ10rbeiN4tFpjrhUBCT0nndMGaEax26dZxoVh6/0vzjISr3JhWhvzl1J+6Y1DiYEfMUZ/naf6k71FaoOx8lh8WcaDOPGYwr0Qgabxp2CFjnqhDQhB5aKkjmi65MrVacYPCsZfFU9aXe8u53sN85/YI+ZA652wGBpuVgsdg5YHfXsHy/MXiwSEINyE0w1l+7IzBrnd8k9MGgmxn1egzYF8p59j/At/ohHlSzN14OfvRhcqDncF6q4koXWsAoFqLGwLwaa5aO/ptIdI4bCYTorsttvRfrH9hffPojFZkRXh5lynlMTRNfT1hSyjsO4toug8ZpnAu0WrdhJy/cQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOmM5/i0kgbuqlPlU/N/Kptmi6nA6GGknsej1HqfqhY=;
 b=wR/ls2/VJLZMtxk7Fa768M5MB7UxPKO6DNLu2S4BBSJ4o24P71mBMKPR+I9bmchhKCPD9WUZNAvt2BJVcJ4MZKlr1WOQHIwQkaiqU/4OXbc+Ii1qzsARCzIvhzNjNAqDbelg8w9+JoJ5h/63WnCvwOFsJGUUxv6kY9mjGYxRX7A=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Mon, 5 Apr
 2021 09:43:34 +0000
Received: from SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::6999:4ad6:8648:9c8b]) by SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::6999:4ad6:8648:9c8b%4]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 09:43:34 +0000
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Mythri Pandeshwara krishna <mythri.pandeshwarakrishna@amd.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tee: amdtee: unload TA only when its refcount becomes 0
Date:   Mon,  5 Apr 2021 15:13:09 +0530
Message-Id: <3150feb19421ca6b15202c853215f8b40fe35567.1617615067.git.Rijo-john.Thomas@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::27) To SN6PR12MB4719.namprd12.prod.outlook.com
 (2603:10b6:805:e9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from andbang6.amd.com (165.204.156.251) by MAXPR01CA0085.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Mon, 5 Apr 2021 09:43:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99f1e465-117f-4255-1cba-08d8f8174764
X-MS-TrafficTypeDiagnostic: SA0PR12MB4351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB43513408EC2BBBFEDEA60923CF779@SA0PR12MB4351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BDVbtCRfd6Fl8H/0/jd2GLWM7zTHac5oDlVzeWi6MsDaedGls/2Jzjx2yTUfTpkL7h89Y7MIa4gjqd7xSUVlKyysNWJ11qF6d233sPxyY+BRPoG58rt44qce2rEkQV8+wPSNwSd6cheNB1dXWZNbqYO3Pd1CTxZ2QXkThBZ/Y3/sr01QQR1BKZR9H/cQODVxopcT2m4/ocj5KS4fSpd6KlO6Fv+c8AFwd3eb2k8dY1oMNX3RXDoaHgGymaH4VQsBsrk5vdjZq5HC0WmzG5ttCog1XqNBxum7MWmMuCcEFET3qyOlzTT2ut/l5KbAFjvEDODgm2fLBM4+XxLyG8OJEsEUnwu10xQrK3R/p5zGM40T56+JdGEJfsnT36EqdF+8m4OXvo87Aa65Ae9+a5fhvmOAnrONoLYOADJTd9FuG/fn6GiSF1VBYwH/b+M7DMmz0LSOWirEWWn7sk1csYo3LH26XYU4B9UN7hINqsczxInh2ZUQXtilVeeeTUQWZZ4U4qCmQbGhPVzvTo95sublBOVUa58Ee0zZsACSzP9OlVnVfuY7F6e/E7DXki9kQaRETI6sIJyMWvVXx6L9pRw0SDKBhf0bFim6HYUNg39j3l2BX0ANtVUEd5rrupmoTgyCsT91o9C8aUvtFQ83gsNBdn0TvHiNObKAI4cewRKvHUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(8676002)(36756003)(66946007)(66556008)(66476007)(2906002)(316002)(54906003)(6666004)(4326008)(956004)(7696005)(26005)(52116002)(478600001)(6486002)(38100700001)(2616005)(186003)(8936002)(110136005)(86362001)(5660300002)(16526019)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0FF2/dNeGzRFpob3sM6tdedy+gNnh+hMAKFKF/WKid83gzzf8r8szi6vMopv?=
 =?us-ascii?Q?Kyz5Smzl/upPDLrEIgnATuzZxW/bfrVoV9Cs2IEMygfQVOyAjlJZ67S6W/mm?=
 =?us-ascii?Q?0HkLftL0NgblCfQvkby7MNPIuIsc4q0/o3MmHQ856QhUa7zhP8t6VSGBj+ma?=
 =?us-ascii?Q?5nKPwj9UJhsQFikFYaOcGErEdWUintVBgQpZpkJzNsgKCPVs+2KP3cewHP65?=
 =?us-ascii?Q?Bw/8fUoETHlvS7Q3wv/39cI7nv8NJU8kQHJoYcAADmdv945qWcufg+XDMd/L?=
 =?us-ascii?Q?JCuNM20Zx8Ou/4JEPQXjUm++ddsdahHfpgp36/l27NT+qORYaJ7DcxhwiIaR?=
 =?us-ascii?Q?Gha0ensWFqSTW40W95jF6eVfi+LXt0BTteu6Hhw8G6lQdvfUsyWL4FKfqwyf?=
 =?us-ascii?Q?KchXcq3AtYRgM8sybeQDVK/TiNCzXugm9leWErrBmxZotaQF8T29H4QewGTY?=
 =?us-ascii?Q?X7+4jwhdz+nFm99lz/5lWAl3C2QwNzTlq350j9ZLhnapD0ztiV4J878VwAOu?=
 =?us-ascii?Q?pScqobH7GBS+ve6I2yJi2rhe91fvjNnKwl3QW2+G/5rUeQ3cTFM5yPoZik3j?=
 =?us-ascii?Q?aQeEw2fxLZXIc6PNx4C9DoyEWOsNophQ8KJMZN/9fJWLsHjXqkRXrD0H1nxS?=
 =?us-ascii?Q?6CWa1iPaiKELNxF1Zxers1Fc/ZXQG8CnTktRqb/X3W9yYOuotjgNSl8Y364b?=
 =?us-ascii?Q?pdOI4/VdI4YdbrbpYSUfaQqhNFMT1+tc+4gCfoRutaji996ihEAo7qhYkqrD?=
 =?us-ascii?Q?HaNp2cc3dw+aPNDWQczpusAt+x/dDtR1+MEYHrUd6oQOwsWHE343I7Li/2Py?=
 =?us-ascii?Q?75VZqO4fxryfVzbzqysPrflQIBTXLvdk29R7LnK42z3ZeXkdw5rYe5SajFoX?=
 =?us-ascii?Q?3PXqdHG+XIMfdwowrYvU7BsgAUH5naeZ+3lxCCJXCxmipQTpXS/SDhBJAymx?=
 =?us-ascii?Q?HknW6+ZBdGukaj2VqHPzkJ8AuDho80ZLjvKnwEqcXRjaiISVvJ7TQTMfX8Vm?=
 =?us-ascii?Q?BXmFwPuZF0ENSx3/nPxx772jE1Pwh8efQgZ69LElLmEjjtHO0GaombcVBtM8?=
 =?us-ascii?Q?ejOgTDXWXBwZXwvDlyBbqyQQWD43gy1IcA9mJIcHtXzVmVMk+9FooXlj8ceO?=
 =?us-ascii?Q?3cRIdIb5lZvUNjV98v4bCPeNQb4H39dZOn7YwWLEgnvrhldjpepKKP5bStH2?=
 =?us-ascii?Q?eDTbPjEDIcVIA1TiIkr6Dy7ML59XtFuxAXp6S8nK9RU/xZCoS5Cst9hTYWQe?=
 =?us-ascii?Q?Y+/SyMzobOkKDoeZ95YL2J+sHTtW0cyzHO+0VR3QsbjK17ftHakPJYgZTiex?=
 =?us-ascii?Q?jprYS2N3WmnoNNZgOt+Z30gT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f1e465-117f-4255-1cba-08d8f8174764
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 09:43:34.0683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +syKqdlLqah3pqiz2lnytn84jeebbifDg6zt76y80zZBmghRuvY2gL7PMWWg5RhZ0sWQ8sRCWeGeBiQdEIp9mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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
v2:
 * Unload TA if get_ta_refcount() fails

 drivers/tee/amdtee/amdtee_private.h | 13 ++++
 drivers/tee/amdtee/call.c           | 94 ++++++++++++++++++++++++++---
 drivers/tee/amdtee/core.c           | 15 +++--
 3 files changed, 106 insertions(+), 16 deletions(-)

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
index 096dd4d92d39..06abaa518921 100644
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

@@ -340,7 +398,8 @@ int handle_open_session(struct tee_ioctl_open_session_arg *arg, u32 *info,

 int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *arg)
 {
-	struct tee_cmd_load_ta cmd = {0};
+	struct tee_cmd_unload_ta unload_cmd = {0};
+	struct tee_cmd_load_ta load_cmd = {0};
 	phys_addr_t blob;
 	int ret;

@@ -353,21 +412,36 @@ int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *arg)
 		return -EINVAL;
 	}

-	cmd.hi_addr = upper_32_bits(blob);
-	cmd.low_addr = lower_32_bits(blob);
-	cmd.size = size;
+	load_cmd.hi_addr = upper_32_bits(blob);
+	load_cmd.low_addr = lower_32_bits(blob);
+	load_cmd.size = size;

-	ret = psp_tee_process_cmd(TEE_CMD_ID_LOAD_TA, (void *)&cmd,
-				  sizeof(cmd), &arg->ret);
+	mutex_lock(&ta_refcount_mutex);
+
+	ret = psp_tee_process_cmd(TEE_CMD_ID_LOAD_TA, (void *)&load_cmd,
+				  sizeof(load_cmd), &arg->ret);
 	if (ret) {
 		arg->ret_origin = TEEC_ORIGIN_COMMS;
 		arg->ret = TEEC_ERROR_COMMUNICATION;
-	} else {
-		set_session_id(cmd.ta_handle, 0, &arg->session);
+	} else if (arg->ret == TEEC_SUCCESS) {
+		ret = get_ta_refcount(load_cmd.ta_handle);
+		if (!ret) {
+			arg->ret_origin = TEEC_ORIGIN_COMMS;
+			arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
+
+			/* Unload the TA on error */
+			unload_cmd.ta_handle = load_cmd.ta_handle;
+			psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
+					    (void *)&unload_cmd,
+					    sizeof(unload_cmd), &ret);
+		} else {
+			set_session_id(load_cmd.ta_handle, 0, &arg->session);
+		}
 	}
+	mutex_unlock(&ta_refcount_mutex);

 	pr_debug("load TA: TA handle = 0x%x, RO = 0x%x, ret = 0x%x\n",
-		 cmd.ta_handle, arg->ret_origin, arg->ret);
+		 load_cmd.ta_handle, arg->ret_origin, arg->ret);

 	return 0;
 }
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

