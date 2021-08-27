Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC3F3F988A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 13:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245053AbhH0Lxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 07:53:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16960 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233739AbhH0Lxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 07:53:34 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17RA9fUg025577;
        Fri, 27 Aug 2021 11:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=YBvQM1MB2XHD9tN+RcqUIoUUFcttVDvcZb9HXTz+4Lc=;
 b=lPcHvwIAB+w6IQ8btBVEh4mlQ0c87S5MIBKrr3bHzyhdY/1LBfqdqtns73IuRZxnDc4C
 GZNjL7dijemQKCbx/rUXPhghjh7C9N8CbxyPoKbD88pE2qmUzp0cxYkVv18Ejd84JuJe
 f7k1ef00Hc2iREodiex/TixF1R7JLJ4Nw+2TYmXKmh9FefvDff5f8O2fRPoLnNdUw3Ze
 ZrCPuMXX3ylhUsQQliNoEnA9dKTyVpoiM9LFdX4CHnjqK5j9lWy/X8ppsKvBDal74oQd
 fmkJQsOBUJWUkWtXQL+58/bTEYFOQRWB8cn3WIByIVNR1Y8PiMu/dMDHAB/2vDmRwWY3 vg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=YBvQM1MB2XHD9tN+RcqUIoUUFcttVDvcZb9HXTz+4Lc=;
 b=hhJyCibkExxY7Q9Aw7UfOUPoX1PhK5SdHpFNdC+QWIkZWwk7LGlgilKQzijGZ7dZ73ol
 6YDPRTBrTLuzvFSgGWdnI/RBa09xaEE5uX3brUUIw7SfMtt45OtMGeS8Ry1S93tbo9JW
 k+lGFPchmWKdH+ej0rWf4D0AM4cTgkoQ3sw1+RzKgUi2SYn4h+9bih2gFFDpSxiT5SSi
 xXaoYk1K9B3/nCnf+s0cLwmlwFmFTpK550FJoZc+bi5ixKrXNbzBWyGb/Eyu6V1js0VF
 KMIoMiFWKoa+hJpanb7mvCH0eOmG4YnvcESj8eZrlDZ7lx9OwCQc5y4bupOeMu9wsIi3 Ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap3eauj1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 11:52:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RBpOss191298;
        Fri, 27 Aug 2021 11:52:17 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by aserp3020.oracle.com with ESMTP id 3ajsab3c31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 11:52:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmT/5DLk4UsnbA0TR9QiCz9a9Pg/MmrYv/EuzZqo+g3Nlvy1jz37Sj18YPIh7ZYpHjLmUFs0YsOI1LcU6iYJyBL75hTg5uKW1DPAewRSyxn1g+WbC3ZGWJnDkVlO4h/rVA4Ngz3J01pHu0etDsfrwP3DEH6ESuL83rBmGfvjDr1KkBgx60s69JJp/8HzECZiKYr3pT70/0b8cUG66Lnq/t4MhlnS4zGzlS8es+5xud38NAF8/fo6zVRomj4eCBOjTRZLtw3Yi31Cb59NURtwQHr5DhW+CUfS7BZ5cRhXhXh0oQsks1fy21Q8WeELqNe2IQBqFmryBz+z5UR6j87hVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBvQM1MB2XHD9tN+RcqUIoUUFcttVDvcZb9HXTz+4Lc=;
 b=ETT8dQzlI6hKK7p3Qp4gnPQSxNIQz2NDID0tQc2jG+oXKn8i/G5Byd68uxtO2MHfDAc11TTaLBAWVAWp6ZiEGOoHDzJON1zjrnPuBdmT1+pOTZjvd//chNf0qMuXWAr9rSvRU1N458WO+m9KumMKdeqTYCCbmdEC0YPfFbBEKo0Vusu+fkesXQkBaSqMWxPQEGdB3zE8zDOsPYgUdgRmxBvrvLEmrSoCvxn8I+ASgm/57E+UETE+IQzCfAzoFjaesMLJGqs8mZz/iQUq/u+DUIQKqluouMzSrkqTzkBmKOMwbUsxDi2pC+A/f4cQH+HzGDU1gcOYID8lCfKHtS/L9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBvQM1MB2XHD9tN+RcqUIoUUFcttVDvcZb9HXTz+4Lc=;
 b=WZ78fKq+LkkZepwVm/l21KCAvCXwyD8fEcw/DqSZzY9Z36OETO2Juo7TP7VmS0+QEIPGyZrBJrbmh+HI58GP6qspMOytHhTmMJVkRb7RYwkRJ1OkzjXgR+gC/mV2JTm631n7YggDTfquWhhyb2P4YZ1koTsfd7gidyCRNxtX0U0=
