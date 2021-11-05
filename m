Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F904463C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhKENF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 09:05:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4838 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231239AbhKENF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 09:05:27 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5CDkXD022784;
        Fri, 5 Nov 2021 13:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=67vX9sR3JKh1Z/52B4b/EtWbT2tIIu80dGs5Fyjv7sI=;
 b=wks66KJ+thlBg+1eCiMzmJTscEpDPwUibrNvljTrrfK4L3k9GI0pFpu5UC12ZkcbIiDm
 jtrtU0lxNwXziBBYViHlxbBM2cTk2lWE3G6r9V9g14itXMC2JW7136vEjcCtf1lxbfl3
 Vv1sQeItSN3BKu6OkVZKOwvwaiWuEUMZyISfFecqeSCInfOwTpWEp4QzrLAfu/gnzqFH
 nlbWsYJ1b6Citmh6kmgetXO2Bp2DKZS57+Pxae1MKFgdr4CJC3RvxC9HKKbSXcDpksKG
 qA587qikwumpTEuLHhwMsy3mrtJjlqwyel1ylPyNuV7kyQRdJP02ESp1IeODUjtuh+VH xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c4t7f2a28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 13:02:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A5CtEOd059247;
        Fri, 5 Nov 2021 13:02:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3030.oracle.com with ESMTP id 3c4t5cxns4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 13:02:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCaQz1o46LlZRjE7KfD92cFM0qB0U3G9poLo/5pV+W11wNPjDFw5Db1FCWEYljAJmcVGKiaY7n55IBLeZwsZwliOzYmqRCokS0Mn0clbd2sPo1mTMh0hLC8K5tyquugHR7IQ22dIK3b19/JE2crfO4Gp4N6P8ao3+o9qwlxCSHIsoXbf0xo/s3U+8nza0aflWwQLHBld0sXQPda8b+OyxAqghqlWaM0+2e34wyxYt+t/65G8aZ4djAjQq/Ad8IknzfPkTfPIL9d1xkWpobpQ2pnfEqAugUrjwL4TWm6EYQbEofIuYYEBDNrMzzJm20VxxRgbuTRTH+05ambyIKs5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67vX9sR3JKh1Z/52B4b/EtWbT2tIIu80dGs5Fyjv7sI=;
 b=X2G6SUfQOJgj9/j6oudcCuzWv1cwj/khOdeGenvP7tmEQYx9HGPCqY0pR78p+8RclxpXz71vmqrrX43JDeZVQgrjuE9bxWwA7Q4BUIl06qGLwJ9RBqMStsYVzOAuHT17MdLM/E9SqEWZ7bHHENnbPCz8nDFZsI9pnsSjOqnReiiQNtRhLSRjqHPcBUXmileNE/WhIuqKlQ9suSCIyLEnOJdD3cjlxP9Fb9JiWJrCrXn/xJOBzLg+81RhN/7+uOnmTU2rDmqIzcAfSqNGMxP2/WNleTmy2VeQbc/EUM+D74J36SS+YKblXZSnTyPudv16Ey81LtxZ3MtMSnVcoZz8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67vX9sR3JKh1Z/52B4b/EtWbT2tIIu80dGs5Fyjv7sI=;
 b=eBB6qdnk4kS/VT0e9x+VSQHwvLSPrlDgr5hv2NnyNN/xvSSpXXQvakG4fXDwMQ2GSgQQWCNR5qEG9hwO1QbbeDqYP6Ps8Kp0L/1hj9WEinWbgkEejCUEeYGsQrQ3M6iRsT7jr96YbYeofEGbyGsnCoOf81JQr6vfg986G+BYImc=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5668.namprd10.prod.outlook.com
 (2603:10b6:303:1a3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Fri, 5 Nov
 2021 13:02:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.011; Fri, 5 Nov 2021
 13:02:37 +0000
Date:   Fri, 5 Nov 2021 16:02:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Paul Cercueil <paul@crapouillou.net>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [drm-misc:drm-misc-next 1/6]
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c:1134 ingenic_drm_bind() error:
 uninitialized symbol 'dma_hwdesc_phys_f0'.
Message-ID: <202110301933.38nGMgE5-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 13:02:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7f89486-e222-4d92-8848-08d9a05c8a2e
X-MS-TrafficTypeDiagnostic: MW5PR10MB5668:
X-Microsoft-Antispam-PRVS: <MW5PR10MB5668FAC4195EABDF839ABF488E8E9@MW5PR10MB5668.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:157;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdcLTSpnGUBx0QQOL+dmw9Y0zJyEx2SqWPrvW4IskkLkhn7TBiHEEgyB6UxeOeLtyrXkWDzPWz8yvfwiEn4nuVRSgtcJxy39+ldiQ3EO6fyDhuzQV8OqHBDPhIeEne8fnn/V3lDcckQyDErXzBhsuP6ajSVzb9VbBUJgRpg/Q5wiIfrcSPN69vA0oOoMf3ml9yDKYXV1Wizys677l1BMZ7DSas7s77gsmnKRpvroe9K67MlKJ+LG0GUhUL9ujmRqhzECiwGeWPMC8pQzs7m90jFfQKEvxibODrD1+kKzlFIbQjGEm+vJTBnCRwBZBvFde1GUGCiTGvpAmkf5CWCTOzieH0cjT+KRpA58m9OonYqwQ3TJAY0uahYAhuW9ToQjYgqMTGAzWtVIby4qmLpImmTfohQYqTlLbPTf58u/oPW+9gqJL36xZyUZ+DtCaX4yZgwzTMZDdMmfcbTO/hoetj+QYG+shYbNgip3A2Gy916c0QGzIvV88nlUDlylRzAS7ZJgVtJENG5hlMObztk7Ktd0XxeIOAEmhla9g1wNadK4dXfhcIojKpxgJICbyO4V6aAGu7nyGF1ZlxtLLt3cyc04exDUwN0uJ/6y5qX7UFGXUifb5NQpyGF6Wz+jSEIONTCpim5Bx4GX1ALFkhmhpDbgX3Vu6ZzA+5vmUKbN3YpHUtOiACOIpfzj43ZVUmN2IarNb9aj9Qb43X7B8xpW/JPsZ0ZJ1uvzGvc2S1EXGXBw7a5mUTeRhBAYXaRAj9lHOElEISTLsqMQ+Mc8CbueQ5Twh/6EG+8hQB2IZQ4Oq7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(6916009)(966005)(316002)(6496006)(5660300002)(66556008)(66476007)(66946007)(508600001)(4326008)(83380400001)(1076003)(4001150100001)(9686003)(52116002)(186003)(86362001)(8676002)(8936002)(26005)(6666004)(38100700002)(30864003)(36756003)(38350700002)(956004)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MKarPy7CatAkRmBaow6QkvHFEol4m1eUZCHa26QSVPvlwbBT1HRyCxAf6yv9?=
 =?us-ascii?Q?pILOJOcPoV5/ozyKtPp3enabKzx7xTDeRgb0VKBq656nvLt1IrNR5AhVIpVY?=
 =?us-ascii?Q?2P2ryL3VV1XCy2IvmIep7zbMUrIYTlzrwvwdI57mv25jXjYv1IWqBSqOTf0a?=
 =?us-ascii?Q?bLP8Ayx1Jv2P0BpRv3zMA2zQFa31ZHx6jTAVLWL0IaUqQTKUdWLKkLYo2l8K?=
 =?us-ascii?Q?yZtedFxSX7IXvLZPWYKzCyFcW6fIJ7ZO8a4WkESxv5wCWmqPDaZL2Ip4NBdk?=
 =?us-ascii?Q?k1q+T0UagQWvnX2a5dp6B6nidCyQRZp2fnUdKm5p2lZkB/GSY6T32al8ZdZ4?=
 =?us-ascii?Q?ptBE7Z/sOL447ys3iECd+/TRbiLtFUfxRMylcJuAFVmS5YveRvmsqC6sUnVF?=
 =?us-ascii?Q?Sb992lZYtpo/F6EnMtZersV3jkaefSJi1dw3hoS4sKV3fVY9qanewAwN5qIs?=
 =?us-ascii?Q?6HO71WfV1uB8aGD2uePu9vgEo56RXoMHyMP44DgtRnMOwSxShreIdhKKilx0?=
 =?us-ascii?Q?c8+DXWIPYlf7Ogltz5+JDovXYILB1mDgkQ88JpnsUbxmL0FoUl6+QW5BcAW2?=
 =?us-ascii?Q?Xt/ovlKc5DLJo+lWssFqcDW3tSlepmbvgmfkFe6WLRAfjmXRdn/oh5q1dsVt?=
 =?us-ascii?Q?W8MRhXV+uHSwe9G0zlo7iPtAP+X9/UInE459Wn5uwefLIQRDgF/ZtaYv5UBN?=
 =?us-ascii?Q?rJkR3s4kXocG1QF1wmfwcAQ60mg3CtU4rqCb5GqtYHUH39qQvb1pdZEukDYt?=
 =?us-ascii?Q?eMxnd5VR/2jNvBOQwyRu4glgJHrMRRmz9oYYqZwWjM+yRnDGxk1tfRb6/42P?=
 =?us-ascii?Q?pyXgqgQsljp/HLG8sltaYSGi4MwHpY15im0AF2PwqgF65Gj36ftKH4lK4Xf2?=
 =?us-ascii?Q?2oKZSRwAX8qx38TRhcibGl6KwEtPBop/mqr/N5ghMuEIwCX8Xc90z5VnVHJP?=
 =?us-ascii?Q?ifWmN3gPkCY6oI+agjNBX0bSNN3StMW9Lmup06A2MFuwV+Brm3PSYo6wm99U?=
 =?us-ascii?Q?Ar+OJTsnbyGLAJZtZ7HAL05kgXZFgYrbRaRLwCHA9DxLvrr8ceUKZ52kxE9D?=
 =?us-ascii?Q?zshF9wPIgDLU85mdugbV2MO+FgfmNpzHc4E3XPYShQygbt7Gyke2uDjhnLVT?=
 =?us-ascii?Q?wzCf6AsfXodHob1GA31k51+rL+JEKV+eXCzKWFK1KS7NLIj97pY2ayW+U89/?=
 =?us-ascii?Q?z2wN1YRMBZhtjniROFV/ScUpJjYK29acQW0g8E7Ji29gKiZCQxbHhap9tkFj?=
 =?us-ascii?Q?3iAk3B2PL88txks0dVs80LPN1i6QTNl6WKp8g5DtViHE5+NE6wspQKZRE83e?=
 =?us-ascii?Q?0JLxSrgY2kkITfdNw3DykZ04m1sjRLOlD5pucw2zkFfrzqQShYsEnO41OI/J?=
 =?us-ascii?Q?oMST2F3HefPEUSmSLkWV7jTr6rW6egONeA2Xykj5JyaZKAbq3OIlYVZ3imVd?=
 =?us-ascii?Q?9THH2j0illJzCnxFkk+79/0G9cR3S4zU9QUtFnIcLyW/GcGMPVrQpQXij72a?=
 =?us-ascii?Q?Rlexj6lA3R4b+hKQ67RpxMmJI6b7SFCJgfrUY1hQFLy1SqYFyEYFYjJwZc/r?=
 =?us-ascii?Q?x41ZSynpzX3EH6lvEiLPwi6Yosc8SFMyGwRuZC3LlbifSJzjhi83CZLhOSh8?=
 =?us-ascii?Q?fcM0Mcwh5J/FRlNwBKWqvRu3yeBWnJwfMuKrs3uT6Kb+wpQfednAEDYEq2pl?=
 =?us-ascii?Q?XhdrzvLQLMUW9DKAWioSzL237n0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f89486-e222-4d92-8848-08d9a05c8a2e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 13:02:37.5936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0e2SSRCFtL3IagqRIwLk/sP82LESdQCSdHS9gTYI7wrxFXmOk0zhkLmUlYmmgMxg6XCsSWHB8IAzzjkN64yJ2ceF04MNercSIQJK142T1WQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10158 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050076
X-Proofpoint-ORIG-GUID: y3kGRPBM1dCGpvV91mU_HiSVNYJC0j00
X-Proofpoint-GUID: y3kGRPBM1dCGpvV91mU_HiSVNYJC0j00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   dded00395bdbd45a16d1504a1da77103522b28af
commit: 1bdb542da736e299a3fb291e5905a14dc955b938 [1/6] drm/ingenic: Simplify code by using hwdescs array
config: mips-randconfig-m031-20211028 (attached as .config)
compiler: mipsel-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/ingenic/ingenic-drm-drv.c:1134 ingenic_drm_bind() error: uninitialized symbol 'dma_hwdesc_phys_f0'.
drivers/gpu/drm/ingenic/ingenic-drm-drv.c:1135 ingenic_drm_bind() error: uninitialized symbol 'dma_hwdesc_phys_f1'.

vim +/dma_hwdesc_phys_f0 +1134 drivers/gpu/drm/ingenic/ingenic-drm-drv.c

3b5b005ef7d9e2 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-08-27   880  static int ingenic_drm_bind(struct device *dev, bool has_components)
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16   881  {
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16   882  	struct platform_device *pdev = to_platform_device(dev);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   883  	const struct jz_soc_info *soc_info;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   884  	struct ingenic_drm *priv;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   885  	struct clk *parent_clk;
7b4957684e5d81 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-01-24   886  	struct drm_plane *primary;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   887  	struct drm_bridge *bridge;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   888  	struct drm_panel *panel;
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16   889  	struct drm_encoder *encoder;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   890  	struct drm_device *drm;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   891  	void __iomem *base;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   892  	long parent_rate;
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16   893  	unsigned int i, clone_mask = 0;
174d8e52a60f19 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   894  	dma_addr_t dma_hwdesc_phys_f0, dma_hwdesc_phys_f1;
                                                                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   895  	int ret, irq;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   896  
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   897  	soc_info = of_device_get_match_data(dev);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   898  	if (!soc_info) {
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   899  		dev_err(dev, "Missing platform data\n");
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   900  		return -EINVAL;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   901  	}
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   902  
1677d31c226683 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   903  	if (IS_ENABLED(CONFIG_OF_RESERVED_MEM)) {
1677d31c226683 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   904  		ret = of_reserved_mem_device_init(dev);
1677d31c226683 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   905  
1677d31c226683 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   906  		if (ret && ret != -ENODEV)
1677d31c226683 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   907  			dev_warn(dev, "Failed to get reserved memory: %d\n", ret);
1677d31c226683 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   908  
1677d31c226683 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   909  		if (!ret) {
1677d31c226683 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   910  			ret = devm_add_action_or_reset(dev, ingenic_drm_release_rmem, dev);
1677d31c226683 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   911  			if (ret)
1677d31c226683 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   912  				return ret;
1677d31c226683 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   913  		}
1677d31c226683 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   914  	}
1677d31c226683 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   915  
37d8d81f019ac1 drivers/gpu/drm/ingenic/ingenic-drm.c     Daniel Vetter     2020-04-15   916  	priv = devm_drm_dev_alloc(dev, &ingenic_drm_driver_data,
37d8d81f019ac1 drivers/gpu/drm/ingenic/ingenic-drm.c     Daniel Vetter     2020-04-15   917  				  struct ingenic_drm, drm);
37d8d81f019ac1 drivers/gpu/drm/ingenic/ingenic-drm.c     Daniel Vetter     2020-04-15   918  	if (IS_ERR(priv))
37d8d81f019ac1 drivers/gpu/drm/ingenic/ingenic-drm.c     Daniel Vetter     2020-04-15   919  		return PTR_ERR(priv);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   920  
a7c909b7c037fa drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-12-10   921  	priv->soc_info = soc_info;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   922  	priv->dev = dev;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   923  	drm = &priv->drm;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   924  
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   925  	platform_set_drvdata(pdev, priv);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   926  
fe1cc102a381a9 drivers/gpu/drm/ingenic/ingenic-drm.c     Daniel Vetter     2020-03-23   927  	ret = drmm_mode_config_init(drm);
fe1cc102a381a9 drivers/gpu/drm/ingenic/ingenic-drm.c     Daniel Vetter     2020-03-23   928  	if (ret)
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   929  		return ret;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   930  
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   931  	drm->mode_config.min_width = 0;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   932  	drm->mode_config.min_height = 0;
a7c909b7c037fa drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-12-10   933  	drm->mode_config.max_width = soc_info->max_width;
96ea0ae692fe38 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-12-10   934  	drm->mode_config.max_height = 4095;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   935  	drm->mode_config.funcs = &ingenic_drm_mode_config_funcs;
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16   936  	drm->mode_config.helper_private = &ingenic_drm_mode_config_helpers;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   937  
ffa8aa00e9e589 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-27   938  	base = devm_platform_ioremap_resource(pdev, 0);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   939  	if (IS_ERR(base)) {
1f7596f4ad9b7f drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16   940  		dev_err(dev, "Failed to get memory resource\n");
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   941  		return PTR_ERR(base);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   942  	}
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   943  
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   944  	priv->map = devm_regmap_init_mmio(dev, base,
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   945  					  &ingenic_drm_regmap_config);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   946  	if (IS_ERR(priv->map)) {
1f7596f4ad9b7f drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16   947  		dev_err(dev, "Failed to create regmap\n");
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   948  		return PTR_ERR(priv->map);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   949  	}
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   950  
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   951  	irq = platform_get_irq(pdev, 0);
71c45008e2b0d6 drivers/gpu/drm/ingenic/ingenic-drm.c     Markus Elfring    2020-04-05   952  	if (irq < 0)
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   953  		return irq;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   954  
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   955  	if (soc_info->needs_dev_clk) {
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   956  		priv->lcd_clk = devm_clk_get(dev, "lcd");
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   957  		if (IS_ERR(priv->lcd_clk)) {
1f7596f4ad9b7f drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16   958  			dev_err(dev, "Failed to get lcd clock\n");
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   959  			return PTR_ERR(priv->lcd_clk);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   960  		}
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   961  	}
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   962  
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   963  	priv->pix_clk = devm_clk_get(dev, "lcd_pclk");
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   964  	if (IS_ERR(priv->pix_clk)) {
1f7596f4ad9b7f drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16   965  		dev_err(dev, "Failed to get pixel clock\n");
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   966  		return PTR_ERR(priv->pix_clk);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   967  	}
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   968  
174d8e52a60f19 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   969  	priv->dma_hwdescs = dmam_alloc_coherent(dev,
174d8e52a60f19 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   970  						sizeof(*priv->dma_hwdescs),
174d8e52a60f19 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   971  						&priv->dma_hwdescs_phys,
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   972  						GFP_KERNEL);
174d8e52a60f19 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   973  	if (!priv->dma_hwdescs)
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   974  		return -ENOMEM;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   975  
174d8e52a60f19 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   976  	/* Configure DMA hwdesc for foreground0 plane */
1bdb542da736e2 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-10-26   977  	ingenic_drm_configure_hwdesc_plane(priv, 0);
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16   978  
174d8e52a60f19 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   979  	/* Configure DMA hwdesc for foreground1 plane */
1bdb542da736e2 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-10-26   980  	ingenic_drm_configure_hwdesc_plane(priv, 1);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   981  
686d4b4b99afe7 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-27   982  	/* Configure DMA hwdesc for palette */
1bdb542da736e2 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-10-26   983  	ingenic_drm_configure_hwdesc_palette(priv);
686d4b4b99afe7 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-27   984  
7b4957684e5d81 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-01-24   985  	primary = priv->soc_info->has_osd ? &priv->f1 : &priv->f0;
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16   986  
7b4957684e5d81 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-01-24   987  	drm_plane_helper_add(primary, &ingenic_drm_plane_helper_funcs);
7b4957684e5d81 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-01-24   988  
7b4957684e5d81 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-01-24   989  	ret = drm_universal_plane_init(drm, primary, 1,
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16   990  				       &ingenic_drm_primary_plane_funcs,
3d705fb0dc43a9 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   991  				       priv->soc_info->formats_f1,
3d705fb0dc43a9 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26   992  				       priv->soc_info->num_formats_f1,
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   993  				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   994  	if (ret) {
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16   995  		dev_err(dev, "Failed to register plane: %i\n", ret);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   996  		return ret;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   997  	}
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03   998  
4a791cb6d34f42 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-05-23   999  	if (soc_info->map_noncoherent)
4a791cb6d34f42 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-05-23  1000  		drm_plane_enable_fb_damage_clips(&priv->f1);
4a791cb6d34f42 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-05-23  1001  
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1002  	drm_crtc_helper_add(&priv->crtc, &ingenic_drm_crtc_helper_funcs);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1003  
7b4957684e5d81 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-01-24  1004  	ret = drm_crtc_init_with_planes(drm, &priv->crtc, primary,
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1005  					NULL, &ingenic_drm_crtc_funcs, NULL);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1006  	if (ret) {
1f7596f4ad9b7f drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1007  		dev_err(dev, "Failed to init CRTC: %i\n", ret);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1008  		return ret;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1009  	}
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1010  
686d4b4b99afe7 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-27  1011  	drm_crtc_enable_color_mgmt(&priv->crtc, 0, false,
686d4b4b99afe7 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-27  1012  				   ARRAY_SIZE(priv->dma_hwdescs->palette));
686d4b4b99afe7 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-27  1013  
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1014  	if (soc_info->has_osd) {
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1015  		drm_plane_helper_add(&priv->f0,
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1016  				     &ingenic_drm_plane_helper_funcs);
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1017  
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1018  		ret = drm_universal_plane_init(drm, &priv->f0, 1,
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1019  					       &ingenic_drm_primary_plane_funcs,
3d705fb0dc43a9 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26  1020  					       priv->soc_info->formats_f0,
3d705fb0dc43a9 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26  1021  					       priv->soc_info->num_formats_f0,
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1022  					       NULL, DRM_PLANE_TYPE_OVERLAY,
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1023  					       NULL);
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1024  		if (ret) {
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1025  			dev_err(dev, "Failed to register overlay plane: %i\n",
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1026  				ret);
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1027  			return ret;
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1028  		}
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1029  
4a791cb6d34f42 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-05-23  1030  		if (soc_info->map_noncoherent)
4a791cb6d34f42 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-05-23  1031  			drm_plane_enable_fb_damage_clips(&priv->f0);
4a791cb6d34f42 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-05-23  1032  
3b5b005ef7d9e2 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-08-27  1033  		if (IS_ENABLED(CONFIG_DRM_INGENIC_IPU) && has_components) {
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1034  			ret = component_bind_all(dev, drm);
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1035  			if (ret) {
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1036  				if (ret != -EPROBE_DEFER)
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1037  					dev_err(dev, "Failed to bind components: %i\n", ret);
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1038  				return ret;
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1039  			}
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1040  
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1041  			ret = devm_add_action_or_reset(dev, ingenic_drm_unbind_all, priv);
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1042  			if (ret)
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1043  				return ret;
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1044  
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1045  			priv->ipu_plane = drm_plane_from_index(drm, 2);
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1046  			if (!priv->ipu_plane) {
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1047  				dev_err(dev, "Failed to retrieve IPU plane\n");
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1048  				return -EINVAL;
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1049  			}
fc1acf317b0108 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1050  		}
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1051  	}
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1052  
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1053  	for (i = 0; ; i++) {
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1054  		ret = drm_of_find_panel_or_bridge(dev->of_node, 0, i, &panel, &bridge);
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1055  		if (ret) {
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1056  			if (ret == -ENODEV)
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1057  				break; /* we're done */
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1058  			if (ret != -EPROBE_DEFER)
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1059  				dev_err(dev, "Failed to get bridge handle\n");
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1060  			return ret;
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1061  		}
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1062  
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1063  		if (panel)
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1064  			bridge = devm_drm_panel_bridge_add_typed(dev, panel,
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1065  								 DRM_MODE_CONNECTOR_DPI);
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1066  
e488b1023a4a4e drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-03-27  1067  		encoder = drmm_plain_encoder_alloc(drm, NULL, DRM_MODE_ENCODER_DPI, NULL);
e488b1023a4a4e drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-03-27  1068  		if (IS_ERR(encoder)) {
e488b1023a4a4e drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-03-27  1069  			ret = PTR_ERR(encoder);
e488b1023a4a4e drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-03-27  1070  			dev_err(dev, "Failed to init encoder: %d\n", ret);
e488b1023a4a4e drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-03-27  1071  			return ret;
e488b1023a4a4e drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2021-03-27  1072  		}
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1073  
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1074  		encoder->possible_crtcs = 1;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1075  
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1076  		drm_encoder_helper_add(encoder, &ingenic_drm_encoder_helper_funcs);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1077  
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1078  		ret = drm_bridge_attach(encoder, bridge, NULL, 0);
fb8d617f8fd64f drivers/gpu/drm/ingenic/ingenic-drm-drv.c Laurent Pinchart  2021-03-23  1079  		if (ret)
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1080  			return ret;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1081  	}
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1082  
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1083  	drm_for_each_encoder(encoder, drm) {
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1084  		clone_mask |= BIT(drm_encoder_index(encoder));
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1085  	}
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1086  
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1087  	drm_for_each_encoder(encoder, drm) {
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1088  		encoder->possible_clones = clone_mask;
c369cb27c267fe drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1089  	}
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1090  
613ba71619cfe0 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Thomas Zimmermann 2021-07-15  1091  	ret = devm_request_irq(dev, irq, ingenic_drm_irq_handler, 0, drm->driver->name, drm);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1092  	if (ret) {
1f7596f4ad9b7f drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1093  		dev_err(dev, "Unable to install IRQ handler\n");
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1094  		return ret;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1095  	}
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1096  
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1097  	ret = drm_vblank_init(drm, 1);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1098  	if (ret) {
1f7596f4ad9b7f drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1099  		dev_err(dev, "Failed calling drm_vblank_init()\n");
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1100  		return ret;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1101  	}
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1102  
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1103  	drm_mode_config_reset(drm);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1104  
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1105  	ret = clk_prepare_enable(priv->pix_clk);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1106  	if (ret) {
1f7596f4ad9b7f drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1107  		dev_err(dev, "Unable to start pixel clock\n");
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1108  		return ret;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1109  	}
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1110  
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1111  	if (priv->lcd_clk) {
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1112  		parent_clk = clk_get_parent(priv->lcd_clk);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1113  		parent_rate = clk_get_rate(parent_clk);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1114  
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1115  		/* LCD Device clock must be 3x the pixel clock for STN panels,
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1116  		 * or 1.5x the pixel clock for TFT panels. To avoid having to
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1117  		 * check for the LCD device clock everytime we do a mode change,
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1118  		 * we set the LCD device clock to the highest rate possible.
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1119  		 */
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1120  		ret = clk_set_rate(priv->lcd_clk, parent_rate);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1121  		if (ret) {
1f7596f4ad9b7f drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1122  			dev_err(dev, "Unable to set LCD clock rate\n");
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1123  			goto err_pixclk_disable;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1124  		}
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1125  
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1126  		ret = clk_prepare_enable(priv->lcd_clk);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1127  		if (ret) {
1f7596f4ad9b7f drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1128  			dev_err(dev, "Unable to start lcd clock\n");
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1129  			goto err_pixclk_disable;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1130  		}
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1131  	}
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1132  
e5507d2c01362b drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1133  	/* Set address of our DMA descriptor chain */
174d8e52a60f19 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26 @1134  	regmap_write(priv->map, JZ_REG_LCD_DA0, dma_hwdesc_phys_f0);
174d8e52a60f19 drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26 @1135  	regmap_write(priv->map, JZ_REG_LCD_DA1, dma_hwdesc_phys_f1);

These are never initialized.


3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1136  
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1137  	/* Enable OSD if available */
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1138  	if (soc_info->has_osd)
3c9bea4ef32bdc drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1139  		regmap_write(priv->map, JZ_REG_LCD_OSDC, JZ_LCD_OSDC_OSDEN);
e5507d2c01362b drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1140  
33700f6f7d9f6b drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26  1141  	mutex_init(&priv->clk_mutex);
33700f6f7d9f6b drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26  1142  	priv->clock_nb.notifier_call = ingenic_drm_update_pixclk;
33700f6f7d9f6b drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26  1143  
33700f6f7d9f6b drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26  1144  	parent_clk = clk_get_parent(priv->pix_clk);
33700f6f7d9f6b drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26  1145  	ret = clk_notifier_register(parent_clk, &priv->clock_nb);
33700f6f7d9f6b drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26  1146  	if (ret) {
33700f6f7d9f6b drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26  1147  		dev_err(dev, "Unable to register clock notifier\n");
33700f6f7d9f6b drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26  1148  		goto err_devclk_disable;
33700f6f7d9f6b drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26  1149  	}
33700f6f7d9f6b drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26  1150  
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1151  	ret = drm_dev_register(drm, 0);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1152  	if (ret) {
1f7596f4ad9b7f drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-07-16  1153  		dev_err(dev, "Failed to register DRM driver\n");
33700f6f7d9f6b drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26  1154  		goto err_clk_notifier_unregister;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1155  	}
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1156  
38d356c7fe7fd4 drivers/gpu/drm/ingenic/ingenic-drm.c     Thomas Zimmermann 2020-04-08  1157  	drm_fbdev_generic_setup(drm, 32);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1158  
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1159  	return 0;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1160  
33700f6f7d9f6b drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26  1161  err_clk_notifier_unregister:
33700f6f7d9f6b drivers/gpu/drm/ingenic/ingenic-drm-drv.c Paul Cercueil     2020-09-26  1162  	clk_notifier_unregister(parent_clk, &priv->clock_nb);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1163  err_devclk_disable:
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1164  	if (priv->lcd_clk)
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1165  		clk_disable_unprepare(priv->lcd_clk);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1166  err_pixclk_disable:
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1167  	clk_disable_unprepare(priv->pix_clk);
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1168  	return ret;
90b86fcc47b4d1 drivers/gpu/drm/ingenic/ingenic-drm.c     Paul Cercueil     2019-06-03  1169  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

