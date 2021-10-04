Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C675420705
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 10:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhJDIJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 04:09:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45774 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhJDIJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 04:09:09 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1947iYYJ018669;
        Mon, 4 Oct 2021 08:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=jjmtkQu7D56EULSZEq/Z0S1rclBnjwoj1csOo4U0cW0=;
 b=qh8Ut06kXxdcNgK9A8LtcRsEzX515DMtsBYw25BOPIyt06zNrtuk8UGuHZZrth7zBFH7
 Zc5KrbZI+lDi1wLeBKPKu+dythcDh5vwmPwe1hRTaSejqlwFaqJx6vg8ujo4oJp4UGAL
 3OATw8kBUSW/Om+Ol83Rk3PV/+U1IXipUk4AN3mW18I4nTG93I2kwJJgsibLUMbLjiG7
 tqwAwT+I2QHJDjeVPpiTJBun7iTyFVgqCA66GtjnyK52J37wM8qnTR94kX6AsRIESUlM
 MFVFYUIRZvtamB8iZtkFhhhurZh+eAaIs359EcwI3m9JcT1pOeWd8GU6UH2Xo2uQP+xH qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bf9m02jv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 08:07:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19484bf2179907;
        Mon, 4 Oct 2021 08:07:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3030.oracle.com with ESMTP id 3bf0s4hnhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 08:07:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqL7u63Ryj1/Mom1oc+rQ2NZzWUT7XbhHojDpGe4UrDvwh0+IjDdsF8SwgyTJo6ugmpST45sY17DHtlAORDUxWZ+EG9PgywsMtjB7L8Pr1Wba6vs1Dq7M67BXhaC/x6BTE7CCZem2y2XVK4a6+pDmGyaJN/GBJQUNGuPwrAePeTTb1vmKAdG6iXsUs3pL/YoI/4S+GW6KmqJzaljL1j2X9Ommk89G9TxQfjAN0cjLShxv75q/0rx6q0daZkW/QmN/JrshXM6xTkl87LUfbk/tJmrKtbAjuNVQMXcL0fpHnRO3Fbkik8wbe5bbuQ9Bsxoq/ASWySvpzaiViFyjBFz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjmtkQu7D56EULSZEq/Z0S1rclBnjwoj1csOo4U0cW0=;
 b=VpQHJs2Q4wwPZm1vaaneg0p0qv3TURugK9qJzDyRh1F0VYLYNBJ7P1JInA8RgoMtPNRaKKEvUVMY43r+MuPcIb4JA0HtOPElQI5gFfrPMXZFKeSNCTHJyMFPg/hwNpHOUJ0DyDqOx1E4Ebr1mFLeDw20EJ6ymmcbRbbKVr2AxJJZ2aY8N7gM2ZF5sMLmpwsNLo0/C9Txp0ip88x/GzkGf+D25DJQMkTWNPgtdT6jTTm45XhkQ1Y7aifwucwFUr7Kn2lUsdBUU5Pr44wLWlfP0Rb6ygw91dGwTYtG9/kdSJPLdmRJ7pOMClWPOP5DouFhJFoNKCILbCiTqbZ/ksGPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjmtkQu7D56EULSZEq/Z0S1rclBnjwoj1csOo4U0cW0=;
 b=w67P2ZI677XMWy2dVN+ZWyUdQx56thc35Q/zirkKwYa08+CAoXmG1nhF8IIx1LF3B3tBH5J/oRkxQLCsycMaFxL0tQWk/m3RJuJ0ZK36+FCrk6WVsrLCmlFovsmWC3pGij3M08wWPsiIyP1N5Aydjgeqk4OegJOW4w37cJZ1oZI=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1358.namprd10.prod.outlook.com
 (2603:10b6:300:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21; Mon, 4 Oct
 2021 08:07:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 08:07:13 +0000
Date:   Mon, 4 Oct 2021 11:06:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Daniel Palmer <daniel@0x0f.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 55/62] drivers/gpio/gpiolib.c:1130
 gpiochip_hierarchy_irq_domain_alloc() warn: variable dereferenced before
 check 'd->parent' (see line 1119)
