Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD83444029
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 11:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhKCKwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 06:52:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14864 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230062AbhKCKwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 06:52:06 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A3AFhMK027859;
        Wed, 3 Nov 2021 10:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=YTKqAO+ra+a26fFReInrrWH+KFx4C80i8jhFBLVr6ZY=;
 b=PGVJa0LJ/aNQE+cGy2e2KV9tXdUN0ZSBRJioSpSBlC8p6jW/4ZcuDhqvueDdOEXhkPWq
 097hGPOXkGiOW8nNrzglBRDOosyQFjJ11cy4A0TWHjI5qk73aizHlYee7kyGGQNBX/UB
 uT2AKvCEU0Qp5Cemcj8OcrIKcudLz7NiDkQVElfXILGm2VPDsWOXo8ecikffEx0smbZ9
 pkY8Q/j6iZdR/1+B5bbZuhdn8kstM9cNB3nodgay4IW8g5B+ERdk8Sdw9Bhs5EOSWjUb
 RBF2epGDIQClYtIb+lHrGqy1mk5gv6XhUhQOYgQkYGDSe8ENe+dunjNTBu9Y9GRahYTd aQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3n9xh2rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 10:49:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A3Al2vq039146;
        Wed, 3 Nov 2021 10:49:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3030.oracle.com with ESMTP id 3c27k6tya1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 10:49:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlQv/rUJFFBfsMBn1zvTH73Vq1GnOGqdq0aDe3hBAgyql84C+I87Z8ZQD7WD/aNKnGF8cq3QeiAXWJpHyEp+dY8EM5MoPQFqR/vZ78NYcXKY2UAKbaZ+meQ7QvM+uTqkKBRcn30f5fflBtst5PBSAYRSNpgjHx5i1xcWB0sdgyR7S2kJXQn09l0H575qp8GQanBJtEcJdcYq5VdtD/+xAcGLUzf5aWeGWXrw1cX0nLu7PuVooU2YK7/H4xxf+6h0fQyyEsUGAGdkFGR4jRJnIFmJcZfnxzs4XlIVoQ6iBpcGtjJr1fx9hFToyYR7UDzwGTH061Jgsg7uqMEU82+uNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTKqAO+ra+a26fFReInrrWH+KFx4C80i8jhFBLVr6ZY=;
 b=DhQIHXfWh5Mx0O/U2py6u/S8M5W5GW8OC0CRHwhINB0Do3l5yL1tCbQzIjbX4I4TCs+MR91loQ4YM0uTvZvGvk0jNtcYeBdbzOhVyj4AuJD7c3m9KsyJ4OomvlfgXNQO84HX5vxJIHo4+rPK4Ti1ogPB0SjVoNdH+wAV611F2EV+PMJd4H5zB3VLoaPTqebbGKZCqX2+BqNRyMSZPsV9dhrDgdHHQkH+eZeHBLL7qWvhOxNpapl5lc0BuGw7mKgzIi+GUqVukvz/+0gIA2EwEW/Th8+ei5z4AoT7e5x6fMpgyUtu1sXrTyskmQh3OCv/VRrnJyK885uNEV9Mz9kvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTKqAO+ra+a26fFReInrrWH+KFx4C80i8jhFBLVr6ZY=;
 b=VPNKuVo2kBXiA8/KXN3AKphrHGmVLtwi/CxHF9VetHNuj6QdNGXMjJQ2McE8kCDqEQSJXe638ED6t+4RqanexmnEaoLcvrfNnb6v7SlOBh+h4EfRRFk94DoSAYGt5WI8zsPHOc3fMkJexGs9dNbYcJDR7qW+HQaCH0Rmz9YVZu8=
Authentication-Results: inria.fr; dkim=none (message not signed)
 header.d=none;inria.fr; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2127.namprd10.prod.outlook.com
 (2603:10b6:301:33::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.19; Wed, 3 Nov
 2021 10:49:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 10:49:12 +0000
Date:   Wed, 3 Nov 2021 13:48:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Kushal-kothari <kushalkothari285@gmail.com>,
        linux-arm-kernel@lists.infradead.org, mike.rapoport@gmail.com,
        kushalkothari2850@gmail.com, outreachy-kernel@googlegroups.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, nsaenz@kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2] staging: vc04_services: replace msleep() by
 usleep_range()
