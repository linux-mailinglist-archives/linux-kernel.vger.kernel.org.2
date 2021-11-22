Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC189458CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbhKVLHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:07:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21406 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232675AbhKVLHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:07:31 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMANa7A024910;
        Mon, 22 Nov 2021 11:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=ul4WEdilM2OH0BS5j2JuAjXF46VlIhLq/kcs+LxipHg=;
 b=epYJlezLOJyVy6RHVMg8LJg9+Rd4g/K4YQ5mvByglVBQUlJzg8QWhHO5bnzGhNUwaQTp
 rbg/vcU3O7Rikem1R/RFinwSTrKEBSp2O6/PZ0UpmAQ5GyMaYAIFqdZr7aLI6mSJzWgN
 32iOIhUK+eajLkCMq5nYmIJhtmypZO1l+ot2ZlFFWz2nQcHhaak6grhQcgGiUNQb5wJg
 wuD1HZD8im5WB4iSOyH9K5bLChrbcsgYVlwF6MsVSyIST9LNLO0PE63bCHG/Ky9Wka06
 CCnaPTTILk+By3P5oZQBoCiK8kGp5m1F1HRDXmzEY/FlGu9pMLVf8BjFMK0OESjQ3t0v JA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg69m937u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 11:04:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AMB0h34014935;
        Mon, 22 Nov 2021 11:04:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3030.oracle.com with ESMTP id 3ceq2ce22q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 11:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1zc+3eK4odoQWozHCa5yeP2N7xfXpA1RMJLTz7xScutF75gQ6P1iKJD8mR0lcwo18MjwjvkHGCPv/oPKVmGxZsRmDYjPZKTy0fDoi2vb9WPQgDwCsaeCfct71Foh0JsQPu6C+G+Viefm3GyQk8gHn/duABtkKQR+6KR1gns38T8kKVVMZtjZK6ymIGUCRnmixhDNKSWr6iC/YdgDclLuVwpBW9KXkOka1RSgyEp6Mmt3lnG91yp9UDyKyhRPY1+LPBFg9evhnQNZyTgOmWBI57yNvQTs7K+RWXgGZKegsqKMM5YZ563BBWO77a1lfn8NiNP9QZ+U2TYU7SFysozEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ef4X5Ka1RD+4lB+YZzzeZQU5dxRiulBWlVF0+531Pg=;
 b=nZ/BVLtwX29qerMUw1PoiNZxhrU9LyCxQTm9mtO/pUI3dfaZHAc6NUZ9RIsyKKW8xbkwFqd2AVlQoIbgiKIKHY2FaGfMw3Ws0LuZ7c1mJkHsT1QuzMd9KkUHc4c/UlntXLPwWOdjOOelWrapgn0u++3Zmi1+9g7bOFC4AlvhK77Q8xNU6ygRtZUx9ycYFTad0x5LSbgvNn5Xnp4GjHQL37z60SdnPAwfeSPosLsQuWZOnWdwrf6hcqNXLF/E4Vhc8dWuiJKJh9NM5iCmQEAR4xX54gwQh1+MrpadRp2eCyu940bwLFmILcPYHapq09BpbuKWZRQuOzjKSmSqcAxdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ef4X5Ka1RD+4lB+YZzzeZQU5dxRiulBWlVF0+531Pg=;
 b=lTvIaHifNOA6rSV9H0EyNTgZuLtQpAQC4gWyL9JzYZT3r4JYL5a20YAFNlreZZ/sCMZAlgWFHN9yvTAtFMUdkj5SVUNfPrvLPAUZPfmCZpq0b/xh77d7b/ZWRQcCLqoRX6vvgMUqGi7SaaeUUx6uWehqHfaY48Y/ETXFVFrPR08=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4483.namprd10.prod.outlook.com
 (2603:10b6:303:98::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Mon, 22 Nov
 2021 11:04:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682%6]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 11:04:08 +0000
Date:   Mon, 22 Nov 2021 14:03:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Jonas =?iso-8859-1?Q?Dre=DFler?= <verdre@v0yd.nl>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: drivers/net/wireless/marvell/mwifiex/cfg80211.c:1307
 mwifiex_cfg80211_change_virtual_intf() warn: ignoring unreachable code.