Message-ID: <202110022143.w3Dgp3Do-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21 via Frontend Transport; Mon, 4 Oct 2021 08:07:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caf86461-4104-4498-6774-08d9870df936
X-MS-TrafficTypeDiagnostic: MWHPR10MB1358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1358A08F724DF829420842FA8EAE9@MWHPR10MB1358.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oy0zYgXkZ0/ckKIDnO0CD/83A5cmFPVL81A1YDmbpyQgqbXUZCjoxouglEMBiKdXjqO5lo0VG8sbqZC371N3RFx6WHQyUNPPbnpcKZtACnG2gsAgqgOuC3x0po4iXMLobsY6Nnz44RvrBqnM9GhQSAhpnbACVjnVSGwKLd7N34BLJdyCC05ElHX79RjWfKyhG1+NAP6Rxt0tfzd8fK5Dgk/MBsBDOB8YboDmt9+VVVgIklSXIYYoi48R5PlPXbci6X6iS9cEJ3DNYQrBRY458Unilh+ZpXlymQZqMMQFd7jAnhY10W/QZx+myPI5px2vJo6HGlnO83K+TZcXVuFensqSYnSdMUlstpz/qOXlPAJKvWy8CHOTEsKwL3H5I5+mM7Rc+xwoHyGwaDZftGGjeGZQlMGR8XdmFDr+5Bm6C1HpSGUzzz0UQcXUaPFgUZpU4+NGWjXojwt/Vr274iyKFnpyTCJPPoXU5Y1Tz2MvewqL62Qy+p7IXmXhNu2i1C0WZGaki8B++R6qVrhmyw+/ONvFmDCjafGE5GmjjXwO0mdYCPLTQmw3qDbps27m+8GqaTwUJnJ4BEohV0Dt0rvwzmu1UggXwr2Wlc6OeHcYo/IUTPCpoacnPSq3hEiaK83iS3auyjlBOjZHL9mG2Kwj4VO3WnX7cHz3a7TimZbdnUswfGUUKn0Nd0pNV39YG6xxTg+I57dplqJXJfSInO1N2YuF1jmshtmYaIPJ+A+bL26ZBaAz5q+DCTs+juwqYFQd82AzXj2Y4HDl/Fu7hH7i1NGLu4mDblicwEJMbHw4NJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(6486002)(52116002)(83380400001)(26005)(38100700002)(44832011)(2906002)(8676002)(38350700002)(9686003)(316002)(66476007)(8936002)(186003)(66556008)(956004)(6496006)(6916009)(4326008)(36756003)(6666004)(86362001)(966005)(508600001)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j34tweAG2c+ztQOnQvKC4xMEt+OER+tmK5iX8bUB3kNGIEXIAoZAiw7Gr0/c?=
 =?us-ascii?Q?qQ6R9LHgkEtrowBarnill1DftLSRF8WLKJUDrvDkM7fS7MFUhbXR032SouGy?=
 =?us-ascii?Q?nxiZtaCysG54iNsz0LLYq2XyenDAHh4QyPlqWQW5eVhu6wwiO9uClUR8MzFM?=
 =?us-ascii?Q?lLfeKrm1JfPWJI4Hjykny5Uiwkz7Zcq/l6EM27CVFiIwb6AE8nd+MqTXdlCJ?=
 =?us-ascii?Q?EiSPsQx3/MpCSELMw/RrsqXYUl8x4Mcg7MK2aG+0M0gMkQV54XvqxQO32QgJ?=
 =?us-ascii?Q?vOEQHut/rjkudcNDX716+obiCQj9rQTZ3JKIeiqnUvoW7IYa2YcM9MuAf8UJ?=
 =?us-ascii?Q?6PTRigloWLWeA+eCtXgT51PqkvqBO5c6oe/lF30Bu/Uuq16za7qtik7r6+rg?=
 =?us-ascii?Q?HVIFJx/8w6x+cVXKlS2CGO+eRh3r+a1KI5TNa9vz9KKUPVQ/NXXD5Ah+Wp7l?=
 =?us-ascii?Q?rvPkOiGhjTLiAN/qUjY/ZYTJIYBo7UmZo7/C/m2owx7WBzYxMh2TnV1opWL5?=
 =?us-ascii?Q?xZYgC10XNbzTKkSeQtDNTvgIVOatGb2PuHSDawae1qnaVyTcLAgjEfZVfoXG?=
 =?us-ascii?Q?7DqHH+NlH0oB4tVi38SzKL3cJOshuYJkx73SQBy2NJ19paTBvs3bi3Pybv95?=
 =?us-ascii?Q?E29qx46xjpRRUOv3ZPAna5RLsFKXyUExqSxPUXPoljJaFZdM1vhl/NLx/76h?=
 =?us-ascii?Q?ajG6Tt++Pf8FVT5QNvBBx4CNV2Pm03Sn20lHL+NDBJPpAtrqQgbPlEAxDrXu?=
 =?us-ascii?Q?I4PtWGpjd93cP4tu21ZvsZSK9qUis6/emz9lILAl67gzoJU70YC349ch1KHY?=
 =?us-ascii?Q?qZ2d7ucw6yTAbXlTqL63LRAJGZGtsa9wj73af1QZfks7/1OqV0kmm75eAiI6?=
 =?us-ascii?Q?co/lUgbwUr0NhFI10mpu6i8Y0vIjQlNx4IYRLQtuLtSY4V0tJNBrdmrzCOVU?=
 =?us-ascii?Q?7O9ypgXRBweghs3dhF8Ow6e9xfj225QOqxmYR5WBh9CN31HiUNaG+EAbFmwL?=
 =?us-ascii?Q?j1N5bHXl3UnvkYctpbVT1eUKt2D7S3reKvfmFSORw1SSnyyFut+IwcfZG1r7?=
 =?us-ascii?Q?TiIAyzbw0uw7zIP/bD2aquZCIvd+JFkMg2NLrIVDtge9FT+jKVuzwOHhcLrc?=
 =?us-ascii?Q?OUJhs6o/SMPKN+j7mK3ar2nXRWiR99gzEyCcrbsZ48XxN4/UHRxIOUxRbGc6?=
 =?us-ascii?Q?zcdzfpBM+rs2x4Vg1vWZbFqzdN1D7LQxwykpzSCBcXNx/6aqdAMPA4Co2arw?=
 =?us-ascii?Q?YTNfeMUe5Um6UhfzZqkTrGps5bEDcsSNw88CF12/scD44f7r7rgczs8EB2sA?=
 =?us-ascii?Q?OJ/wUGhtJwESoD1/2m82YEE4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf86461-4104-4498-6774-08d9870df936
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 08:07:13.6951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjNRwi2E73mc/o8xHh99d4LQapSncB9bldgoitechViKBoD3v1V9/MW+AyH5QSSF2yZW4WOHr+tcVkZrHxKC9o4U79CNoWXK1ZFtlv/tVSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1358
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10126 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040057
X-Proofpoint-ORIG-GUID: G7SCGTzj7JU5U6NvdyLzSsylJuFN9kEa
X-Proofpoint-GUID: G7SCGTzj7JU5U6NvdyLzSsylJuFN9kEa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   1b2db4b2c68fdb4acc386166e82a28dfbc808705
commit: fd6b9913190ecb45cee3195dc919b7ba841e625f [55/62] gpiolib: Move setting the flow handler and don't set it at all if there is a parent domain
config: i386-randconfig-m021-20211002 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpio/gpiolib.c:1130 gpiochip_hierarchy_irq_domain_alloc() warn: variable dereferenced before check 'd->parent' (see line 1119)

