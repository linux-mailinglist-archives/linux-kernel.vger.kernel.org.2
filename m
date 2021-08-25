Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EC23F736E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbhHYKjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:39:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55270 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239722AbhHYKjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:39:13 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17P8qv1s000899;
        Wed, 25 Aug 2021 10:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Z9rd1mq2Q9VTGPu62DOZQUJmU/kPose52+yUhH+ukc8=;
 b=EUwFZErEGtNHOb4RoCIIZRGSai5mw5NQxlLTWdxuDCVrOIehOmYCm0/bFnIJChFqIjOR
 8AHkc0C+tdY7z3B3PwmIHAFBdmJv98RVQfM/w7DB5uv+qqIxpHlJNmpiFZZTLPdz23Kw
 yUxpYVWHJhX01x9OjC7a3osWqUxHA7iyodgSaFOpXfINaJZA8WkCMcnzDZ715PBq13Pb
 JElETBCa1NG8EydJslnjjNqO/iTuhyd5xC4YPu07IRtd1YgJgTU0a4LlxuaHXTyWQfwi
 CCeaQ7vqlF99Le+vT/4QSFu0Bk94zrEKEiDLpcR/DgFXvlTTUKPQ+H+5aAls6ScsiICB aw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=Z9rd1mq2Q9VTGPu62DOZQUJmU/kPose52+yUhH+ukc8=;
 b=M7OB3ak9irVl9C9NEq5ubAw+L7NL1xaRZA1Y3pfhgFgJfFXUTYSLcrXT7QjtmPSSRXHn
 vTHINKSb3qTgFI3UlkmhX0OzAZK0Dm0khQ4ycKz8wZaNmVohQ6xX6hi0MYm7gXXonD0B
 /Omr1xb5/c/bkjS6Mfdy2+O4OWlYguYGLze++eqKbUQE+REEyskw28PceTJ8hqzNZMHh
 6MUs3wZGr0JKgO8A06ijwykD8tsolJrcUZ+QxJKzmgvEof6AHvNkA5cbAMxE6JUHb19R
 QbYSBf1t+45nwFTRXLcqJ9CqC4iMVpNXxpyWt8uB58NlGXQALDL/a+ZFkC0+eCNZmkXX fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwpdb25w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 10:38:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17PAZIwh163745;
        Wed, 25 Aug 2021 10:38:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3020.oracle.com with ESMTP id 3ajsa72rdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 10:38:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtMkvjzwlIlaBHJ/7/LBtVztfjh1t2TcEnkzCUDO0QCwwX7HsEsXdGBUrqg3+QMB1w8XlqX/cB6hVUpnMCuU9JdHZfgTKbu55TdQ6/bBPBIQ5CPiUdFYJ1OQiubMilbFfXiMJbLkgWZOwqSbJVzp4gBFgaJPujnrw6ufE1K721JXc1pQ95kspy7O2rsesKuAnluqBENuHRVtFZnuxk+2pqAcDih6dVL4+UuRh+2E33wecw5+pc1yib2ID68nv93MGfW5FqsM74lOncOzjxShWYjDLe16hIxZ3LoQGZ5KnhiYDWcoITe4yIdmkiqGVsGn65MzpZqF2izmkCoPe5t0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9rd1mq2Q9VTGPu62DOZQUJmU/kPose52+yUhH+ukc8=;
 b=iaSSgnLQeIALu4YeFEk8YanDyHYadY8gVhDUym/t56HihmhqiR32krS/BFEibXZkR2kKK4Zkwd0Y5VnD3fwC3+4ukUJsB35Lid7mzRiw50MbrTB6AqonuMFd8jeLzJT/PYA1DxQuaeR6mgGUK+Y/bo4d1kpP1IXCcPZKgDDYU5xvi8EKJ7qR5rlu2HTydxZF2ifJGXxIFrR2GxZU2TYzue9DVbAjpj9wlnEC/6PIxuboyRWPugOiNpwftMO1cjWJJClXDVWxk+9yy2UGY9G4RQLvohLw8/x64uzJh0DVip4anAQ4sHhAvc2F4Aj/5LvtQxxK+Q/Ebyu+GPuK3o95YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9rd1mq2Q9VTGPu62DOZQUJmU/kPose52+yUhH+ukc8=;
 b=q0jilmlh8Zb8eCMtr5+kCvi/m3Z1uMJn4jSPXmue7v5SlvoO8hs8i4XJKwMu8eeXqSYOR1Z9lFY+w6uZF9qq0uoWTyMDVo+oVc5qr27rl1zj3viahxNQdV8PS1PUSmqhdmL/YJJi9JR1ikQvg6QsbPEaABL5RWPIofxfztJgRqc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4641.namprd10.prod.outlook.com
 (2603:10b6:303:6d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Wed, 25 Aug
 2021 10:38:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.018; Wed, 25 Aug 2021
 10:38:17 +0000
Date:   Wed, 25 Aug 2021 13:38:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] staging: r8188eu: add error handling of rtw_read16
Message-ID: <20210825103802.GS7722@kadam>
References: <cover.1629789580.git.paskripkin@gmail.com>
 <1665728.ljvk3MsED4@localhost.localdomain>
 <ab20fcd7-69a8-0530-7770-0e309178b0f0@gmail.com>
 <2227654.mbYB7oqmoa@localhost.localdomain>
 <794dfd94-fe88-43ac-c4ec-9ff7df9db6de@gmail.com>
 <20210825100647.GS1931@kadam>
 <3396277b-6d80-b621-0ef0-71de7d581602@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3396277b-6d80-b621-0ef0-71de7d581602@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0047.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JN2P275CA0047.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 10:38:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9a1a79f-85b9-4c8d-f60b-08d967b4731c
