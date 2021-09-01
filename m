Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76DF3FD3CC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 08:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbhIAG2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 02:28:07 -0400
Received: from mail-sn1anam02on2107.outbound.protection.outlook.com ([40.107.96.107]:6169
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231501AbhIAG2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 02:28:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ac+E7apD8ilxmb1TpfeLlC1TiGbZVtUKFv1NdtxgwC0bsE/zObmyr96wd7/NGd1dTz5TuNhQgS2Bt6Y+dN+W67FnbKmp7tYdkOnyKZeLQjBcO75g3RAy4wrxOaxRt7VZUF9JOBncAgFY+qsKCo5Jk0MVqF1nGOw0v0R2nz5+/CjN0P8CX5r8ccindKO1YGgSh75qddkFZcIr3HG2ivIrl4cDqFXaz2EjBAYJ12cZ3Ky12qOh5UaNyzvc4bbm0WdnY0czA4h/QiiCXyw5aupHqqk2eSSN6ylc0QKA9kWTNqe+hdvBHqHXfi42RQRoAmezzS6KcFz3oc/D6vmuVoqYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6nA3NxfqrJyvAQ5HKp+CD6k2iqfuZmvLaW87MnGzrw=;
 b=PET4aYEvfauF8xs66eG8dIx+C2nNq7JFO38NTIXomIxxXJ6yOx7mJocFF8AFH5w9h4J/sYvXosaTEUCJSIkJxuleFzN+M8S1oB2dr4REzQbRwaBqbcBNBD8D4fQBefIkktwdrRH6fdEt9bu+BXpJVzEG5eEHZaOas0pyuO0kH28TlHpz29C3HldM8PXjm2is/JY6Qdyb/idfLTYAW31I+9kxsyrgtCdHKDZb6k/HZgMNtK7UIXjIkCDloMP+SA7KYLWJotJ74qYz/l1S6YiDxtmzVQSMOVFxTLeNCf+5lPgiNgzGLgxydwRPZHolYJPO8/JCgPKTuwHJ10irkeAX3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6nA3NxfqrJyvAQ5HKp+CD6k2iqfuZmvLaW87MnGzrw=;
 b=rzNP/CCUqAYoVvOPhRUkCbEMJ0+BH7nGs3UkDEhEhvUk8v1kIOSpUmwVBCXvUE+e+NENlArr6W9oseC2oVCztY8w+AiyzsOOwzUe99BTWso1ddVDJjhIUbdGiN0k6Z5k2zNwU3qi7MIUUCfKPPvYWgoMjaiVgUmQpPorA9ahi5A=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from CY4PR0101MB3160.prod.exchangelabs.com (2603:10b6:910:45::12) by
 CY4PR01MB2709.prod.exchangelabs.com (2603:10b6:903:de::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.18; Wed, 1 Sep 2021 06:27:07 +0000
Received: from CY4PR0101MB3160.prod.exchangelabs.com
 ([fe80::d054:80e9:cd9c:6c20]) by CY4PR0101MB3160.prod.exchangelabs.com
 ([fe80::d054:80e9:cd9c:6c20%6]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 06:27:07 +0000
Date:   Wed, 1 Sep 2021 14:25:34 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        song.bao.hua@hisilicon.com, linux-kernel@vger.kernel.org,
        Frank Wang <zwang@amperecomputing.com>
Subject: Re: Is it possible to implement the per-node page cache for
 programs/libraries?
Message-ID: <YS+NXmDO0yqDEBmD@hsj>
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
 <YS7yjcqA6txFHd99@casper.infradead.org>
 <YS+AhXJGsniaHTS4@hsj>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS+AhXJGsniaHTS4@hsj>
X-ClientProxiedBy: CH0PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:610:75::15) To CY4PR0101MB3160.prod.exchangelabs.com
 (2603:10b6:910:45::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj (180.167.209.74) by CH0PR04CA0100.namprd04.prod.outlook.com (2603:10b6:610:75::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 06:27:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb4ea8ac-9d67-4b11-f0b8-08d96d118559
X-MS-TrafficTypeDiagnostic: CY4PR01MB2709:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR01MB270993431EC81F96071321D0EDCD9@CY4PR01MB2709.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGT66bnbV2rV3LRb/trN2izI71JswNg3MqAijf5OLfnwmUscK1UfKxz2fqxjMClEsHnsAF+hQHY2NbDUWFkYkg0mzQv57s+2P0uOOG+QmatmixJQ2SlVXNN3mjrAZEnEUnAbh0Y0IxkDa5LgnAQ8ef0q9Z0xXznUDNgHZ5SMRHEqnWt64lHJ24DxiWeg9b+VGQLKvjwmtHGnjrp1iVRKMrdQxkOdjfDoZU3+s8t8WyJIqK+U8ptwt7V620Ji/+mX9hCgiSN/8pUTmzMOEEVsSpaG4f8iN7pamGqYI3Zp024JJfY+RsNZDkGYTg+Jf0jZf8JR+GByFzCA4zhL4SuAljafsInDUYFUlE8JwOkJmX2KxFT6a8e2fir6N2yh3iaBE6OG9/VZ1SKvPSWUZZfy1iQ/rd7PgHL5yV4syjQK3k4DklVWElXrbVoiFQgydBFA9wmgexB5jXmhDmWBl0MaxOPNBrP0IuTce5xgAV7iUdJ18zwYJkohTltjaHcOM6tOZzSkfL1NOzqijeg9za9ccVfTTIDGPw5D93T+c8E13Y80BEsZ7YGeu1n3y3GemCIl/xftbvk03McaZEj4lUgHvzgX4roJld+mKtDoS6eGOXbtRV/9kR88FcjdVhMH/YV3g5mP1V+FI98eMkXXkrIVkAusqf7zW1FgIPVijnU4jSuWQkLDo6rJHKlcTjojDJaFdk1bWhDKDcD1Xenigf5l6RF5gr8ujzpjXLSkX9y7uWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR0101MB3160.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(396003)(366004)(376002)(9686003)(8676002)(478600001)(26005)(38350700002)(956004)(4744005)(186003)(38100700002)(107886003)(83380400001)(316002)(33716001)(66556008)(6666004)(66476007)(4326008)(55016002)(52116002)(6496006)(5660300002)(66946007)(2906002)(54906003)(86362001)(9576002)(6916009)(8936002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8zb6bqsQCphla12HYRnoH/qS6VRySLJFdu7tiIjdBfb9qc+ncvcnTeFZkzh7?=
 =?us-ascii?Q?JtFQj9tltAG1JszV9v3CL1ujyq+1xT4JCFKa6TVL2xUkkS/YNN3KLYZxPj9c?=
 =?us-ascii?Q?qqt+64bgUeUb17GqHf1H016eH7j0oQoifU3UqH5jX8oJiZrEpYCPnx1BOMtX?=
 =?us-ascii?Q?x+jOcdOgKJEIRkOhQnD162ENDPmnTYXA2fLaDyi7sGmf30g+eo6XgtgmU2ro?=
 =?us-ascii?Q?Jga1m1BrShdB5JiVEk1hYssBxnAH3owYaBFSrnT6gISxFREreJhcCDVCTc87?=
 =?us-ascii?Q?vWN9F54ScoGi74r7YlpS24Vu1UmEpWCEnZl6yCvYJSiAcK6i578lENGl/gSe?=
 =?us-ascii?Q?5/cqmGRKAF2wd8uGgheAkTdKHYyhCBtdz4e5XDEQJ5bl954K0GcOzTgRPOQs?=
 =?us-ascii?Q?nLJpxQjtvGTWcwzvumyqr1M0qBG4Mq6ty5KAijxSCaQi5kKTDQxtMzjG9+IW?=
 =?us-ascii?Q?UrG13AOziUDnLYtDYPbNd564jXxggAwqPuBySnfYNUUh6wPsRjwmUpevRW+K?=
 =?us-ascii?Q?/8+k8GaX/oPvjFncP8H69dpdX21Yq6bHt2w2S1sz59bMfMpm1btZK8fwsWH7?=
 =?us-ascii?Q?7CfFn7T4yihEhsqAC0MozdqARvW4uSAjFLE3LGMzLhryWXmERf0Emi9haxQw?=
 =?us-ascii?Q?q5eNaiX8JavsYkTFt/gKciciXLPKld9c8MS5lsvyNMtuJ/UfPou9P1tDNtYL?=
 =?us-ascii?Q?5frFXLJKY8Tj78FkWM2EiNX2DCr2zHW4kXIRKR/vhcMBqS1EHP1LrHVfJTNd?=
 =?us-ascii?Q?2tclbyeFG0idDJJEevh1nWsnJFSIexHflt+Ye8QwrO+BFM6R2WMuyNzEt9To?=
 =?us-ascii?Q?NS0M7EURziU7t15vQqvwr+n65avQv+MTq+e6X2xcklkRt9AsTpLdl4oUNi1L?=
 =?us-ascii?Q?mOpKYcRCWNZ+NEpuAGP3fsn3q1fJdK0sN5p5z3m4w64bEyuhFN1hFaAvgIxQ?=
 =?us-ascii?Q?8J6Dz+tByczqL48UxtJm6fM9vWMOs+OYfsp9S7M7tYsT9orfp6r1DFWw1aro?=
 =?us-ascii?Q?tuSTQVUfFdvmFvCZubdAXHlYBr6jG7Qy3uY/8fdrowUhqFRMYl7xqo44nf5K?=
 =?us-ascii?Q?Kn7n87HRJJmh1tnwD0p1nF5jeNVj1QX2dmD1u+8jWVvpBqSlrsmniyBXOYA0?=
 =?us-ascii?Q?nytx/lGbq5qJgIUf+FYe53cpOP3E4PBojMR+18Kyrln4s+vEifYF1KdFdibu?=
 =?us-ascii?Q?1PECWfAPpLRPHmmetI5SSOA6Fk1nBdtJOotyeIPViad4U9S6M6/UjZAOK86G?=
 =?us-ascii?Q?k6QreI24jk1gs3b+VHs07Wd0jpI7zWMDT5ZHzyq5DtF97UVSxeVvw2VRViNT?=
 =?us-ascii?Q?43o+KUc35zAPBesRJdhGPXag?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4ea8ac-9d67-4b11-f0b8-08d96d118559
X-MS-Exchange-CrossTenant-AuthSource: CY4PR0101MB3160.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 06:27:07.0410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+DFFEIXULJHmkwydMkRcdzI2hQHyuXtOwXDRjCL13I1n6rKRs6O5F55KuOxs1Rf5m4iQPPezNVJ6zpV6YLjYFIq1XXRoiLCcHa//bV5iOEf9meq+yCeZ5CfsNJGBz8q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR01MB2709
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 01:30:45PM +0000, Huang Shijie wrote:
> On Wed, Sep 01, 2021 at 04:25:01AM +0100, Matthew Wilcox wrote:
> > On Wed, Sep 01, 2021 at 11:07:41AM +0800, Shijie Huang wrote:
> > >     In the NUMA, we only have one page cache for each file. For the
> > > program/shared libraries, the
> > > remote-access delays longer then the  local-access.
> > > 
> > > So, is it possible to implement the per-node page cache for
> > > programs/libraries?
> > 
> > At this point, we have no way to support text replication within a
> > process.  So what you're suggesting (if implemented) would work for
> 
> I created a glibc patch which can do the text replication within a process.
The "text replication" means the shared libraries, not program itself.

Thanks
Huang Shijie
