Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4599B458D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbhKVLVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:21:31 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12932 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231383AbhKVLV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:21:29 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMABUwU006210;
        Mon, 22 Nov 2021 11:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=lrz0kx0up2zcolrLKzAGUtGUDW4u1r6aVVkIKCVg2zI=;
 b=zN3aHmiMwleGWI8PYUVomwqLw3jdRgSmUyrh4tllklcMdZKjpVgzK2X9uaf2zG+QBVIT
 e9ZO2TRjP1HKH+vjqpZ316RdEaKm4FYIDas1OhA04RsitJ2Pe5hYmkBrdq3FoZTk0G7m
 6N2FXYZ2JqzNabCjxf5png6ivaoaeXtOFGPfp/hB77fbdN7H44ISltJddBk6gIvLl4Fy
 g2OQlpz7/NGPIDpeCzwW5sYaXxU+OOBV0bbod8PQFXyE7IWNXmPZX3M+Wjxi5ZENdz2Q
 eRbf5UE8lmT+6wAALqegQ75KRsAQ/bGkGhZ+SrTJhVNJg9IJVHdiVSGWbwXz2LIqhoCo Mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg3051nkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 11:18:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AMBAwYv161867;
        Mon, 22 Nov 2021 11:18:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3020.oracle.com with ESMTP id 3ceru3brbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 11:18:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfIvvOeLa1HaEgW41SnpRb6zIWCnz9xGCjZCeSI7X3GrBx3wRqkKKhQHytJNSq2AUw4nje20uKrI5oQHVYFyGLMuZJxuGqjduil3WyAzIKcvUPhYH1S+62Cjyq5ZBLdejJ4vO+WhLJFNAgBF2VWXSuTH35elgK14xcuZCuj6bjG0DVmCpLrScMfHDTvqaWgA3PUUcXRZ0G5Jvb92f0JpN6KwuGn5Y611r1/suUf+vqRiRtW7qWLQ5MZu1qAgc+l3s/zkhgzt47wCVD9gC6nUsCRCah07Ug1SjJVHGPQyNYrRch1N2p72bTR3UCnlKxK3tB/2XT5LdvPyJao4EMmgTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrz0kx0up2zcolrLKzAGUtGUDW4u1r6aVVkIKCVg2zI=;
 b=PrF4r9jTLRj8Rg8oV3G1S3ioqIqEcIDzE8nJtaiAcMBapbwER7BM6AIyYp7G6VOdWA5zAhXOW3t42GbPLvg8fjmN2QfJ4wtMNQadcifuCK/mR4yxbP8G2dnq/76tJCHF15hH+aBpdGYNnb/vo/YmcKYEtYkhUbs+0c6t+PYpamUpS1djjQilg8QB8ftPFedebnPPIhtwPOaFLq/kk9wJ8WjQn52vmghLFKH2huu0/xvU2fNZwJs4ez1Nd4mtclvIuZ8ysnIMe6WIXtjAdTD4okhIp4U7kvavUl42p+QTCpdaBolgkSZW8OdPcYzg+buDm5Ehe4bDXfp+E5YobeDftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrz0kx0up2zcolrLKzAGUtGUDW4u1r6aVVkIKCVg2zI=;
 b=hh2d4C6GUXwP/rzhz6YfKJuZbCwxAfT1wA/IBdGb2snprgYkxELE3vjRjXJR9m3P5r0bbhLcSbHIjn8SvNvhT5yqyDOiVLAi9vX7fMzaxGvT0obFJBkSthe78DZWQx8oZngSWvuZMEiaZjWuDYnBLRpBofbTEaEWV9H9klg/kK8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5555.namprd10.prod.outlook.com
 (2603:10b6:303:142::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Mon, 22 Nov
 2021 11:18:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682%6]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 11:18:17 +0000
Date:   Mon, 22 Nov 2021 14:17:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Kishon Vijay Abraham I <kishon@ti.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [ti:ti-rt-linux-5.10.y 4405/10206]
 drivers/pci/endpoint/pci-epf-core.c:169 pci_epf_add_vepf() warn:
 inconsistent returns '&epf_pf->lock'.
