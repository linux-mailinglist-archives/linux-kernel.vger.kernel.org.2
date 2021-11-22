Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8866E458D20
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbhKVLR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:17:59 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39588 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234647AbhKVLR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:17:58 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMAOkvB024905;
        Mon, 22 Nov 2021 11:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=dIdBNzMhKdt92ABflY8TqPqbgd06JSjGEZA2VdH7u5U=;
 b=yM8KRQhuSfd3cMQMas+/a4368sL5Q2foCefX6Ljrf2MK776XSm1T/MkgmBHvAOoPofFR
 S2ajzxlbopruGNRnmSTylUu1bcYTZWfoG5mo/dQhuGFYWxOQxg4RDv+ShYVFvbxO5Ij3
 CTrE1Hj3sDZnlI7Y1c895sXBisrz4IO9DTFJGsYL0hOagXVdINp66K0X4DdxtdRsO8qJ
 LckP++uOXXnZjmiRSybT6rgpt3EiKWPmfug3V4JYLfDBAO5yWRVMciZCWWfrsRlV1coB
 qGdjRrgdUdcDfoPuAvGa2Ag+fLEKRLy0aq9pmm1C0UEqaqEPj9u5YwdBY+bl1zyXCuqs 7Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg69m94qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 11:14:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AMBAh14053428;
        Mon, 22 Nov 2021 11:14:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3030.oracle.com with ESMTP id 3ceq2cebsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 11:14:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6OiUUsXCEsqmaL8Ky0vYfVpiB6CF4xwreCvoGnCBo4cFattMneyjVpN+m5UMm9WPLKfmaZTq/+4Z0snQE8BP6yidCc20ylKkakHcc4YzNnrWMt8rz4KOo/QQDUVq+px+FgQXv4r1YsuevS+fXYeiqj8xYMaVvl/L2h+l7AfWP/S7aLtBJV+73H3gqzZfK0QxFp3DBhh/RbjVbuVOMJJAtrNqDwPZAm5mn8T7E9olx7iBCcvFfxVnAKuTXnrQEv2k6q0qkgJd2G9XdqOUBkq5nAiV8j1MyiENxztH6w32UIRw132AvFWR8hq69aSrnTWrOoerQJLNy3CRr7dLMWuyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIdBNzMhKdt92ABflY8TqPqbgd06JSjGEZA2VdH7u5U=;
 b=LO3M1lWAt4rfBRJhw32nhcphZqcZtZ9cFqkmnQwEysiY2JsotT3BTce4Iy2Rk17sUFs+WVjxB6g/bEzLgINpxBvPtDNM/DJk3OIYMYF6UaQ/VBT4Ta96MOMlil2W4eoXWBL0OGyHmFh7Wxf88pDAn3r+dZ6J6QsdevJlKkcFLXuJzSWXzuboTnkuGnIUikvHZwO46UFi75d8eZPOSEjFKz1SXwH/R2vwdlCMOUy1tSKmc1m2PWGAwuevxSjA+BbdSQSEL6HH7GE+GmB1DUapbVmKSSxjzEt5omb4PXSPQMfLnpZqP+gy8FyYtfMWpJ3WpkRTTX+JR+ufTMe+5GAdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIdBNzMhKdt92ABflY8TqPqbgd06JSjGEZA2VdH7u5U=;
 b=BrLxmgwzBGVXurvh8b1vHKGKRVNDn2RqOm7iLH+k4WvbjCRMIbfVXHiR0b9ThADNsaCyjHzfAX9ljozTGdyFmRxfmOH0uU6cLUlLwQWW22w571yVdLx+7J3Us18yVoHmfZTCsGDfpxlCZzjYD9HxXWXCgVCCXCtWUIYwAVIb3Ik=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2208.namprd10.prod.outlook.com
 (2603:10b6:301:2c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 11:14:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682%6]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 11:14:46 +0000
Date:   Mon, 22 Nov 2021 14:14:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Johannes Berg <johannes.berg@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: drivers/net/wireless/intel/iwlwifi/pcie/drv.c:1353 iwl_pci_probe()
 warn: missing error code 'ret'
