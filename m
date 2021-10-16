Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946D04300BF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 09:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240533AbhJPHHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 03:07:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64250 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236688AbhJPHH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 03:07:29 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19G5EACR013525;
        Sat, 16 Oct 2021 07:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=kBiNG53k8V/XekocivRz+gybbAW77HZc5PLHqMzTDTM=;
 b=lcSDT+1EMtf7ID2epYGHshU+U1joPIOEvNRBT9rgirSL4hgq2yrsMHS8Iv33W1l7EI9M
 8LdQnj+R5nljMq9wtDdbqQdipoSSr9xZdg8TQvfpz8X6EeLsrapT20lJlZk5Ecf64pWj
 EM5gi86TfEP1uJSsNLMo65j8u956AJasudAqR/EnieJi/5viSHO4pmkXtXISCOca+gpz
 CzPk5Ax14xWpqXrs9knNT0d2J8dxRT6cg/O3rfubXJNG6HGW0uQR5yaNRGttQoyXJnMV
 MPrDPfC3o+E2nXDFiFToqM92AhjuooIxP+WFPHsNnLUWN9MMOhNXUNSGyFtBEFA8g8YT IA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bqqj5r6n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Oct 2021 07:05:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19G6vMXc125110;
        Sat, 16 Oct 2021 07:05:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3030.oracle.com with ESMTP id 3bqkut27jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Oct 2021 07:05:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEyBtU2Ljym3wdRCr0iTbKXiR18StwBSvA+JRTg5WL14GfhudCQJbyagfJaFh/r5Ng/XFwFEtSOOCTOXTvPLM27eWTdfzAhSa9nwCAGnM8JeNGStJzjLd3+EYuzAp2FUcH8TfpKARC6rBXhwe23LSQZtCHG2XlrMX7bCDWsMhARkiiAsZN+AvYcjUkYi47K4yuh2MO3B8ovRqvO+7c+xn7knPULLI+JL180pbi2z79kHpDswD7juzJo07SpqO6ktPHdukJ1ZywI1Ece+8rt4nIf7G+YYvzZrCrggcCzi/rFAfCl4mKY5SdiEV65KXW6ba57MtiSfnYDgm0zYH55iRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBiNG53k8V/XekocivRz+gybbAW77HZc5PLHqMzTDTM=;
 b=asNUD5cl2T/A9q4l6kvJEd4iHOVXyNe5hMhdedqNwy+hUXh71M64pMkB0qMLkS6FtQlP/WL/Rg1RlgVMCfI3BBIQaGx5pJ+l5dsNnLRa6sgbboMkZZ0bXvJp4MFh0oGuTet/0j7cdKMiEVntTTN1bQN44h+6qvYNiHPR810yjqW26JkvHEKOdq3bjzcsmBZDmOWybQhG5yn0cJVgW4pKgLkBJuybO9s64PeRkDhwBgRZULEGOXD2wB9Xo8bKmdKlHtc5Q+1PsZGZMGucoKoxqbHNq3i7sCoRTf4gMNLN378UljmFGrisjjMc+THBlzfyeInXEMPyvQOV7or/KIfN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBiNG53k8V/XekocivRz+gybbAW77HZc5PLHqMzTDTM=;
 b=LCWi/e8e0jVRDS4bnIcH60fX59HZqPtC+Wk4U/PngbrR/blDnVBMpqb3G9B2urCw+n/b7mSpYbjcs1b8OCjQbvTrtdsoidSBwEH9+KdHOlMiywEe3acWxMDzNkDda2AoPEZsQFkIXVJZL/MFQzhJ+fxwzo9aB6cfHtrhkq1aa30=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5678.namprd10.prod.outlook.com
 (2603:10b6:303:18c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Sat, 16 Oct
 2021 07:05:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4608.018; Sat, 16 Oct 2021
 07:05:13 +0000
Date:   Sat, 16 Oct 2021 10:04:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] staging: wlan-ng: Avoid bitwise vs logical OR warning in
 hfa384x_usb_throttlefn()
Message-ID: <20211016070455.GT8429@kadam>
References: <20211014215703.3705371-1-nathan@kernel.org>
 <20211015094344.GQ8429@kadam>
 <YWm2oVk9YKzjhYYi@archlinux-ax161>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWm2oVk9YKzjhYYi@archlinux-ax161>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JNAP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Sat, 16 Oct 2021 07:05:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e95e530d-22be-4fdd-a790-08d990734c61