vim +1130 drivers/gpio/gpiolib.c

fdd61a013a24f26 Linus Walleij 2019-08-08  1071  static int gpiochip_hierarchy_irq_domain_alloc(struct irq_domain *d,
fdd61a013a24f26 Linus Walleij 2019-08-08  1072  					       unsigned int irq,
fdd61a013a24f26 Linus Walleij 2019-08-08  1073  					       unsigned int nr_irqs,
fdd61a013a24f26 Linus Walleij 2019-08-08  1074  					       void *data)
fdd61a013a24f26 Linus Walleij 2019-08-08  1075  {
fdd61a013a24f26 Linus Walleij 2019-08-08  1076  	struct gpio_chip *gc = d->host_data;
fdd61a013a24f26 Linus Walleij 2019-08-08  1077  	irq_hw_number_t hwirq;
fdd61a013a24f26 Linus Walleij 2019-08-08  1078  	unsigned int type = IRQ_TYPE_NONE;
fdd61a013a24f26 Linus Walleij 2019-08-08  1079  	struct irq_fwspec *fwspec = data;
242587616710576 Kevin Hao     2020-01-14  1080  	void *parent_arg;
fdd61a013a24f26 Linus Walleij 2019-08-08  1081  	unsigned int parent_hwirq;
fdd61a013a24f26 Linus Walleij 2019-08-08  1082  	unsigned int parent_type;
fdd61a013a24f26 Linus Walleij 2019-08-08  1083  	struct gpio_irq_chip *girq = &gc->irq;
fdd61a013a24f26 Linus Walleij 2019-08-08  1084  	int ret;
fdd61a013a24f26 Linus Walleij 2019-08-08  1085  
fdd61a013a24f26 Linus Walleij 2019-08-08  1086  	/*
fdd61a013a24f26 Linus Walleij 2019-08-08  1087  	 * The nr_irqs parameter is always one except for PCI multi-MSI
fdd61a013a24f26 Linus Walleij 2019-08-08  1088  	 * so this should not happen.
fdd61a013a24f26 Linus Walleij 2019-08-08  1089  	 */
fdd61a013a24f26 Linus Walleij 2019-08-08  1090  	WARN_ON(nr_irqs != 1);
fdd61a013a24f26 Linus Walleij 2019-08-08  1091  
fdd61a013a24f26 Linus Walleij 2019-08-08  1092  	ret = gc->irq.child_irq_domain_ops.translate(d, fwspec, &hwirq, &type);
fdd61a013a24f26 Linus Walleij 2019-08-08  1093  	if (ret)
fdd61a013a24f26 Linus Walleij 2019-08-08  1094  		return ret;
fdd61a013a24f26 Linus Walleij 2019-08-08  1095  
366950eeb6ee7ba Kevin Hao     2020-01-20  1096  	chip_dbg(gc, "allocate IRQ %d, hwirq %lu\n", irq,  hwirq);
fdd61a013a24f26 Linus Walleij 2019-08-08  1097  
fdd61a013a24f26 Linus Walleij 2019-08-08  1098  	ret = girq->child_to_parent_hwirq(gc, hwirq, type,
fdd61a013a24f26 Linus Walleij 2019-08-08  1099  					  &parent_hwirq, &parent_type);
fdd61a013a24f26 Linus Walleij 2019-08-08  1100  	if (ret) {
fdd61a013a24f26 Linus Walleij 2019-08-08  1101  		chip_err(gc, "can't look up hwirq %lu\n", hwirq);
fdd61a013a24f26 Linus Walleij 2019-08-08  1102  		return ret;
fdd61a013a24f26 Linus Walleij 2019-08-08  1103  	}
366950eeb6ee7ba Kevin Hao     2020-01-20  1104  	chip_dbg(gc, "found parent hwirq %u\n", parent_hwirq);
fdd61a013a24f26 Linus Walleij 2019-08-08  1105  
fdd61a013a24f26 Linus Walleij 2019-08-08  1106  	/* This parent only handles asserted level IRQs */
242587616710576 Kevin Hao     2020-01-14  1107  	parent_arg = girq->populate_parent_alloc_arg(gc, parent_hwirq, parent_type);
242587616710576 Kevin Hao     2020-01-14  1108  	if (!parent_arg)
242587616710576 Kevin Hao     2020-01-14  1109  		return -ENOMEM;
242587616710576 Kevin Hao     2020-01-14  1110  
366950eeb6ee7ba Kevin Hao     2020-01-20  1111  	chip_dbg(gc, "alloc_irqs_parent for %d parent hwirq %d\n",
fdd61a013a24f26 Linus Walleij 2019-08-08  1112  		  irq, parent_hwirq);
c34f6dc8c9e6bbe Stephen Boyd  2020-01-14  1113  	irq_set_lockdep_class(irq, gc->irq.lock_key, gc->irq.request_key);
242587616710576 Kevin Hao     2020-01-14  1114  	ret = irq_domain_alloc_irqs_parent(d, irq, 1, parent_arg);
880b7cf22e8ca08 Kevin Hao     2020-01-14  1115  	/*
880b7cf22e8ca08 Kevin Hao     2020-01-14  1116  	 * If the parent irqdomain is msi, the interrupts have already
880b7cf22e8ca08 Kevin Hao     2020-01-14  1117  	 * been allocated, so the EEXIST is good.
880b7cf22e8ca08 Kevin Hao     2020-01-14  1118  	 */
880b7cf22e8ca08 Kevin Hao     2020-01-14 @1119  	if (irq_domain_is_msi(d->parent) && (ret == -EEXIST))
                                                                              ^^^^^^^^^
Unchecked dereference.

880b7cf22e8ca08 Kevin Hao     2020-01-14  1120  		ret = 0;
fdd61a013a24f26 Linus Walleij 2019-08-08  1121  	if (ret)
fdd61a013a24f26 Linus Walleij 2019-08-08  1122  		chip_err(gc,
fdd61a013a24f26 Linus Walleij 2019-08-08  1123  			 "failed to allocate parent hwirq %d for hwirq %lu\n",
fdd61a013a24f26 Linus Walleij 2019-08-08  1124  			 parent_hwirq, hwirq);
fdd61a013a24f26 Linus Walleij 2019-08-08  1125  
242587616710576 Kevin Hao     2020-01-14  1126  	kfree(parent_arg);
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1127  
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1128  	if (!ret) {
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1129  		/* If there is a parent domain leave the flow handler alone */
fd6b9913190ecb4 Daniel Palmer 2021-09-30 @1130  		if(d->parent)
                                                                   ^^^^^^^^^
Checked too late.  (Already Oopsed?)

fd6b9913190ecb4 Daniel Palmer 2021-09-30  1131  			irq_domain_set_hwirq_and_chip(d,
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1132  					irq,
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1133  					hwirq,
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1134  					gc->irq.chip,
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1135  					gc);
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1136  		/* Otherwise set the flow handler supplied by the gpio driver */
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1137  		else
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1138  			irq_domain_set_info(d,
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1139  					    irq,
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1140  					    hwirq,
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1141  					    gc->irq.chip,
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1142  					    gc,
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1143  					    girq->handler,
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1144  					    NULL, NULL);
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1145  		irq_set_probe(irq);
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1146  	}
fd6b9913190ecb4 Daniel Palmer 2021-09-30  1147  
fdd61a013a24f26 Linus Walleij 2019-08-08  1148  	return ret;
fdd61a013a24f26 Linus Walleij 2019-08-08  1149  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