Message-ID: <202111201630.4xbsgBqN-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Mon, 22 Nov 2021 11:18:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b6c2e57-edbb-4712-834f-08d9ada9c87d
X-MS-TrafficTypeDiagnostic: CO6PR10MB5555:
X-Microsoft-Antispam-PRVS: <CO6PR10MB5555FD31F05954286E6BCC6B8E9F9@CO6PR10MB5555.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s489ubqAIk3KO3m4wSqSYUdAYJ6NI+5FIDI9ggQ6DOPgObaovoKqynJ7DA1BM1OeNOrr6zY7mm7NEch63Ovv0f//9cNYCNPUGZkunc3eeumygM7MBN8gEHRUAxECDng2FZWk2aLFFNmBk0ob+ENDFeAlYrGnR51U9bc+fHGlqkwweT/YB6yFMaTWb0DL2YJFWE6ujTtxCEu/ppGKqLbxcnqT/OE4mPCeEDosUxTUp/IQdfewMIcHXVCNKs/5WbF3y20liVwZN8kil9qOeZ2oZ2cXVEmadz8vqzgCPYrR8+0EYrxbH9TZXvNLTTj7hRFCBxfyG+uWMDIIfyleC/Xh+kMpDPmh0O+Q4gQOV25Hao+YBnye57dC54EjZjR7ky0p8mKIB9VM4JHso5PQ7YQHg9/BB5zjr7cdheFDgVGvh89sy/tu5Ns0XXQPh6Zwwtk9YTiE5f+D57zjLkpk4eU+qDtjKOGHwwR1ORnVeh00rGHDdYdmXdP8oY+jQQoDd6C7VhPQYR0dOrkcHW3biyt5EGcb0a/R9P2VsEsTsFkQqhRWjvSw6CymGMmadCIDTy7eIEd2g8GkgawFxKRdWrkhMEDeIj39QsH6mYqG9SncykwaWhJrPEaXFZfE8nkyKPiAq2urXA84IH/t5XMSz0lwZ/4ChhYhX0qVuYj4Gad2L5yXQuUrnL99HvM3pYK0HdRyUh/e5xtikl3Es9KbImwwkmRkBiqWG8fgUBnDaVjf1ItRofeBo3GAmp03OGzaFXZwToYVotNtL7RERZ9jzy2qt2JNxges3g/LPsAW3LmCszk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(6666004)(966005)(508600001)(26005)(83380400001)(86362001)(4326008)(6486002)(66556008)(66476007)(186003)(956004)(44832011)(66946007)(9686003)(1076003)(8676002)(38350700002)(38100700002)(5660300002)(52116002)(6496006)(2906002)(36756003)(8936002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zvBHOXQ9eiQp5z/iXON0F41dXyiFxQCeZFGZa/EJZHsRCvhUMu82Xz++H+eO?=
 =?us-ascii?Q?e4ebwgzQ+m7kePmtx3v3d8tU+QeP2GqaXBCRjGw+2Bs48+A7VHfx1+0sGqHr?=
 =?us-ascii?Q?7n4BVBk4p31LifONQNnEHlK5UmxC9tPrCH1EWYXbyrOh2XGEHhPrHrSswU0H?=
 =?us-ascii?Q?k+cN4agSKBkBvuMO23Y5WzGdBTP9+jpnbDViO7uPgYY4IzdM2kK+ZJoOx+Hi?=
 =?us-ascii?Q?NJKHGjgvneAwuovg4ELS8fpxTvfarcISYKcVLs4gCxEhe8gmuT7NJSjU5w49?=
 =?us-ascii?Q?g+6OSXhIKviSqTPJknczP9sBE0Q9FH9FmtksAHy46iCr9+vAuyC0ve+BfRl7?=
 =?us-ascii?Q?jxN7EtWkJ8jA2bGPV31p5Q89hiDRboUfJbXIN5kW5jHoVskwv6laFy6EPS39?=
 =?us-ascii?Q?eIcjSKVwdCTTvFJ+OP7TloSC2bDaBRyWVAtfQO/6hqJV0mx0Awxae8ATfbqU?=
 =?us-ascii?Q?EqpV1VG3uU0kYftow6e3nF/4OGLMfgsh70AzsAPsZuZTQ16hjKLuk2OwGAkv?=
 =?us-ascii?Q?04FTf/pj2FrU/O3pF/EMq/KKVGdS/YpBklx6kZGPMJ1uzs0jldQbHJMJD6yx?=
 =?us-ascii?Q?GT+7/eiC6NRC04P3kmi8JBZgthBxL9DZC2WkjyZr9hAoSTanNy/jjHzUny5j?=
 =?us-ascii?Q?evi7jOk7ZxNAuC75Ae9sjbyqGgoo8QangJktNtzQ744Uo6+TVkLHgS0yalSb?=
 =?us-ascii?Q?m6+V71JMrZ9odRWjSnfZg8Ge4eSkYdgCds/gbSXL/3Hqrm03GGjcsdYRsL4r?=
 =?us-ascii?Q?6/jypryYAfC8DTFxL+GXP4PrTMS0qIaZGZWIAPkTY7oHIGu2CxPFgqJxnzQg?=
 =?us-ascii?Q?S5Ktm55XnuYi8iCpA96mRH9KRGZ6QywLBLk1yWfpYOKQtCufrDUIULU/bMSj?=
 =?us-ascii?Q?73/SmMPUltfjCZHE7y/iLlq50nAS+bBJBjUQ4/AquGii1y8aiJ39bOugvHCU?=
 =?us-ascii?Q?78XnNvp4lhqCssSU+yK8eFvYHTW2iSuVczM2PGDbNR4OYeaYebVFNQHl1n55?=
 =?us-ascii?Q?CuWzcqTJ+i7AmzugP9UNix+dk9PSEWz6Loa+p5xqm08MK1qVX8UzSRT1/SVs?=
 =?us-ascii?Q?YWOiuu0I9PONmueTZb54vKv5Vegu7xnV2Su0S695SfXkM0wjNdVjQfMVqFuo?=
 =?us-ascii?Q?XMt8vEkQx300C0KckoIUwKIBjW7f8TDeLGBcNGfgxOU9I50ntEbN6Rcn5Vqn?=
 =?us-ascii?Q?fgEqNj1Y/ZtclOu75YOqrCZ1XU7KPWT/7MiXhmuKzZNaZSV4BFK0/TCr/5W+?=
 =?us-ascii?Q?NcVfy7icT0RgiJjqngY5zUrq8S33sjA2HzRxt2Z+/wTDMUWUCmAIomxmFyR4?=
 =?us-ascii?Q?tp/VSD5d5SlHYe13txk3o1dB4V8bxLNY8SGQAyiMRmmAQHy7c/RRQZbuduBA?=
 =?us-ascii?Q?usqEqO0QFrJy09wOkz0NQlJBwCafm7yvjJTJDWO5aGemKVBQwz0pSpSMF0Dy?=
 =?us-ascii?Q?2TS9OIymsPfALOUUx7ipxIWi05zg1uoPzB3z8hpDP2e5pxuKml4RTaK/+J07?=
 =?us-ascii?Q?ADxp0G9rZvrqsAoizbAbISplhv4LfO9VUcCLhMhYHhPpcSWR9OKp+b2n0EEx?=
 =?us-ascii?Q?kDgQkj/6iKZX8nBN10M7qM1WQ/eCY9lGU3xhy5iEzCPP5FGWe8h+YOjh1vV5?=
 =?us-ascii?Q?VhAY5axcxbyPCjYfXyO/6jVshdkqoEl99DZZlmirZ5S9LPIkcS7dymBIP/sU?=
 =?us-ascii?Q?RD7Gs/M2dP0GCxQ+sftVSbsTbms=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6c2e57-edbb-4712-834f-08d9ada9c87d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 11:18:17.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMfG1z4b4WuiKnT2rXNXaVKLQ1EC2IuoUH+cKpMZ8jpGtIeWS+/hNmFopQWvUwV6qPNTlzSWSwnYPLZOMDZ9yXGoe/suDv3piO69X/PREd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5555
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111220059
X-Proofpoint-GUID: ZsHk_XyCEQ7p5VH7VCJehbYI8vRvMsPe
X-Proofpoint-ORIG-GUID: ZsHk_XyCEQ7p5VH7VCJehbYI8vRvMsPe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.ti.com/ti-linux-kernel/ti-linux-kernel.git ti-rt-linux-5.10.y
head:   0c67d996db8f3c9149598bc98657ae28fee22208
commit: 0cf43e35b1743dc43574089fcf3ff71d8cd2ae39 [4405/10206] PCI: endpoint: Add support to add virtual function in endpoint core
config: x86_64-randconfig-m001-20211116 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/pci/endpoint/pci-epf-core.c:169 pci_epf_add_vepf() warn: inconsistent returns '&epf_pf->lock'.