Authentication-Results: ispras.ru; dkim=none (message not signed)
 header.d=none;ispras.ru; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4691.namprd10.prod.outlook.com
 (2603:10b6:303:92::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Fri, 27 Aug
 2021 11:52:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Fri, 27 Aug 2021
 11:52:13 +0000
Date:   Fri, 27 Aug 2021 14:51:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Mike Turquette <mturquette@linaro.org>,
        Kirill Shilimanov <kirill.shilimanov@huawei.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] usb: ehci-orion: Handle errors of clk_prepare_enable()
 in probe
Message-ID: <20210827115156.GK7722@kadam>
References: <20210825170902.11234-1-novikov@ispras.ru>
 <20210825172937.GD192480@rowland.harvard.edu>
 <c22d943a-581c-c1bd-d453-3f0f6176c8a5@ispras.ru>
 <20210826152438.GB228824@rowland.harvard.edu>
 <4d91f982-99df-29d2-c335-1df0c23acbc8@ispras.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d91f982-99df-29d2-c335-1df0c23acbc8@ispras.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0037.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0037.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Fri, 27 Aug 2021 11:52:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72738e5e-5675-4424-071c-08d969511bd6
X-MS-TrafficTypeDiagnostic: CO1PR10MB4691:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB46914437420CC2362C0C2D788EC89@CO1PR10MB4691.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMakkLf32+FQQhCp/IZd07ZDuQVmJB01Su+k77tckb9UiaOoTUbE8ice1r1sbyQVoc5sI7Xot2fm9KbWOV9zfx9CQ7hcug2fx9o8+IVxpF+kMWBO4sJd00p4z87ssUAgLK/7Q9Qz2HtnbyEZK2/oZzzq35Y/bk/Iw9Ha/G8+4t7/n44WyfRoDRCheB90hT+P+xtxHPL/rzy/fyS/lFWPT3GWQuR5LOD0AuyOVGF+X4MdOBkM/fBr6m/fFdArcyazMB9qIxwD09eR06q5wIZxDpJRfu6hDKOqR27OQCw2wp+yVzhxyP5SmYsWVSCg9zEZur87u2HIUOD9APqWaOlPGWuMYhvWKbocVMJgjA4LEi3LUgTzXRDuSuRkCb0G+94Rza0Dw5wK02o6pi4axbPJ+zypm2FHq3SlTtLVlae6u3gmdzQhAOOvbNhPgoQZvvQPGlU1oPN9+KIuKK6g5h4pUemYjA6bcWG+9750NkziaiatrB2lnT5mCPsCyF0zlkRk8ISOSfLDaw1Sxq+GnFEii+yt/xpQoNMQy81cUWNnjzturFInc4GM8bUGLq3uVpwazFY/KKslKag1cE0/wYYdslLYZraoPyOk2z5jm/84l/lBo1j5/WC3rAP3ECQV21zo9zzArs/WbhoY8Q3FQ3m/QjyPC/5Osz9EQN1ZKUhm2OCOE9+nnFpPM6zMCCmb2TY4tj4Z9pw9QFfLOGHCsL2VFL0hyoHmeszDzh+BD+dnHHwGS0/gzs7PD9RMJJlLZpq5JRfCfSJSr8928VE9jJnEYilTUzYuvDj6dxcWtmZFE6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6666004)(66556008)(66476007)(2906002)(33716001)(316002)(66946007)(6916009)(1076003)(9686003)(4326008)(186003)(966005)(83380400001)(54906003)(86362001)(26005)(8676002)(52116002)(38350700002)(956004)(33656002)(8936002)(55016002)(44832011)(6496006)(38100700002)(9576002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?stlWIvkcMKKiLjpSstlh3xUV5CfRXObJ4MmZxa0ge52zTcwIuYku9YgbHkFi?=
 =?us-ascii?Q?hJrCy8/9MJl3ubZgFDB2C5dEJvN5gBVFwK8K780Yjv73QUlU+dNP4CessSeO?=
 =?us-ascii?Q?QS1gZXD7ZpPRg0ZNtyLdzIDandoqddVcZbkaqtdiqUnRZ6CHdT7rTJdVs8Gy?=
 =?us-ascii?Q?SLQxjfUjqzW0hfTFmOx+GPJWIEcFhvAYrYYqUAUyvF2Dd9RTO4jEGOJj749T?=
 =?us-ascii?Q?No5VWixFJRvqHrhUNVCSsH9IzO8joHDhSejUNtmp7qthzNLikpiHQ3S1oZHE?=
 =?us-ascii?Q?Mpiu2avkdsTXbNr7g+40Xq2z3KSj2dSH8tpPaqbzGlLgpq/TcDTiagALRAvO?=
 =?us-ascii?Q?gppWxKgZlK+udUsFdD0LZrGi6eaWd+3VeOVaya12Eux7Cn4e7noreZMTVFNS?=
 =?us-ascii?Q?n68fCTlC4a1Ug3x96jSa/SeMHBGiNBVFtq0gEwwXB9UAWTBBGD8RSrl+eWFb?=
 =?us-ascii?Q?kKia9mwxTFdFLiPG5kzvoZjdXEw5XVAPILE7BUGbMnbICOfusr08KBtM0Ahb?=
 =?us-ascii?Q?vNTS5ZoEaPIgMLdAxUcr3Va4SeF29Y+Sg4QxUCBr+rpduoBS+xsTGIUGq0iJ?=
 =?us-ascii?Q?C6U7hpH0jCZ/ciTA9oVs//5wxswLTzVTrDTHnHzDxyeIMI8aUIEBrwRngYuC?=
 =?us-ascii?Q?6AbkYcu1pSCeo8Q8sd7A8zUYsokBvYY1xooT+bH+6TKEAt7eGU+Si14TUfzL?=
 =?us-ascii?Q?K6FgJxNPan/FIegzqJn+LV+8+JijWp0PBKtJUzK7jf2WQGskE6LdToOpaZ9I?=
 =?us-ascii?Q?dsyJott7ikso8y8BUV3oTH/gRJyPoNQUUlY4sbdCZb4IbGbNTdemV1o+bIiD?=
 =?us-ascii?Q?0qm/ypLb8PY2fTTcI+i1e/N6sxGPPGCF4nWMaofwHH3IwU+UML8rIviUYzBM?=
 =?us-ascii?Q?WGLwWJbFDF508YHIJrnGc2w8cq2cYqaOabBlqQz5uzhIRouqmC0EuyUqhWgr?=
 =?us-ascii?Q?NK8L0hH4mZR+xoq/c1WNBK+q979nRSSCj2XWM6DsT7CPNbsPj3l+qBJ5MJi/?=
 =?us-ascii?Q?OlH14VIYuBTqn1yCpe3dwUwvaMoQX6mAwD827ClxPp2wauD/zLhaypH2mqGR?=
 =?us-ascii?Q?5fahsbOWGqeEUb6qEd2vC9sIyFsr8TsAwAwPps7nJ8sddJPAASmBkqz2iPGg?=
 =?us-ascii?Q?HTQokaq1RJuHn1lbGqn861ixRDz1NkCDCJIkjBjPfz4LufrgmFzToCivVnvo?=
 =?us-ascii?Q?4HCIdBg8/DoArNdZfwZX2ZMokAuZW0+icA8LNOPcalyE6cyvKLxusKh/MMAa?=
 =?us-ascii?Q?u8YF8n6KEQo//G+PnpWacdu4DI0qBFsNWtP/tf1oOi8TwSjKhRZz6oP/xovp?=
 =?us-ascii?Q?/wr/zJ5UyvbAlXG3O1FOIQfp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72738e5e-5675-4424-071c-08d969511bd6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 11:52:13.7046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypqI2VdI4lHMgTCvXNDILHZ5UNjAmCQwJRByL79FtlUR+ZyvkuTPGb+vPEdaNwnHm/jR6JRe0OyCnO7Tif7pBIOVOizFusptHbK4oP4So1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4691
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=775 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108270075
X-Proofpoint-ORIG-GUID: AJTuURYdl66exbWWaHoL1IcLBeB2sjdn
X-Proofpoint-GUID: AJTuURYdl66exbWWaHoL1IcLBeB2sjdn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 07:26:22PM +0300, Evgeny Novikov wrote:
> I added Dan to the discussion since he is a developer of one of such
> tools.

Thanks for that...  :P

I never warn about "forgot to check the return" bugs except in the case
of error pointers or allocation failures.  There are too many false
positives.  If people want to do that they should add a __must_check
attribute to the function.

You linked to another thread: https://lkml.org/lkml/2021/8/17/239

That patch isn't correct.  Miquel was on the right track but not 100%.
The nand_scan() calls mxic_nfc_clk_enable() so we should disable it
until it has been successfully enabled.  The current code can trigger a
WARN() in __clk_disable().  In other words it should have been:

diff --git a/drivers/mtd/nand/raw/mxic_nand.c b/drivers/mtd/nand/raw/mxic_nand.c
index da1070993994..87aef98f5b9d 100644
--- a/drivers/mtd/nand/raw/mxic_nand.c
+++ b/drivers/mtd/nand/raw/mxic_nand.c
@@ -535,11 +535,11 @@ static int mxic_nfc_probe(struct platform_device *pdev)
 	err = devm_request_irq(&pdev->dev, irq, mxic_nfc_isr,
 			       0, "mxic-nfc", nfc);
 	if (err)
-		goto fail;
+		return err;
 
 	err = nand_scan(nand_chip, 1);
 	if (err)
-		goto fail;
+		return err;
 
 	err = mtd_device_register(mtd, NULL, 0);
 	if (err)

nand_scan() error handling is still leaky, but it's hard to fix without
re-working the API.

Anyway, thanks for the fixes.  I've been inspired by the Linux Driver
Verification project work.

regards,
dan carpenter
