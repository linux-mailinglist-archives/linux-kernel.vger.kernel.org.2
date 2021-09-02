Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C073FF4FF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhIBUgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:36:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44862 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232057AbhIBUgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:36:16 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 182KDvmx002200;
        Thu, 2 Sep 2021 20:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=/Jy9Uu0XW5QuZh9sfOe0Za5474fp6sEYmS0dRv8Iryc=;
 b=lYYXdFidNMOrc/T99NE+6M2cWIGdA7mjlTsVXe+VYXzWtaU3RcRYoRCgFLzri/47wmRA
 rD0jLZ3wjy7xHbh8ZayyzxwZRI1u+x3UavvYdLocgGmAdE0fs7HzQ3w1QAe0yTwDhcMR
 osscCjI3cIaBFLLL7PZuaxnC925/3R625k8mhiweeYqEN8yEeJLB7TKTaB2lfx/L63vY
 ijl4wad3A1CGxC7tKj29zy7/j5o0PrgH+ZdQ03hKrXzhx7rB32I7xc+hOx4sW091sdjl
 mLzirxjkdeuIoAjsxHtPAYBGv+age6gM22i/1+c49/ArxnKAavwWEg9/E7HwcShlOKjo gQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=/Jy9Uu0XW5QuZh9sfOe0Za5474fp6sEYmS0dRv8Iryc=;
 b=TSMLOQllPz3QotPbd24/HkFTARY320Pyz0n77uU1s4WjpiU22tOF8JqysYVm/13Wro/B
 MAfIw8A58Tndn+p2gp6Wc1Ju87uArGgKNM+DrFikRRw8D+5iZH8EXN4RnJek8V/1b12T
 PZhQbFoJWGVUdFqbcS6zkTwuHGWgkuFdoussjtget0FGrUV+Pj1AEJ6/cVfoY/OLMoD0
 qhQPkFGk/bRQS1rJdKTEJbczaymiok80TPsQULVn1P152leDnuOIv+e31iJUCQqeeinF
 n839P0gwT/P5fji8lEXALcK8qmetCjpD80U5miF4wPvq08ukT3A8Le3LZEg8fMTldfJq mA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw5c03w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 20:35:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 182KGX1t032443;
        Thu, 2 Sep 2021 20:35:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3030.oracle.com with ESMTP id 3ate06dhac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 20:35:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvhXhYJi6eiIZY68ymt5yCzqbMFsCirnqeu9LfHvAK9zpiT7SDBtL5DJ0ZHBNzPb+1VYW0jJJ6CE1umKTIb/RmEPfbFpuq+oLwwVuFkzxuQxMV9hPpYcOH2EMdeeF+wJEsDXXx9FIc+prNwGMlbUJZf2ng9drfZdFwAYVDfV+yzTGXP10gGxQqLvjd0O3DltUVdxAKjAENLaqhkToSNnCwAlYOuAAeU4PgWaFaLkQCxYS/3QNMohwqlDYREWagxIayVbU7wpSk/obpWuqmPTFBYhYdpnM+ntEAEWVjwSB0cLCkIvjvQNoKY14zw1u6Vsvff9Jy2pWJtwSFcehPb0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Jy9Uu0XW5QuZh9sfOe0Za5474fp6sEYmS0dRv8Iryc=;
 b=HD6mJGVwbXtI8cOl7pSyN8OYM9P2HZf6iuW2wsZciQCksqTLWYsjaTct5HxPGadKpasAJtFKdVklqeOqZFXG9FNX3MyKsf5Viw3/J2OQo7jla7IwCN6dAymHoZguROxOOnmJn21KiFhv2zpArTmvErxcrOWTK+GOv2mzQDK9JTeNwMwWBM/DoJokmq1MZp0Zw/2+BAySEqy7F3xdfaS9OBPhippohyO9GkarlRsa8rIHK1n6jQBp7I5uICeWcNOV4BaoQsQcJqN0YqLySxIQl7QC1m3uKkSAnDJVh57t8+Xpmr5p5GKJYI7Jh/+1NZiVpfSQ+4SXTkpNjhPTELOUCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Jy9Uu0XW5QuZh9sfOe0Za5474fp6sEYmS0dRv8Iryc=;
 b=hmBbfitKmMIjwPeAiRJ6Sc776tIRrcq3nlL/EaoyBbcWjBRlgC+X8ePct4emv2g3M1VT9s7fJAG+h3XCFThCTMw2+uwPhfeaXZErGQifdx+Lrh9Bq2kPayXYALgFTmXERJ4TqFQhTtaSXbtzShxe6QzGbUt7Jrs6RVejf8jImGY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB4179.namprd10.prod.outlook.com (2603:10b6:a03:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21; Thu, 2 Sep
 2021 20:35:11 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c%5]) with mapi id 15.20.4457.024; Thu, 2 Sep 2021
 20:35:11 +0000
