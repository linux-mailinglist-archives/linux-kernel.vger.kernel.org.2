Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD38E3BBACA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 12:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhGEKIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 06:08:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1704 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230421AbhGEKIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 06:08:10 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165A1uJE024122;
        Mon, 5 Jul 2021 10:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=5WtdkYGsYWaBf0at4jEnCbjwxzyJWameS3zeyQdip8g=;
 b=WajIMqhxVO2dHHlGOCWRDZikvg8BsEJT8VnOpYxa5GZ+3oayjCzbvauTZ6dnqhP519PW
 ieFHnwQDyUax78g1RJyzeeSnt8+y9AmJ82HUWAbQZdiYfftioT9h106f3invTBOXZPyy
 z05QOnyPu9I1N24QymUwKcTjrDXjz13iRpIE2UxwFR7Qm8ags2F9ZHq0TeMgwePtTZF0
 4GUI2YAXZ/naSsZsKczWnas9TUbkXrKHkUjqFCudoMU/aPXzQmfSq+j044PbYHws4pAY
 /GdNXsXBiMyt9FX8C64F/ZI7S4dBxsAs3TuD8svCzeKmwFGrmnqZ+Rz2Hakx4Vbdynex 6Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jgesa7uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 10:05:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 165A00TD161940;
        Mon, 5 Jul 2021 10:05:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 39jd0y6teg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 10:05:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvhao3PpOiivDQ4xB+J0B43cEeDUn2FXDCRdMrfNITxIe13yiaClG93P/7r4BQ5PegDIyjHYfnbpn4ykn1G3LGQahMWUY0LMiuEUYkLSfgcXVjXJSUFN093GCYj5LXe3MFPY0LvARsjR18btXyF8yPFJwLGUz+jbZxleZ1rvKIgrlEn51tkynQ/bAHTH4iHtzWd9shSUe9k57LngTMFsfDwlWR09zLUz7/sZ3xXY4/51dCI8Pcyao9e7VikH2g5iJu2WxNdb7eJGjb/4TzPXVskn2f2b5NDRzkaLey8YvTMyfFM7SuihJYDn1DF9S0PWcMZhzCpv2o4ljw6kcE4wDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WtdkYGsYWaBf0at4jEnCbjwxzyJWameS3zeyQdip8g=;
 b=mjQZztTapFwur9zkLRan2WwMWqlRuO06bsTyriU6Bw3caJKglloSTtqYVo05Ky2v+lzthRCQeLveFt5o4G8KOmLc1f1IBOBO8gqzl0Q9ZM425tnAtfqNz+TfFGy+rkscirC2b6PdApmur6w0YTO2HejRwCZLeM4iwk4f4DZDDXbmYU/SwudDfII9WPvGGiVZN2b2PewT3rCIIjiPoICW49cgzvT2PNVacqt1HD7pI9ivniA4hf6dhWhSYNQEYJBuUXqO0c9aFski8g1k/jUc8z4nDF/KBoq/V89cs2Bgw8Zm9YVnyBndNdiXNX61zcc2G9jrS3SIrn1FhuOywXNozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WtdkYGsYWaBf0at4jEnCbjwxzyJWameS3zeyQdip8g=;
 b=lvwfdWVTQealox+aV9HykRxExXVP2qbGs5fY3DpOOYn3/mn7ZJCg16o8P557CXKJ94ZcBPiP2Z4Fvuixti///rrv5xXB993EMS18ZSeBTdW6FakcfNlnMZ5CXZIk3qm2pW0b1WhDaWXCc6Y+ME/o8zJ89xdjCNMyUMZBx9o8JYE=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1886.namprd10.prod.outlook.com
 (2603:10b6:300:10e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.29; Mon, 5 Jul
 2021 10:05:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 10:05:28 +0000
Date:   Mon, 5 Jul 2021 13:05:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Tong Zhang <ztong0001@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/wan/lmc/lmc_main.c:947 lmc_init_one() warn: 'dev' not
 released on lines: 903.
Message-ID: <202107051739.oCYoztzM-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [102.222.70.252]
X-ClientProxiedBy: JN2P275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 10:05:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d6e83e9-fb41-4064-8ab2-08d93f9c6a2b
X-MS-TrafficTypeDiagnostic: MWHPR10MB1886:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1886CA5EDD1BD3682D62D6C28E1C9@MWHPR10MB1886.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yS2Wy1A9Ld1EuYshrjhRTH/ixbvjHTtTsxhMtQUDBcMNzY1VFKgOoVQ/JO1zwtjoy7ian203wz03ncW8SBALADm/NtFbzN2RprAYpMvLRUrykko8YahFskpLfotkAieVjxhf+VWDduWAUj3yClnybknzwQgfraSou9w7nFAI7Vk6XbMcWritgHW9zpYbEHGYstrbZXtj82s9KtsUZligot2ZGZ6Kov1PMMn8DwsnlJl0zdrr3baU0Bw75QL0oauWOnltibiv7FTbMiX+Vc2+5y6kYEpVkPOTh3/sLdp4T1o35BEMhx3XnKsXJak1x/EzUbOujzaRcwO4RJ5qnOaH5H95rQo+KSlhyzilJpfXkjK3JtRreNLFQE2mRgqEKuiGu378e4JZmGdR9Fs4dUhB5GxS/D3kvj9YCxxeQCTODS55d32bUR7AD63FpA6tDytrshJ6TTOwP2XYHYyYs6nBQcY53JGakGIp3Y1GsyIJSAfKwc8wLxgcxJ1BxoHMO3Ct1TGvg+sWFtYSGJN35j9iq+3OtP7xyxqCs49v9X74D/Afmx581X2YFxmtxw1VwvrBU277kLOk+3bNn3QbxB60oKTpLnjtzs8GAY4NgR6hQjLsO7ZHSdrPIMx5RmtIuATGoEMr8n9+D2PAKnUwTCFnqFSsdi5KcSdjXL7GWQTuFSiTApVEeJ5a7oWZkxJHWg1o093LOmP5hExxMoDjaFOmoF74gTV7LTXawm8/5J7E4ElrQgLpM2hVAcLkpmlzJOwKQ3rhhd5RI3m6w/C46HQfEopYb8E4ksZ8+SuQ9ZwaTUBtzjOR2NNFt1yhvV7J7JQ7X8peaRJ4mHS92RqpszJGVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(39860400002)(346002)(376002)(8676002)(9686003)(52116002)(966005)(86362001)(6496006)(26005)(8936002)(6916009)(478600001)(6486002)(36756003)(30864003)(316002)(44832011)(83380400001)(956004)(66574015)(4326008)(186003)(1076003)(38100700002)(38350700002)(2906002)(16526019)(5660300002)(6666004)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmNLRk5qTmFEVnErU3N3RmpsSVBvaTYvbURYZThlQk8yYUd6amhDRFRCK2lH?=
 =?utf-8?B?LzZ6U2MvK0UyeVdPUFUrSXBmblNlT3BkdmU5ZCtEMHpiK21Lczh3NHQ1VVA2?=
 =?utf-8?B?RVdGdXkzR3UybzdJSk9sNmdwK0FnQnNzNE1jeTJEZXhiaUdnUWwzK2NUaHRV?=
 =?utf-8?B?QVNTTkFiemdEbUtSMVMvKzRSdDdiZzVOZUZSdlgrSUZTUEl0UVJMcU1EMHpP?=
 =?utf-8?B?WjU1REQvVVhpdUQxZkVYWFJHQ3pIRXRmK1F6d29VNzJEb0FFQjVKekNSNzhy?=
 =?utf-8?B?QUJwVEp1QzQvbzJjK0VmM1ZxbWcrek8ybFJUMlBRMmVaUWI3SUpGcXZzWTgx?=
 =?utf-8?B?MnZDTmZoU0ljSENlbjdaMWRTRktldWEwQjJZY3grK1ZKSGVzREFvYWZ5SXFW?=
 =?utf-8?B?ekgwclo1bCtYNEE2RlZneHYwWVlWKzc4dDBUZ3krQkFUOGhRTUFaL3hENCtl?=
 =?utf-8?B?aGZOeldNd041dW1RNEdpenR0ZDlmZ2hJVjZhVkFnaDU0OUlENlpvQ09ZQ2RM?=
 =?utf-8?B?Rk5mS2dFWU5YT0lxSnBRNHNHKzA0VElDWXNLc2l1WlBKYUNBMmo5c1htMkI1?=
 =?utf-8?B?b0JMMEs3QlJjYldYS1BqM2N6N2o0bEswRVVuVmlTSmQ3TU0zMWxGNHprNWg3?=
 =?utf-8?B?VzhodGZOaFROTHFpREwzbGt4N1JNLzF6blEzQk5ONFBuYUZxSjBoVEhrYzYv?=
 =?utf-8?B?SDY4Qy9sSzhqR0JSbGxVazMycDFTb2F6am9odCtNMEN6a2lFZW13SklqeDAy?=
 =?utf-8?B?U3NFd2FHbXMvMkpkdXR5c0pYTkhBUFdLa0hKZDNmT3hBWWhRaDY1NlpEalpK?=
 =?utf-8?B?QkltUzRRV3dTeDZSM0pxdTNJN3lkUUZtc0R2Tjh3YWxWUi83RTljNG1Nb1lh?=
 =?utf-8?B?TDBZNjc5dFJYQy91NmhiQnRKRlF0OWgvVklDbjkzZ09OclJoTkpNRWpPRTNo?=
 =?utf-8?B?Yjd4cU1sR2hOdURxWlFqUjZUQmxVSkRMSnFIOGgxcWtFUTZTbldyTHkwMWJj?=
 =?utf-8?B?UEFudDJiNldsdDV5YXJSOEcyUU5NWHVsSmRuaU8wYSsvUTNVSy9raXJzRWhH?=
 =?utf-8?B?ekhjOTRVaGxnSk5rMGtOVEJQZ3JHdW1CRzdaRGViQ1BCcGh5bEhQeC9GU0RG?=
 =?utf-8?B?Z3R6NDZ0M1NkQkRJNys4dzlOektheTV1aW1MTUlZZWdDb3BCbUJqUVo2WU9s?=
 =?utf-8?B?TDVMVWh6VWRpWjdaQjBCODVDSWcyZHNoNFVpdFgyRmVxN0lBUWlMOEVUL1FV?=
 =?utf-8?B?YUZETjQxSUhuYUdDRExQQUtJNU50U1Y2MXJvRTBsc1ZWSmdFQlRsUFUySWpU?=
 =?utf-8?B?Mmc4SUFGL09oREhrZG5YNDZ2NXIzbitOWUlQZTNoYzdaRU1kejdWY3FIMkcx?=
 =?utf-8?B?bFNtbEptRmsyR203bjNtM2RRR2o3RTlFWUNJN3NEUDZuLzNNUmxnZXpRQXA5?=
 =?utf-8?B?SXZBamdiTUZtRkZZUlVnTDFQWlNuM0d3YWZzOURRNm9XaVY0QjZJU0g4SnF5?=
 =?utf-8?B?dmhyRmJCMzFSYldGUENxbGZ5TlhVME12QXRTN3BJdlRnaTBJODk3aGZmOTds?=
 =?utf-8?B?UUlLM3lWSi8wM0VSL0k4Q29rcnMwdkRzYzZQS1lsd0FyZ2tabGZETXc1dm0x?=
 =?utf-8?B?QjAyNlA0QjNDMnBZR0xzeFc5VENWeWwySkp5bC9OK1NuUG1CK1VLMHRQdXk1?=
 =?utf-8?B?NUtDT240ZzM1YXdKaGpNd3JyNVRhbGNsYUF2VDU0NFBlRVFHUWY1U1E4RmMw?=
 =?utf-8?Q?KYhJNGn31zonexIam5PVjRrQTwwPaNp0gTKnxGY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6e83e9-fb41-4064-8ab2-08d93f9c6a2b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 10:05:27.9541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wmt8iMrd2aUpQ9aLz7PvepQN0WsyyjtprBy3BtdtbrNUOeh1Lk8HA2lRMKOP8+W6qTlBbL7mjb/qyAVFOw12Q2iEQLC5a/oxA6ToWedMkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1886
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10035 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107050053
X-Proofpoint-ORIG-GUID: 7WY9kCEoQMBPc7DFxslTjTFQ0I0Vo6k_
X-Proofpoint-GUID: 7WY9kCEoQMBPc7DFxslTjTFQ0I0Vo6k_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a180bd1d7e16173d965b263c5a536aa40afa2a2a
commit: 62e69bc419772638369eff8ff81340bde8aceb61 net: wan/lmc: unregister device when no matching device is found
config: parisc-randconfig-m031-20210705 (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/wan/lmc/lmc_main.c:947 lmc_init_one() warn: 'dev' not released on lines: 903.

Old smatch warnings:
drivers/net/wan/lmc/lmc_main.c:721 lmc_watchdog() warn: inconsistent indenting
drivers/net/wan/lmc/lmc_main.c:867 lmc_init_one() warn: inconsistent indenting
drivers/net/wan/lmc/lmc_main.c:947 lmc_init_one() warn: 'pdev' not released on lines: 822,827,903.

vim +/dev +947 drivers/net/wan/lmc/lmc_main.c

1dd06ae8db716e Greg Kroah-Hartman 2012-12-06  796  static int lmc_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
^1da177e4c3f41 Linus Torvalds     2005-04-16  797  {
^1da177e4c3f41 Linus Torvalds     2005-04-16  798  	lmc_softc_t *sc;
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  799  	struct net_device *dev;
^1da177e4c3f41 Linus Torvalds     2005-04-16  800  	u16 subdevice;
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  801  	u16 AdapModelNum;
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  802  	int err;
^1da177e4c3f41 Linus Torvalds     2005-04-16  803  	static int cards_found;
^1da177e4c3f41 Linus Torvalds     2005-04-16  804  
7cb43bebab52d8 Amitoj Kaur Chawla 2016-02-27  805  	err = pcim_enable_device(pdev);
^1da177e4c3f41 Linus Torvalds     2005-04-16  806  	if (err) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  807  		printk(KERN_ERR "lmc: pci enable failed: %d\n", err);
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  808  		return err;
^1da177e4c3f41 Linus Torvalds     2005-04-16  809  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  810  
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  811  	err = pci_request_regions(pdev, "lmc");
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  812  	if (err) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  813  		printk(KERN_ERR "lmc: pci_request_region failed\n");
7cb43bebab52d8 Amitoj Kaur Chawla 2016-02-27  814  		return err;
^1da177e4c3f41 Linus Torvalds     2005-04-16  815  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  816  
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  817  	/*
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  818  	 * Allocate our own device structure
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  819  	 */
7cb43bebab52d8 Amitoj Kaur Chawla 2016-02-27  820  	sc = devm_kzalloc(&pdev->dev, sizeof(lmc_softc_t), GFP_KERNEL);
7cb43bebab52d8 Amitoj Kaur Chawla 2016-02-27  821  	if (!sc)
7cb43bebab52d8 Amitoj Kaur Chawla 2016-02-27  822  		return -ENOMEM;

release regions and pcim_disable_device?

^1da177e4c3f41 Linus Torvalds     2005-04-16  823  
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  824  	dev = alloc_hdlcdev(sc);
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  825  	if (!dev) {
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  826  		printk(KERN_ERR "lmc:alloc_netdev for device failed\n");
7cb43bebab52d8 Amitoj Kaur Chawla 2016-02-27  827  		return -ENOMEM;
^1da177e4c3f41 Linus Torvalds     2005-04-16  828  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  829  
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  830  
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  831  	dev->type = ARPHRD_HDLC;
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  832  	dev_to_hdlc(dev)->xmit = lmc_start_xmit;
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  833  	dev_to_hdlc(dev)->attach = lmc_attach;
991990a12de422 Krzysztof Hałasa   2009-01-08  834  	dev->netdev_ops = &lmc_ops;
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  835  	dev->watchdog_timeo = HZ; /* 1 second */
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  836  	dev->tx_queue_len = 100;
^1da177e4c3f41 Linus Torvalds     2005-04-16  837  	sc->lmc_device = dev;
^1da177e4c3f41 Linus Torvalds     2005-04-16  838  	sc->name = dev->name;
^1da177e4c3f41 Linus Torvalds     2005-04-16  839  	sc->if_type = LMC_PPP;
^1da177e4c3f41 Linus Torvalds     2005-04-16  840  	sc->check = 0xBEAFCAFE;
^1da177e4c3f41 Linus Torvalds     2005-04-16  841  	dev->base_addr = pci_resource_start(pdev, 0);
^1da177e4c3f41 Linus Torvalds     2005-04-16  842  	dev->irq = pdev->irq;
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  843  	pci_set_drvdata(pdev, dev);
^1da177e4c3f41 Linus Torvalds     2005-04-16  844  	SET_NETDEV_DEV(dev, &pdev->dev);
^1da177e4c3f41 Linus Torvalds     2005-04-16  845  
^1da177e4c3f41 Linus Torvalds     2005-04-16  846  	/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  847  	 * This will get the protocol layer ready and do any 1 time init's
^1da177e4c3f41 Linus Torvalds     2005-04-16  848  	 * Must have a valid sc and dev structure
^1da177e4c3f41 Linus Torvalds     2005-04-16  849  	 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  850  	lmc_proto_attach(sc);
^1da177e4c3f41 Linus Torvalds     2005-04-16  851  
^1da177e4c3f41 Linus Torvalds     2005-04-16  852  	/* Init the spin lock so can call it latter */
^1da177e4c3f41 Linus Torvalds     2005-04-16  853  
^1da177e4c3f41 Linus Torvalds     2005-04-16  854  	spin_lock_init(&sc->lmc_lock);
^1da177e4c3f41 Linus Torvalds     2005-04-16  855  	pci_set_master(pdev);
^1da177e4c3f41 Linus Torvalds     2005-04-16  856  
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  857  	printk(KERN_INFO "%s: detected at %lx, irq %d\n", dev->name,
^1da177e4c3f41 Linus Torvalds     2005-04-16  858  	       dev->base_addr, dev->irq);
^1da177e4c3f41 Linus Torvalds     2005-04-16  859  
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  860  	err = register_hdlc_device(dev);
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  861  	if (err) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  862  		printk(KERN_ERR "%s: register_netdev failed.\n", dev->name);
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  863  		free_netdev(dev);
7cb43bebab52d8 Amitoj Kaur Chawla 2016-02-27  864  		return err;
^1da177e4c3f41 Linus Torvalds     2005-04-16  865  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  866  
^1da177e4c3f41 Linus Torvalds     2005-04-16  867      sc->lmc_cardtype = LMC_CARDTYPE_UNKNOWN;

Indenting uses spaces instead of tabs.  Also wrong number of spaces.

^1da177e4c3f41 Linus Torvalds     2005-04-16  868      sc->lmc_timing = LMC_CTL_CLOCK_SOURCE_EXT;
^1da177e4c3f41 Linus Torvalds     2005-04-16  869  
^1da177e4c3f41 Linus Torvalds     2005-04-16  870      /*
^1da177e4c3f41 Linus Torvalds     2005-04-16  871       *
^1da177e4c3f41 Linus Torvalds     2005-04-16  872       * Check either the subvendor or the subdevice, some systems reverse
^1da177e4c3f41 Linus Torvalds     2005-04-16  873       * the setting in the bois, seems to be version and arch dependent?
^1da177e4c3f41 Linus Torvalds     2005-04-16  874       * Fix the error, exchange the two values 
^1da177e4c3f41 Linus Torvalds     2005-04-16  875       */
^1da177e4c3f41 Linus Torvalds     2005-04-16  876      if ((subdevice = pdev->subsystem_device) == PCI_VENDOR_ID_LMC)
^1da177e4c3f41 Linus Torvalds     2005-04-16  877  	    subdevice = pdev->subsystem_vendor;
^1da177e4c3f41 Linus Torvalds     2005-04-16  878  
^1da177e4c3f41 Linus Torvalds     2005-04-16  879      switch (subdevice) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  880      case PCI_DEVICE_ID_LMC_HSSI:
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  881  	printk(KERN_INFO "%s: LMC HSSI\n", dev->name);
^1da177e4c3f41 Linus Torvalds     2005-04-16  882          sc->lmc_cardtype = LMC_CARDTYPE_HSSI;
^1da177e4c3f41 Linus Torvalds     2005-04-16  883          sc->lmc_media = &lmc_hssi_media;
^1da177e4c3f41 Linus Torvalds     2005-04-16  884          break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  885      case PCI_DEVICE_ID_LMC_DS3:
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  886  	printk(KERN_INFO "%s: LMC DS3\n", dev->name);
^1da177e4c3f41 Linus Torvalds     2005-04-16  887          sc->lmc_cardtype = LMC_CARDTYPE_DS3;
^1da177e4c3f41 Linus Torvalds     2005-04-16  888          sc->lmc_media = &lmc_ds3_media;
^1da177e4c3f41 Linus Torvalds     2005-04-16  889          break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  890      case PCI_DEVICE_ID_LMC_SSI:
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  891  	printk(KERN_INFO "%s: LMC SSI\n", dev->name);
^1da177e4c3f41 Linus Torvalds     2005-04-16  892          sc->lmc_cardtype = LMC_CARDTYPE_SSI;
^1da177e4c3f41 Linus Torvalds     2005-04-16  893          sc->lmc_media = &lmc_ssi_media;
^1da177e4c3f41 Linus Torvalds     2005-04-16  894          break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  895      case PCI_DEVICE_ID_LMC_T1:
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  896  	printk(KERN_INFO "%s: LMC T1\n", dev->name);
^1da177e4c3f41 Linus Torvalds     2005-04-16  897          sc->lmc_cardtype = LMC_CARDTYPE_T1;
^1da177e4c3f41 Linus Torvalds     2005-04-16  898          sc->lmc_media = &lmc_t1_media;
^1da177e4c3f41 Linus Torvalds     2005-04-16  899          break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  900      default:
af901ca181d92a André Goddard Rosa 2009-11-14  901  	printk(KERN_WARNING "%s: LMC UNKNOWN CARD!\n", dev->name);
62e69bc4197726 Tong Zhang         2021-02-15  902  	unregister_hdlc_device(dev);

More cleanup required?  (I haven't looked at the unregister_hdlc_device()
function).

62e69bc4197726 Tong Zhang         2021-02-15  903  	return -EIO;
^1da177e4c3f41 Linus Torvalds     2005-04-16  904          break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  905      }
^1da177e4c3f41 Linus Torvalds     2005-04-16  906  
^1da177e4c3f41 Linus Torvalds     2005-04-16  907      lmc_initcsrs (sc, dev->base_addr, 8);
^1da177e4c3f41 Linus Torvalds     2005-04-16  908  
^1da177e4c3f41 Linus Torvalds     2005-04-16  909      lmc_gpio_mkinput (sc, 0xff);
^1da177e4c3f41 Linus Torvalds     2005-04-16  910      sc->lmc_gpio = 0;		/* drive no signals yet */
^1da177e4c3f41 Linus Torvalds     2005-04-16  911  
^1da177e4c3f41 Linus Torvalds     2005-04-16  912      sc->lmc_media->defaults (sc);
^1da177e4c3f41 Linus Torvalds     2005-04-16  913  
^1da177e4c3f41 Linus Torvalds     2005-04-16  914      sc->lmc_media->set_link_status (sc, LMC_LINK_UP);
^1da177e4c3f41 Linus Torvalds     2005-04-16  915  
^1da177e4c3f41 Linus Torvalds     2005-04-16  916      /* verify that the PCI Sub System ID matches the Adapter Model number
^1da177e4c3f41 Linus Torvalds     2005-04-16  917       * from the MII register
^1da177e4c3f41 Linus Torvalds     2005-04-16  918       */
^1da177e4c3f41 Linus Torvalds     2005-04-16  919      AdapModelNum = (lmc_mii_readreg (sc, 0, 3) & 0x3f0) >> 4;
^1da177e4c3f41 Linus Torvalds     2005-04-16  920  
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  921      if ((AdapModelNum != LMC_ADAP_T1 || /* detect LMC1200 */
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  922  	 subdevice != PCI_DEVICE_ID_LMC_T1) &&
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  923  	(AdapModelNum != LMC_ADAP_SSI || /* detect LMC1000 */
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  924  	 subdevice != PCI_DEVICE_ID_LMC_SSI) &&
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  925  	(AdapModelNum != LMC_ADAP_DS3 || /* detect LMC5245 */
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  926  	 subdevice != PCI_DEVICE_ID_LMC_DS3) &&
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  927  	(AdapModelNum != LMC_ADAP_HSSI || /* detect LMC5200 */
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  928  	 subdevice != PCI_DEVICE_ID_LMC_HSSI))
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  929  	    printk(KERN_WARNING "%s: Model number (%d) miscompare for PCI"
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  930  		   " Subsystem ID = 0x%04x\n",
^1da177e4c3f41 Linus Torvalds     2005-04-16  931  		   dev->name, AdapModelNum, subdevice);
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  932  
^1da177e4c3f41 Linus Torvalds     2005-04-16  933      /*
^1da177e4c3f41 Linus Torvalds     2005-04-16  934       * reset clock
^1da177e4c3f41 Linus Torvalds     2005-04-16  935       */
^1da177e4c3f41 Linus Torvalds     2005-04-16  936      LMC_CSR_WRITE (sc, csr_gp_timer, 0xFFFFFFFFUL);
^1da177e4c3f41 Linus Torvalds     2005-04-16  937  
^1da177e4c3f41 Linus Torvalds     2005-04-16  938      sc->board_idx = cards_found++;
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  939      sc->extra_stats.check = STATCHECK;
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  940      sc->extra_stats.version_size = (DRIVER_VERSION << 16) +
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  941  	    sizeof(sc->lmc_device->stats) + sizeof(sc->extra_stats);
64bef7630ad5b0 Krzysztof Hałasa   2008-07-02  942      sc->extra_stats.lmc_cardtype = sc->lmc_cardtype;
^1da177e4c3f41 Linus Torvalds     2005-04-16  943  
^1da177e4c3f41 Linus Torvalds     2005-04-16  944      sc->lmc_ok = 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  945      sc->last_link_status = 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  946  
^1da177e4c3f41 Linus Torvalds     2005-04-16 @947      return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  948  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

