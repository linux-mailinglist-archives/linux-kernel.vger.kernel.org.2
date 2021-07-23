Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782E73D4097
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 21:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhGWSdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 14:33:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7594 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229461AbhGWSde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 14:33:34 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16NJ4ZNU015716;
        Fri, 23 Jul 2021 12:14:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=8npyLCnn28VMMtjyARsVFhIP6ZTz+F1s3/4zaLlTDyM=;
 b=VxFcQBVnznCChxxBSzqUWjRvmAz2dNXyQSm2hYtEe53yLIppCpu7M/y1uqRGvf28Z2Jn
 +l4eTe2nbLo6IH2tK+5sJX7kpYPcT7++Wbt1dDtjVHQ0SOLHXdhzlR5oJmsbix4GRua/
 ZwPipXBHW//dUTmwoY5rW2UKoAT0c41hRgo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39ycpcr0fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Jul 2021 12:14:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 12:14:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5u2yv58l4+eMMiiWDMoDiFEcFOpzs15kUTg/bH1XeAAmbYjOtAGxmMWlI8ztYy+c+U7GiQ5O/PDAFJNhZ6KO8ghkeAHE1TavPxEb4IP06+L5AGsU1b4g8+kL/So3SsxET6WoQiVbBk0HRARAqV5njYG8WgB1kHnBDth+fpNCN7CcuTDd+reePwFsV/8Z1xdxtAuGED561xhWU2p94QCW184js3LD+WB8zCb3RpDU34FxdFPPTxxWhX1cVeflLt4qj0O6O8h3k/aUaBdGdqHHyKmeuw7Xe1Q+fV6bYaSQfbXZ4ld5Y8XHZAF4qsyzgKNe9AKRud3Ti4TK/o/t0n8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgRtWjMUcUijJvtSIBPHm941ka6wzsfNp3OglRLdN3I=;
 b=OhdWzIIIzEaNmEUjFVHiVM7NWhn9DubZjnaTwdGtCNYBCWmJHlv2y8ELRsaG6Tq9qJ0m5OWwDTXbym0HxWBBKw2LzI5RuXWzDBKYpiBWl61HQ5682uTWEbaYYAsC4Dgh+eoSep/blP/L8sJA24bEADPqCA1fWWTtTkqy1QXdwypz+/s7f5Kd2egfIwKhlhtfAZx/F5Yowrd+EEnMLZGi7JVeaLoWDf4nSTfX9ZeSK5ZjPQ4luy0p8S6LCn86ey3O0v88bdXgoMLs/97u7wMz0+MkFoRWGyiPLMFNMIdgfjlIpYsqmqoOHUkr5uzSiYCjfXmvbsO+TiPoehKjzyXGGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4471.namprd15.prod.outlook.com (2603:10b6:a03:374::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Fri, 23 Jul
 2021 19:14:03 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 19:14:03 +0000
Date:   Fri, 23 Jul 2021 12:13:59 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Adam Williamson <awilliam@redhat.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] writeback, cgroup: remove wb from offline list before
 releasing refcnt
Message-ID: <YPsU9/8ZijTjHTWh@carbon.dhcp.thefacebook.com>
References: <20210716201039.3762203-1-guro@fb.com>
 <20210723183343.10017-1-awilliam@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210723183343.10017-1-awilliam@redhat.com>