Date:   Thu, 2 Sep 2021 16:35:03 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, vijayendra.suman@oracle.com,
        mlombard@redhat.com, pjones@redhat.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iscsi_ibft: Fix isa_bus_to_virt not working under ARM
Message-ID: <YTE1dzQ7ytQWW4Ow@char.us.oracle.com>
References: <20210902140313.1555053-1-konrad.wilk@oracle.com>
 <20210902140313.1555053-2-konrad.wilk@oracle.com>
 <YTEGhPnQkgOiOHf7@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTEGhPnQkgOiOHf7@kernel.org>
X-ClientProxiedBy: SA9PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:806:22::20) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from char.us.oracle.com (138.3.200.57) by SA9PR13CA0045.namprd13.prod.outlook.com (2603:10b6:806:22::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend Transport; Thu, 2 Sep 2021 20:35:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b40d9b0f-22fc-42b0-df67-08d96e5128b8
X-MS-TrafficTypeDiagnostic: BY5PR10MB4179:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB417935227FEEF5F34A69723789CE9@BY5PR10MB4179.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dX12fHRTzUvt2RSh/aJ8N/6hQ2FOIfLZH3pVcYcxnnsuJ0CLY7ygC2YsQFA47Fnnz/q88iJwN+gYDv5bK3AFe/2aZHjgbNPVkJnzVC/wBDBUwOaYGvmZzr9qqqAWZHRbDPmu4FXxapFSW6a5wwS3XlTYXa0hkS5/pOeSFrU2+nH6SjcmstSgAK6ETQr9Gl8furCWFHY4B+VMq32al/USWxdabVFvucSfH2dfS4Y1pd+NJOdrucbFNXWMH3OdKtcU8DT9CjTZVTnqJpVhx4r0bzk154vKI3qJiJUPCQ3E8JoDhb/LN3T8gtmhP6F4pWu+OIzgs3r6sRPpJBe2zhMa1yncT42cyaaSUxd4Cf/p6rFN/Wy2lFsNDMS0aHDVKnSbbdd20gSGSFXdPvdK0z5qfbV7dGAdk2I6EsVNLuCsDDhxjhCGf2BtMF01l3Vkx24hJEFlAYZ8phYUe+YmkFCNqGjRbIdfrKCExhzDktWl3eYmIdmBRgPmiTFdhW3Bm77OwnDupTD5Lem72Ky5Pjco2JPDrGZV2AYa0Eo29C3exfHyybNddFdUJl/Vsk/NZvoDEUkjYhJ5NPn6azAZR4z/OKDIQ8kfToI9lpDRTlpMnGW1S0JHw2EGovkjJhSnhXiq0Mma60qzlzCHkRneszI0rFGYnI0AqwiPhtV4hosrWuZELITZRdDkpM0qxJZiO30usaMhsoeu9qSRA8C3Z+aTGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39860400002)(396003)(366004)(186003)(53546011)(66476007)(66556008)(66946007)(26005)(55016002)(2906002)(38350700002)(38100700002)(316002)(4326008)(6916009)(956004)(5660300002)(86362001)(8936002)(83380400001)(478600001)(7696005)(8676002)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LiWzPluIaWlSI3+gRhA6X55oIYwLSIPyJ/N1Ia/5qFFeMDVA/kX2T0SbdUAS?=
 =?us-ascii?Q?1Ke+CFUficWF4+T4VX5II3O43+YV39w/6Sj4Pw/8cHTKLNOuxUJp5JalFnkc?=
 =?us-ascii?Q?fCgTWz5TzCkHs12jHgq7g6q1DJgILLCUnsTdVMB/g2v3PHwdrgqwgAcmcIVr?=
 =?us-ascii?Q?T/87a8cVYSWoauDTWNz1VWK7eSoHcLP/vDk5uy/XUuiF3F8tpMF0ygo26nIM?=
 =?us-ascii?Q?zXGksZQvJ0V9lZwHKd2AJnt1soFx4ynonebXd3aWQuEE2bizKPS3qkm6AvEl?=
 =?us-ascii?Q?Frx/ZbvGF6WDgjHtB6Lcj+Ay5tOC+gU8FUokyORwRdh3enTZe7+qGbRcoezP?=
 =?us-ascii?Q?3QS08KVheVaJQZ7MGMwmqrsinc104DqMceONXAV6+QCvXWC2vWPA8MCtb1nd?=
 =?us-ascii?Q?GuhWk0hr4NT+/NlmHK1vRS2q+c8P149nAG8EXFfnwO/iaEcv14af4nhtA9wX?=
 =?us-ascii?Q?vF3nE4igN/6bVqM8zmNbRIbJdp1QGyp/NW3RGZbQdpEt3j3unqNwnM5igL5W?=
 =?us-ascii?Q?B9TfqEHr0Ibg8OpBBXLLRcElM48tuDHo4EBmiq1uvQEkAW365dDIv611rCv0?=
 =?us-ascii?Q?nmVVRP00mVuw3Ig2uTGsylEBjPCKU+nFBy9SJvLNqsVmIfxmQSTwoyqlM8G4?=
 =?us-ascii?Q?fxf0rahq6bCGpWMlVJCM20v9148H4JE8Rtmbbx/BJaHhaLMPgLFno7B+W/il?=
 =?us-ascii?Q?7v+rRfePxS0PZOwtw8AElnv67siogDNfOxo8Rm41W3ZZVrFQB//yPtyBr6Jf?=
 =?us-ascii?Q?bJBwEKslUSIHZUgt74qLK3ULc/WjmhIPeag2mUhPqdVOMjXPMstkp+/KOGiG?=
 =?us-ascii?Q?Iizi7+34t3NkZ5Sst+nNwPsWhdvsVseu/b+2oapywJM7sr2fmr//OrhUwegy?=
 =?us-ascii?Q?UaT4ivrEu+auFF+frQO2uf/Zzm4q+/KDPI3t4qIbklN9Lfc38fI8rs72ijvG?=
 =?us-ascii?Q?w1CMrhNLMExAyNmOUtJt/wgwjfU9shod6/QROja/BGH0kHDkFaqna42o8Eoc?=
 =?us-ascii?Q?GEY4eOvrwkSfCa4GPPRP3rEBfwBA0OiKHBjYKI1vbkvtxDU+7osRSiXn9zjs?=
 =?us-ascii?Q?oSZu+NW1MlzWuzClon0QaGEpogBSpXIQrbSZQhjow/o/eO8eq27IKh2DjzTY?=
 =?us-ascii?Q?tMcFepS4SpO0r6E2jxZSJiMlaiDS6Z04uY03NniMtHkwY8pISt365+FgjH14?=
 =?us-ascii?Q?D7KGXKE8hZVMrwsSZFbulsob39DCNTu4fNcpGQbculngYjui/LC/ESu0Y0Zr?=
 =?us-ascii?Q?7RgsZ6ePNMC+3UqCx9EN6one02HjdMRpGhGcJrL5Q/bOr+wRJ/DlUKuZQzfc?=
 =?us-ascii?Q?iquPDQ9c//yb++PMdSPxFDa1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40d9b0f-22fc-42b0-df67-08d96e5128b8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 20:35:10.9753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFx6t4HxsipnBuJbXIh77Ea8kbNvWmJwI+i8h9LHZwx+3Aey6o33X85ZYvDz5rESJSO1bsAuKeEtC+8BOm+jPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4179
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109020116
X-Proofpoint-GUID: GsPiE7wwu_9fdt_D-DMHYS20FOoLEV2G
X-Proofpoint-ORIG-GUID: GsPiE7wwu_9fdt_D-DMHYS20FOoLEV2G
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 08:14:44PM +0300, Mike Rapoport wrote:
> On Thu, Sep 02, 2021 at 02:03:13PM +0000, Konrad Rzeszutek Wilk wrote:
> > The isa_bus_to_virt is only needed under X86 and in fact the code
> > that sets the ibft_phys_addr is only compiled under X86.
> > 
> > As such lets just ifdef the code.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Vijayendra Suman <vijayendra.suman@oracle.com>
> > CC: Maurizio Lombardi <mlombard@redhat.com>
> > CC: Mike Rapoport <rppt@kernel.org>
> > Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > ---
> >  drivers/firmware/iscsi_ibft.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
> > index 612a59e213df..7cde1a7a3ab1 100644
> > --- a/drivers/firmware/iscsi_ibft.c
> > +++ b/drivers/firmware/iscsi_ibft.c
> > @@ -86,7 +86,7 @@ MODULE_VERSION(IBFT_ISCSI_VERSION);
> >  
> >  static struct acpi_table_ibft *ibft_addr;
> >  
> > -#ifndef CONFIG_ISCSI_IBFT_FIND
> > +#ifdef CONFIG_ISCSI_IBFT_FIND
> >  phys_addr_t ibft_phys_addr;
> >  #endif
> 
> I think this declaration should be removed after you added
> acpi_find_ibft_region().
> 
> Before your changes we had ibft_phys_addr defined in iscsi_ibft_find.c for
> CONFIG_ISCSI_IBFT_FIND=y and the declaration above was needed to avoid
> compilation error in ibft_init().
> 
> With the only use of ibft_phys_addr hidden under #ifdef CONFIG_ISCSI_IBFT_FIND
> this declaration actually hides ibft_phys_addr defined in
> iscsi_ibft_find.c.

