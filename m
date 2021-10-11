Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492C9428C57
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhJKLul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:50:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13932 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231659AbhJKLui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:50:38 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BAK2gE004474;
        Mon, 11 Oct 2021 11:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ZACiAeLcB5Wz24zmZrP/1rYwqgLC+5z18JKFO2Jtq/A=;
 b=Os21/5jqYKNdjBSs/Ipk5tPeNMImjSp1qJ3EH8iQAA2hG3Td1mmcekxmhi2BDupB4gza
 5i1SPaEPFdzAPlfmQ+VSWbMoGf8t9lzRjRH1NSVzO6Jnq04uULgjbqaUg8TXvL0TdN6W
 ZARpzqu74FokgdZm0Ryn38UvWv2/VYccre3tVLSt3EEqCdJ5B4cD00XmT9/giMqU4AXX
 ddRlt8vsplseoo1Oim/5KP1snY2e3E8d0Zw6QgJdaD3sFzKj5n+skwOZVFbEQfBoX3yk
 JnumY6IjXlz0uHNVgjuvND9MvWDBoEsRtHjGEC64MIAylC2jpiMl342tcaTenZudQ4Wr Ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bkxs5bju7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 11:48:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19BBj2Zj039169;
        Mon, 11 Oct 2021 11:48:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3020.oracle.com with ESMTP id 3bkyv846cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 11:48:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzTiPsUEIrvzwHokmfCCVQPxImk5CJAC27n2au4lSsNtSzTbIsK5Spl0QHs+vod+tEdJKQj9OisH9FMXZbXxkOa4O4SZjyVJ70BtJOLXWpEgLtkkgaTFq1eL3olF/c6tWg/f3+lrrYoghBr/aj9diWgtt3GpHfj3GvnfcccOh9vUBR9DjANRbFYZ8PYk9mhzmCJOk+L7BKdGbXmuG6rXmfcKilPCyu0OQqKXAS9I9AzbckTZbUQIflf6UU82A676IDfOZBOyQkvkToeB1bHaFWULp1PE9YNxHo/Ddu2TguKHMFSt2mokvc8CkT9We2LUkMusnp9yVJAJBbQdKtD5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZACiAeLcB5Wz24zmZrP/1rYwqgLC+5z18JKFO2Jtq/A=;
 b=ENQUOwZjBcKrb2OafaYATxfeeg0Kf1cYFmyj34uFm+qYWFy8rILfAoprDIKPBi0aiVGcY8dc9JkUnaeQYhY7HBGnwTjj5MB2zqxbjzimbl/U/aS5zvtiM4QqoyUIZ3aZS1sITy1Ucnl3TJmOoYJ5YixmP37DhLkUPZJf8g3ccqRjALchcuIiaer6Bs7M2oXhEuGEjltNexkt2dMUcTtmxRV7PRDEFQxRjjwjBhY2TkGexzwuyCpsvm0D7jSXGt0vkkBMYEy1M8iFHybhO4Cja+AUcGnD/dXqc70HQKPSb+Y1seaHQAbKXM7G1Cwo6p5+O26bknn0UcD2CUHD4MFPZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZACiAeLcB5Wz24zmZrP/1rYwqgLC+5z18JKFO2Jtq/A=;
 b=wr8AGNI9Tih3lQsyAoXIyjkEjTmVLlO8SPEhUjrc86O7Al1/ytWzzq93Fn93HLntGyvNni00PKQ+YuzOUUDKGzzVuvvNaeyZN9PQEkkYiKT61Ojx3jDA2gb/GT28p4j6kTvYSPa1RoxBW8Jbas0aZUG+g43a7XY7ddysXCqmG6w=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4692.namprd10.prod.outlook.com
 (2603:10b6:303:99::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Mon, 11 Oct
 2021 11:48:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 11:48:27 +0000
Date:   Mon, 11 Oct 2021 14:48:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Dani Liberman <dliberman@habana.ai>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>
Subject: [kbuild] [ogabbay:habanalabs-next 17/19]
 drivers/misc/habanalabs/common/command_submission.c:2421 hl_cs_poll_fences()
 error: we previously assumed 'fence' could be null (see line 2402)
Message-ID: <202110111947.2oUxucXl-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: FDHHUW4DVK4G34T6M6JUGOGKBJC6JRBI
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::32)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Mon, 11 Oct 2021 11:48:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22a01ee7-8fcd-4bea-b1fd-08d98cad09c4
X-MS-TrafficTypeDiagnostic: CO1PR10MB4692:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB46925A160800AB965FF4437A8EB59@CO1PR10MB4692.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VRqaLg93iP/z4n4nk4EOQcR4wY2qyC5jPgRWLO+psdG7lq9PJUvJqmgBgDo2pIcPGC2U2/uf1KUFvzPWyiNo1g3SqsphFGSrEXSzL3zs8rd3eIGhJis3CD+8mTbdmWz2hQeIhTecdJThGueZ0F/YXDsx6neVAzrmJUmPzNsCiuNHINtLtSbLxoB3Jyavw9jhPYfNyPOVQx8eMLxsORq4odMChFFPpk7Ml1xx/rVDNmqdqza9p++0oBxRIJlMGPF1dAxHonOirYviasHRW8pHRINmwQ8ioJZ86dhltMIrsUujJOjNWloTHmiNQbsgouxvhqvtdWQD9q33NPNo+7++wwwMfIrt4m3JHFZoGsTkcMJbYy9tXB8db64A/6u3d8nhoclgeQlrwQCHGEJypF4PvUnjzeWPfHVCZjXAHMXzUfX7UfR4J7arEM/bExAWiJ0ihVQUDQF62H22QqSuHwtop7miiqO/Kar1kezw56b02OHQTHaKrUeqJA7DKtNUI9kic8h3uq0m+AUDR4UsJUs8EjUaRR93CZpMrBw+RCo0SVtS2rPxiYTSpRpJG6KVwGPhTVOG9vUNSC+knxXqP8x4nFtpG7ssqQFqQhjIIIEwF7NehtO6B8ouv4ShHZ6SLoxhEp5N7akNpr2N58rAc6+vrfcVGbu+N5czA6gJmjrUfz6UPnvOxbwI3VgWlbakTTd/ojEJVVSegb7opMNDpm5QFjP3sVdjZ68NZ48L15NTHYna6bsO8L+8W/q9EUjmY1h0e6eo8u7G82v4ZxXjjLOeSHNNa2Ps4nefvnOHZMkmM5ERxRCww6Qe++nULH+EidYMm0bffTPd4SeqBjFIKU2fsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(316002)(9686003)(508600001)(38350700002)(38100700002)(956004)(6666004)(966005)(36756003)(1076003)(52116002)(8936002)(2906002)(44832011)(66556008)(4326008)(86362001)(83380400001)(8676002)(186003)(6496006)(30864003)(66946007)(66476007)(6916009)(6486002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bJNhlSVkyhckwJEGeiXaubLUUlEl5luWjYGaWUNTypBeIEGiXnDBeDrcpw1S?=
 =?us-ascii?Q?cllDWH6AlsWWvth6BZAZCpKQc5uSQGAomhNubS6ZdhyY0EehRJNOq8ObJsCW?=
 =?us-ascii?Q?M0HJJl1+Z4Z6lhUtPyzFOP5vIh/v6878CU08ujID4TieK+NF+36AND79G6vJ?=
 =?us-ascii?Q?L9Bz9aXNI414o2MyEH9K64Jivaz2fqMPI873o02Cgkg/nmUUvlaOzlbWa9H+?=
 =?us-ascii?Q?UJz+ZKH1B7Cw4SN0kPdRsmhrzJC0owFDBsgYP+iuHePVMzyydf61Lkm0wSOg?=
 =?us-ascii?Q?NAljb8aGgP1/15QkolNq2xYfKEYYVq1z/8hYn9S+NQflyqmXHgn9/nIGE1Ta?=
 =?us-ascii?Q?yqFKjnNy8//3NHTDAXYAsHVw+0ae6iDTjUAcpWuE4ZrMlAuvtdlSBFZP7SYZ?=
 =?us-ascii?Q?J6xRHVY3IvFpEIV8VRoWI3U9tjqOqekzBHybR+pYtxDS9hpiFQ/rpoZR9+2P?=
 =?us-ascii?Q?zpbvybyY4M6xW7ceL0Qx2fEGLOp1LyRx5Pw5KAOPIhqUKOMh4pOOB4CVJq7r?=
 =?us-ascii?Q?hph/xOi8bw6w19gwOkDw/6Cck8+lsEyMxW6+5+8EGDOX6FZryvH0nbDC+x4p?=
 =?us-ascii?Q?b5XTMU6nql31QafXQcQD+rdWGFINEdaz8WzTQO+0zO6WReRl54AqWi611i4r?=
 =?us-ascii?Q?80lQUIadswAvNepL0WU2zl5GAuc2cOVFOaBHt2qwB3LrTN63nTp3isRy2gnY?=
 =?us-ascii?Q?gCL3WyV1Uep5GBj4cp1kJxDaFdRjeYYOEYZmgBwX17Jvm7kZcRj6HTTy9jdc?=
 =?us-ascii?Q?8LgjTXaqcJvJoK6FcXJRKc+4omJmQfcDt6Lg6WXldlqxKKmir3d6kta2O21W?=
 =?us-ascii?Q?jZKTNqvPz/irZUe5zlvZz15ZnFe9/kQDeGvyeZbdkgPoavARoTP2Qzs6bBDc?=
 =?us-ascii?Q?YH0OpoAG7dWIEtOFvkxuRtkxkv66NOaZIGE3DGhQlhGaFguUDkiFMtdQXGko?=
 =?us-ascii?Q?5PBXLfn2lE3Fi9tIv+9LWGeb1+urgy+VrYfbCzOW19KE+wT/OUpkFPp2ojSq?=
 =?us-ascii?Q?fFh5b815v59/672HC961BpLf9u0KnYDeH7JghlwUd1D+WNYL3NoxVjepChCe?=
 =?us-ascii?Q?2s8A3dGfTGlIPQQEU2SSc4nMsJzdZHjEp6S4nHI7wNlwgJjAuM03GWVECbGf?=
 =?us-ascii?Q?ao5Yi0GDoxEU43ZzDQmsXK1PoENSwxqtZ1LVR6MMbk7kHa8fOhzzlf4GBQ5j?=
 =?us-ascii?Q?xFnIMbJEmhriZmukw+PwEHBf7wsMSD35J8Npop7XK2DO0PN3/o30hOsMjFV+?=
 =?us-ascii?Q?Qs/cjPhwonCw2JMtBd5Q9YRtSiWBYD0eMPm9XT8Ogm8LmixexNx5dNKag+Qv?=
 =?us-ascii?Q?m3oVwTu646ZSZFUwdlE5t9ii?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a01ee7-8fcd-4bea-b1fd-08d98cad09c4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 11:48:27.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDBczXtILQ+Uq4J8qDBR52dhZDJANn/Ja7kzdmUP+H3dc96mI9flS6bPGBTXZlVoQhrt5NHM/ULrosn2onUjgvoI4RxYDf5MB2PtG1YEhUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4692
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10133 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110067
X-Proofpoint-GUID: fVtCzCixMr338U0KBvmI0Az7zXZWTMdf
X-Proofpoint-ORIG-GUID: fVtCzCixMr338U0KBvmI0Az7zXZWTMdf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git  habanalabs-next
head:   41548e6097f0e2673e99c18aa74c9bbba341c9ba
commit: 2819e6243c5cdf6619cdaddaf117076a043d7bb2 [17/19] habanalabs: fix NULL pointer dereference
config: x86_64-randconfig-m001-20211011 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/misc/habanalabs/common/command_submission.c:2421 hl_cs_poll_fences() error: we previously assumed 'fence' could be null (see line 2402)

vim +/fence +2421 drivers/misc/habanalabs/common/command_submission.c

215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2346  static int hl_cs_poll_fences(struct multi_cs_data *mcs_data)
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2347  {
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2348  	struct hl_fence **fence_ptr = mcs_data->fence_arr;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2349  	struct hl_device *hdev = mcs_data->ctx->hdev;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2350  	int i, rc, arr_len = mcs_data->arr_len;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2351  	u64 *seq_arr = mcs_data->seq_arr;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2352  	ktime_t max_ktime, first_cs_time;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2353  	enum hl_cs_wait_status status;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2354  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2355  	memset(fence_ptr, 0, arr_len * sizeof(*fence_ptr));
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2356  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2357  	/* get all fences under the same lock */
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2358  	rc = hl_ctx_get_fences(mcs_data->ctx, seq_arr, fence_ptr, arr_len);
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2359  	if (rc)
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2360  		return rc;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2361  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2362  	/*
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2363  	 * set to maximum time to verify timestamp is valid: if at the end
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2364  	 * this value is maintained- no timestamp was updated
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2365  	 */
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2366  	max_ktime = ktime_set(KTIME_SEC_MAX, 0);
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2367  	first_cs_time = max_ktime;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2368  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2369  	for (i = 0; i < arr_len; i++, fence_ptr++) {
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2370  		struct hl_fence *fence = *fence_ptr;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2371  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2372  		/*
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2373  		 * function won't sleep as it is called with timeout 0 (i.e.
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2374  		 * poll the fence)
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2375  		 */
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2376  		rc = hl_wait_for_fence(mcs_data->ctx, seq_arr[i], fence,
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2377  						&status, 0, NULL);
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2378  		if (rc) {
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2379  			dev_err(hdev->dev,
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2380  				"wait_for_fence error :%d for CS seq %llu\n",
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2381  								rc, seq_arr[i]);
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2382  			break;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2383  		}
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2384  
2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2385  		/*
2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2386  		 * It is possible to get an old sequence numbers from user
2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2387  		 * which related to already completed CSs and their fences
2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2388  		 * already gone. In this case, no need to consider its QID for
2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2389  		 * mcs completion.
2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2390  		 */
2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2391  		if (fence)
                                                                                                                    ^^^^^
2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2392  			mcs_data->stream_master_qid_map |=
2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2393  					fence->stream_master_qid_map;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2394  
f0d5ad46a0eba1 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2395  		/*
f0d5ad46a0eba1 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2396  		 * Using mcs_handling_done to avoid possibility of mcs_data
f0d5ad46a0eba1 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2397  		 * returns to user indicating CS completed before it finished
f0d5ad46a0eba1 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2398  		 * all of its mcs handling, to avoid race the next time the
f0d5ad46a0eba1 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2399  		 * user waits for mcs.
f0d5ad46a0eba1 drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-03  2400  		 */
2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06  2401  		if (status == CS_WAIT_STATUS_BUSY ||
2819e6243c5cdf drivers/misc/habanalabs/common/command_submission.c Dani Liberman 2021-10-06 @2402  				(fence && !fence->mcs_handling_done))
                                                                                                                                 ^^^^^
Checks for NULL


215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2403  			continue;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2404  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2405  		mcs_data->completion_bitmap |= BIT(i);
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2406  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2407  		/*
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2408  		 * best effort to extract timestamp. few notes:
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2409  		 * - if even single fence is gone we cannot extract timestamp
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2410  		 *   (as fence not exist anymore)
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2411  		 * - for all completed CSs we take the earliest timestamp.
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2412  		 *   for this we have to validate that:
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2413  		 *       1. given timestamp was indeed set
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2414  		 *       2. the timestamp is earliest of all timestamps so far
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2415  		 */
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2416  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2417  		if (status == CS_WAIT_STATUS_GONE) {
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2418  			mcs_data->update_ts = false;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2419  			mcs_data->gone_cs = true;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2420  		} else if (mcs_data->update_ts &&
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14 @2421  			(ktime_compare(fence->timestamp,
                                                                                                                                       ^^^^^^^
Unchecked dereferences.

215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2422  						ktime_set(0, 0)) > 0) &&
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2423  			(ktime_compare(fence->timestamp, first_cs_time) < 0)) {
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2424  			first_cs_time = fence->timestamp;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2425  		}
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2426  	}
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2427  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2428  	hl_fences_put(mcs_data->fence_arr, arr_len);
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2429  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2430  	if (mcs_data->update_ts &&
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2431  			(ktime_compare(first_cs_time, max_ktime) != 0))
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2432  		mcs_data->timestamp = ktime_to_ns(first_cs_time);
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2433  
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2434  	return rc;
215f0c1775d550 drivers/misc/habanalabs/common/command_submission.c Ohad Sharabi  2021-06-14  2435  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