Message-ID: <202111211855.at1xbk20-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 11:14:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14b970f8-cc13-4050-68ed-08d9ada949a4
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2208:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB22084E60D9CB6B2FDCCFC33D8E9F9@MWHPR1001MB2208.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:334;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SMZLYcZSwOCFUj9hHs+vrI7iGaQa9z9Jl1Y3Nki/Vqcy5fksKpNjLg8cVF5wqddRNw67fHVnccnV44tMFmv6oPwLRhZpr3eo+c/T6RMB54O3GQtofLO+bmorx+giIvbedONTWdMg1nnZLA5BEQXGzJC2nVFO6c0KL1VMtXMtjydX5rvlUGjUaEvVIDXvnWJNDHHzwtawM83v6VNLnOQl1YT8unyFKa9dl3Auuxtyj9TCPJarGaHhgEzk2Wmdd+torMC3E3ncx57/g9z90DbkPrPVFqwnji6/AMfeQrXr548txKOmzbFl60m5lgLvKtkUXxhtUOhcHN6oGZ5IT4DtrgdZACOvJPvJi7SJPqViLnBbR0u2WJbhTUpWq272eLq73ANsowtwkhpjyhWwYIqqREsBMYo4amjSZ82CwlRAUHFVDfN6sdjLDZbFnJoZtePGQuac4YWy7QqR4xsXwSlbnSyHXPpki/Meg1G8rsmQrqAiQBXBGJK6Q0TO9Fq9OhRajoSMv/4H87iQipVnNzQ9GcqNG3qaCI+5e6y6IzskqsGSc/Cf5PW+axYBzcF+pq19NX1xy9VZiJIuKJ+Uwk3oxBL99xMR7nkY0Cu723ybRj6+cr6cd8PBtLoPfb4/qPqY+7fSmuzR7pjUEj4sIujva1W5F9+HmN0OnyvFcc0uk3JpyKJ5VQhCbeL2W4BVlBF7nwoG01lXz8+dmp8wiWO7Vk07czqie3gS/TJPNWkKIGLsWcVZwErZMLHhk9k1SC831knhaN2QfPgNcUbvgTa95DxLaIKQCdCadkGZb6ifK9oCJDwxzlpOr8wbW7n0DX012iXrftIO4s3ftpaib5Z8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(38100700002)(38350700002)(6916009)(956004)(30864003)(26005)(966005)(186003)(86362001)(6486002)(1076003)(6666004)(8676002)(83380400001)(508600001)(37006003)(4326008)(36756003)(2906002)(66476007)(5660300002)(9686003)(8936002)(66556008)(6496006)(44832011)(66946007)(316002)(4001150100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P0M3qAi38cgbqS2de5u0bb8JCAWkecjh9tUYQA88TUasumY+nDvlp/1N+fjn?=
 =?us-ascii?Q?H0pkC4uMuSQAkRVBIobqWKB4fgAjQRBEbODVjeZCIG/+x7Ot82nlAWgzqNZU?=
 =?us-ascii?Q?gpOUl58pgYDlwl0duacmn63Wp9bk39/fMopbXeO3XP8IuIKoKNGcDFxMcjOD?=
 =?us-ascii?Q?X7PHTjTcMWrFFUP2Ly5SGmxrDFJjstwM97yMKUnSaMoHXP8YZGtPpFTv2q3n?=
 =?us-ascii?Q?hGkSuNxPxu1Jg+FAE3NzsvnaR1g21HhriQUHMoir7LRDIkck98/yYIuE3Ds7?=
 =?us-ascii?Q?DP0jVCrEjhS+hnnSSSWXCOuGLggRbEDX5Cns00AFF70PsHdZ154KVNUU9ATl?=
 =?us-ascii?Q?AgqvzKcmnyD3fAIkalTmPfxGTFH0h/TDyJV9S2V+auFx7X1qV5YzJp9y77jm?=
 =?us-ascii?Q?dR3rd6SZ0y7w3Ivxo1UXtG4amOsVVeTvcpOwrP0PGdcRY73LKxaMEpJ0mk5S?=
 =?us-ascii?Q?KHSwAkWekPbeR4qjZypH27d3WBAAUr+4xmXC5nzIUz5DzZxVm2XcA2PBzgJ2?=
 =?us-ascii?Q?ZTqRLDINfDDfG3MDo6e7A0vd95/eWy2AzpdY8awz5SuMrkOHSa9e4WWD5HgH?=
 =?us-ascii?Q?r+06T64xmXAWO1WL4qiPvT/efdekW4ofv4T8hBpvyaPDuNEGlV8MfTwhIBmO?=
 =?us-ascii?Q?mwZa36vX2gwKMthWGP3SFo2E/wf9EPcNNOz5UqYXK8Z2R8alJwKLYCJeKrLC?=
 =?us-ascii?Q?8PinXMi35tVAFMlQJfLp9cs1PJE/Y92GdMso/o4W6DjGOk/sLTgs4W9W1XXR?=
 =?us-ascii?Q?udu/+WBqng25LVXhH1viuF6hofeBBpOb/PIkpg3PAXly98Xwg7veqGbyfqGF?=
 =?us-ascii?Q?lT6xaLVlVb0eFyfXZqGXfJDD1ZAfkSyzND209T4AVqTFa3q7/CLMkuPlUSO2?=
 =?us-ascii?Q?nPiE91IX6vg5mQ+gJ2wBKzS0DJpkEsReRYjiXFYyTA1lxUNLYq1zmM6UTaDu?=
 =?us-ascii?Q?lec0IsShGpvuYsaEjwY1svMYHz7giGlxpN+HgdlxeRIukJRn1m8M/dfDBkk0?=
 =?us-ascii?Q?pCA+hnIRFcBjuMtvtkvunxK06I8IhGWId6082/ueXUeL0wf8Is5sq80b0KGu?=
 =?us-ascii?Q?JfphRQ9cL2j40EQLucuRLJe+DyUAfX5J2BdNgB5UKiK/i2ccOF/ILCsBafR1?=
 =?us-ascii?Q?uIhaQz2JeYWnBLqxkpfYmAczoSV4FvURqtVmL32HMR4pWxe+LlR3j/viHuaW?=
 =?us-ascii?Q?XZsGxM/XQM87mMNde1HbR42wvowV3qMkmafcgK/UkHAlGUkM1bDprI7vOyGM?=
 =?us-ascii?Q?jMK+WQellVA+sHSu4mAttHy/Ksi72G03wSFY++rpLi3IRKdORJ9JhHF9y26Y?=
 =?us-ascii?Q?WU/Gff9CwGNn9k7gUpkqRV9TkldkR5u++iAyUH5h2Q1xJQNpHAvRbYFxl9+v?=
 =?us-ascii?Q?7hWKN1u3+pk0U6W3M4jg8Mn9PCC/KULAmoh6kj8oOfm7iFsJ7bdoMPo/kMXL?=
 =?us-ascii?Q?UJ819brWBzjbCOke/zC5I6FSDOxziQTm/6pusaDcfEynLFObWlUevPnAxx1W?=
 =?us-ascii?Q?72XU0KBOS66DviYMOEuWHd8trFTV4+USjX8ub+gi0d4vpblHdTt/aOaxYeDP?=
 =?us-ascii?Q?WjgD1nwVi1a13EXITF/MMwlyTgVaJ7qCpuulEf28fPUZH7QGZULfYOFdCMqf?=
 =?us-ascii?Q?bxhONeaVRFkgGKXl5VLUNVTOjRu4ZGOj4C/O32MdfzZ4N43mTUk1PJ8fgMGr?=
 =?us-ascii?Q?2jHgdY8681b3q8kiTMjSpmzCc2A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b970f8-cc13-4050-68ed-08d9ada949a4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 11:14:46.0587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSUDrTdlc0PhjL0nin87opsAQjCY/NTqRM1qeSbtdv2olT7tXe3lEQtysNg5rfQZVpTluNEgmsU+z/C87f4vUboXMcKwI29mz1YmsmFBueg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2208
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111220059
X-Proofpoint-GUID: 6tLpqiGXT_8IgXwPwBzrnhNRPYx0itrb
X-Proofpoint-ORIG-GUID: 6tLpqiGXT_8IgXwPwBzrnhNRPYx0itrb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   923dcc5eb0c111eccd51cc7ce1658537e3c38b25
commit: 2fd8aaaeb87441e2577e8e55373e9b3b221dc4b0 iwlwifi: pcie: try to grab NIC access early
config: mips-randconfig-m031-20211104 (attached as .config)
compiler: mips-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/wireless/intel/iwlwifi/pcie/drv.c:1353 iwl_pci_probe() warn: missing error code 'ret'

vim +/ret +1353 drivers/net/wireless/intel/iwlwifi/pcie/drv.c

48d1a2110ad9cb drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach 2011-05-24  1297  static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
48d1a2110ad9cb drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach 2011-05-24  1298  {
48a5494d6a4cb5 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-03-30  1299  	const struct iwl_cfg_trans_params *trans;
3fd0d3c170ad6b drivers/net/wireless/iwlwifi/pcie/drv.c       Johannes Berg     2014-11-18  1300  	const struct iwl_cfg *cfg_7265d __maybe_unused = NULL;
36a79223c4b998 drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach 2012-02-27  1301  	struct iwl_trans *iwl_trans;
c042f0c77f3df3 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2019-09-27  1302  	struct iwl_trans_pcie *trans_pcie;
2a612a60ab440e drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-10-10  1303  	int i, ret;
48a5494d6a4cb5 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-03-30  1304  	const struct iwl_cfg *cfg;
48a5494d6a4cb5 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-03-30  1305  
48a5494d6a4cb5 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-03-30  1306  	trans = (void *)(ent->driver_data & ~TRANS_CFG_MARKER);
48a5494d6a4cb5 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-03-30  1307  
b3bd6416fc77b5 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-10-10  1308  	/*
b3bd6416fc77b5 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-10-10  1309  	 * This is needed for backwards compatibility with the old
b3bd6416fc77b5 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-10-10  1310  	 * tables, so we don't need to change all the config structs
b3bd6416fc77b5 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-10-10  1311  	 * at the same time.  The cfg is used to compare with the old
b3bd6416fc77b5 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-10-10  1312  	 * full cfg structs.
b3bd6416fc77b5 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-10-10  1313  	 */
48a5494d6a4cb5 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-03-30  1314  	cfg = (void *)(ent->driver_data & ~TRANS_CFG_MARKER);
a48709c5d076aa drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach 2011-05-31  1315  
b3bd6416fc77b5 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-10-10  1316  	/* make sure trans is the first element in iwl_cfg */
b3bd6416fc77b5 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-10-10  1317  	BUILD_BUG_ON(offsetof(struct iwl_cfg, trans));
a48709c5d076aa drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach 2011-05-31  1318  
b3bd6416fc77b5 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-10-10  1319  	iwl_trans = iwl_trans_pcie_alloc(pdev, ent, trans);
6965a3540a4b45 drivers/net/wireless/iwlwifi/pcie/drv.c       Luciano Coelho    2013-08-10  1320  	if (IS_ERR(iwl_trans))
6965a3540a4b45 drivers/net/wireless/iwlwifi/pcie/drv.c       Luciano Coelho    2013-08-10  1321  		return PTR_ERR(iwl_trans);
b52e7ea109cfe4 drivers/net/wireless/iwlwifi/iwl-pci.c        Emmanuel Grumbach 2012-02-02  1322  
c042f0c77f3df3 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2019-09-27  1323  	trans_pcie = IWL_TRANS_GET_PCIE_TRANS(iwl_trans);
c042f0c77f3df3 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2019-09-27  1324  
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1325  	/*
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1326  	 * Let's try to grab NIC access early here. Sometimes, NICs may
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1327  	 * fail to initialize, and if that happens it's better if we see
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1328  	 * issues early on (and can reprobe, per the logic inside), than
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1329  	 * first trying to load the firmware etc. and potentially only
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1330  	 * detecting any problems when the first interface is brought up.
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1331  	 */
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1332  	ret = iwl_finish_nic_init(iwl_trans);
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1333  	if (ret)
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1334  		goto out_free_trans;
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1335  	if (iwl_trans_grab_nic_access(iwl_trans)) {
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1336  		/* all good */
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1337  		iwl_trans_release_nic_access(iwl_trans);
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1338  	} else {
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1339  		ret = -EIO;
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1340  		goto out_free_trans;
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1341  	}
2fd8aaaeb87441 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Johannes Berg     2021-10-17  1342  
d6f2134a383168 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1343  	iwl_trans->hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
d6f2134a383168 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1344  
1f171f4f1437f7 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Matti Gottlieb    2021-08-26  1345  	/*
1f171f4f1437f7 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Matti Gottlieb    2021-08-26  1346  	 * The RF_ID is set to zero in blank OTP so read version to
1f171f4f1437f7 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Matti Gottlieb    2021-08-26  1347  	 * extract the RF_ID.
1f171f4f1437f7 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Matti Gottlieb    2021-08-26  1348  	 * This is relevant only for family 9000 and up.
1f171f4f1437f7 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Matti Gottlieb    2021-08-26  1349  	 */
1f171f4f1437f7 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Matti Gottlieb    2021-08-26  1350  	if (iwl_trans->trans_cfg->rf_id &&
1f171f4f1437f7 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Matti Gottlieb    2021-08-26  1351  	    iwl_trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_9000 &&
1f171f4f1437f7 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Matti Gottlieb    2021-08-26  1352  	    !CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id) && get_crf_id(iwl_trans))
1f171f4f1437f7 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Matti Gottlieb    2021-08-26 @1353  		goto out_free_trans;


Should this be an error?  If not the way to express this clearly and
silence the false positive is to set the error code explicitly:

 	if (iwl_trans->trans_cfg->rf_id &&
 	    iwl_trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_9000 &&
  	    !CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id) && get_crf_id(iwl_trans)) {
		ret = 0;
  		goto out_free_trans;
	}