Yes good idea. I think this below will work rather nicely:

From 799206c1302e8fabfab5a4151e74a2fe90090590 Mon Sep 17 00:00:00 2001
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Wed, 1 Sep 2021 20:22:11 -0400
Subject: [PATCH] iscsi_ibft: Fix isa_bus_to_virt not working under ARM

The isa_bus_to_virt is only needed under X86 and in fact the code
that sets the ibft_phys_addr is only compiled under X86.

As such lets just ifdef the code.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Vijayendra Suman <vijayendra.suman@oracle.com>
CC: Maurizio Lombardi <mlombard@redhat.com>
CC: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
v2: Remove the ibft_phys_addr as it is defined in iscsi_ibft.h
---
 drivers/firmware/iscsi_ibft.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
index 612a59e213df..6e9788324fea 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -86,10 +86,6 @@ MODULE_VERSION(IBFT_ISCSI_VERSION);
 
 static struct acpi_table_ibft *ibft_addr;
 
-#ifndef CONFIG_ISCSI_IBFT_FIND
-phys_addr_t ibft_phys_addr;
-#endif
-
 struct ibft_hdr {
 	u8 id;
 	u8 version;
@@ -851,7 +847,21 @@ static void __init acpi_find_ibft_region(void)
 {
 }
 #endif
-
+#ifdef CONFIG_ISCSI_IBFT_FIND
+static int __init acpi_find_isa_region(void)
+{
+	if (ibft_phys_addr) {
+		ibft_addr = isa_bus_to_virt(ibft_phys_addr);
+		return 0;
+	}
+	return -ENODEV;
+}
+#else
+static int __init acpi_find_isa_region(void)
+{
+	return -ENODEV;
+}
+#endif
 /*
  * ibft_init() - creates sysfs tree entries for the iBFT data.
  */
@@ -864,9 +874,7 @@ static int __init ibft_init(void)
 	   is called before ACPI tables are parsed and it only does
 	   legacy finding.
 	*/
-	if (ibft_phys_addr)
-		ibft_addr = isa_bus_to_virt(ibft_phys_addr);
-	else
+	if (acpi_find_isa_region())
 		acpi_find_ibft_region();
 
 	if (ibft_addr) {
-- 
2.27.0

