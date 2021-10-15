Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429A842F169
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbhJOMxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:53:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55214 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239195AbhJOMw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:52:57 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FBmPMA001745;
        Fri, 15 Oct 2021 12:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=RZmKaoLVswghVtKbGJiGW2YPPbvW1gipQZJo8DzXmuY=;
 b=D7fymdxuQN9KJH6uTt4HseuyQyqxJ56eWOvWSMH3dC/KwdQN54en7sIlHHRQQYcAZQum
 V1Js+7Y+iQv8DvpjQswu1OysHPOLisgHH2xl8qHoizBc08k6hQKHQ1uphsQluvQpk9d1
 0Mylp/nxUeJ106G2QPZ6fuY+enWKP1ofJOvtLraww46bO/ESoLKlXAnnm2lkFmVWxWWx
 08QTBlpz1OpZsZ9w3vijpwyC1V8Q6OVp6eEJ1r0Wp8Bn605vaRlJ29DWSuTkcTfLEBFq
 LMTCLMDQZSPwjxOUNmVcU11TaUSFGz6UlnOXgymILGcNWOJeJXCWslB58RW00JWKdEyE 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bpfy68jpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Oct 2021 12:50:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19FCfHtG150945;
        Fri, 15 Oct 2021 12:50:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 3bkyvfp59t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Oct 2021 12:50:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K17a1UvEuaCTxqI+CqrR6IWpXiTXtvRD6veitVwbFoOTLbFqEa9Ena5FojmJpAZPXm30Qh2ROjewMmIxJIQLtgnZHzlB0+UDgmeFdHNhMlDHoGJTxi1kQQL68Ul6QNI3R/Bf0O4LLcjfZ1GVBMou+DkNtKxnbweYDxkEeGAwlTjNyeH/mW6Je8tESMn6eqxTDTpmeEm4Wm1ODdnedTD69iPQG8d+b+ioilFeizl9nP+UsSCFF+tbzANRq67ysFW1wnx8c5AS5ByW7UvDo/+m4K4LkSQ7E4+L2QDjIhDldmOFd7wD4Ssf8h2ysLHkVSMQNGykdekCwt0G41pNX049ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZmKaoLVswghVtKbGJiGW2YPPbvW1gipQZJo8DzXmuY=;
 b=dgWEI81ctwvg7tpLbvilFT6OP6DIWa4caQHy8CqN1EvtdpB0gVTEra2sg5wKwJ4jOf9aJjbqKV/tY3xw35Zio4Pn4FVjDeuaJROXhUXCkHiOq8tAgjBvwdtVLDx/AU9Mq70R7JWffuxrXwuGV0/wJ4z598taUsbZ3G0JQP/DVtoabyVxsPiSdCo3BbpI8YMMyhpvAthu9vfUYM6lpHxtlTtNNRT4mI7+D5LTAubRDhijZqvMR0KezMd1EpCVJj3JCoMaJQsdF3cHHkSUFjjHxizUmmKw3OeM3vlP6AK6mSvlTf0+WthgJKxUaIY9M9aXR7DhJ1Gxg6W3Z7h2p5IDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZmKaoLVswghVtKbGJiGW2YPPbvW1gipQZJo8DzXmuY=;
 b=AL55qMJukEFk/CXuxkgw3x9OMiYD6rv/QydiK5CYYi3QE0xWFTWAUEvOQEdBrTyxuJ3WcAa3x0u9yXpncPZOnkNSke35CwF4fKH8RveQB7/VXxuxxsL+MaHNCXDV0BJgyc9rTmiin+x+kz7uIxD0sMQsMQWtKrkeYt8vnlcMR74=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4724.namprd10.prod.outlook.com
 (2603:10b6:303:96::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 12:50:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 12:50:38 +0000
Date:   Fri, 15 Oct 2021 15:50:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] staging: r8188eu: Use completions instead of
 semaphores
Message-ID: <20211015125020.GS8429@kadam>
References: <20211015110238.1819-1-fmdefrancesco@gmail.com>
 <20211015113715.GR8429@kadam>
 <2060953.sJFZD89sIB@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2060953.sJFZD89sIB@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 12:50:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83b7e758-6e08-4880-f2c5-08d98fda630f
