Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4BC3BA8C4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 14:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhGCMxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 08:53:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8416 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230196AbhGCMxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 08:53:53 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 163CkjmM002556;
        Sat, 3 Jul 2021 12:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=z8rAldYfRCxNykxIE8ci3HJGYDKn08sy3ZLhjgfmjvY=;
 b=PfWV4q72bQkdVEpBcN+vneZZyghqS6EgyuTq6Lk9/FpSNyLyr973YiAxMcbPluIZ353T
 VG641BBy7Xz71chpAHIhciQ9Pk7E98l7TjyEHDMxkEwcUvIwOiNkDFPo47OgNyAGLS/O
 ucboUgqohqgWXrnaYVRld1C7tRrch00Yp9YKXFkUHCvjQK2VXY9A4+3Um/obtkYNKiyC
 fkyUhhbsMlfZ+n3GKPipEjmIVMZY7xqCbYtfB218K+iz71rPSKY9FuvTRYYFOtIBojxp
 JdxMkmJC26qlor39nkbQSsFAPzz6xeZLroJEkVI8C/tv2iX4vilq9QW8MHtf/TH3BNyg iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jfsc8bhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jul 2021 12:51:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 163Ck65P001934;
        Sat, 3 Jul 2021 12:51:09 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by aserp3020.oracle.com with ESMTP id 39jfq33jwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jul 2021 12:51:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxTj+NFf6vjo1jeDRIyvlvQrNTiFgINhfChnmiD8UMOP2/3ZuNKl7HSYCJlk/zcGAfTmZcsAvx+Q+F2q14+byCDXtn/2PdzLQMKBjc4jkq7Cp6V8bsndKcbghj3LFXvbJL50R8YxGa/CD5GLndifGxugEJCNSXWBH2YXUZzf3r/NLgOXTwYdCRn9l6vg9XlZGYAMoeK6iz914tsfFyPAA2LE6WNqDRrICkBg66e/rbByuOmzzPfCIedNysVECsQfZtMRwE1P0YWIuhT1u13/CMSeouaFmyT/adFKVv4vsnqmvvgRsTFwpj72AeZVBbdqnqzSGHtbu9FfFt6NEvP+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8rAldYfRCxNykxIE8ci3HJGYDKn08sy3ZLhjgfmjvY=;
 b=fOEABc1m6RoqOIudt59xXrr1nRisXbpa6ugFyNW6yq+t27I1ie8EGuU52zEXjzNiyvwNeQnseH3plsgix9IC6bmg8lO9pZH6WGNTO6w4dlmTS+WjjvIctHgA/jYV3AnKbqa/0eG5M7snyVO1xr+PjKz8kSFhpnsj58x0KcEpVQAzApRjV0/cWABjFE1W4Z/H/93zYiiNBBkxr3f9XCrXUv3IAx6uV7EUDgFJFgdFMryGwxB2FQvS1YYgn8wm+7DROyc2xgKRDjqRSUxPN6qFGd6yTpfTaQ6QakMURLwermy51xlZ9kyktG+w1mxa86njk1wZV3+iFhdGWQ85mflzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8rAldYfRCxNykxIE8ci3HJGYDKn08sy3ZLhjgfmjvY=;
 b=hN02A8A8VWRMP0XVH09P/IKAyE6qgmMFqm2YEDGlKxP+V+s3XyTaou+xCw3y+f1hKW3Wk/USOs0oEeuo9Wz1ToZGjimHK2dyJezQEwqxKsUxXYr9t/VYNoST9PKKGr3tdxPDo8TwniAQw5YMIk4aZqpGBdoEFaEpx3mlpXtAYus=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4706.namprd10.prod.outlook.com
 (2603:10b6:303:9d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Sat, 3 Jul
 2021 12:51:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.030; Sat, 3 Jul 2021
 12:51:06 +0000
Date:   Sat, 3 Jul 2021 15:50:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Hector Martin <marcan@marcan.st>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: drivers/irqchip/irq-apple-aic.c:849 aic_of_ic_init() warn: 'regs'
 not released on lines: 803.
Message-ID: <202107030700.SB4h6CEa-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [102.222.70.252]
X-ClientProxiedBy: JN2P275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Sat, 3 Jul 2021 12:50:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed4bed06-bcb9-4f11-0d41-08d93e213912
X-MS-TrafficTypeDiagnostic: CO1PR10MB4706:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4706F1AC0C1854CF14FBF2B68E1E9@CO1PR10MB4706.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ySullYMbLOYuScMCW8A6TeaN3jAExf3vmIRoT8o9HLpsCu/0fb9bA9hMcLlyl2Kjw3m0qXcm5tYUOqNIG1bwpEQ+N2AGjIRRYhj/60gaP0V4qkoAwj6m1dqwBBPG1EI+PDsDZjqlBIvUy+JvSXa/tHjDsDK6iMP75Rm/aK9TcMooC4sBTm+0rPeLJP+xS3QPXrC0hWFPXhmAxiS4efVMLQdOGRwvFyZhV9zycThXI6Cso9XprgJ8D1uWoBGrjlQfsY+2irs9NhSW8fQ8GXrsvhiMVh/NDFi70lBR6SpmmcqcGhne+vzJXnlzQpUymNIMMCsJ2djKYONDw5AcKKxGviQreHDTzhhVeTyEd46r91De8fCG67Ktukb+0f5WDrH6l59iF3jg/SCxffh+7FxjVQw9yTFgfFGAoJCzWjDri03E57M8O3HrZZ+T+EffqlECseSv2V5QAbiJcNZ77Z5TKf0wmjRI/S6tOJOJBQhvn150oC4qvXuklwRkD0cJG+27jIT5Tx+B46lL6uU06US2PZM1MxLF7SKNP13LCCdyoL4lafmqcGLZ1ZhDHY4iuYfEo2oTinW1NxcYVtIoRIb+3z2frxLJ7AyuR1Z6HEXyw8T74uvh9BjI8xx0tSa+crLEJiIj2LaeN/DPN8/AeqQAJQa/f7AgrC+6YWWF8nSVK8DYLNZwdO2+cko0TyCvLIKyaq7qLiS9gb5pN47IxzxHOELYe0KX2s5q6OXWC1f1faVOJuosFAAHLPCdhV+8Rt1lhw1IO7+R8GHgBLDA1Gqd5kkk55CYTKd9FP9ZrIBscKXYttaGAFuQmS/9eSE7iFVlIuT5Te2aYMuQUsBfGdfcYCNif3S9Od7lDC0RQqxxsN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(346002)(396003)(376002)(47660400002)(9686003)(6486002)(8936002)(8676002)(66556008)(66476007)(1076003)(5660300002)(66946007)(6496006)(186003)(52116002)(26005)(4326008)(6666004)(956004)(6916009)(44832011)(966005)(316002)(86362001)(83380400001)(16526019)(2906002)(478600001)(38350700002)(38100700002)(36756003)(46800400005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JQ05LZoVTHs17avw2ENapsx+UJQce6u6jxReGw4qmPJTKmKxeqjacf4ZEHOR?=
 =?us-ascii?Q?J0wQD9qTH2sJBk4g1/AYagtqD48f05y6ZHINolmah88IvYwry8NmgWhYdw3s?=
 =?us-ascii?Q?ZmNqaowif3ncRDVYCKbQT9MdWOrMDUQrkh42ITdv9P1Vq0zp+Mwi7Q/P3oSA?=
 =?us-ascii?Q?Ij9lehmlFDvYmwotP1AtFdHu9IkR2E68P6Gi8TiENjjFei3aimvYAu6GDZe7?=
 =?us-ascii?Q?VJrN7Sa9r5XxuN7qunCJtSdIDCFQiZgKr4wa+KtMFXlVtdPOBCqgT5NTyBcR?=
 =?us-ascii?Q?i92XIJOVFMLMAMMIXX7wiyWB40mFM6iQFe0SoLDbM/eMYjEgd/RlYNG5wgvE?=
 =?us-ascii?Q?NB6BdhNHLvsmRGqF1ARC5gmA+qCDWoB9zNTKsM9svnpUbExLJEnm1an7jySH?=
 =?us-ascii?Q?vWShghz7ydY08Y7sXFwY6T9TCdZ5EIfbbu2we0YsXTeEUXUNiTaAcGhb/i5h?=
 =?us-ascii?Q?lCY3lUXiXZ8a65Je1uPtc/Gj1ZaxsAaH06E2/r0CF3xRJ6KjKYzhZCY6nEik?=
 =?us-ascii?Q?kSL2csrvn0xxXvScIud5dxBIbwBNlho3R8Hy5jYI87wwNQLcYyuN5Ph3k6R4?=
 =?us-ascii?Q?qV5f6aT/BAPJC6vi536ldANOjGRMp7vWD4oNyDC11Y7hxIHho3n0FeAUu4bZ?=
 =?us-ascii?Q?EcMflUCb01lDluZjjVWzy9Y4onrUxwwsH6pMSfeU+3j6RrCZj8eqyxAtwTCf?=
 =?us-ascii?Q?Rh2Nl/rCJSAnnMXDyiigvVqV5BTCDsf+JYU7Hwlyr9ZPHhQ5/5vE1eH2KOII?=
 =?us-ascii?Q?cKqKfT5edkqFUHwwgyIenvDPPJXkA0dtift89nw1OolazLM9QUcSbQcd3wY3?=
 =?us-ascii?Q?fHNe4LgFc6zxP5HIvmb+q5KQMKa65YaWOanmEZRle6V0MqMOxTQ+9sCaaDXa?=
 =?us-ascii?Q?ythyh1Ekl9TUFSxdIpBBKf6Ld/CTmyUQHfW6+X9zEvIjUAIycADJzmz1lNJ6?=
 =?us-ascii?Q?RpaCFL2cUdPW49rwh9oxFA9tjr+wgZQIwY4/ktv5wK6ubk6qwjL8whoW/vPe?=
 =?us-ascii?Q?pyeB9dMMH6ubUku33EwpLgaIt/qTSWGIZfHgnsdsRhbEWXgp1mIcn000lepR?=
 =?us-ascii?Q?jzKHnxijIZK131XpIQ9YILgn3adCtYYhSaY/cS6y6DiR2a7pkX99wk2fUula?=
 =?us-ascii?Q?j4YhYfPzqfqMeI4Ej95JLNr2sQU3eMpOBulEq922iJsmH/UYoOe2126PnM7n?=
 =?us-ascii?Q?4ucnb6wbwNNCCZ8OnpGxByxsqJR4KRE6NqPzVYHRKD6tgKu/IvZZmPTU9rFf?=
 =?us-ascii?Q?ICwT+PWvuZo2syBmt+wziuq+6FzlL6AN3S7ExP+x+HF/q4je5tOaeYxzLRTN?=
 =?us-ascii?Q?3Q7z5ilxcNkrc1ePw152SrUT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4bed06-bcb9-4f11-0d41-08d93e213912
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2021 12:51:06.7979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uk5bbrXhXW/70DPu+IhTRNDpMEF6R3ZuEQob2zUqFb4/0Jl1NdBUeW9AUDjw3dqvtUKHSH9e7WCOkBe5zKuVMOS2pP8WCDL52eATSKhKVGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4706
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10033 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=946
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107030082
X-Proofpoint-GUID: ndT8ROq4a5P23-tmzTJtIjVzECh3NjJ-
X-Proofpoint-ORIG-GUID: ndT8ROq4a5P23-tmzTJtIjVzECh3NjJ-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   35e43538af8fd2cb39d58caca1134a87db173f75
commit: 76cde26394114f6af2710c6b2ad6854f1e8ee859 irqchip/apple-aic: Add support for the Apple Interrupt Controller
config: arm64-randconfig-m031-20210702 (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/irqchip/irq-apple-aic.c:849 aic_of_ic_init() warn: 'regs' not released on lines: 803.

vim +/regs +849 drivers/irqchip/irq-apple-aic.c

76cde26394114f Hector Martin 2021-01-21  790  static int __init aic_of_ic_init(struct device_node *node, struct device_node *parent)
76cde26394114f Hector Martin 2021-01-21  791  {
76cde26394114f Hector Martin 2021-01-21  792  	int i;
76cde26394114f Hector Martin 2021-01-21  793  	void __iomem *regs;
76cde26394114f Hector Martin 2021-01-21  794  	u32 info;
76cde26394114f Hector Martin 2021-01-21  795  	struct aic_irq_chip *irqc;
76cde26394114f Hector Martin 2021-01-21  796  
76cde26394114f Hector Martin 2021-01-21  797  	regs = of_iomap(node, 0);
76cde26394114f Hector Martin 2021-01-21  798  	if (WARN_ON(!regs))
76cde26394114f Hector Martin 2021-01-21  799  		return -EIO;
76cde26394114f Hector Martin 2021-01-21  800  
76cde26394114f Hector Martin 2021-01-21  801  	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
76cde26394114f Hector Martin 2021-01-21  802  	if (!irqc)
76cde26394114f Hector Martin 2021-01-21  803  		return -ENOMEM;

iounmap() before returning.

76cde26394114f Hector Martin 2021-01-21  804  
76cde26394114f Hector Martin 2021-01-21  805  	aic_irqc = irqc;
76cde26394114f Hector Martin 2021-01-21  806  	irqc->base = regs;
76cde26394114f Hector Martin 2021-01-21  807  
76cde26394114f Hector Martin 2021-01-21  808  	info = aic_ic_read(irqc, AIC_INFO);
76cde26394114f Hector Martin 2021-01-21  809  	irqc->nr_hw = FIELD_GET(AIC_INFO_NR_HW, info);
76cde26394114f Hector Martin 2021-01-21  810  
76cde26394114f Hector Martin 2021-01-21  811  	irqc->hw_domain = irq_domain_create_linear(of_node_to_fwnode(node),
76cde26394114f Hector Martin 2021-01-21  812  						   irqc->nr_hw + AIC_NR_FIQ,
76cde26394114f Hector Martin 2021-01-21  813  						   &aic_irq_domain_ops, irqc);
76cde26394114f Hector Martin 2021-01-21  814  	if (WARN_ON(!irqc->hw_domain)) {
76cde26394114f Hector Martin 2021-01-21  815  		iounmap(irqc->base);
76cde26394114f Hector Martin 2021-01-21  816  		kfree(irqc);
76cde26394114f Hector Martin 2021-01-21  817  		return -ENODEV;
76cde26394114f Hector Martin 2021-01-21  818  	}
76cde26394114f Hector Martin 2021-01-21  819  
76cde26394114f Hector Martin 2021-01-21  820  	irq_domain_update_bus_token(irqc->hw_domain, DOMAIN_BUS_WIRED);
76cde26394114f Hector Martin 2021-01-21  821  
76cde26394114f Hector Martin 2021-01-21  822  	if (aic_init_smp(irqc, node)) {
76cde26394114f Hector Martin 2021-01-21  823  		irq_domain_remove(irqc->hw_domain);
76cde26394114f Hector Martin 2021-01-21  824  		iounmap(irqc->base);
76cde26394114f Hector Martin 2021-01-21  825  		kfree(irqc);
76cde26394114f Hector Martin 2021-01-21  826  		return -ENODEV;
76cde26394114f Hector Martin 2021-01-21  827  	}
76cde26394114f Hector Martin 2021-01-21  828  
76cde26394114f Hector Martin 2021-01-21  829  	set_handle_irq(aic_handle_irq);
76cde26394114f Hector Martin 2021-01-21  830  	set_handle_fiq(aic_handle_fiq);
76cde26394114f Hector Martin 2021-01-21  831  
76cde26394114f Hector Martin 2021-01-21  832  	for (i = 0; i < BITS_TO_U32(irqc->nr_hw); i++)
76cde26394114f Hector Martin 2021-01-21  833  		aic_ic_write(irqc, AIC_MASK_SET + i * 4, U32_MAX);
76cde26394114f Hector Martin 2021-01-21  834  	for (i = 0; i < BITS_TO_U32(irqc->nr_hw); i++)
76cde26394114f Hector Martin 2021-01-21  835  		aic_ic_write(irqc, AIC_SW_CLR + i * 4, U32_MAX);
76cde26394114f Hector Martin 2021-01-21  836  	for (i = 0; i < irqc->nr_hw; i++)
76cde26394114f Hector Martin 2021-01-21  837  		aic_ic_write(irqc, AIC_TARGET_CPU + i * 4, 1);
76cde26394114f Hector Martin 2021-01-21  838  
76cde26394114f Hector Martin 2021-01-21  839  	if (!is_kernel_in_hyp_mode())
76cde26394114f Hector Martin 2021-01-21  840  		pr_info("Kernel running in EL1, mapping interrupts");
76cde26394114f Hector Martin 2021-01-21  841  
76cde26394114f Hector Martin 2021-01-21  842  	cpuhp_setup_state(CPUHP_AP_IRQ_APPLE_AIC_STARTING,
76cde26394114f Hector Martin 2021-01-21  843  			  "irqchip/apple-aic/ipi:starting",
76cde26394114f Hector Martin 2021-01-21  844  			  aic_init_cpu, NULL);
76cde26394114f Hector Martin 2021-01-21  845  
76cde26394114f Hector Martin 2021-01-21  846  	pr_info("Initialized with %d IRQs, %d FIQs, %d vIPIs\n",
76cde26394114f Hector Martin 2021-01-21  847  		irqc->nr_hw, AIC_NR_FIQ, AIC_NR_SWIPI);
76cde26394114f Hector Martin 2021-01-21  848  
76cde26394114f Hector Martin 2021-01-21 @849  	return 0;
76cde26394114f Hector Martin 2021-01-21  850  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