X-MS-TrafficTypeDiagnostic: MW4PR10MB5678:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR10MB56782EA8F9DFD204700606D08EBA9@MW4PR10MB5678.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itaXjb4KX2mhFpXPATpwHPEchNw/No1fBYGlf//K9CqLbK8SEb9DYNt8QV/CDkLIhUXiR4tnxc6kOZPohaaNYfwC1OGDIu912ACxCI2adWjrCcg8x358UA0Cd1CMQ9H702eU1hD8pr908s3VGjujTiFP8rMdpoRYTBETYdq0SAiA2el5wA9DV5GryblAE58t1IZDvvTJyqBXyq2m4VncB0Eh0kpaax+8yC8qpLJ0D4075kDIwADNB/7ranSVVxcOS7snc1IavPKrsjR1D1aHuFC/zbj4z8igD6MUpbB3CeatU2NZBSNfTc++JQZ4Z3ZH0nOlkPuug5OliPvKXhdLzwLDi0l235iiT2GrMGsspzJNAtYj19XxA5UMqvR1xiH9g2Et6reN0P+7wmFajHRxrmg78u1wRwIqsbernYdP0Gj52S7OsyP203vi4PS3uQ9hLqoIGGrCFCtbp2X2+K+39uxExmXab7RN546njRoN7TTpZs0MIk0b2uOmrmWzGKPW2NgfVYfFlnEl0i+91/ky00DQWgdD2BotaYdACaAPaPUAtpNxjSqHnKkofQBahtv/uD/3ateMJ3QjR2fT2OHPRgpaGpBPVaLI2Na+74Lga/NmfvpXr1yeZsUizP8cotl64hUTf+s3Pr57aB0YKVtStg2gKHaygkQce6hEjwtdv/+XDYym7SZF94WUULIq8uux
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(33656002)(83380400001)(55016002)(8676002)(86362001)(54906003)(2906002)(6666004)(508600001)(4326008)(6916009)(956004)(1076003)(6496006)(52116002)(66476007)(33716001)(44832011)(66556008)(38350700002)(38100700002)(186003)(316002)(26005)(5660300002)(9576002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v8mFs4lUAH3QQRdihVzbrvJnzIJ+Sici6TwD0yVHJCwLpnXGSvYVSiWdc+ot?=
 =?us-ascii?Q?ox5HwDySmXEPNLN5C6gEU450gIlUOryrTOk6mNWfHAHQJmU3rS9YH19+AmDi?=
 =?us-ascii?Q?69Xq+SecBDXj4n1Ai8CwOYNvvxyAcGMXCc1w4uur4lD9x4PqbDxBYoqwaQ2f?=
 =?us-ascii?Q?EnhmY1bHIj5DGZXXhq9W+ALcpvukOBhWXQY3oxMX+DM724ygl+qntRDN0yp5?=
 =?us-ascii?Q?J1nMzRVD4qxbaPX6U84gyzzojYi/vkqkRndYIRItqyMDKU1AX+JLvrLRLHGx?=
 =?us-ascii?Q?nnUkqta4bMFZI8NQNVlnSZykCcFvx9dhKeUZSlr/BhtXGRqXLmC9QgGhd44N?=
 =?us-ascii?Q?CwQ6VExQr/5sEjTPddSgojYMuVCNvNX/s7tGkXcJoNfeDtK187HSjkQb199K?=
 =?us-ascii?Q?inqcb1A9Caxvfl6szrrD1vYp+RIOH/LiJzWyR2HA0FxGWXvcTmjM2viTJ40t?=
 =?us-ascii?Q?41Lgrsu/U0VPKEo5RiIrUuQH5btvogQ8x9guaYmTVHB+Ni1TdWIs77wTpbmp?=
 =?us-ascii?Q?IGeSwo1uCqRDKTHbdzW3Cc7YrnSAQ+RdDZZC1/hGm/Q3xmkV1kDjrp0WzOcK?=
 =?us-ascii?Q?VMQ6+jAtnDHJSxFPwDFbVuOJca877FCC+VPraq1TdltwPyBqYxXXTzJfdtYB?=
 =?us-ascii?Q?4zBJGhC/vjGri0nqmYCpvGn1JIdN5C3GZeocuyGn/5+jWtFtqTylTa8AoMVx?=
 =?us-ascii?Q?qMgIteh+HiUkA25ueINIh0cOU4+iHc1iRdYhLFRgfpoFuLYlrc7uWcOA4OZV?=
 =?us-ascii?Q?eXCb4NKR6NnyIGhxn3bp1DOCgw2j1t6a98B6fXMS+kWV+E3FMl1G+8aEc7dF?=
 =?us-ascii?Q?Pu7WNrCGnCoA4W9wepXmj+I3dXKzH+lbwvZh1P+z3SyFsbtophLYWXTbaVj+?=
 =?us-ascii?Q?/d55yVQlDjDBnzTMUkg+QlZ7Ej2cNfYbPzQIMLkqdYAi7EP/KqOqFNjBkmcc?=
 =?us-ascii?Q?Yh/0eBMGRgiZOgugL5V6mijxQZQReiecQSUNbtc/Lrt4ZP1coLYYCWU+fOTN?=
 =?us-ascii?Q?cc3Td0VbzF1eJDEFG6lGMl9YsnEavVHwepIMcF4JMP1JH7PjxKp2Q1slX7Rc?=
 =?us-ascii?Q?0nyEr6w4tiKW9EeMkvIff9O7G1iwl8LVj5fVzfaFA/UTBgwu8dysdzh1utfp?=
 =?us-ascii?Q?id83DS4VOpLt8HHtfHTbCF6Zq8r6ZC1g6s2Bwpb8LQfAg0WZEcWjZ3W8HyLE?=
 =?us-ascii?Q?nsMd32nIFwkhviEAZpgtQDawsDkyNH5c8qOW3yqrzdkauIiV19fzxyE53PYu?=
 =?us-ascii?Q?lhzyu/eo57f6WWhR4QkR2QgOckCjkwGz+j+Q9f4gyHwjnShwX13puTK4mBA0?=
 =?us-ascii?Q?xWK0pcw6EruY7cRv6Pb7tMOU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95e530d-22be-4fdd-a790-08d990734c61
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2021 07:05:12.9531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fI6w8NVkcMccVbOLmnWYUpbFsuf6fO9CY6txIYv8LGdVlidNvscRo2eeOifTVsDwnr6i2I4bWuECYiuNpyliuBwgexpYnlqksudOrvR/g/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5678
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10138 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110160046
X-Proofpoint-GUID: aCZezv1Iqhz53KLNXkYWDqI7eufU0xWK
X-Proofpoint-ORIG-GUID: aCZezv1Iqhz53KLNXkYWDqI7eufU0xWK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 10:13:05AM -0700, Nathan Chancellor wrote:
> On Fri, Oct 15, 2021 at 12:43:44PM +0300, Dan Carpenter wrote:
> > On Thu, Oct 14, 2021 at 02:57:03PM -0700, Nathan Chancellor wrote:
> > > A new warning in clang points out a place in this file where a bitwise
> > > OR is being used with boolean expressions:
> > > 
> > > In file included from drivers/staging/wlan-ng/prism2usb.c:2:
> > > drivers/staging/wlan-ng/hfa384x_usb.c:3787:7: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
> > >             ((test_and_clear_bit(THROTTLE_RX, &hw->usb_flags) &&
> > >             ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/staging/wlan-ng/hfa384x_usb.c:3787:7: note: cast one or both operands to int to silence this warning
> > > 1 warning generated.
> > 
> > Both sides of this bitwise OR are bool, so | and || are equivalent
> > logically.  Clang should not warn about it.
> 
> I do not disagree. The original motivation for the warning was code like
> 
> if (a() & b())
> 
> where a '&&' was intended to short circuit the call to b() if a() was
> false but then it expanded to encompass bitwise OR as well. The clang
> developers felt that warning on bitwise OR was worthwhile because most
> of the time, '||' was intended. Feel free to comment on the Phabricator
> thread if you feel strongly, there are not too many instances of this
> warning and I think the '&' vs '&&' aspect of the warning is useful.

Of course, this was a Smatch check early on.  Bool is almost all style
debates and false positives.  I didn't see a lot of short circuiting
bugs in the kernel.

But I'm not going to tell people how to live their lifes if they want to
spend it debating coding style.  (Unless it's GCC's brain dead unsigned
comparison warnings where it tells everyone to make their iterators
unsigned int and leads to a lot bugs and ugly code).

regards,
dan carpenter
