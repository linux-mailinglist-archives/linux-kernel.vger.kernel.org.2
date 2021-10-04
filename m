Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0478342096D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhJDKoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:44:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48734 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhJDKn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:43:58 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1949kcG8026324;
        Mon, 4 Oct 2021 10:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=zZfusRiy704liGGjGtZMR7cdNSX7P8lGKIIXe/dG4qo=;
 b=qO8Jhq4Vk2qWk7tp3mYbkt3eo9w48izOLHjZlOR8/59xWusfX8Y2wZyMWaiiNemtXTc+
 fulKxfHhQs9GS61zQ655FOGpWJ5gBSpYa5wlXkHg1xuO3jtgbEmJ1gbm8e4JP8hrwvsM
 ruS0hpyqrI0Ek8tkIoAGmwBK+kivB0nWG1eN/sqJZ+5XgMx7bqf4PJ1VA0778ssB7ZCL
 5uAKkRkmpIW9JsA5K9BHbevd6DIYrMbc3O7EuhA+9pj2OHd5fXY96tT3PmWRJ2nP/5dI
 YDduEPcu5lFuWSYvOwpz9RjRbFUD8n6Z5f9QhCdk4Ca0T6Er4fSMQERsB1QuMh2/d+gl TQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bfbb133wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 10:42:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194AeEdu165837;
        Mon, 4 Oct 2021 10:42:05 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by aserp3020.oracle.com with ESMTP id 3bev8uybk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 10:42:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpVvEnu9VQLkXCYIT47vrrEzDbN7FjLYhoOatfXF6sRxMkzHfheerH9QJ+WaHW2spOFZm9G4+JOxWkBNv2voaHirVkF9+pxpm5L0rC5zaQB/9TuEqCZnJyiEqAH0RF9XtDzDiDyxDeEjtNyCF30pzu6bOgH7VxwUNyPqiEKTUwMeAtmP2IAV6gu2dVZbspoVf+zvq75yCkTyQR7cynVROZ4n7Fl4MXAWRI+ItAZeJnU/Je77HFJjDKcqP12hTq09Rs2dRPuRqQRSo9CmjOXpG4a9pabEcajati1goxGNUdLThmjKcltVl52YOv7gNm0h5fzPTeDN7Atq18pRiwO6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZfusRiy704liGGjGtZMR7cdNSX7P8lGKIIXe/dG4qo=;
 b=HDCDtiWc2IBRdP4W9hyrcOxPFC72THnJ0sfoUol/zgJguoaNcOY3Jjc6YQoJq8SpvTdyjHFyFfXQ53jZ7mXgFNxsxLZVHgFndK3to7MsRgS4f3y94vOEWr3izqQFzNh6AnAif0A4lkR53356tzq/XyN/WxuL9Hmm7t86ygXADt3G6DPyBd682QYwsShmEeqhJv2cGO0iPzbXp/JLoJlow6PSHv9uiMog46h17jJaXU2hUAeOKcrMmBdN8GlnuY4H4do4C5OofVbZKma0XTXNYiHaJoAQkHgU0lnGG6r1E6jHcmGKTpP9+sPTBCFL6+FRsRzCMqFaG2twpO3jS9j++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZfusRiy704liGGjGtZMR7cdNSX7P8lGKIIXe/dG4qo=;
 b=NeCitmD3YuuoMeo/aoYG+mqe0BaZa6wIU0zMl80sNqHl+JXWhMu9MedNxoOC76uLnHAiw0y4fenPJNbJJIuONvATcVQ0fW1dxjDDOtecRLP9Vb7a21vqzZwt44+fD+m9Ff5i5bXY3waoyPoR/YzVsuIttndUiRbh6nbYf0Y+Hk4=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1776.namprd10.prod.outlook.com
 (2603:10b6:301:4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 10:42:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 10:42:02 +0000
Date:   Mon, 4 Oct 2021 13:41:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Megha Dey <megha.dey@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Tomasz Kantecki <tomasz.kantecki@intel.com>
Subject: [meghadey-crypto:crypto-avx512 5/6]
 arch/x86/crypto/aesni-intel_glue.c:725 gcmaes_crypt_by_sg() warn: possible
 memory leak of 'data'
Message-ID: <202110011150.YtrcL6xt-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend Transport; Mon, 4 Oct 2021 10:41:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6b48af2-9284-4d73-b848-08d987239986
X-MS-TrafficTypeDiagnostic: MWHPR10MB1776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1776973DF69758DDB419CFA28EAE9@MWHPR10MB1776.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3jnZWT/xR/LuXf2MXQkMpAX/iUPmDq4O2x2Zvlya7uU8LAPdX7DbCvCBTqd9KElwXx3Xf7uMpY9ThDMG8eqDISJny7byBt+VC4bHTM+kxAYWKXoEFx5RUK9PGNoSSS8Hzr6YHb74F5B6HNyq/mTvPFgLAvSZXFxUEjU39Mo8EumW82baI0ZnP4mfwotbQG5+Uk2jsS7t9VKBZTOk+Ht8Y2h1HWs0aBbE6ihuX4h8uHuDBAs1l3at5YpfA7S8awUpLPeHo/lfLgHAtB9Cg2MIsYDxH8UlCEu485J2RzLNU6C/m7zRLKhsCa5Xzly/IV0YimrjYbaywLN+xi7jWUvJv3dqI9lBgdz7jW1ORWpJCX/4ZECzIGQbrmPmRKoh6lhNY+s9a5R9DxPLEvNshJr8OnwofugwSq3X2SMO17YSvMHjne2veeTNvLFkWal01Z4I0dlvmoXP3UCKImeIJxwiuVglijPjPaNyKIXFCoovKCZyRBw0IXtWeSl3qZo/cqWVn1Bo90hbTJyCtp1cJ+CbRaLNuEbDvzeHWKfDDk8mb7KOFTLC3xvj4Yp4mCenn5o93Qk/3b6H46m+TFL0gLmiUBZCnAvviNPhYGomv9FpQmgEIUuv5V4GlvonFbxM2gwtCvnfk0gjQAeoSLkoAIyvzSBYA2Jt78EGdtVMJYouJPxvdR7Q06VJ/QPa+4XUGYssMkoOlZPW94/FA2erDin24aGh1BLlBCsVdmQJaJaT8zagwwrDADBlVo93YgIZ73e1g7M1sZAGbLrYXlGxpJVuornnJZrUb1CGCcr2KElFnWesuhasUpOly89vdJ7gYPq7GMOxLVWs5jupO9pZRGpKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(30864003)(6486002)(316002)(83380400001)(66476007)(2906002)(86362001)(508600001)(38350700002)(38100700002)(186003)(1076003)(66946007)(37006003)(26005)(956004)(36756003)(8676002)(8936002)(6666004)(6916009)(6496006)(9686003)(52116002)(5660300002)(4001150100001)(44832011)(966005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3k1jTqgWkv9iY1nclnCsAVR2HpElJ1Hf8zvvg6hhF1mNz9l3WdsA+na4ewxH?=
 =?us-ascii?Q?zvhnYP6ocuZh5htg6d+YKy21sgsmvZFmIuxcrCgTV//bjxjDZWcP04qMtEz9?=
 =?us-ascii?Q?HaKsiiuvTHe0DdyghIIxILuo1DzipJlgNXwVG4uz5M4xexl3jBu915V6Tbw3?=
 =?us-ascii?Q?YFWXbk67a4/+VvQjVfpW5jyMhsQgIeilAAFCcsnmEbdsrFqnCVlgn/VNK3zr?=
 =?us-ascii?Q?v12nDezeKr/ktaWKnf12JxOaAIA8ANI3OsetPg23OfioxH968Eth856X4ynP?=
 =?us-ascii?Q?fao7lPhrRwfClh4URTSitgqvUKswivR5vOmw//8ZTHup/EkdUT7N4DpG2Y6N?=
 =?us-ascii?Q?GNGjy31YttkasmbaEL7MSmECQmBpzYpMVhyxayr8TEnpuRTB5j/tl8A3RtdQ?=
 =?us-ascii?Q?/tvIoqeJX5PNWjALJSU6EaPSLDut6G4hmN0uknqU0EiV4aYx2LFQRSTGrTaX?=
 =?us-ascii?Q?du50m8A/RFO3bbYGVBlefbsFnk8s9otSfn2sZ37BEpDroSbe1D746IihtAiA?=
 =?us-ascii?Q?XMrVEQ9hDGHhFbo3rAuoapWJNBbkGMNoyRJJiv19lR5wjFCC7rlsEVUZXzRm?=
 =?us-ascii?Q?GrzXBNWrwIc7lmHxAL5vJLW0z5ye3xw7iS3C4Pyc74W4cYWsx9+Wa7ID6BOL?=
 =?us-ascii?Q?Ddr6i9CWlku1a775WClORecU0j1pwpxUZ3WOYUOBcN2qtNm4EOVafLAgGlfB?=
 =?us-ascii?Q?f2/zVucO1vSLY6JLMY7nH5pHbihDbHTYbm0Nq3N8KtR3izsSripjQ2+jtxV4?=
 =?us-ascii?Q?HYWWXlIWK/YDjstVlZf0NtJmBSwqEvWi6hbbO87KkjmWpo7kNrY/VWFlhU8m?=
 =?us-ascii?Q?AnSfQ28yBxvtFElPKGoS23TslSefryoIaKz+KRd+eEGJb4DLty0hf49gZ032?=
 =?us-ascii?Q?b/ZJBC94CpZ10rSrkygaaxyU9pN4xFlsrHwsojMDlD0iOnIgLZJWk8+f/dOK?=
 =?us-ascii?Q?RKm2ulH8cw4Ugyn1cmn2YR7OMKxGDKYyGO6In1RmnKnu0fKsT8WPwDHk8IkY?=
 =?us-ascii?Q?O5ewe4GkTrGmd5+aW6y1NX3Q8RjlsDFqK3EPcn/ukCV3PCtDI3p8eABs4Iff?=
 =?us-ascii?Q?5lNyq+eQqm0HeHpe2RD6n/tcqVR4y5YceYwEuJ9QO+YfmyQaCYxlpRGLCq/S?=
 =?us-ascii?Q?BSF7d8LBbFdNbXNoUR/O6I55g+lI1V422LT5x2sQR6Kt8FyoKygPgcevzA2W?=
 =?us-ascii?Q?PaJiytUt+bIbuAL8dCqe8LMbiZzSwSznrkT4r2debvHvGUZ9NkD1/AGDJDjO?=
 =?us-ascii?Q?knsNOMCBdRl5SHTzlmoYrr7YB6i7S+UIYKSa/M+LNCzGO8KlTTXB0g1T5t0Q?=
 =?us-ascii?Q?w1lTnelRJPg/5Zq8iE8yoWYe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b48af2-9284-4d73-b848-08d987239986
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 10:42:02.0822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOtg6z8pxJFL6nqhYMWGExXxWUrvdZ01sTdI6cMpbtugV/8B0QHfPbPN9Lmb+yHdtl8MUPFXyw0v2slWnRXDosLcYkon0wgqAfnVo4q87zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1776
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10126 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040073
X-Proofpoint-GUID: l7xVRKjXIJcYqFo4qKp-V1NotLsPIixV
X-Proofpoint-ORIG-GUID: l7xVRKjXIJcYqFo4qKp-V1NotLsPIixV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/meghadey/crypto crypto-avx512
head:   9c8c2ca77f6e2575a130bddb9767d068e1162d71
commit: 377aede9f10ee28be954473668bc6d33c6c9db75 [5/6] crypto: aesni - AVX512 version of AESNI-GCM using VPCLMULQDQ
config: x86_64-randconfig-m001-20210930 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
arch/x86/crypto/aesni-intel_glue.c:725 gcmaes_crypt_by_sg() warn: possible memory leak of 'data'

vim +/data +725 arch/x86/crypto/aesni-intel_glue.c

e845520707f85c Dave Watson     2018-02-14  677  static int gcmaes_crypt_by_sg(bool enc, struct aead_request *req,
e845520707f85c Dave Watson     2018-02-14  678  			      unsigned int assoclen, u8 *hash_subkey,
83c83e658863e4 Ard Biesheuvel  2021-01-04  679  			      u8 *iv, void *aes_ctx, u8 *auth_tag,
83c83e658863e4 Ard Biesheuvel  2021-01-04  680  			      unsigned long auth_tag_len)
e845520707f85c Dave Watson     2018-02-14  681  {
a13ed1d15b07a0 Ard Biesheuvel  2021-01-04  682  	u8 databuf[sizeof(struct gcm_context_data) + (AESNI_ALIGN - 8)] __aligned(8);
a13ed1d15b07a0 Ard Biesheuvel  2021-01-04  683  	struct gcm_context_data *data = PTR_ALIGN((void *)databuf, AESNI_ALIGN);
e845520707f85c Dave Watson     2018-02-14  684  	unsigned long left = req->cryptlen;
e845520707f85c Dave Watson     2018-02-14  685  	struct scatter_walk assoc_sg_walk;
83c83e658863e4 Ard Biesheuvel  2021-01-04  686  	struct skcipher_walk walk;
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  687  	bool do_avx, do_avx2;
e845520707f85c Dave Watson     2018-02-14  688  	u8 *assocmem = NULL;
83c83e658863e4 Ard Biesheuvel  2021-01-04  689  	u8 *assoc;
83c83e658863e4 Ard Biesheuvel  2021-01-04  690  	int err;
377aede9f10ee2 Megha Dey       2021-01-20  691  	int hash_key_size;
377aede9f10ee2 Megha Dey       2021-01-20  692  
377aede9f10ee2 Megha Dey       2021-01-20  693  	if (static_branch_likely(&gcm_use_avx512))
377aede9f10ee2 Megha Dey       2021-01-20  694  		hash_key_size = 16 * GCM_AVX512_NUM_HASH_KEYS;
377aede9f10ee2 Megha Dey       2021-01-20  695  	else
377aede9f10ee2 Megha Dey       2021-01-20  696  		hash_key_size = 16 * GCM_BLOCK_LEN;
377aede9f10ee2 Megha Dey       2021-01-20  697  
377aede9f10ee2 Megha Dey       2021-01-20  698  	/* Allocate gcm_context_data structure on the heap. With the
377aede9f10ee2 Megha Dey       2021-01-20  699  	 * VPCLMULQDQ version of GCM needing 48 hashkeys, allocating
377aede9f10ee2 Megha Dey       2021-01-20  700  	 * this structure on the stack will inflate its size significantly.
377aede9f10ee2 Megha Dey       2021-01-20  701  	 */
377aede9f10ee2 Megha Dey       2021-01-20  702  	data = kzalloc(sizeof(*data) + hash_key_size, GFP_KERNEL);
                                                        ^^^^^^^^^^^^^^^

377aede9f10ee2 Megha Dey       2021-01-20  703  	if (!data) {
377aede9f10ee2 Megha Dey       2021-01-20  704  		kfree(data);
                                                                ^^^^^^^^^^^^
This is unnecessary.

377aede9f10ee2 Megha Dey       2021-01-20  705  		return -ENOMEM;
377aede9f10ee2 Megha Dey       2021-01-20  706  	}
e845520707f85c Dave Watson     2018-02-14  707  
e845520707f85c Dave Watson     2018-02-14  708  	if (!enc)
e845520707f85c Dave Watson     2018-02-14  709  		left -= auth_tag_len;
e845520707f85c Dave Watson     2018-02-14  710  
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  711  	do_avx = (left >= AVX_GEN2_OPTSIZE);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  712  	do_avx2 = (left >= AVX_GEN4_OPTSIZE);
603f8c3b0dbbe2 Dave Watson     2018-12-10  713  
e845520707f85c Dave Watson     2018-02-14  714  	/* Linearize assoc, if not already linear */
2694e23ffd210c Ard Biesheuvel  2021-01-04  715  	if (req->src->length >= assoclen && req->src->length) {
e845520707f85c Dave Watson     2018-02-14  716  		scatterwalk_start(&assoc_sg_walk, req->src);
e845520707f85c Dave Watson     2018-02-14  717  		assoc = scatterwalk_map(&assoc_sg_walk);
e845520707f85c Dave Watson     2018-02-14  718  	} else {
2694e23ffd210c Ard Biesheuvel  2021-01-04  719  		gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
2694e23ffd210c Ard Biesheuvel  2021-01-04  720  			      GFP_KERNEL : GFP_ATOMIC;
2694e23ffd210c Ard Biesheuvel  2021-01-04  721  
e845520707f85c Dave Watson     2018-02-14  722  		/* assoc can be any length, so must be on heap */
2694e23ffd210c Ard Biesheuvel  2021-01-04  723  		assocmem = kmalloc(assoclen, flags);
e845520707f85c Dave Watson     2018-02-14  724  		if (unlikely(!assocmem))
e845520707f85c Dave Watson     2018-02-14 @725  			return -ENOMEM;

kfree(data) (also below).

e845520707f85c Dave Watson     2018-02-14  726  		assoc = assocmem;
e845520707f85c Dave Watson     2018-02-14  727  
e845520707f85c Dave Watson     2018-02-14  728  		scatterwalk_map_and_copy(assoc, req->src, 0, assoclen, 0);
e845520707f85c Dave Watson     2018-02-14  729  	}
e845520707f85c Dave Watson     2018-02-14  730  
e845520707f85c Dave Watson     2018-02-14  731  	kernel_fpu_begin();
377aede9f10ee2 Megha Dey       2021-01-20  732  
377aede9f10ee2 Megha Dey       2021-01-20  733  	if (static_branch_likely(&gcm_use_avx512) &&
377aede9f10ee2 Megha Dey       2021-01-20  734  				IS_ENABLED(CONFIG_CRYPTO_AES_GCM_AVX512))
377aede9f10ee2 Megha Dey       2021-01-20  735  		aesni_gcm_init_avx_512(aes_ctx, data, iv, hash_subkey, assoc,
377aede9f10ee2 Megha Dey       2021-01-20  736  				       assoclen);
377aede9f10ee2 Megha Dey       2021-01-20  737  	else if (static_branch_likely(&gcm_use_avx2) && do_avx2)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  738  		aesni_gcm_init_avx_gen4(aes_ctx, data, iv, hash_subkey, assoc,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  739  					assoclen);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  740  	else if (static_branch_likely(&gcm_use_avx) && do_avx)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  741  		aesni_gcm_init_avx_gen2(aes_ctx, data, iv, hash_subkey, assoc,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  742  					assoclen);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  743  	else
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  744  		aesni_gcm_init(aes_ctx, data, iv, hash_subkey, assoc, assoclen);
e845520707f85c Dave Watson     2018-02-14  745  	kernel_fpu_end();
e845520707f85c Dave Watson     2018-02-14  746  
e845520707f85c Dave Watson     2018-02-14  747  	if (!assocmem)
e845520707f85c Dave Watson     2018-02-14  748  		scatterwalk_unmap(assoc);
e845520707f85c Dave Watson     2018-02-14  749  	else
e845520707f85c Dave Watson     2018-02-14  750  		kfree(assocmem);
e845520707f85c Dave Watson     2018-02-14  751  
83c83e658863e4 Ard Biesheuvel  2021-01-04  752  	err = enc ? skcipher_walk_aead_encrypt(&walk, req, false)
83c83e658863e4 Ard Biesheuvel  2021-01-04  753  		  : skcipher_walk_aead_decrypt(&walk, req, false);
e845520707f85c Dave Watson     2018-02-14  754  
83c83e658863e4 Ard Biesheuvel  2021-01-04  755  	while (walk.nbytes > 0) {
83c83e658863e4 Ard Biesheuvel  2021-01-04  756  		kernel_fpu_begin();
377aede9f10ee2 Megha Dey       2021-01-20  757  		if (static_branch_likely(&gcm_use_avx512)
377aede9f10ee2 Megha Dey       2021-01-20  758  				&& IS_ENABLED(CONFIG_CRYPTO_AES_GCM_AVX512)) {
377aede9f10ee2 Megha Dey       2021-01-20  759  			if (enc)
377aede9f10ee2 Megha Dey       2021-01-20  760  				aesni_gcm_enc_update_avx_512(aes_ctx, data,
377aede9f10ee2 Megha Dey       2021-01-20  761  							     walk.dst.virt.addr,
377aede9f10ee2 Megha Dey       2021-01-20  762  							     walk.src.virt.addr,
377aede9f10ee2 Megha Dey       2021-01-20  763  							     walk.nbytes);
377aede9f10ee2 Megha Dey       2021-01-20  764  			else
377aede9f10ee2 Megha Dey       2021-01-20  765  				aesni_gcm_dec_update_avx_512(aes_ctx, data,
377aede9f10ee2 Megha Dey       2021-01-20  766  							     walk.dst.virt.addr,
377aede9f10ee2 Megha Dey       2021-01-20  767  							     walk.src.virt.addr,
377aede9f10ee2 Megha Dey       2021-01-20  768  							     walk.nbytes);
377aede9f10ee2 Megha Dey       2021-01-20  769  		} else if (static_branch_likely(&gcm_use_avx2) && do_avx2) {
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  770  			if (enc)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  771  				aesni_gcm_enc_update_avx_gen4(aes_ctx, data,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  772  							      walk.dst.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  773  							      walk.src.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  774  							      walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  775  			else
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  776  				aesni_gcm_dec_update_avx_gen4(aes_ctx, data,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  777  							      walk.dst.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  778  							      walk.src.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  779  							      walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  780  		} else if (static_branch_likely(&gcm_use_avx) && do_avx) {
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  781  			if (enc)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  782  				aesni_gcm_enc_update_avx_gen2(aes_ctx, data,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  783  							      walk.dst.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  784  							      walk.src.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  785  							      walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  786  			else
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  787  				aesni_gcm_dec_update_avx_gen2(aes_ctx, data,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  788  							      walk.dst.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  789  							      walk.src.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  790  							      walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  791  		} else if (enc) {
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  792  			aesni_gcm_enc_update(aes_ctx, data, walk.dst.virt.addr,
83c83e658863e4 Ard Biesheuvel  2021-01-04  793  					     walk.src.virt.addr, walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  794  		} else {
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  795  			aesni_gcm_dec_update(aes_ctx, data, walk.dst.virt.addr,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  796  					     walk.src.virt.addr, walk.nbytes);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  797  		}
83c83e658863e4 Ard Biesheuvel  2021-01-04  798  		kernel_fpu_end();
e845520707f85c Dave Watson     2018-02-14  799  
83c83e658863e4 Ard Biesheuvel  2021-01-04  800  		err = skcipher_walk_done(&walk, 0);
e845520707f85c Dave Watson     2018-02-14  801  	}
e845520707f85c Dave Watson     2018-02-14  802  
83c83e658863e4 Ard Biesheuvel  2021-01-04  803  	if (err)
83c83e658863e4 Ard Biesheuvel  2021-01-04  804  		return err;

Here too.

83c83e658863e4 Ard Biesheuvel  2021-01-04  805  
83c83e658863e4 Ard Biesheuvel  2021-01-04  806  	kernel_fpu_begin();
377aede9f10ee2 Megha Dey       2021-01-20  807  	if (static_branch_likely(&gcm_use_avx512) &&
377aede9f10ee2 Megha Dey       2021-01-20  808  				IS_ENABLED(CONFIG_CRYPTO_AES_GCM_AVX512))
377aede9f10ee2 Megha Dey       2021-01-20  809  		aesni_gcm_finalize_avx_512(aes_ctx, data, auth_tag,
377aede9f10ee2 Megha Dey       2021-01-20  810  					   auth_tag_len);
377aede9f10ee2 Megha Dey       2021-01-20  811  	else if (static_branch_likely(&gcm_use_avx2) && do_avx2)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  812  		aesni_gcm_finalize_avx_gen4(aes_ctx, data, auth_tag,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  813  					    auth_tag_len);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  814  	else if (static_branch_likely(&gcm_use_avx) && do_avx)
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  815  		aesni_gcm_finalize_avx_gen2(aes_ctx, data, auth_tag,
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  816  					    auth_tag_len);
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  817  	else
d6cbf4eaa46794 Ard Biesheuvel  2021-01-04  818  		aesni_gcm_finalize(aes_ctx, data, auth_tag, auth_tag_len);
83c83e658863e4 Ard Biesheuvel  2021-01-04  819  	kernel_fpu_end();
e845520707f85c Dave Watson     2018-02-14  820  
377aede9f10ee2 Megha Dey       2021-01-20  821  	kfree(data);
e845520707f85c Dave Watson     2018-02-14  822  	return 0;
e845520707f85c Dave Watson     2018-02-14  823  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