Message-ID: <202111210832.ur2HmiVQ-lkp@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::25)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24 via Frontend Transport; Mon, 22 Nov 2021 11:04:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6c9dbf1-1f36-445b-e753-08d9ada7ce70
X-MS-TrafficTypeDiagnostic: CO1PR10MB4483:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4483513358CAA1B972ABCE2D8E9F9@CO1PR10MB4483.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gfgd7vDeFfuJQ4D662nTtuDoyE4ki3Rc79ph/+OqsL5c4hxEvtO0Z/KC58Kd0c3ib9cLUIG5OFAMOik3TD2EGSzDf1kJHo/Ik/Dus7kKSqkDH6PCqvE7tYRQsABKZ5QL3MqSq7nH5muTcApxRKU2gOSjowxAm9zTHIKZn59zpFUr/V7EVu5P5udVjdqoUdRmaESrDbe10GzHVlkd2j/6FMoiBz9Ha/+5SjOC5dZGbGcP8ziSvlwwo/h1V+i0duQcBE8aWhsSYVbBk7Tq/uH3A8IfvoKjMzIkmL1w8vwwQ07lDslWinWZbqkgCyfjJAQ4/wuN6Z5+YKBDZ1ENAmvW1WDdTLQmMozOO0of5gONp8Z5S279J4QLff9IOQ7xZo1pyCkHjJ1HyMX3Ex2SHBNDrYcGNAAo3vhbgLddiWjpKMk/hh21uGmOeXG+T8k+au4pIWUQBLmgF1FN7CYAv7c45GrSFuLxSejW+4hNgHEWTAOWbYYGQFoBYOrpfK7Mf+2DDwpLsRkpbLC+q9MlpSPPqQZUKDdib2AnSNIaav8cNFxTFuDL/eissZE2FU+qBSnQf6J3ukuV0hfFp5wi2nXkAKbjj+eoeUOE/+eJdKUOvKzg5K96/Tuxyc3LpB6/LL6iPg9Kn4VkJZvEGv+2CtxLJxPmlQEvT198ezaQOYa1m/PxP/+3sPC7n4gdEs1Fb9nxa/hdaRNgReaBJaLZM45voPRFJRcwyaQvyDGq/rP3fn3SRCTA9CxZuVXyJ38qgC3KDXfdCzmiMJixzNeqi2efGdQIP4X2DTFCZFOof7n4YDKBYLPRo5ErSJ91QFIDsQjYkdA2et6Qu01kZFqpQsqZ5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(38350700002)(36756003)(38100700002)(508600001)(66574015)(6486002)(966005)(316002)(83380400001)(30864003)(44832011)(8936002)(9686003)(86362001)(6666004)(26005)(956004)(6496006)(4326008)(52116002)(186003)(2906002)(5660300002)(6916009)(1076003)(66556008)(66476007)(4001150100001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CDKhts98qw42ztS3eSAnkC8iTP1/HNpFTTdyHlao13A89FAUduhXdejENL?=
 =?iso-8859-1?Q?iQYWOxemP4oq3x1Otr3jjUHm2Db5iHwQ8PAEIPfea5GEqP1nqjHMwCQ1+f?=
 =?iso-8859-1?Q?l/H8aXXf2ocZ1tuMwdH/6+7t/VbjLFJLAletYY1tmMOGeGGV87GtLZ8t5w?=
 =?iso-8859-1?Q?z8ROhOTCCbVIIe4Ytxn7jHfj5fFWsHnHSO1OyTTGsDf0Wj7RQP2Kf4Y/vr?=
 =?iso-8859-1?Q?N6GJBshcfFyT+OLj0XHoRIfYh7tmUsqtmT3YTyquLuwQZD37CQ45xPnAsM?=
 =?iso-8859-1?Q?SgdEUISSxP6WrCEQS/uFWCeqmhowIMtkbZzKlPvyIWzK2Eqn9De6y4yUfJ?=
 =?iso-8859-1?Q?VnhQ1FgHvNjwBBtRfCRcHwW2h8sNNQYS+5oJu3x4Ei8xKCdDvDh5OKp8CU?=
 =?iso-8859-1?Q?7nvorwF+xN7ebdsaPTePNP665+857Kor+Z9st+QIzQ9+OgXJhmHxmzU4Ng?=
 =?iso-8859-1?Q?rmCqH2tP8p4XQl8veRcVdvOLkhUDezU6rJH+prszMeoyHifIL7P6Wae4tz?=
 =?iso-8859-1?Q?8jCL3ffGoEhdd43OIS/SW8NTCJs+WPfTDyRrRamjJ0TLuOGEqin6+NdlBE?=
 =?iso-8859-1?Q?x+bDbTrfgTEWaQU47Px/glwer7qq+G0QyFplkJ1+2tK273bGi67X8W2Npu?=
 =?iso-8859-1?Q?1Atm8YHtlDEGK396E0oVjGYcjfNGdR5at/g10Kldx0OJKnN6SmsWAoLjnm?=
 =?iso-8859-1?Q?PrCI9cZ3GOcMFITsCA3kW2xSHHxnSLCws+XVIAFIMSO05mpiWmW8/8y6fg?=
 =?iso-8859-1?Q?Kri6ySRGTvvlrbwtoRMtSdfxX24XTXdAF239pwshdjyF3pSAMp7iXoAN/C?=
 =?iso-8859-1?Q?q64ryjd8HkWwIcnNgpp3NfViKQxsnH1OHlrkPh4R1JWKaYzsBhGCHiDmT0?=
 =?iso-8859-1?Q?WtwEH3wJRUqJrMPVdfV6dONkTY48ITKCg2seCeQC3avup7kcWxonualy6G?=
 =?iso-8859-1?Q?XLsaPPZf1UCD5JORFlpOD36Zk8jeoSF7iq9vd13sw+nJmiuV+UU/yZTYHl?=
 =?iso-8859-1?Q?6s6ejbOdXNR+XtdGD7jqE2pBkBznw9PtZwJeW3KiVqW7Os4WHclD+RnGRd?=
 =?iso-8859-1?Q?qRZstc2r914hBuqrZrDMv/xXUOqR0P2c5WXTat1rUBK9nHO8iQwhF/oy4R?=
 =?iso-8859-1?Q?AWur67nguNNhT9z8jj6wtqriokcw2GCAgRpRY5nRqvg1BkFwI7RdOfxlAQ?=
 =?iso-8859-1?Q?622vMYQDCt7AyTYc06uPxSPfMc1KGwBbRDOEEupt3+Ng+5NqeDUNzE2VYo?=
 =?iso-8859-1?Q?gcJQlCU1YXBFuIsdDNt0FmANsX8dU+rEeNuzerqjAAJ/MyfP13msCPCpt+?=
 =?iso-8859-1?Q?FCPAPnnpN+GiQhCXgwhKHsvnhqRJA5kDdnA+crpjlhxFL4SlAbCQVL+nkb?=
 =?iso-8859-1?Q?dmHIZJS3Q7n/7IvfdNPi054mYwLeuJyE7xeMT7ly81x5eCRuEgmIL1WsgA?=
 =?iso-8859-1?Q?JXlVDFb3iCKcupWrHOHMFAxB9TuQUOLtXfL2+z5NMEH3O2z1oVunw04HJt?=
 =?iso-8859-1?Q?RU3UEcshuIz2BYirXD+Y9sOkUVWOtcbdjhr0Po7DBZ77B0bcDIJkkq5NiY?=
 =?iso-8859-1?Q?dsZzUxfL7tQUxPDa/rJcHyc3vNQhyRthS5UMNBygmYd8uVo/wTfp1T1agv?=
 =?iso-8859-1?Q?eTxwT3wipb708hvntSf/KUbq4A717gChMHdfFK1BH4BC0ygFux2S3F5OFB?=
 =?iso-8859-1?Q?Bed5An4ag/M7JXo7RE1XXB7Zo41a4409CJgan78dgosMV669ceHW04DNfa?=
 =?iso-8859-1?Q?vnJ7+BvTHc/ZgOsxXOh+e5ZRg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c9dbf1-1f36-445b-e753-08d9ada7ce70
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 11:04:08.8772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bxq1bzyl67zTt68ld/HdlbZJU6VHgCV05/Nvd/V86ThCylQGxxkMTx7f97KFJpHfcIiCUlUO3welQC3enYZ4DUk0H6T0D6Gjf3BM6DOwumg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4483
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111220058
X-Proofpoint-GUID: IpmIW15TQWfa22eClbisAWrVwb_yL7gD
X-Proofpoint-ORIG-GUID: IpmIW15TQWfa22eClbisAWrVwb_yL7gD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   923dcc5eb0c111eccd51cc7ce1658537e3c38b25
commit: abe3a2c9ead8fd95db141ea1df8d96c48cad3893 mwifiex: Use function to check whether interface type change is allowed
config: mips-randconfig-m031-20211104 (attached as .config)
compiler: mips-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/wireless/marvell/mwifiex/cfg80211.c:1307 mwifiex_cfg80211_change_virtual_intf() warn: ignoring unreachable code.

vim +1307 drivers/net/wireless/marvell/mwifiex/cfg80211.c

5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao        2011-03-21  1176  static int
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao        2011-03-21  1177  mwifiex_cfg80211_change_virtual_intf(struct wiphy *wiphy,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao        2011-03-21  1178  				     struct net_device *dev,
818a986e4ebace drivers/net/wireless/marvell/mwifiex/cfg80211.c Johannes Berg    2017-04-12  1179  				     enum nl80211_iftype type,
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao        2011-03-21  1180  				     struct vif_params *params)
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao        2011-03-21  1181  {
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao        2011-03-21  1182  	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1183  	enum nl80211_iftype curr_iftype = dev->ieee80211_ptr->iftype;
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao        2011-03-21  1184  
c61cfe49f0f0f0 drivers/net/wireless/marvell/mwifiex/cfg80211.c Limin Zhu        2017-11-30  1185  	if (priv->scan_request) {
c61cfe49f0f0f0 drivers/net/wireless/marvell/mwifiex/cfg80211.c Limin Zhu        2017-11-30  1186  		mwifiex_dbg(priv->adapter, ERROR,
c61cfe49f0f0f0 drivers/net/wireless/marvell/mwifiex/cfg80211.c Limin Zhu        2017-11-30  1187  			    "change virtual interface: scan in process\n");
c61cfe49f0f0f0 drivers/net/wireless/marvell/mwifiex/cfg80211.c Limin Zhu        2017-11-30  1188  		return -EBUSY;
c61cfe49f0f0f0 drivers/net/wireless/marvell/mwifiex/cfg80211.c Limin Zhu        2017-11-30  1189  	}
c61cfe49f0f0f0 drivers/net/wireless/marvell/mwifiex/cfg80211.c Limin Zhu        2017-11-30  1190  
babe2a332dc40b drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1191  	if (type == NL80211_IFTYPE_UNSPECIFIED) {
babe2a332dc40b drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1192  		mwifiex_dbg(priv->adapter, INFO,
babe2a332dc40b drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1193  			    "%s: no new type specified, keeping old type %d\n",
babe2a332dc40b drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1194  			    dev->name, curr_iftype);
babe2a332dc40b drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1195  		return 0;
babe2a332dc40b drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1196  	}
babe2a332dc40b drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1197  
babe2a332dc40b drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1198  	if (curr_iftype == type) {
babe2a332dc40b drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1199  		mwifiex_dbg(priv->adapter, INFO,
babe2a332dc40b drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1200  			    "%s: interface already is of type %d\n",
babe2a332dc40b drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1201  			    dev->name, curr_iftype);
babe2a332dc40b drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1202  		return 0;
babe2a332dc40b drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1203  	}
babe2a332dc40b drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1204  
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1205  	if (!is_vif_type_change_allowed(priv->adapter, curr_iftype, type)) {
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1206  		mwifiex_dbg(priv->adapter, ERROR,
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1207  			    "%s: change from type %d to %d is not allowed\n",
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1208  			    dev->name, curr_iftype, type);
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1209  		return -EOPNOTSUPP;
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1210  	}
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1211  
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1212  	switch (curr_iftype) {
4f02341ac27f70 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2012-05-08  1213  	case NL80211_IFTYPE_ADHOC:
4f02341ac27f70 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2012-05-08  1214  		switch (type) {
4f02341ac27f70 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2012-05-08  1215  		case NL80211_IFTYPE_STATION:
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1216  			priv->bss_mode = type;
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1217  			priv->sec_info.authentication_mode =
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1218  						   NL80211_AUTHTYPE_OPEN_SYSTEM;
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1219  			dev->ieee80211_ptr->iftype = type;
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1220  			mwifiex_deauthenticate(priv, NULL);
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1221  			return mwifiex_send_cmd(priv, HostCmd_CMD_SET_BSS_MODE,
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1222  						HostCmd_ACT_GEN_SET, 0, NULL,
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1223  						true);
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1224  		case NL80211_IFTYPE_P2P_CLIENT:
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1225  		case NL80211_IFTYPE_P2P_GO:
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1226  			return mwifiex_change_vif_to_p2p(dev, curr_iftype,
818a986e4ebace drivers/net/wireless/marvell/mwifiex/cfg80211.c Johannes Berg    2017-04-12  1227  							 type, params);
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1228  		case NL80211_IFTYPE_AP:
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1229  			return mwifiex_change_vif_to_ap(dev, curr_iftype, type,
818a986e4ebace drivers/net/wireless/marvell/mwifiex/cfg80211.c Johannes Berg    2017-04-12  1230  							params);
4f02341ac27f70 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2012-05-08  1231  		default:
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1232  			goto errnotsupp;
eecd8250e492ff drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao        2011-03-28  1233  		}
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1234  
4f02341ac27f70 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2012-05-08  1235  	case NL80211_IFTYPE_STATION:
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao        2011-03-21  1236  		switch (type) {
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao        2011-03-21  1237  		case NL80211_IFTYPE_ADHOC:
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1238  			priv->bss_mode = type;
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1239  			priv->sec_info.authentication_mode =
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1240  						   NL80211_AUTHTYPE_OPEN_SYSTEM;
e1a2b7a394ad8c drivers/net/wireless/mwifiex/cfg80211.c         Stone Piao       2012-09-25  1241  			dev->ieee80211_ptr->iftype = type;
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1242  			mwifiex_deauthenticate(priv, NULL);
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1243  			return mwifiex_send_cmd(priv, HostCmd_CMD_SET_BSS_MODE,
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1244  						HostCmd_ACT_GEN_SET, 0, NULL,
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1245  						true);
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1246  		case NL80211_IFTYPE_P2P_CLIENT:
9197ab9e5f3016 drivers/net/wireless/mwifiex/cfg80211.c         Stone Piao       2012-09-25  1247  		case NL80211_IFTYPE_P2P_GO:
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1248  			return mwifiex_change_vif_to_p2p(dev, curr_iftype,
818a986e4ebace drivers/net/wireless/marvell/mwifiex/cfg80211.c Johannes Berg    2017-04-12  1249  							 type, params);
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1250  		case NL80211_IFTYPE_AP:
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1251  			return mwifiex_change_vif_to_ap(dev, curr_iftype, type,
818a986e4ebace drivers/net/wireless/marvell/mwifiex/cfg80211.c Johannes Berg    2017-04-12  1252  							params);
4f02341ac27f70 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2012-05-08  1253  		default:
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1254  			goto errnotsupp;
4f02341ac27f70 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2012-05-08  1255  		}
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1256  
4f02341ac27f70 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2012-05-08  1257  	case NL80211_IFTYPE_AP:
4f02341ac27f70 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2012-05-08  1258  		switch (type) {
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1259  		case NL80211_IFTYPE_ADHOC:
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1260  			return mwifiex_change_vif_to_sta_adhoc(dev, curr_iftype,
818a986e4ebace drivers/net/wireless/marvell/mwifiex/cfg80211.c Johannes Berg    2017-04-12  1261  							       type, params);
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1262  			break;

Return followed by break.

047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1263  		case NL80211_IFTYPE_P2P_CLIENT:
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1264  		case NL80211_IFTYPE_P2P_GO:
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1265  			return mwifiex_change_vif_to_p2p(dev, curr_iftype,
818a986e4ebace drivers/net/wireless/marvell/mwifiex/cfg80211.c Johannes Berg    2017-04-12  1266  							 type, params);
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao        2011-03-21  1267  		default:
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1268  			goto errnotsupp;
4f02341ac27f70 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2012-05-08  1269  		}
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1270  
e1a2b7a394ad8c drivers/net/wireless/mwifiex/cfg80211.c         Stone Piao       2012-09-25  1271  	case NL80211_IFTYPE_P2P_CLIENT:
9197ab9e5f3016 drivers/net/wireless/mwifiex/cfg80211.c         Stone Piao       2012-09-25  1272  	case NL80211_IFTYPE_P2P_GO:
e1a2b7a394ad8c drivers/net/wireless/mwifiex/cfg80211.c         Stone Piao       2012-09-25  1273  		switch (type) {
e1a2b7a394ad8c drivers/net/wireless/mwifiex/cfg80211.c         Stone Piao       2012-09-25  1274  		case NL80211_IFTYPE_STATION:
e79801ffe9c862 drivers/net/wireless/mwifiex/cfg80211.c         Aniket Nagarnaik 2015-07-16  1275  			if (mwifiex_cfg80211_deinit_p2p(priv))
e1a2b7a394ad8c drivers/net/wireless/mwifiex/cfg80211.c         Stone Piao       2012-09-25  1276  				return -EFAULT;
e79801ffe9c862 drivers/net/wireless/mwifiex/cfg80211.c         Aniket Nagarnaik 2015-07-16  1277  			priv->adapter->curr_iface_comb.p2p_intf--;
e79801ffe9c862 drivers/net/wireless/mwifiex/cfg80211.c         Aniket Nagarnaik 2015-07-16  1278  			priv->adapter->curr_iface_comb.sta_intf++;
e1a2b7a394ad8c drivers/net/wireless/mwifiex/cfg80211.c         Stone Piao       2012-09-25  1279  			dev->ieee80211_ptr->iftype = type;
3d8bd85c2c9e47 drivers/net/wireless/marvell/mwifiex/cfg80211.c Karthik D A      2016-09-28  1280  			if (mwifiex_deinit_priv_params(priv))
3d8bd85c2c9e47 drivers/net/wireless/marvell/mwifiex/cfg80211.c Karthik D A      2016-09-28  1281  				return -1;
3d8bd85c2c9e47 drivers/net/wireless/marvell/mwifiex/cfg80211.c Karthik D A      2016-09-28  1282  			if (mwifiex_init_new_priv_params(priv, dev, type))
3d8bd85c2c9e47 drivers/net/wireless/marvell/mwifiex/cfg80211.c Karthik D A      2016-09-28  1283  				return -1;
3d8bd85c2c9e47 drivers/net/wireless/marvell/mwifiex/cfg80211.c Karthik D A      2016-09-28  1284  			if (mwifiex_sta_init_cmd(priv, false, false))
3d8bd85c2c9e47 drivers/net/wireless/marvell/mwifiex/cfg80211.c Karthik D A      2016-09-28  1285  				return -1;
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1286  			break;

This break statement will break to the outside switch statement, fall
through to the default case statment, and goto errnotsupp.  But probably
the intention was to "return 0;".

047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1287  		case NL80211_IFTYPE_ADHOC:
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1288  			if (mwifiex_cfg80211_deinit_p2p(priv))
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1289  				return -EFAULT;
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1290  			return mwifiex_change_vif_to_sta_adhoc(dev, curr_iftype,
818a986e4ebace drivers/net/wireless/marvell/mwifiex/cfg80211.c Johannes Berg    2017-04-12  1291  							       type, params);
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1292  			break;

Return followed by break statement.

047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1293  		case NL80211_IFTYPE_AP:
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1294  			if (mwifiex_cfg80211_deinit_p2p(priv))
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1295  				return -EFAULT;
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28  1296  			return mwifiex_change_vif_to_ap(dev, curr_iftype, type,
818a986e4ebace drivers/net/wireless/marvell/mwifiex/cfg80211.c Johannes Berg    2017-04-12  1297  							params);
e1a2b7a394ad8c drivers/net/wireless/mwifiex/cfg80211.c         Stone Piao       2012-09-25  1298  		default:
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1299  			goto errnotsupp;
e1a2b7a394ad8c drivers/net/wireless/mwifiex/cfg80211.c         Stone Piao       2012-09-25  1300  		}
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1301  
4f02341ac27f70 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2012-05-08  1302  	default:
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1303  		goto errnotsupp;
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao        2011-03-21  1304  	}
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao        2011-03-21  1305  
eecd8250e492ff drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao        2011-03-28  1306  
047eaaf64503c2 drivers/net/wireless/mwifiex/cfg80211.c         Avinash Patil    2015-01-28 @1307  	return 0;

Unreachable.

abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1308  
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1309  errnotsupp:
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1310  	mwifiex_dbg(priv->adapter, ERROR,
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1311  		    "unsupported interface type transition: %d to %d\n",
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1312  		    curr_iftype, type);
abe3a2c9ead8fd drivers/net/wireless/marvell/mwifiex/cfg80211.c Jonas Dreﬂler    2021-09-14  1313  	return -EOPNOTSUPP;
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao        2011-03-21  1314  }
5e6e3a92b9a4c9 drivers/net/wireless/mwifiex/cfg80211.c         Bing Zhao        2011-03-21  1315  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