1f171f4f1437f7 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Matti Gottlieb    2021-08-26  1354  
2a612a60ab440e drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-10-10  1355  	for (i = 0; i < ARRAY_SIZE(iwl_dev_info_table); i++) {
2a612a60ab440e drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-10-10  1356  		const struct iwl_dev_info *dev_info = &iwl_dev_info_table[i];
d6f2134a383168 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1357  		if ((dev_info->device == (u16)IWL_CFG_ANY ||
2a612a60ab440e drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-10-10  1358  		     dev_info->device == pdev->device) &&
d6f2134a383168 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1359  		    (dev_info->subdevice == (u16)IWL_CFG_ANY ||
d6f2134a383168 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1360  		     dev_info->subdevice == pdev->subsystem_device) &&
d6f2134a383168 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1361  		    (dev_info->mac_type == (u16)IWL_CFG_ANY ||
d6f2134a383168 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1362  		     dev_info->mac_type ==
d6f2134a383168 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1363  		     CSR_HW_REV_TYPE(iwl_trans->hw_rev)) &&
be2f6886a34eb1 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-11-04  1364  		    (dev_info->mac_step == (u8)IWL_CFG_ANY ||
be2f6886a34eb1 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-11-04  1365  		     dev_info->mac_step ==
be2f6886a34eb1 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-11-04  1366  		     CSR_HW_REV_STEP(iwl_trans->hw_rev)) &&
d6f2134a383168 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1367  		    (dev_info->rf_type == (u16)IWL_CFG_ANY ||
d6f2134a383168 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1368  		     dev_info->rf_type ==
d6f2134a383168 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1369  		     CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id)) &&
b964bfd048d3ab drivers/net/wireless/intel/iwlwifi/pcie/drv.c Matti Gottlieb    2021-02-10  1370  		    (dev_info->cdb == IWL_CFG_NO_CDB ||
b964bfd048d3ab drivers/net/wireless/intel/iwlwifi/pcie/drv.c Matti Gottlieb    2021-02-10  1371  		     CSR_HW_RFID_IS_CDB(iwl_trans->hw_rf_id)) &&
f673a193d56ea0 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1372  		    (dev_info->rf_id == (u8)IWL_CFG_ANY ||
f673a193d56ea0 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1373  		     dev_info->rf_id ==
f673a193d56ea0 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1374  		     IWL_SUBDEVICE_RF_ID(pdev->subsystem_device)) &&
d6f2134a383168 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1375  		    (dev_info->no_160 == (u8)IWL_CFG_ANY ||
d6f2134a383168 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1376  		     dev_info->no_160 ==
95939551e28c9b drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1377  		     IWL_SUBDEVICE_NO_160(pdev->subsystem_device)) &&
95939551e28c9b drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1378  		    (dev_info->cores == (u8)IWL_CFG_ANY ||
95939551e28c9b drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1379  		     dev_info->cores ==
95939551e28c9b drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2020-03-09  1380  		     IWL_SUBDEVICE_CORES(pdev->subsystem_device))) {
2a612a60ab440e drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-10-10  1381  			iwl_trans->cfg = dev_info->cfg;
0b295a1eb81f37 drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-10-10  1382  			iwl_trans->name = dev_info->name;
2a612a60ab440e drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-10-10  1383  		}
7d34a7d7da97bc drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-07-12  1384  	}
7d34a7d7da97bc drivers/net/wireless/intel/iwlwifi/pcie/drv.c Luca Coelho       2019-07-12  1385  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