X-MS-TrafficTypeDiagnostic: CO1PR10MB4641:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4641E3DBC220A36EF31103758EC69@CO1PR10MB4641.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GbkjIGZQUhvt0ixG77WPuByLJ6PNp53dYd6uNmHsOLe4yAHYX4AgRCccdEabfidIs1rnrKqwv24tiZ3BKmeV/CKjoR/hF69oo4piV95JE6PkAavSG6L0j42U79X7ZFlBvCTOK5fwSzzhxrJkthKIf4q+zx6PSCRabFqEJlDF5bVdLU6VgRkIV6Ri+2spZcAt+6lt6BJAre4DrYU+5P1tN7aTlOoF5PQZvOe9e0sKMH14RZ0GCDyCL6jTC4++6PPUbJFQM5HhqVkFcqbpb61Dg8gyflQad/DN4vOsFPJ/u3zh+5BcSZIsqpiTFjc8hZPCJBlAMpHs5oJMsm43zsCRQ9kJfTNC/BPxX0AUI9r7ZETTVA29TkR65SiXgzQuoGmTNNAPg0Pc81D0/qfwf5YXUAWkgINyVqvk2EUf8FftEp4QRtNpEE2bvio1PH+Rqw1rjPgmHMJB4kWlmLuMl573xlDzK6RLS48Lgl6G6A1jY6mm6bj8LEtG4tV1LqYlLE1HO32EztwyaEbxuGMGAdd3UwQyvOkzSURmCK1KwlK8aCD0O2HzhbuCBm4Wic0hsAcwv2E+MA3Xu9BzNtj+QmUmJWNMEMbep+cJ0eAbDPOjWebIbpHvSWZ9I0Ac7rE06RIETZYe3hTv+28vnAWmkN7fuWGycSVlxix8lX4reQe8VxX0MhevDkWUn8moIw4yO3PsC63e1M/hZ8B+n3iWsCttbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(396003)(136003)(346002)(38350700002)(5660300002)(956004)(38100700002)(9576002)(8676002)(9686003)(66476007)(8936002)(66946007)(66556008)(83380400001)(4326008)(52116002)(55016002)(478600001)(6496006)(6666004)(33656002)(86362001)(44832011)(1076003)(186003)(316002)(6916009)(53546011)(2906002)(33716001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x/n4n6SULvOJ+R3OVJIdIcTligZetqCajk48fgW7cShU5Q94AybRCrkLsByJ?=
 =?us-ascii?Q?PTNjgKE3PQOHsicmclnvN9ji3BYm3T0yDW5lT1Dy4ICFRS6zpMTL0jWAxwoS?=
 =?us-ascii?Q?qw+sj55phyP9Rb+WSbWmIZhVMQuSP2TYhl3dqV1jZP9o8TFVBFsElToJuM9o?=
 =?us-ascii?Q?9XbACs8xn7ZnAZdgzp3itdIDqlZeMp2oTS4Pb7elRyizEwRMkov5Mi7xeD+2?=
 =?us-ascii?Q?K0C2GAyZ//GIdezbPK86bHrGiIVTj/AXnx0fixenoBZ/xo7NXSgf4FsWW/JB?=
 =?us-ascii?Q?cTU5QJ1cGECWctg4LRO+uxB0+dMznz127oX3jgA8ueLiwTkUyL5RwFO+NcWK?=
 =?us-ascii?Q?zDLOpjznITcPKcuYf1lNdgDoxsrmUK5ukRBR///l2zo4mTZfWQMO0hbSQGo2?=
 =?us-ascii?Q?atay2rdO0xY1V1dSPGq6o8NNpKy3zzzWnw+05P7lknqjmEmPhgVYiCxlDmy9?=
 =?us-ascii?Q?oZXiBg7poMU6jYKb0nbw2PfFUjLKDpeLj3sdM3Qb+vH9lByldzWeacwy8GS3?=
 =?us-ascii?Q?RzkFNsp+qZVTezXARGz60VI1Q8WhyWqZ/xeyRpoCEogp3SHqsVUtZyFcgqm0?=
 =?us-ascii?Q?Kx3dtg8Cw8QwBrnKdjPOJMkq/72GTddfhz7pGLS0Z+IvxfAYIUPM48Zmwu47?=
 =?us-ascii?Q?iJHaliKBaeBrrR4fphkMeS/Rr0jSlfcEBsLM+ieVqgVw+vfToAzqLmlKAJnO?=
 =?us-ascii?Q?j32/8ZX+aWRbyVUXnFS6jmoF9yqfxojfLwhu0ACgSdbMdguA86SVF78FFzKb?=
 =?us-ascii?Q?ZxC+TRm7Hx1nup5w75NK2kcyeGqTQcIlaFx/XBV36i8fQBnbpbVK+phUkYoh?=
 =?us-ascii?Q?6wT+fX4WFlMLOoeHFgwQQKNcp9kj07bjtHn5rLQHY2CpIwK5P+fezcm6MUZn?=
 =?us-ascii?Q?PCGOxaeGEI/E5xJArZW8SmCD8cpttzta825/AfrfMM2C/9qePsA2z4nQbjcX?=
 =?us-ascii?Q?jWktnYsQatvXtYgn4InGpkdvo7sZOm2+ZBhn5k+Pi8LjJBMpLf5QvR4wRU2x?=
 =?us-ascii?Q?5GiO3QpgA8dxiAjxAHE0SFDzPemSTJgmRHkYe009l2CiFL02RbDIB17BjfM9?=
 =?us-ascii?Q?88PkcQ786QlEDZfqEsSnwYZcOOS0PJYopiSpHGy2QHa4f5118wHPgoTFVM7g?=
 =?us-ascii?Q?riPsDlh1RiLlMnGUHJhOfU4E6XrRDQSn4Md3bmlOXUz97hK/Hoiiknabt5+z?=
 =?us-ascii?Q?iwJIePGZ+nMGjG7D+/QEtfkKWUr3VdjrBoIvxwMq6uCCGV5MSQIGNJbz2e1o?=
 =?us-ascii?Q?IJGB61KZIuYojEA9jXxwpDO/UtzU8LSaAFkrowLDyZd6N2/yAFWLli2BBKZz?=
 =?us-ascii?Q?H3akkBF0ljlNufJDJQ2+sqxF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a1a79f-85b9-4c8d-f60b-08d967b4731c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 10:38:17.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/hpCXTo3nnQFsivu3+8I+wgCFn5KL7tZjKklNsT0AoYNln5LMB5qGWTD+ShbwhiEBS1i8CoRdLvCK5Y6kSzifKdNvnJTPXL0NtUbHKaU+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4641
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108250062
X-Proofpoint-ORIG-GUID: yldaGj-w434xrC-G3A_coMJK61EXyAOq
X-Proofpoint-GUID: yldaGj-w434xrC-G3A_coMJK61EXyAOq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 01:13:54PM +0300, Pavel Skripkin wrote:
> On 8/25/21 1:06 PM, Dan Carpenter wrote:
> > On Wed, Aug 25, 2021 at 12:55:37PM +0300, Pavel Skripkin wrote:
> > > The main problem, that no one knows who is the "old". Greg can take patches
> > > in any order he wants
> > 
> > Patches are always taken in first come first serve.
> > 
> 
> 
> Ok, but if pending patch needs new version, then it will be taken at the
> end?

Versions don't matter.  No one is tracking any of that.

A patch arrives.  It is either applied or rejected.  First come first
serve.

> 
> Here is the situation we have:
> 
> 	I have the patch series based on old function behavior, it was
> 	posted first
> 
> 	Then Fabio posted refactoring of the function and it changes
> 	return values.
> 
> 
> Both series are pending right now and made on top of staging-next branch.
> Who needs to rebase? I think, applying these series as-is can broke the
> driver, since error handling will be broken

That's a bug then.  The patch should be rejected.  You're not allowed to
break the code.

Also don't write patches which lead to merge order breaking the code
silently.  That makes it difficult for stable as well.  For example,
don't do this:

-void frob(int a, int b);
+void frob(int b, int a);

In that case, you would change the name of the function so that the
build would break when people mix old and new code.

regards,
dan carpenter