vim +169 drivers/pci/endpoint/pci-epf-core.c

0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  141  int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  142  {
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  143  	u32 vfunc_no;
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  144  
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  145  	if (IS_ERR_OR_NULL(epf_pf) || IS_ERR_OR_NULL(epf_vf))
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  146  		return -EINVAL;
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  147  
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  148  	if (epf_pf->epc || epf_vf->epc || epf_vf->epf_pf)
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  149  		return -EBUSY;
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  150  
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  151  	if (epf_pf->sec_epc || epf_vf->sec_epc)
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  152  		return -EBUSY;
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  153  
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  154  	mutex_lock(&epf_pf->lock);
                                                        ^^^^^^^^^^^^^^^^^^^^^^^^

0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  155  	vfunc_no = find_first_zero_bit(&epf_pf->vfunction_num_map,
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  156  				       BITS_PER_LONG);
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  157  	if (vfunc_no >= BITS_PER_LONG)
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  158  		return -EINVAL;

Missing unlock on error path.

0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  159  
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  160  	set_bit(vfunc_no, &epf_pf->vfunction_num_map);
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  161  	epf_vf->vfunc_no = vfunc_no;
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  162  
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  163  	epf_vf->epf_pf = epf_pf;
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  164  	epf_vf->is_vf = true;
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  165  
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  166  	list_add_tail(&epf_vf->list, &epf_pf->pci_vepf);
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  167  	mutex_unlock(&epf_pf->lock);
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  168  
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30 @169  	return 0;
0cf43e35b1743d Kishon Vijay Abraham I 2021-03-30  170  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

