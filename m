Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4C535F9FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhDNRjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:39:22 -0400
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55]:45312
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234179AbhDNRjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:39:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikX2P4N4TIQCOs4DL0k5eF/OqZtQOBTHia1YRmYcDU8HB0452ZMa2gfClXlsqE8cm3BD+3Gy16uVR4RNp7boP0htYMlvdaMqpxktQLOxZWpMVo/ccxObmMOoL5KHN/XQXcu5i1z9ZOgvnJk56rYt2AbL854ewfUsRkRT9CTo89XxU3RV4q1YHnc3telu4rq2gKoq74dYLT4NEwIi2UT+kaBQQSW3EACe9W0uFpMcP6SKJwvZ1bv23Qi7irXsQYP69G/Aygx1uqfCarDkd1g51Le7nn8U/s9Q2h1e/tBMMWJKkMahm+hhcLDFBRgN4GaTcUy0cG6bkMcPZwvXMPS7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOZk0rknPuaAs6NzUCWQ9OOtkFGhHanx61RsXQqDjqA=;
 b=jadjxIwhTcpqQcVIzxnThUH9+lLsdyXE5Bp13PgdLWP+YAq6CbyB4SAQ6+jvP0M2lOFeAeiJTp4vc+aLPoPabgoPDVR4q5wMAsJI2cwHQ6KtM2lp78g8XeTEj0qJkxyaeNqleAX0e9peZSTWDI/eCwcZypu0aTylQ6UIVH6xw39lrnz6ZZ6g8WNx+iyWiKtEuGbC3npOFMMES/YGp6Z82BaPC7OTup7xq/pyu9WkijO+ehNEDBO2xZWfQ2yqdU5tqFO2GX7M5G8yYvnJdFvy1ey0NOwfYMYmy/HT/Fjvfoo5WYx2JlPxUg1BHXpP3/tdWS+sadqMiLNzYlq3NY+rlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOZk0rknPuaAs6NzUCWQ9OOtkFGhHanx61RsXQqDjqA=;
 b=pM3Y5VHOEjsZpK8BMJ98DbkFOI24PTEHrwO48bwNNcMzOB3bbuCYIiBiixs8/WPZtV2+pz6R96vFW0SfFzt2Dy23q8emZ9Uw9nbmshHcqLSS2SMGwlGea3reHSKKLn7S4Vyy6A8qLObxHHeRv0h3DmbU8NtdDtLLgYQNyc2762A=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Wed, 14 Apr
 2021 17:38:58 +0000
Received: from SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::6999:4ad6:8648:9c8b]) by SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::6999:4ad6:8648:9c8b%4]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 17:38:58 +0000
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Mythri Pandeshwara krishna <mythri.pandeshwarakrishna@amd.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] tee: amdtee: unload TA only when its refcount becomes 0
Date:   Wed, 14 Apr 2021 23:08:27 +0530
Message-Id: <5057c53afb568fa70234de2f23b0ffeff75af426.1618421014.git.Rijo-john.Thomas@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR01CA0090.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::30)
 To SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from andbang6.amd.com (165.204.156.251) by MA1PR01CA0090.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 17:38:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 903dd237-b26d-431d-a2e4-08d8ff6c2f32
