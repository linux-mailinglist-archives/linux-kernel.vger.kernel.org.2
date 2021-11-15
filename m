Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88075450304
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbhKOLEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:04:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5854 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231176AbhKOLBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:01:55 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFAEMko000684;
        Mon, 15 Nov 2021 10:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=oDydssl+gmbaU/DgWq2hxMCUHb9wK8x3S7JzAgNPxzc=;
 b=xZkyOnsfHkKl39mxtSDywucHdUoDhzTGfJ96qbCmuWlZ8+Kg/J4QPiLTlk31rbVVG+bC
 elU3c/Q+RNvp/UXpfLqIhQ/Vp9tyYyCnCffnUUqsPwb8P8VD2pvpvDCjrJ5jxSY3fHO9
 OP/a9ADwTkVzkeBmJKvLyOXHqPkTQtidH4/DwioYh1oSH+2qIfHEpt8TYVZAQZPgAF3+
 xe8j5pQyB6W6jdf7X1YrCPRctUgIrlhJ189xomdUUA93mHl7okIt30qHKkHfDZfPlMnh
 8pUGWz9lKMMiKIyVzjJBw4SIqti6nEw/XQqwYyKK9sU3sZsQPgHeonXmxQlMDQVHD9Db xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhmnhfjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 10:58:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AFAuvav102960;
        Mon, 15 Nov 2021 10:58:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3020.oracle.com with ESMTP id 3caq4qtrse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 10:58:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juuXbckjgT4GAsjmJdIkuZXOBemHXuajhva2w8oscVH07Vwg101cvffUk+teOIWVA30BKVqzg8EZO9ZIxDdPgbsmbSaZN4KF52roeeaAslZ7uwBKE5+hDnKnVQ6Q3i0xviUp8qB/nghqROo6zRfuK3h8R+VaVWVRZ0jTtMRoIAEHcefJfkzSOVVl2474qCG3kEk8n7/+g/cgoVAacw3QS1aWkiB+zr9QO/qWVkvNQKMC/flfwN6SISH780CYfcKM1FoFIev/K4dUDE+rU8xPeR2tpcK1LcK3jnpvkx9IrzumPKRUU443NKXyY/9B9k6WJXi31fZ5rD6YSgDt5GaQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDydssl+gmbaU/DgWq2hxMCUHb9wK8x3S7JzAgNPxzc=;
 b=OKf+zFc6HiQ0te+sf4pPfCv1r0a6txH+Swvtt43z7s1O/OvarVjK5lbKhyF4TMwYzOnqVDE2Hc+VVB/gZJ/M02rCF0kVtGXX2GVtdapZrB6P5JMZQlUGyr0BgbU+wuQfwOVZMrv5KDji+0GACWeBeyud+H8AlsaTZ4iizdsoBuRSNA81NuRe8L7iM6wQ6BhoisHuZbRSMHjAGu5c7vgagQp52DasyGMSRsot8RLhDuSdZtigxDxFHDonqFgv9lOZ8xUrehh/LCkYcHtIJp1PFH1CTt4P2axTy5liNxzwQ/y3m/PqH87Vk1ATVyVN2AgpwlcMmKHiBQpb/SoIXxAw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDydssl+gmbaU/DgWq2hxMCUHb9wK8x3S7JzAgNPxzc=;
 b=QF1IJp7WlmysarzPxy4OQ6evDiU8HHrZKPIttUaDVocP75SU6bRVuUYd2kUNGk7nQHYtFNUa1L01K0FGiz3BMKHuvgY0unnGyEDYR7mRseTfA7tWFb+m4+K47+B5U4ZLGOQ70oBolSxw/xH9rTUX9a/4rbQITpoLA0Ll0MqYDhI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1775.namprd10.prod.outlook.com
 (2603:10b6:301:a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Mon, 15 Nov
 2021 10:58:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Mon, 15 Nov 2021
 10:58:45 +0000
Date:   Mon, 15 Nov 2021 13:58:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: sound/soc/amd/yc/pci-acp6x.c:251 snd_acp6x_probe() error:
 uninitialized symbol 'index'.
Message-ID: <202111131437.WN6zRp5F-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25 via Frontend Transport; Mon, 15 Nov 2021 10:58:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8fec8a7-31f0-4279-8890-08d9a826e4cb
X-MS-TrafficTypeDiagnostic: MWHPR10MB1775:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1775B37CCCA04DAEF1A9DD828E989@MWHPR10MB1775.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DXQ6YmC1wHQUOqF5iicLwAwFI1HAZ2MT1480smU+O9Q+PWfvfJ046ffzwAdE8gaRCR1GKdi0T7YRKKhpQegNOB2leeE9RZcLGKnkWHJX7bfxLKxFBQyKIhh+aLuhBMPciRUqB+Ca9VKSwNA4VBOme/DSY2J5QD+v3CBWb410oZ3R5UEXK5gBRqqzDuIG9vQ9REFYHfwJDyOs+jUkLWl9kEzJmLrWprDi+ueQibh6tUcgDTEVt1q3LB2oCif1AiEiYMPmFzGtFmz/5zT+zcyCHhs/z/1v68iBO7exFEHFpeiOr4W6AntAAQt/W93C2r4Bz9z4iSKR65Lvo8KczCmF7sbK/BLCfDalrnSgkMpLN62LJIOSiTPCuLJ+VAZxz74Kvd66/8wJxNSc7UugG5Dkb6g/9GZwfCaUAtNHE59YvKLW+dQfttYKZRqIEkEIB5h6cB6RKDLzrwe+Wq12TdPMj1PR29Dy7uvrt1YPH2L6XSWLT5mPAoLjjG9M4I9+DbbgyVNZZU4W945dImYkMv147mAzlhHvGgjdiSkqCfhnCnLKmlEU0xvJloA5y2Z9y/EHYjnk13S0poUMenAg8OwDTidyDk8tueD+WDofgzLLRsYLkNyiQqQkWv4M4s9O0JmjRPWSD2G7PVF+nhLWXgFZb5BwBPR+fXdLg7GID+Z3GJa5YSjOjtNHz5abPnFHKutEZVbERPgTyynd4du5LRMXlBSgeqkbXVrqdIfSkGwi8druQOhIeNUDbzO0g5/B4OUFFcpTMh8kUp3jRzWXzUxwh5lqZIFa4D1Yb7aUxsoZZ/glHv10F0QettTg5G0DkX6DxeK2KUCrgIzJAf+zQJH/lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(508600001)(8676002)(86362001)(8936002)(956004)(316002)(5660300002)(6916009)(2906002)(9686003)(26005)(4001150100001)(6486002)(6666004)(186003)(1076003)(6496006)(66476007)(66556008)(44832011)(66946007)(83380400001)(36756003)(4326008)(38100700002)(38350700002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nOCgpDoO4fA/jbUKOu5o5iUGSZCuYpQRW+I0yaPz52rQd98vvdPNaZNn9V/X?=
 =?us-ascii?Q?38jGqt5bQeHsmSqNm1qO9B9osrRzzr6FCuJy0h9ZIFRYocDP7lfb6ObTb2D2?=
 =?us-ascii?Q?9NmTiUteuC0LXnceB/AKcLbOWN+3HCh8Z6r4DpldRq+NrXPNfm9rNVdTpDv5?=
 =?us-ascii?Q?KfbUH1xNChiC4eXGvldoCmPPR35ZAlwrSiGhyfQtFGOFEcHBeo7mpISOHoQZ?=
 =?us-ascii?Q?/Lf66W3Wmn9jKrF55RGBF4yM8SoNv9D9TLh/r4nj6glw7wK2eYkC/PBhxBcX?=
 =?us-ascii?Q?aZhPzDlW7pFXhvRtDznEzqUWwL2DDTEhXIrQO/ZXqMmtyOz3wuHL9EKBmE2j?=
 =?us-ascii?Q?erZNqZlhE0YXRb9N0MZQBvOhgMwn79YI25zwtNGSqohZYxUcL6v+v5ou+WMl?=
 =?us-ascii?Q?9SkwmCFYQXiLmM/rrX+pnzPTFuSGD9roCiPV3dLb3Z+aCCKF8hDtVBjp48M1?=
 =?us-ascii?Q?K8DLJNU4RJjfWfoDB8kLAoHrdJ7NlvXsYanr6hNJrEf7DVa6Rrh9BOk+Xk1r?=
 =?us-ascii?Q?mbhlauTtnu5/dkr9761dQqxlveHcGCcoFp+BAX2sm8A5bYWVYkhjadED9MxX?=
 =?us-ascii?Q?wfRVYcxi4k1wv5fjoOvQWizf7mfBLv/6NLNkbKNeBHuAn7kY+4xCjpYFDr4W?=
 =?us-ascii?Q?7XcA+/A3lSBLJc0kAVTA/a/vHxB4dcib8+ZHz/NVf3xNyruNQlqn7PAr5DMD?=
 =?us-ascii?Q?j4A6QiYc9CqjTmI1I84LvRVUu+6fBdMlucTBmURO74nssX9AVbS0qSXjq5wR?=
 =?us-ascii?Q?0PGswPO5pp/s7L446NDzXZdxlGRWKpgVS/PZWF3AZJ4nuz17w8u1VQ0NkdnJ?=
 =?us-ascii?Q?RuwiF36pfnzPtfo64dBWV0z7nIxYjS4kAwA62PB+P+sr+TWfYmf9sUQh24BS?=
 =?us-ascii?Q?pkFvDsAaYayJL9ftgJ95Qijl6o72suCs/fMr8x3dxWkLkqG1lpfipl2LCtRi?=
 =?us-ascii?Q?YHKydJeaYvz6h365P+FavDkBEmcswCwNRxVLWwIlb0UaYWI/y37UmwuwSbuk?=
 =?us-ascii?Q?8IgkMgLHgspz4KzkZowXDJatfQu4wjeTqy+Sa3gPfdVzZGXb120AIDaAkN7J?=
 =?us-ascii?Q?pQ5w+AlWPhtr1322kuld430QXVKLFdIuW0I3EGZSDl9BBm0ZLpq5AdqX99ai?=
 =?us-ascii?Q?/NP8rqDkUahAVZ6Js7pewtDRppTJfvkEz1QJruSEpgjQOqEPKfuIB0FJDmf2?=
 =?us-ascii?Q?OU+QY3dykYdY7xxKWhHd/LOK/TXSUUoiyRGb551BKg2MNmUm0qSmmVUzLEtB?=
 =?us-ascii?Q?N7nOXfi1vRSogv8Pic4DrP/gRToVxAh7iiKb7mwtIcHves52uvJvgNeASQAt?=
 =?us-ascii?Q?7k57IoTMSDRs6W+47NNwTB2bTt7MrOr0qMBPgnvJPpU8MsCeP4JVZKgncnmH?=
 =?us-ascii?Q?lzKMHzXhRDVFELa0gYU5fRkkQNkSJI8/oPr4bKnxVOJoCqx6c9qBJJzFErnW?=
 =?us-ascii?Q?ILlUgoHwtVX6pEvmQiSjZuE9bx/eJxAX9lBaDY9jmOFHwB5b5aXqcLA3e7k0?=
 =?us-ascii?Q?6esPVpCSwMRJmIYjvZi/xzcM6vQfq3WnD26pf+hpqMQoXGvy4zeprBG3Nfx4?=
 =?us-ascii?Q?G/YY/qTLZCgkx+SLpOTPI1v+PIWpfM5t1A2gDDxztnzNZYFmdH6LlAttdUp/?=
 =?us-ascii?Q?hVGr8OXM12Zkh+4YjcrY4YVLunM51Wgn/QHH+EmrLcGOqoFvvbwtFFMiTntS?=
 =?us-ascii?Q?8YsPGt95TO0HkbKZ8SP8lRdLaKE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fec8a7-31f0-4279-8890-08d9a826e4cb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 10:58:45.4750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DECz/EtZumU5Q168AP8xfjxITdSvGkSRIykzvdqw+wUWiBOg9zGECg0sHgpPHEjWRH4J/hiD9miI652UbobfX2Y4bQy82eWVrzZu3fP5Nw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1775
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10168 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150060
X-Proofpoint-ORIG-GUID: -m_yCEDmLfMyy3cuDI-4LEpi0Kd3uGZy
X-Proofpoint-GUID: -m_yCEDmLfMyy3cuDI-4LEpi0Kd3uGZy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijendar,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   66f4beaa6c1d28161f534471484b2daa2de1dce0
commit: 89728d97db3f078aceb967ebe5ed2d0797b6a117 ASoC: amd: enable Yellow carp acp6x drivers build
config: x86_64-randconfig-m001-20211028 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
sound/soc/amd/yc/pci-acp6x.c:251 snd_acp6x_probe() error: uninitialized symbol 'index'.

vim +/index +251 sound/soc/amd/yc/pci-acp6x.c

c62442bd5d9f86 Vijendar Mukunda 2021-10-18  144  static int snd_acp6x_probe(struct pci_dev *pci,
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  145  			   const struct pci_device_id *pci_id)
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  146  {
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  147  	struct acp6x_dev_data *adata;
fc329c1de49825 Vijendar Mukunda 2021-10-18  148  	struct platform_device_info pdevinfo[ACP6x_DEVS];
fc329c1de49825 Vijendar Mukunda 2021-10-18  149  	int ret, index;
fc329c1de49825 Vijendar Mukunda 2021-10-18  150  	int val = 0x00;
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  151  	u32 addr;
cc0deaa2dc7300 Vijendar Mukunda 2021-10-18  152  	unsigned int irqflags;
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  153  
cc0deaa2dc7300 Vijendar Mukunda 2021-10-18  154  	irqflags = IRQF_SHARED;
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  155  	/* Yellow Carp device check */
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  156  	if (pci->revision != 0x60)
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  157  		return -ENODEV;
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  158  
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  159  	if (pci_enable_device(pci)) {
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  160  		dev_err(&pci->dev, "pci_enable_device failed\n");
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  161  		return -ENODEV;
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  162  	}
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  163  
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  164  	ret = pci_request_regions(pci, "AMD ACP3x audio");
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  165  	if (ret < 0) {
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  166  		dev_err(&pci->dev, "pci_request_regions failed\n");
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  167  		goto disable_pci;
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  168  	}
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  169  
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  170  	adata = devm_kzalloc(&pci->dev, sizeof(struct acp6x_dev_data),
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  171  			     GFP_KERNEL);
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  172  	if (!adata) {
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  173  		ret = -ENOMEM;
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  174  		goto release_regions;
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  175  	}
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  176  
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  177  	addr = pci_resource_start(pci, 0);
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  178  	adata->acp6x_base = devm_ioremap(&pci->dev, addr,
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  179  					 pci_resource_len(pci, 0));
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  180  	if (!adata->acp6x_base) {
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  181  		ret = -ENOMEM;
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  182  		goto release_regions;
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  183  	}
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  184  	pci_set_master(pci);
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  185  	pci_set_drvdata(pci, adata);
8c7161f2c97b2d Vijendar Mukunda 2021-10-18  186  	ret = acp6x_init(adata->acp6x_base);
8c7161f2c97b2d Vijendar Mukunda 2021-10-18  187  	if (ret)
8c7161f2c97b2d Vijendar Mukunda 2021-10-18  188  		goto release_regions;
fc329c1de49825 Vijendar Mukunda 2021-10-18  189  	val = acp6x_readl(adata->acp6x_base + ACP_PIN_CONFIG);
fc329c1de49825 Vijendar Mukunda 2021-10-18  190  	switch (val) {
fc329c1de49825 Vijendar Mukunda 2021-10-18  191  	case ACP_CONFIG_0:
fc329c1de49825 Vijendar Mukunda 2021-10-18  192  	case ACP_CONFIG_1:
fc329c1de49825 Vijendar Mukunda 2021-10-18  193  	case ACP_CONFIG_2:
fc329c1de49825 Vijendar Mukunda 2021-10-18  194  	case ACP_CONFIG_3:
fc329c1de49825 Vijendar Mukunda 2021-10-18  195  	case ACP_CONFIG_9:
fc329c1de49825 Vijendar Mukunda 2021-10-18  196  	case ACP_CONFIG_15:
fc329c1de49825 Vijendar Mukunda 2021-10-18  197  		dev_info(&pci->dev, "Audio Mode %d\n", val);
fc329c1de49825 Vijendar Mukunda 2021-10-18  198  		break;

"index" is not set for these cases.

fc329c1de49825 Vijendar Mukunda 2021-10-18  199  	default:
fc329c1de49825 Vijendar Mukunda 2021-10-18  200  		adata->res = devm_kzalloc(&pci->dev,
fc329c1de49825 Vijendar Mukunda 2021-10-18  201  					  sizeof(struct resource),
fc329c1de49825 Vijendar Mukunda 2021-10-18  202  					  GFP_KERNEL);
fc329c1de49825 Vijendar Mukunda 2021-10-18  203  		if (!adata->res) {
fc329c1de49825 Vijendar Mukunda 2021-10-18  204  			ret = -ENOMEM;
fc329c1de49825 Vijendar Mukunda 2021-10-18  205  			goto de_init;
fc329c1de49825 Vijendar Mukunda 2021-10-18  206  		}
fc329c1de49825 Vijendar Mukunda 2021-10-18  207  
fc329c1de49825 Vijendar Mukunda 2021-10-18  208  		adata->res->name = "acp_iomem";
fc329c1de49825 Vijendar Mukunda 2021-10-18  209  		adata->res->flags = IORESOURCE_MEM;
fc329c1de49825 Vijendar Mukunda 2021-10-18  210  		adata->res->start = addr;
fc329c1de49825 Vijendar Mukunda 2021-10-18  211  		adata->res->end = addr + (ACP6x_REG_END - ACP6x_REG_START);
fc329c1de49825 Vijendar Mukunda 2021-10-18  212  
fc329c1de49825 Vijendar Mukunda 2021-10-18  213  		adata->acp6x_audio_mode = ACP6x_PDM_MODE;
fc329c1de49825 Vijendar Mukunda 2021-10-18  214  
fc329c1de49825 Vijendar Mukunda 2021-10-18  215  		memset(&pdevinfo, 0, sizeof(pdevinfo));
fc329c1de49825 Vijendar Mukunda 2021-10-18  216  		pdevinfo[0].name = "acp_yc_pdm_dma";
fc329c1de49825 Vijendar Mukunda 2021-10-18  217  		pdevinfo[0].id = 0;
fc329c1de49825 Vijendar Mukunda 2021-10-18  218  		pdevinfo[0].parent = &pci->dev;
fc329c1de49825 Vijendar Mukunda 2021-10-18  219  		pdevinfo[0].num_res = 1;
fc329c1de49825 Vijendar Mukunda 2021-10-18  220  		pdevinfo[0].res = adata->res;
8c7161f2c97b2d Vijendar Mukunda 2021-10-18  221  
fc329c1de49825 Vijendar Mukunda 2021-10-18  222  		pdevinfo[1].name = "dmic-codec";
fc329c1de49825 Vijendar Mukunda 2021-10-18  223  		pdevinfo[1].id = 0;
fc329c1de49825 Vijendar Mukunda 2021-10-18  224  		pdevinfo[1].parent = &pci->dev;
fc329c1de49825 Vijendar Mukunda 2021-10-18  225  
fc329c1de49825 Vijendar Mukunda 2021-10-18  226  		for (index = 0; index < ACP6x_DEVS; index++) {
fc329c1de49825 Vijendar Mukunda 2021-10-18  227  			adata->pdev[index] =
fc329c1de49825 Vijendar Mukunda 2021-10-18  228  				platform_device_register_full(&pdevinfo[index]);
fc329c1de49825 Vijendar Mukunda 2021-10-18  229  			if (IS_ERR(adata->pdev[index])) {
fc329c1de49825 Vijendar Mukunda 2021-10-18  230  				dev_err(&pci->dev, "cannot register %s device\n",
fc329c1de49825 Vijendar Mukunda 2021-10-18  231  					pdevinfo[index].name);
fc329c1de49825 Vijendar Mukunda 2021-10-18  232  				ret = PTR_ERR(adata->pdev[index]);
fc329c1de49825 Vijendar Mukunda 2021-10-18  233  				goto unregister_devs;
fc329c1de49825 Vijendar Mukunda 2021-10-18  234  			}
fc329c1de49825 Vijendar Mukunda 2021-10-18  235  		}
fc329c1de49825 Vijendar Mukunda 2021-10-18  236  		break;
fc329c1de49825 Vijendar Mukunda 2021-10-18  237  	}
cc0deaa2dc7300 Vijendar Mukunda 2021-10-18  238  	ret = devm_request_irq(&pci->dev, pci->irq, acp6x_irq_handler,
cc0deaa2dc7300 Vijendar Mukunda 2021-10-18  239  			       irqflags, "ACP_PCI_IRQ", adata);
cc0deaa2dc7300 Vijendar Mukunda 2021-10-18  240  	if (ret) {
cc0deaa2dc7300 Vijendar Mukunda 2021-10-18  241  		dev_err(&pci->dev, "ACP PCI IRQ request failed\n");
cc0deaa2dc7300 Vijendar Mukunda 2021-10-18  242  		goto unregister_devs;
cc0deaa2dc7300 Vijendar Mukunda 2021-10-18  243  	}
c8212df7bc0f2e Vijendar Mukunda 2021-10-18  244  	pm_runtime_set_autosuspend_delay(&pci->dev, ACP_SUSPEND_DELAY_MS);
c8212df7bc0f2e Vijendar Mukunda 2021-10-18  245  	pm_runtime_use_autosuspend(&pci->dev);
c8212df7bc0f2e Vijendar Mukunda 2021-10-18  246  	pm_runtime_put_noidle(&pci->dev);
c8212df7bc0f2e Vijendar Mukunda 2021-10-18  247  	pm_runtime_allow(&pci->dev);
c8212df7bc0f2e Vijendar Mukunda 2021-10-18  248  
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  249  	return 0;
fc329c1de49825 Vijendar Mukunda 2021-10-18  250  unregister_devs:
fc329c1de49825 Vijendar Mukunda 2021-10-18 @251  	for (--index; index >= 0; index--)

Uninitialized variable "index".

fc329c1de49825 Vijendar Mukunda 2021-10-18  252  		platform_device_unregister(adata->pdev[index]);
fc329c1de49825 Vijendar Mukunda 2021-10-18  253  de_init:
fc329c1de49825 Vijendar Mukunda 2021-10-18  254  	if (acp6x_deinit(adata->acp6x_base))
fc329c1de49825 Vijendar Mukunda 2021-10-18  255  		dev_err(&pci->dev, "ACP de-init failed\n");
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  256  release_regions:
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  257  	pci_release_regions(pci);
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  258  disable_pci:
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  259  	pci_disable_device(pci);
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  260  
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  261  	return ret;
c62442bd5d9f86 Vijendar Mukunda 2021-10-18  262  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

