Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9415C3FD2E7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241949AbhIAFdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:33:13 -0400
Received: from mail-dm6nam12on2131.outbound.protection.outlook.com ([40.107.243.131]:40672
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229731AbhIAFdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:33:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2VV7ISJWMA2rls+2GbISaLloZpbBixQEUjnaZUMjfsD3Zvk0l5TOa6x5TPx1kpoULwkCvyO371dxPGPZz4yM8LT/Pkvm4qHXPE6Qit9PWm3o6CiUUyBHcJKP4odkBmRlrVv4xjJExGKYen/AAbQAd46FKlotoJxrNvr4Gr5M/VfCMmCYxwzDkY55oMqg7gSIMCiy2Xx3x2ewJnJyw/ZUoBTpKVKeG48/capcO23YqmcFI4NPyYTA7ALy3bIVkIAiiZsa6geUY+8xbsNNxihrf22aUOjzoPYW52PP1cahGhaUbTLD1RPqjenxgy741OairBlpasrZzGxfXCtNfVajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CYxnMNjXUVYM+s194WEnePGy/4xv/sxFJrXW3UATIhA=;
 b=lwGtBlKiXvaBc9Qlgsxeoty1rsEmZ2uG9O4xWJYCmnSEExZvrN4E0WTygKiimUPrDgRmK+q3wI/BZRYUyUMI8bwxMzmb+SK2CVptnPXmVEwbbqdxbGCZ9xaLJv1fLoA7Tna557axuIATCFhPqc9qLwdhQcqOxKyZiZ0YedFmTpui33uujiRPbmRm7ui8kYGMEc52zWcWJUuBRn9hJn43uq3nDrfJFmhHgHWfF3XwQ9Jaf+tXvnL60fpp6pdVLQAkAYpNpTtrN/L9V4qhcNZEBTqn/E18m4Rh16VZ0ewwYdwI8jr3A5k6N2OQU4eiKKDe0ndWlCseqYQEK3fD4+B5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYxnMNjXUVYM+s194WEnePGy/4xv/sxFJrXW3UATIhA=;
 b=FDMCsX/qHtkEHV6mqoOHfMM+9UeiFxrWtiqNE3Etg9gnnhhOwemf6baCwgMpSqSJzyWFaO1XUxtsKmvSY2D32FnRXqLKdBYKUHZgfSU057i79TYE+RUpbV6E0t3LZj5PQus3s74+145D6ZbAT+u5T9IHw5XEn5tuAchCzD5Sbqs=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from CY4PR0101MB3160.prod.exchangelabs.com (2603:10b6:910:45::12) by
 CY4PR01MB2422.prod.exchangelabs.com (2603:10b6:903:6d::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.17; Wed, 1 Sep 2021 05:32:13 +0000
Received: from CY4PR0101MB3160.prod.exchangelabs.com
 ([fe80::d054:80e9:cd9c:6c20]) by CY4PR0101MB3160.prod.exchangelabs.com
 ([fe80::d054:80e9:cd9c:6c20%6]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 05:32:12 +0000
Date:   Wed, 1 Sep 2021 13:30:45 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        song.bao.hua@hisilicon.com, linux-kernel@vger.kernel.org,
        Frank Wang <zwang@amperecomputing.com>
Subject: Re: Is it possible to implement the per-node page cache for
 programs/libraries?
Message-ID: <YS+AhXJGsniaHTS4@hsj>
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
 <YS7yjcqA6txFHd99@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS7yjcqA6txFHd99@casper.infradead.org>
X-ClientProxiedBy: CY4PR20CA0046.namprd20.prod.outlook.com
 (2603:10b6:903:cb::32) To CY4PR0101MB3160.prod.exchangelabs.com
 (2603:10b6:910:45::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj (180.167.209.74) by CY4PR20CA0046.namprd20.prod.outlook.com (2603:10b6:903:cb::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 05:32:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e79215c8-8286-45aa-8fda-08d96d09d9bb
X-MS-TrafficTypeDiagnostic: CY4PR01MB2422:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR01MB2422703309A4A5B5EC381724EDCD9@CY4PR01MB2422.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xg0Yc/AAgh9ZD04Mxjcx58o33ucscRmdBSWpLpAbnsd5jf5vU+K7YZzzla/vYPhJf0u73LDllHaTE6N81MySED1WjU0B5TP1P5ZqkIcDhWNnWb11DiV2SoM2tlW+83LHhgIPBuKrQVC6pkAtHy877Yvrz695OON5hG75prBvDvED1OXd5GQaDSjF34R6lcJAKB2JTnjYwbbuOjXO53JV4rqhQ9v/mHIWU0lIKvDj64BB6lFrW6TxC0HDirWLcLWn2qNBndldyV/ybMA5tXmGsoPkEGDcpUHcjqVpz+uKRa4VYu0fiFPKlR6p+wQGbp98EbJagEEOMkRe9TaL063atAh7W7AsG2618rUfBGo54qowL2/KNtRJR0wH79QjxJEnBOsgh7NKo3bBH51KFCnfaWctrlwruWz59kA0ssczz5APhdvB3Xjgj3/Y1YD/gqP978I5JX3MUY3MpjlmT3AKCWIjkXyomspCc+cbxGYnK7sAS84WyEh5QOkt4u6NAwLYrRSQSl1UylZ4RbUIKcYcYomWUneuyL/SIn1rc/F2HOp4wtQHOpBwoMOWgMGLwxrPOZz72r9jiut+kpAPHiooG9G2hUlkTlW8XDZamG0ZC15o3UoY7QD/mE2AgFhwB2fnOTenxIhzj0nCxzd1blM3m/oEUFfwTJDsqwXEm05Bi5a1+avIKhzL8pD+PTy/M4QGRTl1IYJpi4vcuK2NvVjBYMuVFemYgornp9MQuwtFt/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR0101MB3160.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(39850400004)(136003)(376002)(52116002)(33716001)(956004)(38350700002)(8676002)(2906002)(38100700002)(6496006)(86362001)(4326008)(8936002)(6916009)(478600001)(316002)(66946007)(26005)(5660300002)(107886003)(66556008)(66476007)(54906003)(186003)(6666004)(9576002)(55016002)(9686003)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/b9ODH8Q0lZPZGBqmsayjO1CS1tk/cSqLZRiK4ukpfCGZWQ94sUfqRgykKeQ?=
 =?us-ascii?Q?r3TUOOaREUb3TBBzfHouWqiBxfU81eK4QXV/0GgpXSWM6KrCEaBBAoRPY1LA?=
 =?us-ascii?Q?UOaqEgWWLrqnsLEa0Z2LrxCqPAsZdQN1wtQ7S5MTj28QSDOVT9Ed7pnKIVEb?=
 =?us-ascii?Q?AbXme5f3qAk3vMWs9dKWH85yES95S8wdLbDLqBnMO1Acwx6lO4XvehJikOFo?=
 =?us-ascii?Q?I5ccs9il6BK0B7ufazko+t4qh4OERCbcP0BUUIRwbYsYdMW9tm/odPIJWzD5?=
 =?us-ascii?Q?qjpbAaTvSox6C/TFr2bmE3rpa7ua+aBtaWtONseNeAbs9HnaQC0L2bRxPAqg?=
 =?us-ascii?Q?dMqPYfGHCevZh6jWPS+VdGbE1KWfeDF94LB4Wk/OGt8H6qTxqJEfVNMm0eMf?=
 =?us-ascii?Q?wnUK9D8hHTcn7EHs9vRcppW6aRpWjfU92tl1XcN9Aa85dSLnT9fonX7/Wz0f?=
 =?us-ascii?Q?LJxTjhL+VRTblfIeP6J9yvJ+qS8VfQh5UX/PRjTkRlT7Zi4GY1ovvhnogdG2?=
 =?us-ascii?Q?JQqNKBqWjRhmPKXBVSfTNEzlXk59LrjIPHZLEyNi49ciNFsHotgEF0QcDqSL?=
 =?us-ascii?Q?uf2dehzs9ky/gHjLjI6EoyYQCyjI16kmdQows/ugXmGCapOHgmYKIY6uQmyy?=
 =?us-ascii?Q?Om4LsCAY18RaGDMNahrOznUwjpwbsg4yYdVPfSY9IlkDqZiSepHDuo0K1sxl?=
 =?us-ascii?Q?LWwQ2lNYi4feaSpbcZZTXy7xlvbVRq/1ctimuHvCUA/fXqL4MbFL+PWohPDv?=
 =?us-ascii?Q?NDuvkwoq2JSLemNDiDtKRdCeN0RT/Oi0+u5rhl4guX71PB50EUV9QxVCS57U?=
 =?us-ascii?Q?MSv7mAQbThgfNxCb6dEmtkTIUaVa+ArXiIsaATTIK0ctfJSd038W+mdCN/Ib?=
 =?us-ascii?Q?FHLHxhSfIzosu+HH+s95V7ZMTRJA34IPumYznalxfvc7OGcsXbb4pl8qG2y8?=
 =?us-ascii?Q?uuW2ruiq+eeSUuTn2cj/KffQFHvJmbzbn7Ru2dVnglg7+X9W+dwcVCRJ0vvS?=
 =?us-ascii?Q?gVoT00HtstQtwYbI4H0zbRKMbrWHPg7JmQmOiyTcvUQMvfIjq14+/C6SFUw7?=
 =?us-ascii?Q?juUUTZzw32oyXh2FIE2uIYVPgiGPZC71igy+MtP8TLwi960Xwc5W2CZ6d/lf?=
 =?us-ascii?Q?ryszSEMmpXMoC8k/lr0pFyB1hAO0WNuw1R0qjWDYPCwR+J0GAbGP3CZOj+O2?=
 =?us-ascii?Q?xtkbGAd/FLSEZ5Xp0Vd61Tgs0qaHctKVLTbUMNgQG3J98YZufJob2l+FTYcs?=
 =?us-ascii?Q?a+EummvVX9txfQ/Vfm0g8KtS/wtRjGeZGv7ufOLayhlymHQLDYAUkw749Xb0?=
 =?us-ascii?Q?OohUMq0Bcwf2HtXd/oO9rUHG?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79215c8-8286-45aa-8fda-08d96d09d9bb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR0101MB3160.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 05:32:12.8354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvYskVq16rOHUfoirL6O1lzvY0LZDsqb6sHORAKJ0Sce/15LHMGK/j+LYZ8BDGzDVzdJVx6+YCLtwcfIkZ2DdcUWVBpSl+ZgVeNp7yUPWnga3INm0vvMT/RF9KDoZDMk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR01MB2422
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 04:25:01AM +0100, Matthew Wilcox wrote:
> On Wed, Sep 01, 2021 at 11:07:41AM +0800, Shijie Huang wrote:
> >     In the NUMA, we only have one page cache for each file. For the
> > program/shared libraries, the
> > remote-access delays longer then the  local-access.
> > 
> > So, is it possible to implement the per-node page cache for
> > programs/libraries?
> 
> At this point, we have no way to support text replication within a
> process.  So what you're suggesting (if implemented) would work for

I created a glibc patch which can do the text replication within a process.
I will send to glibc maintainer later.. 
(it seems glibc does not use patches to maintain the code.)


> processes which limit themselves to a single node.  That is, if you
> have a system with CPUs 0-3 on node 0 and CPUs 4-7 on node 1, a process
> which only works on node 0 or only works on node 1 will get text on the
> appropriate node.
> 
> If there's a process which runs on both nodes 0 and 1, there's no support
> for per-node PGDs.  So it will get a mix of pages from nodes 0 and 1,
I think we do not need the per-node PGDs.

One-PGD for one process is okay to me.

> and that doesn't necessarily seem like a big win.  I haven't yet dived
> into how hard it would be to make mm->pgd a per-node allocation.
> 
> I have been thinking about this a bit; one of our internal performance
> teams flagged the potential performance win to me a few months ago.
> I don't have a concrete design for text replication yet; there have been
> various attempts over the years, but none were particularly compelling.
> 
> By the way, the degree of performance win varies between different CPUs,
> but it's measurable on all the systems we've tested on (from three
> different vendors).
Thank you for sharing this.

Thanks
Huang Shijie