X-MS-TrafficTypeDiagnostic: CO1PR10MB4724:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB47240261554FF2367FFC977F8EB99@CO1PR10MB4724.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+NrLSvNn7etRG/ZCRo6dgA7zfuOh+LbS2d6CFugUcYrUt7QKgTEnslenUSqMwge3oftkOgqUgwjiyJpaKMhCphFzTryN4uO67V4AYthAy5GmpkZd6w8Ephi5erRVKBKD8Wjgy1OSBT+lqEuZG2A/Zv6VBnKy1reyZTQQeQq6KC+/oYpRqMgzwzL4dslZE6G68lVlynbPPchh01G5W99JSi6FTOJcIOe8obt87a2QV0hiOAUVn8/SZX3T9Fup3y1PRXKW66IeEMZZXACkIeN2DEEdNDqK8lzBSsUa7qV1YIfa7sgFN8M7aLrhyU55gGvwOSTeA4HTrT3mbfRsRmrp/cIh7KcDLRDJer6WykzL+F5W1C/fxdITRYRjR6enMnMlXF02qtXJdTo7GgqDPqWf2gEL/KMrdXZPd8u6F4wqjMLJgL503FX2X8avaByKv9dFBlmbpEeMoC6/mT1N+QphFCQzVDtr1XaA7mtvkB2J8/Y8JgUbZoP/C5prUk3iKGv5AB980yVQFiS3+tEGHq1uKTzvWgYMXPCS5XkeeJC4DHoUlqlRoqwgH7hme4wabSFpmjdsAvLKw/gZZNOqZNsHgUSw4N1WMi4RIg5BYZ13fXj1iADthdAQeiTEWguKB1adeuY7UEq/rVeB8+Ia0O0QnhmokhR4pDIReWEEpgyIgZKrCFJXD3wmBTSLQncxY0N5Y7bzGab02f99rFvVFylBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(38100700002)(38350700002)(316002)(6666004)(6916009)(4326008)(86362001)(55016002)(83380400001)(508600001)(54906003)(5660300002)(66946007)(66556008)(9576002)(66476007)(2906002)(53546011)(44832011)(8936002)(956004)(6496006)(186003)(52116002)(33656002)(1076003)(8676002)(33716001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VndTPAnsCWYdQDGd7/jw2bfxvW4EJWY9F2cl9v+C+dXqtW6O6iXd5e1SSU1c?=
 =?us-ascii?Q?nKFVbERquwi2kld8HyJ4FRArDT2IDqi7jfvqAIi/O+Ck38ua3pM6YwaZR44P?=
 =?us-ascii?Q?56QWTBnZh64yaKTIMjOgH8tB3+D0pEacYYhsxEAK66CwBdlqWFbve/BtxkET?=
 =?us-ascii?Q?FX9hEwx3EgAN5qE88u3ml1NGcD/UuEuOjrVdaX0N9a2gWVq/bNjx89IS/kuk?=
 =?us-ascii?Q?osTvhfHbfRfzccEYaLKYjCMUs7qjvrKAEDR6NUQ09rTpRazua+riVyfZXvKN?=
 =?us-ascii?Q?Gk8JpN0QObbGbmGgTUjFCkAf8kSub7ir+U+ygeXSBwn4zJ25uskMf0cak3eQ?=
 =?us-ascii?Q?oUHUWe85SOUlcF7NquwdCOK8r9g7FVB3mTzDHVoU83I33fGbmK7GnjOfXWJn?=
 =?us-ascii?Q?QF2de+91x5bNTMo3K1cKqobhxY7MvATdPgpk7+nfuDCctxQBSPqW2RGTIVne?=
 =?us-ascii?Q?dO6dNlY7X1jJ2ju3HuZBjDaOHXt9pWIUyVv4lKRzu4HzAkGfjndPehInXyb8?=
 =?us-ascii?Q?4roF1OY/239gkbxrB/PL30Jn5h5+q/SMNfFsE2JnnWITa68ILa3ZCmoilH6v?=
 =?us-ascii?Q?sKBIHsIS9qZCyZiY/tp9CenS544r1WNyHHkZEFf2hydwgHADzio0cU9TslNY?=
 =?us-ascii?Q?XwBzfsNJOhdZ+bQceH8BaHQ7Eb0aLhmCuxXV+rKu42Q3eXz3AUq+ak8wlTN6?=
 =?us-ascii?Q?E77+VsclVxsjb2pZ73H4NJC5NwslE5k6nMhdPwkdavp/x+iNGUhF8ik3BYTA?=
 =?us-ascii?Q?LtKfP8L5QLGOcHon85QIYfz4VqlLX9wqSJY8NTLw0cmhW4Iw22jgEWOwZ19T?=
 =?us-ascii?Q?Xxu2wP4q2ZjmZ9pWP/M7QzeSGGJxMaChvRbiyINxmr4EzVTpH72dvKp2mCCP?=
 =?us-ascii?Q?TVv4At60dFNqG5cKG9rI3PJuTDoWpM/ZVDsYi1kPyYwjbcWaZZ8t0shp2Z4L?=
 =?us-ascii?Q?rFNktorn/at4T9Zly2whfIZDVFfGFQMt1DVAc8oFgrZb+nT6ehzIhh0e7g5Z?=
 =?us-ascii?Q?Mhee3V/Wuif+ConEX2OPGre1SDv82YIBjQKIe3Km8HgtgllfHyBBT8LvKHEq?=
 =?us-ascii?Q?xo0pWZxuNdUymQOJnrNKgRUYOw7B/gqSha0+LaypZs5IBbZuejxasZkGj7pn?=
 =?us-ascii?Q?5pMK/1BDWI5JdUTP/5eKt1yZ23RDAyyW2dOtBQREmHcVvTfA4TuTJg/3po/D?=
 =?us-ascii?Q?O0ygkzOAib991PBijSBxN525Z/RyvrbFEsi+5itkfL80QdDCTKFSgSf5Wdv9?=
 =?us-ascii?Q?tr2ZtwnGn89Ka0VR4oAXyz2XLQFxBqCtGzesf/fCkzQyuEE4VC8iCqTRjZOw?=
 =?us-ascii?Q?D4z+fKnVpH7rqwQqymLzpiqq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b7e758-6e08-4880-f2c5-08d98fda630f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 12:50:37.9426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rN3kobM8kAkmk8MjrSyz957eqvC2CQUxVYf8QSfmuT7BXV/MuThfHLz+TH4KSH6C5swOPyg1Bp5u3Sa/lmmWqnhQnObjmya1sOB1SmQGvxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4724
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10137 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110150077
X-Proofpoint-GUID: uS2b3tOk8P_Oe3MrW2elzxslqFeAwvOr
X-Proofpoint-ORIG-GUID: uS2b3tOk8P_Oe3MrW2elzxslqFeAwvOr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 02:11:41PM +0200, Fabio M. De Francesco wrote:
> On Friday, October 15, 2021 1:37:15 PM CEST Dan Carpenter wrote:
> > On Fri, Oct 15, 2021 at 01:02:38PM +0200, Fabio M. De Francesco wrote:
> > > rtw_cmd_thread() "up(s)" a semaphore twice, first to notify callers when
> > > its execution is started and then to notify when it is about to end.
> > > 
> > > It makes the same semaphore go "up" twice in the same thread. This
> > > construct makes Smatch to warn of duplicate "up(s)".
> > >
> > > [...]
> > >
> > > I'm waiting for Maintainers and other Reviewers to say if this patch is
> > > actually needed and, if so, also for suggestions about how to improve
> > > it. In particular I'm interested to know what they think of using the
> > > uninterruptible version of wait_for_completion*().
> > > 
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > 
> > This is basically what Arnd did to rtl8723bs in commit:
> > 
> > commit 09a8ea34cf431bfb77159197e46753d101c528c5
> > Author: Arnd Bergmann <arnd@arndb.de>
> > Date:   Mon Dec 10 22:40:30 2018 +0100
> > 
> >     staging: rtl8723bs: change semaphores to completions
> > 
> > But there are some differences.  His patch is a little bit cleaner
> > because it gets rid of "pcmdpriv->cmd_queue_sema".  Could you basically
> > just ports Arnd's patch for this driver?
> > 
> > His patch goes quite a bit further as well, and change some other
> > semaphors but we could do it piece meal and just change the
> > rtw_cmd_thread() related ones.
> > 
> > regards,
> > dan carpenter
> > 
> Hi Dan,
> 
> Thanks for your review. 
> 
> I wasn't aware of Arnd's patch. If I were I would have sent a "normal" patch.
> 
> Beyond this, I noticed that other semaphore (pcmdpriv->cmd_queue_sema) but, 
> since I was not 100% sure that my changes would be accepted, I decided to 
> leave it as-is for now and wait for reviews like yours.
> 
> Now that I know that this changes are welcome I'll also make the other 
> changes. 
> 
> I guess that I have to change one semaphore per patch and make a series. 
> However, now I see that Arnd's patch makes all the necessary changes in a 
> single patch. What is the correct approach? Is one patch per semaphore 
> preferred or one big patch for all of those that need to be changed?
> 

The two semaphores used in that function are very connected so I don't
think it makes sense to split those up.  The others are less connected.

regards,
dan carpenter