X-ClientProxiedBy: BY5PR17CA0051.namprd17.prod.outlook.com
 (2603:10b6:a03:167::28) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:7494) by BY5PR17CA0051.namprd17.prod.outlook.com (2603:10b6:a03:167::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Fri, 23 Jul 2021 19:14:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64f202d0-f8b5-40e4-7072-08d94e0e0896
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4471:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB44712D77520D6BE5CBAE3FCCBEE59@SJ0PR15MB4471.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AX6fK+wyVY52zrJ+PVwvg9PAn3WlLDRxsn4jQGJ6LiPEnCKQm30APTgntxC1JLQjQJ34xlK0QWCiTaZh7hi4EO7VhLsoJw5yvmqFVGqHA2dAIdrDiVeJKESWYPzsXyczKc72VTtMzvXVCJYaITQovNv+rgdwap29vfBsCRxuB1a9gJLBpbz8v2dFLhTwlgmwhJ3FUjbDiIRhf6MHuqnGFEtDiMkzzoddnxYP/4BvRQrGQQVrGU6syle9ZV+06sDcBb86F046/LrIqTEKAIvpbdKW5XBfYcnDxcU8bOgPeFTwgxq/6uzknQTkmo2Jy6GN9R6KQmmudSijP5O4NNHPn8nPavsqQpgKqQDvPaTTWcfO1nPHIiCrOkt9ncIBf5Qa8J+LEoupWb6MiSpek3s1ez9DPRd6j6jwbkWpsNmVB6uvilFw41YcvYl6iEHygIXk2joueC5pGQby5gSATQ68jbsLgvUpl3j8ESS5EqfY3aeYa/aO4Ie2R0VREvVCjgBYViq+akNJ4+CxUFL22HttAhp1MG4ywf/Hn4ylFSIUZxn+CMJsbvkZGCmTAqLLxPV89BhOdASDzcVVYlgjyJwasj/EJyHm4XeCJGNjFmLz/Uz++MIDV7EYCnDHhyNE1ymgoIZ3l8oxVF4b12eT+i/fo/X8NLWkpaut3X04+k3CDBWieh7DShIfMyq7OJ0HOlt24qqLXbZGcZGsl3ff/K2qqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(6916009)(5660300002)(38100700002)(6666004)(4326008)(316002)(8936002)(83380400001)(478600001)(966005)(6506007)(186003)(66476007)(9686003)(66556008)(2906002)(86362001)(55016002)(66946007)(52116002)(8676002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Y+kboNDjEpUIGpwer58Hrx9uN5hl0y7a+WcClzW2bjkCw2zYX/AYPeRUy2I?=
 =?us-ascii?Q?iRqqyP5lqALe1Qcoj67wAV22gpqQTEMfGGqEOtjFlCB1OpihTXFIVNo41m/2?=
 =?us-ascii?Q?1wqnN9EU0CshmTkYMMJisAZEUP9TYAD3daYTKD2k5ORzbeZ3LBESd/y6+GMA?=
 =?us-ascii?Q?fs1iEHm/a7p2qn/fPGsI2dHZp2FK76Tjlr2sRlLLqEEfV+cecH7LLNujiMbY?=
 =?us-ascii?Q?ADO8KyLoD2q9x+ZcMz557YQKcbEAPZ/nYRNbpQF253qeK6xsO6LFoPCUvw86?=
 =?us-ascii?Q?47pMiC6f9RqBUS5WyBMQqh9/M3ZALZVhuZ2lXjShg8+15iREMnxGj4B8A0kL?=
 =?us-ascii?Q?6rkX9rf7RcPkFdoEqDIoKpsnadUZW2+YqyJtVisEWSJ69x5eIXT0cBhJ5D15?=
 =?us-ascii?Q?lO0wbJUacIBZsSU1Ui6YjtZ84WAYKVXXxxg763qtCtvAqldBX18MfcyWMOI7?=
 =?us-ascii?Q?gad2oSMn170hZvW5inRfmuhzg7AYSYRUEouJrkhN9MeOkDx/kaAGXAObqwIE?=
 =?us-ascii?Q?hl2OsVX9UP4bOI+TMHyVbsWwOrxQOuVHlUj7i/xmVqBg3AYkSuvEjSFWlGfd?=
 =?us-ascii?Q?xTms+ut3dD2ze/Qp35AFlGRGMAyszdhxLa8Ha0lJEl4+QK0j+iQjU1bU2XXE?=
 =?us-ascii?Q?z33E1fGU/Gn4Mpq/ZvQRH7LAeuJh9dTyVhx5pGspslmRL4ewc4XrwlKh2scz?=
 =?us-ascii?Q?+wfq/cysTfrfX7L9kKXFuPNVTlljnIpGMIbQwCgCFBCPvJZkx/3PgQn9ZNXK?=
 =?us-ascii?Q?LQeJ/X4lnRzof7/zswy7hqON4SZ0d2yKgUST9f08tXWH7MttMzr0Eu0RFURe?=
 =?us-ascii?Q?m+fje4+iJjWxwDeoxVlbi0q76zD6aoEZXXX/LNJWaWeI3zYZfJb9IAcHLJct?=
 =?us-ascii?Q?qGZdKx4QV/N9eiu6D4j76iWMrHFDmUDF311dxC2MMldfcnZEpSGPAd9zjPDH?=
 =?us-ascii?Q?brxuRXgUsyE8cTNGzy3LgW/eHDWS+NSvLlcLRiueMGBAEqTzsOEAEspHgUBB?=
 =?us-ascii?Q?a/11N9sfie6ItTIyfXmwaBBLa3zt11OPkRZvPs3Mw/mswv//My7RiIhBBwMw?=
 =?us-ascii?Q?j8D3q3sPNCPJo8vtDY3/bSGMKkEpgwJP99QrtXUBgqzkE1HwGr347MeYxI7D?=
 =?us-ascii?Q?AVlLA2XGh1WeR6PbgfNCxoo5lJdyM7dlu7R2skF+3D4gwdLyBFoMp2JXNViX?=
 =?us-ascii?Q?R85VRFdodenFyf3yn7EMEpznzFFT68fZTzmGemN8Gaidu3OjQDvvsaIl9ESP?=
 =?us-ascii?Q?TGn9cjQIwp6B+2z71ftV3bZ+lH/UaOiShwA4eZ/Ugl5Gu3EkYtQlxsM2kgl0?=
 =?us-ascii?Q?VeJlRM8BrMe17PssPqDby6k96zxg2XMZyQ2rvsqmxwc1Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f202d0-f8b5-40e4-7072-08d94e0e0896
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 19:14:03.2490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaaqyTGM2MTNEGUM63eckRBaDEEvWxyY0OW39/RCPWBQ+Zh6zyj7klAwc6Ph697C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4471
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 8KCDDihVaCBHQIP0AQCGF18qm5xhABkI
X-Proofpoint-ORIG-GUID: 8KCDDihVaCBHQIP0AQCGF18qm5xhABkI
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-23_09:2021-07-23,2021-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 mlxscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 11:33:43AM -0700, Adam Williamson wrote:
> Hi folks! I'm not subscribed to the list and am trying to send this
> using git-send-email, apologies for any weirdness related to that.
> 
> Just wanted to confirm the issue that this patch attempts to address,
> and ask if it can be reviewed/moved along. I look after Fedora's
> openQA automated test instance, and in tests of recent Fedora Rawhide
> composes, we're seeing at least one failure per compose that's caused
> by this crash (it usually prevents the system shutting down or
> rebooting correctly in a test which requires that to happen).
> 
> I can't actually confirm the fix as I can't really easily change our
> tests to run on a non-official kernel build, and our kernel maintainer
> (reasonably) says he won't backport the patch until it's at least got
> some review. But I'm definitely seeing the problem!
> 
> Thanks folks.
> -- 
> Adam Williamson
> Fedora QA
> IRC: adamw | Twitter: adamw_ha
> https://www.happyassassin.net 
> 

Hello, Adam!

The patch was picked up by Andrew Morton and will be soon merged into the Linus's tree.
Currently you can find it in the "next" tree (can't provide a hash because it's not stable
there).

Please, note that there it another fix called "writeback, cgroup: do not reparent dax inodes",
which you likely want to backport too.

Both fixes got some testing and reviews.

Thanks!