Message-ID: <20211103104854.GO2794@kadam>
References: <20211017092900.134752-1-kushalkothari285@gmail.com>
 <83076fd7-3183-5665-a9df-63a0b7e13c3f@i2se.com>
 <alpine.DEB.2.22.394.2110171433141.3026@hadrien>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2110171433141.3026@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JNAP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 10:49:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f52bcc53-8bc1-4654-fb54-08d99eb79232
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2127:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB21272CA0D0438C521D9FA6A28E8C9@MWHPR1001MB2127.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bssZJB74tS/ygegAoaNvtFWP7gkzBtDgWGjb4Jw1BG4pP7+7oY4MGVmagSxB4zsUaSxdK5EIZsOSVyWI4mGSUkSHoY6Y5MnvtmKooHcWog2RTfiqueS/r2w7EXZiUojbx7OOhgh54PV6BIEmZPd9LDefsPyPzOl5jIPfz24sbwzjf36LvKDQbqwJE36hLjHL1VkWRco4th4DJDnlZ/isHQ1ZXb+cy0CRPTLV/3o8AJuV08eveT7n4TvymBcY7Qw37d8gKX3rhsMioFNsXliJt49blbHkTcPXcnTjQhARRMnupGf1kM6dgiQSZJz1OT0ZnlQZoxW2BVGRG/ipgihqtZsVnS4PiIEFrSMWv1s+hxqFBwaS4+B/Pp0NemOG9b0WtSWOUzkWLBsjfVJqcpzby6ENFrfLcH2kDbseQ8Ufd8FvMZjeRrmq04ebE53zokKzbC1b+N6XTocOIIlxlo0Q1y5NPGmZkjXFB+d4WUE1gwJAQ193vWD3zfs0G9wngf6wY3pgrbJEkSDLlAOz267LRpBIa9Ga9/4VgVVTJTWYgFJimutwW0a02BR+ilIm3a7RsrMs8QFLalflQERIzOKyiP1+PruCFNjYgMx614XHdVl5PaQrsZpXZiBuOCMWfolMuN08YCfYXUx9jiIRdonlzuggfZL0jJBepw5lRX+F13C9kA8tQ+NmjlCnNhCbEBFs6S/MDx3Iuu6dloRjdhCmkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(52116002)(956004)(9576002)(6666004)(6916009)(54906003)(4326008)(66476007)(5660300002)(66556008)(33716001)(38100700002)(38350700002)(26005)(83380400001)(508600001)(316002)(86362001)(8676002)(1076003)(8936002)(44832011)(9686003)(33656002)(66946007)(2906002)(6496006)(7416002)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m/NhsOsPSo3bGrFx5vDY/kRgxsYjQBhzh3u1dsZZ6KZvaJVs33tM6Dnduri8?=
 =?us-ascii?Q?ZBM0V4kqAIaFz/SQ5Uo6vaOesoc+8gyDHOuJQOrep9x1lvra1oji3FYZhuFs?=
 =?us-ascii?Q?mFlqBYCHmT4MA8BjWLlbMuxhx7iNnoMW6IBjOcq62+hbBr9VHyKHRLnjwYlO?=
 =?us-ascii?Q?8RAvAC4qY5mrMgppTGwSaNxSErHTFQDai7orgqCmwBXfvi70Wzzu7+x5988j?=
 =?us-ascii?Q?2YjyvpqEo73jGzWxyKtKY5CiugOoO8ERTNG6gO1PfBdmEb/GB07FecEzkqZz?=
 =?us-ascii?Q?Sdo/hIJzBwq7OgFqyG/nyCAMIAJIpU5g/Ai54/Cc15jz3kCSG8x5SDktDhXD?=
 =?us-ascii?Q?XfD0elpis2l16/gSMJgn5nz5WUmvDkBEsh7fvoV/wwGHviwK22xha5pSwNmd?=
 =?us-ascii?Q?SMgAdb/7uBQ17MNPTSZIUI10nn2tDX3ab+tTCJqbRlCezs8un7FqfZdjhjYE?=
 =?us-ascii?Q?a9am0Qpw0Krl6E+a5LsYpowT4W4/vx1LZqcaqJHTgZJuwBKGrngi4ZYypLhM?=
 =?us-ascii?Q?p/48DBHFns2tPD1QYO0j9zfiHNkgWzl4xcrsieLOxh9vtBmTgnQqflMjE7uU?=
 =?us-ascii?Q?Sik/Uq5JalvRphXgkevv+bcE4eRdPDGsyUiLwk2+kIJyKOMdih0gfxCQ6iKV?=
 =?us-ascii?Q?3hluTSsGLfJj6RYHsZWQGB4KH3tH7Q9z6UjA2uClRta/XTvmts+K+/IsnB+H?=
 =?us-ascii?Q?T4NglGmwXt5GEPZ47p7s/d89qFlZyBipFX8dy/VrDChJ/sLJm4cH5X9GVwK2?=
 =?us-ascii?Q?m96CU6mp6Mglp8wUfiPIGMVf20r/UkzclFEItsNkHlWasdz8tqC+hrGuvLAe?=
 =?us-ascii?Q?6k7p+SVxlAMQ3DQ2lkz2amsKL/RPCRdqtE6PnPWYNSxK2UogM5ruF/78UHZF?=
 =?us-ascii?Q?FtBqes/zU09Nw9LrXJOdItUDaT1+0jY8S0TmGbn7MugoJLYAdfiKoOe5lZM2?=
 =?us-ascii?Q?bHiM6a7Ji+HIznYdGJ8XCogIY0dzsJPIpU3xMI0IEp4xMsBscB8BMLj9q1qJ?=
 =?us-ascii?Q?QELOVtWUzB1YQh3AYfJX4KXrMFFjKOqJvWoNfKtik8aosn0ApiDLRaqE2WEs?=
 =?us-ascii?Q?Br1tjBG8qs08wNqH8aN32DV1QEUmK3UnxeZ5F75/N/AV5k5FcPNqkK9ztLdY?=
 =?us-ascii?Q?FzCfttCSpFsKhb15gVWjz2IkWXGzBELeZnwcnytKt8Sd9itZIMQLaz56vESN?=
 =?us-ascii?Q?NlHaZdQ2RDpyxnLQCAYHrQDEioqNN1CgJZ10aX928NJh1K5HRPVeXRNPXuh4?=
 =?us-ascii?Q?OeERfgtpmEHuK/t6TGajHTr1nKSjsd4zatmirskx3f76c+1nFdPOe5Gc3raq?=
 =?us-ascii?Q?EAb7QP6WT9bBOOea6n7K44k/7bXsPs8xF5Y+vNXUikfJNg+sXZJebhhsxHvf?=
 =?us-ascii?Q?mza+TgyzvaGoaYycfSbNwImNHxl57gL9dQgr7YJ7zsQx+AovTp8pXocgmFid?=
 =?us-ascii?Q?j+VmLKLfvE4FJE62JCksJH8hiQ07aCSmgeDQVbHMRZTor9+yGKRfUQcYZ6Ag?=
 =?us-ascii?Q?0CEXAtIZEG2AsC2yPc1yNughlEfX2xdZRINeZDzxu89GbVe41hWGBla9QucI?=
 =?us-ascii?Q?SvbempGk7GBht3kxHJsGyZpZbGe1n+Wxq+VRjqIGTRfHeahbdGuLKsA8Erz1?=
 =?us-ascii?Q?eV0P9gBDy07KAy552otUPoszIa9f1EnjzyL2rLPJ5+od959TkueLdCVYFTm6?=
 =?us-ascii?Q?/bbH7A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52bcc53-8bc1-4654-fb54-08d99eb79232
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 10:49:12.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZ/7HxZndfEWGYOxHkSp9u8tevxzBTIHauVNYsFOdyCTzgLYfurZuMKhww64hkMKxqtQ/FXCbB8OmIBfirOSHJv2+RvzIrpmvH4y6gep4F0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2127
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111030061
X-Proofpoint-ORIG-GUID: kxsBo0HpiC4P2seiMjNDwhATSgj5mAmK
X-Proofpoint-GUID: kxsBo0HpiC4P2seiMjNDwhATSgj5mAmK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 02:33:57PM +0200, Julia Lawall wrote:
> 
> 
> On Sun, 17 Oct 2021, Stefan Wahren wrote:
> 
> > Hi,
> >
> > Am 17.10.21 um 11:29 schrieb Kushal-kothari:
> > > Fixed the warning:-msleep < 20ms can sleep for up to 20ms by replacing
> > > msleep(unsigned long msecs) by usleep_range(unsigned long min, unsigned long max)
> > > in usecs as msleep(1ms~20ms) can sleep for upto 20 ms.
> > >
> > > Signed-off-by: Kushal-kothari <kushalkothari285@gmail.com>
> > > ---
> > >
> > > Changes from v1: Reword both the subject and the log message.
> > >
> > >  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > > index 6fbafdfe340f..80a7898c5331 100644
> > > --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > > @@ -857,7 +857,7 @@ vchiq_bulk_transmit(unsigned int handle, const void *data, unsigned int size,
> > >  		if (status != VCHIQ_RETRY)
> > >  			break;
> > >
> > > -		msleep(1);
> > > +		usleep_range(1000, 2000);
> >
> > there was a recent discussion about this checkpatch warning [1]
> 
> Should there be a comment about it?

Even better would be an alternate wrapper around usleep(1) which would
silence the checkpatch warning.  Something like:

#define short_sleep() usleep(1)

regards,
dan carpenter