X-MS-TrafficTypeDiagnostic: SA0PR12MB4399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4399B858B73D8C53A9223E72CF4E9@SA0PR12MB4399.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OXwgBNQpaJAmUxrVMdZ6OFLpuBJko7CheY06+aU0115ZK3NMEOR6NDaFDf9jKUEL2/40L/QS8mgp1f+2mUaEMnvdeiCQBQlHdqYVXhHHONclaWwSS01qtFfhUYt/brfxcVksGCq4fL22ys9QQFgxxd+8wvzO3EK/eUuzQwBjhTo1+x5FWrn0yh6WQPl2VIcnxEOo+xcxc3ImLlHp++rEtz2GqdCrnmR0ROJZpjZB3Vw94zSDzPqopr1jZKvv4dpUGQFR/eW7aNIQLjcn/+7OaUtArsBwDpF9Z40G0FDBM7xI3woqYyNmz9y1BV0sPadNRyla72H4I6lqgPjM7Ce/hTxlyNCS01wTNF07MQ56woRqq2VgPP+6EfpoipEBGC6V6lDBhLHrwAF2Jmp7aRG/597q6gjB52G4I3r4C5Nbvojrx7CtwfJnK5jIdjIPsFuK08TjJp92CyeK16kshqQynhSZufneYktADXUMMfcAPeSI1+1tGvV6o2cJiTg86ziLCl+2MULJPzw4crLnpMoXUPVFgwImaV5jqdQpgLJEt7RJ++2Vo43nOUWUFWxjNsfAAx5Mb2BpRiwIFkPz/aK7XU/6R7b+EapGArdDJtAgnyrLXGTYrOg8bHJRnSQcBErV24TiCxhSAPeGeoX1zGNBeCVqfNWDy9fHDEvOjEmAKAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(38100700002)(38350700002)(6486002)(478600001)(66476007)(2616005)(26005)(52116002)(66946007)(66556008)(6666004)(16526019)(7696005)(83380400001)(956004)(2906002)(4326008)(54906003)(86362001)(8936002)(36756003)(5660300002)(8676002)(316002)(110136005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7nANdqJU9SGCgLo9gxHcyhiW/+vebPzhNjoShjI6ZELSfPJIpGEVEHbUkvGX?=
 =?us-ascii?Q?fDXLYRVDulRAyBMU9WeIfkXSMQ6gy5NyVhA2eaIhbxPgJC6UwobvlePsg4zp?=
 =?us-ascii?Q?JWtlVo3elepfttzv6LKF35iioxPWyYDuBOZFX+B+nLb0xCOQrbWzBPOJdurN?=
 =?us-ascii?Q?455ZtLgWpAqxuwuRRm3hQeIN9peiA8dKNqXa15jg0d1IsDrylhQknT5SmXJN?=
 =?us-ascii?Q?8vhXghsBO/zts+lsc1Sl1JZ8P5RGJ+GYQcbUMFIm46I9XXQE3S/tsdFwpuo3?=
 =?us-ascii?Q?LGGCO+u+E7bQrYlN2SLUkFTm4LC5SdO44awmTMwoiK7cQSpgbDBBrQVOMxaU?=
 =?us-ascii?Q?Epp6He9QOKPokUuk7r1dFXrJa5vUNW7jXY29+ApDG2Lg/KWYZ9PKmDn3m9+K?=
 =?us-ascii?Q?zS+L6wuEDvDnzkOngFhh4xY0fLytwby5qaZTEvAG6tND6mRJcXus8S0mdGkd?=
 =?us-ascii?Q?K48R7ZKMF+LZJOJHdTwI/8a7IvRiduBOOiREAFSGV3OEx1xFN8XHBPQ8hQ2S?=
 =?us-ascii?Q?0iu25Q2a/Sl5v5TrIje+GEvXuXN+Pxc7lDkyrrG/iHGjyPxrE4LLEP7t1rbJ?=
 =?us-ascii?Q?9UQqFIguwwUSK2SJRJlnKU2yXsfcSz9LKQa9by+5R9xIiRz0me2hYGs8P6Dt?=
 =?us-ascii?Q?dF+Suifwx6CPOA7wQq88wXrswh2u7wYOeHYZsTUYJztYc76bV6yv8cdkgakz?=
 =?us-ascii?Q?lJoVbKxzFyQ7JFiuZ1+ju2mklQvjj/74HPv6O/q30L4NPHMGC81KfqecVd0u?=
 =?us-ascii?Q?tRQ5DjYo1tRV/OeP89pikBMNH74oPH8mcJvcX9/wqZ2vYZVpB12l2nvop4XT?=
 =?us-ascii?Q?seWRVpIlWIEwKYUH4wl2CcmTjuoAByRHjqaFRMkQXg2rSvIEAXcIxKNr/DDB?=
 =?us-ascii?Q?oryl/s4d+IWB9ZXyqz92ggKtKcg6OafvFOWOLQSBqA+JNYJbpbAr6WSIjPEr?=
 =?us-ascii?Q?ydSEObPkPVQmQdTDmNa6dSGq3cc02QcZiW171IMODQl9gzBKZuckQSpY0aXE?=
 =?us-ascii?Q?I2eNsggdnZbEdOXL/WamjBMsmi5I0ObHJ6uKGtpJGTzFID6QaX6YqcrMETTE?=
 =?us-ascii?Q?b1buQYyvmT0PDyHY54vd+3IF2/bTVBMT4ehiKHiD2Vhh2q3X8OPT/5gwuhYs?=
 =?us-ascii?Q?Ats5Z/e497FXaDHyddUppIWu8SjMOaa/mLi/YqzyXde5U5Slaqneh+6+emQd?=
 =?us-ascii?Q?7umAk07yaef7WhcgtQ6EFDeFuVFd7bKbEXbM6/R4Q9DS941ZOCpkp3l4tT3b?=
 =?us-ascii?Q?ZesbT54X4B5Eg6Ij7IBR5X7v21nO+dNqzTp2jQVG/eENzKcXy6LUGe5QMen/?=
 =?us-ascii?Q?XCOZFf5Ab5NOdihYOI8UHeJ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903dd237-b26d-431d-a2e4-08d8ff6c2f32
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 17:38:58.7642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZj6dIM+NjMHOSpau6/ahJU3LWqoDq69MKN+8kyx3lStHsTxVP4o/TgtC2L1PztOCqEc838QpGydtkkeQp5k4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399
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
v3:
 * Updated structure initialization list from {0} to preferred
   style {}

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
index 096dd4d92d39..07f36ac834c8 100644
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
+	struct tee_cmd_unload_ta unload_cmd = {};
+	struct tee_cmd_load_ta load_cmd = {};
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

