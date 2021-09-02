Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296373FE783
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 04:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242828AbhIBCTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 22:19:14 -0400
Received: from mail-dm6nam08on2122.outbound.protection.outlook.com ([40.107.102.122]:62782
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242800AbhIBCTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 22:19:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzeNPAMBtIJI7tCWR1OyEE6RDkML1FP/UmVqYaViAphrFXxJk9gFMbdUEpfTWqkp2W+7kTjaxd9ZFcUzNflw6g4bAlptUTm/2hiS6NUloz9GFWVKvqenn0fEE+RQwpSlPcs/fgqNHogL9Ur7FLlgXQJIH6HcZ8Vg7bNgVXXJfGxt1T3JDP43j+lZI9iqiFcEF4HHf/aRtQckYqH2lvYcEqicxvZzI8HdpuUxv9APBBNLO2qHf7N2tzZHFXDvQtzvFxMV4S3Q4ilFOUJwJXc3nCmMBaBsTvnVofVQ4t85fgAO0qWjf1S+96NBM8QUY26zz93I7dN/p35zbqEig854yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yzSv+rHq+RUZb7MziqFkMI+5b7UIm7v5j8pm+yZ5luI=;
 b=Km1HEuenq06LC+7a6Ue+IJ6+mtbB1djw4KX3/LNKkJYTOqkbhV5S8eMVCw7n423MxgaFmaGhTCdXnoLdrnLG69enE2DhxUW7tlKArtLJW9wl8SinUYqrVtJPRM9yqJRFeVkkWIWScdx8arg/Mx8Qo9n2OEhPtSQQqpR07hYP8b/8bWDmybh7aDHXSj9f4cA6+TENcH4D8s5glLf04HddAdtY9OtF6UzwY0Mx17FfyTeNge2dal/mZRRr2GVeC5vx9g8XuypZvWhdNPVHdCye9FCc5RMOeo3d/xGDFKZImbM+QixU+hveVXfXs1JijeVcxYfFpgFxqACi1a+cCkYWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzSv+rHq+RUZb7MziqFkMI+5b7UIm7v5j8pm+yZ5luI=;
 b=kxIdpwNxYS3q1EEXqHMBgO7VxXaLro4WWYSwUQyI2EvmTcVzRw3nMT0csYFpzOkEzwzaKD1GAnIQVbmZcBHWRs2Bc4ohpbVxb4zjVKvGNi3rU3zb8pyux51/W93qJ8EhNFhyaRqEp3P0M7rFIRCJ0D54nwnPBfESke5b/Ub1Afs=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 MW4PR01MB6177.prod.exchangelabs.com (2603:10b6:303:76::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.17; Thu, 2 Sep 2021 02:18:13 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::ed89:1b21:10f4:ed56]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::ed89:1b21:10f4:ed56%3]) with mapi id 15.20.4478.019; Thu, 2 Sep 2021
 02:18:13 +0000
Date:   Thu, 2 Sep 2021 10:16:38 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        song.bao.hua@hisilicon.com, linux-kernel@vger.kernel.org,
        Frank Wang <zwang@amperecomputing.com>
Subject: Re: Is it possible to implement the per-node page cache for
 programs/libraries?
Message-ID: <YTCkhjqXMshBr4Qu@hsj>
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
 <YS7yjcqA6txFHd99@casper.infradead.org>
 <YS+AhXJGsniaHTS4@hsj>
 <YS+NXmDO0yqDEBmD@hsj>
 <YTATir09urAUTSI+@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTATir09urAUTSI+@casper.infradead.org>
X-ClientProxiedBy: CH2PR15CA0011.namprd15.prod.outlook.com
 (2603:10b6:610:51::21) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
Received: from hsj (180.167.209.74) by CH2PR15CA0011.namprd15.prod.outlook.com (2603:10b6:610:51::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Thu, 2 Sep 2021 02:18:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd58d25b-0a69-45d5-dc06-08d96db7ea64
X-MS-TrafficTypeDiagnostic: MW4PR01MB6177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR01MB6177C5F50796C99340F69A97EDCE9@MW4PR01MB6177.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DpNGfpQavQ03GDs9gSnR+kQtTroFwD/CqyLl+wF3eSOGBacRjPJ+mqF+hsnd9vBBx9wnWezGKUraEITZ8cRD2Fn7e3jUAzwSjkcBhXJlRbymd4h7c2Aw1vo3OERN+33ocKlnpzDnA8x9k7bTakYmPJ4fB7RJK5jCv14nTXmJCoqiH3OjrMSuYQkAIqIn/lZmg07Zg7ny+yGYHG0X3WC/MZV2/dR8dqEoMHiffvRvq1Q+eZwSxuz6hFAO26wA/isthjxW761nyKsRsbQkZVlQMuZB9Zmu8Mwl3z9eO0mSFgkppuhLUJUfWWj1MdTnFWkwZ3Dy2pcS/+2rSGAabtAQMNX62P593cO5KL1xEUfJ09vqMoBP3tfOwLMJDMWI7Zrz5B0AryJCsFGDM3OxItMp4p6QQou+A7ICDE3IHieEcwHROnkDapwTrap7n5Sv6+t5AgMn0gBA9J4ItNAzICRnGKHZw3e6jehu+W+TXg2nASRPG9RlcONhYZ6t2/373mr2/2JyRI92+9J6Gm/FwePRYIlxy8bOYe9DAmEE5Q6CiK7txQfWksOXkukveGqHuM0s5hE8T6Fu2vx/dFLo1Zq6iB8QMHIhEod2O/Go9VcD/id6QJDBG9wvUZDGnLnxEzb+VNJPfHALayrZvAAWadvEPwjE1m+gk2fc5TudLwGEBVJX94xBlOD7GQiZ/kYrscF+PmIUJ3Z+UuDaexO8/Zk7pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(8936002)(956004)(4326008)(6666004)(5660300002)(9686003)(9576002)(107886003)(83380400001)(55016002)(8676002)(54906003)(38350700002)(38100700002)(6916009)(316002)(33716001)(508600001)(86362001)(66556008)(66476007)(66946007)(26005)(186003)(6496006)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x8IvNdm9EFmVQAYIAXImJqLN5rDHbDfvs/e8dMzEVX/G94yg95gjdlBscfJd?=
 =?us-ascii?Q?kUei3PvP90MOBqGenP/tkjhWO1xJ9URwkAGODxZcMctLKLjLfyDd06gGGCki?=
 =?us-ascii?Q?IFKBjhfJJZmVOCtDeIMgEqPW6zpIEH7uDZMnyI+cKZbOmosFmDTbjxRm0jMh?=
 =?us-ascii?Q?DYmIA9udDvzxKTvuPqDj8b06jlrRDKX9gse+d+R5khk6Tb4+/Cw8AIkmzMD9?=
 =?us-ascii?Q?ruqs9WAUXy9NFG4dVRgVV8PceYKMYJ/zRQRKoMC6nON+/5pwr64HTSHn/rkf?=
 =?us-ascii?Q?tR3ybpVjtt2yPp2c3M9QeOZvRxLs1uedxA8dalPcC8dlwGVdErciVFIid1EV?=
 =?us-ascii?Q?K8HvkT0MSk0oJR2sCBBTf8ePVOZa+XCTCgDMyDHbdjGR9DGS3Z1DDwra0n0I?=
 =?us-ascii?Q?tWc/lIoSPc6r+gR/Ms1UAgdnA95HlaE0cKJB5f5x7J9+g1Vz9S/62FbxqL6N?=
 =?us-ascii?Q?WCZ065JF7sma9ufO/rE5cEEJaPSLYEGalpUg35Bdwsi6p+gFu/YliM/fspOO?=
 =?us-ascii?Q?HqfZFuyS2rqlXNRCmkv8oJijdarbXV9njyh7dyBEmaBuSXSiyAUtT3YLeVds?=
 =?us-ascii?Q?7qKLuOENStNLPl6FMxYokJwIJAuxHOons+6C1fhg2BfQrBLAbdrnZ8WIQZAc?=
 =?us-ascii?Q?CsC53MzBh6mcchU/64ksG2G5/femR8NC7XAl0cLksEucK9qW3ykYhWIqrsd6?=
 =?us-ascii?Q?ZIDt+Bzt9skhsGFWrcn8hiOXsC5LjfDyWNYPD6gBPIqarouVf+jhoJ+IYibo?=
 =?us-ascii?Q?y97sKO5zbzEpt2CoDZO8yYb64lqFkmR9MkaDoM0R+a8l4f8Xc+IBmlu/lqmO?=
 =?us-ascii?Q?+DKqII72Ad6orVvROdTV9yNttCFcm7NLDcw1kiqodRJPwzTpjiDM+eF6d8Bh?=
 =?us-ascii?Q?kfo481kDhw2pJBO4axogI2+DpCuAuHgM64x+4+RFO76qJHcER58GY8Qb/I+d?=
 =?us-ascii?Q?ARmHUcCOpvk27ijQ8tT5V3UdYD8CqIpo6NN1QMRzmbwx7hQkFXIz2UhLKTgr?=
 =?us-ascii?Q?A+vyqjJXjQq0tc2WD9UdM05c6x8mJocKv/u8mFQlUNBXuo8BLAK+DAWmqVP1?=
 =?us-ascii?Q?7cq/Ixy9eMZZJDT1zlvkTrJWvRPMcdQe1SACVJ7KL6mpnKmqGPeoGTlX/XfG?=
 =?us-ascii?Q?IVaycKfDiFCoLH+ZeG5Jl+/dsVDl69Xjmz2qMrOh8MNAL3t01jbkthM4OCOZ?=
 =?us-ascii?Q?DI3BreZwbufQsowpxrWq+5AWLp/XSwv6wWHUgC+cGq9t5fEK/nHMZcI9ov9u?=
 =?us-ascii?Q?XSPk2F1Robs+U+dVbMxtXhELWBOq25SIJ0VM/5nQ5jVM7bQZhI38rlvH51OE?=
 =?us-ascii?Q?R3mSKXC8LkaPjyjZjLmG1cZH?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd58d25b-0a69-45d5-dc06-08d96db7ea64
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 02:18:13.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPS9Nkz/+bt3JbSf9wuwO6PRNBxkwTmVeIXGiOym2Jfr6XCVTrvMlHzC4LETMK8kFL3BplzAwyYRmqLvmjKLcCwNgPa0kn3RKBh3sZ8rMQhbqGw0U6vsy2OfCB0Q67fI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 12:58:02AM +0100, Matthew Wilcox wrote:
> On Wed, Sep 01, 2021 at 02:25:34PM +0000, Huang Shijie wrote:
> > On Wed, Sep 01, 2021 at 01:30:45PM +0000, Huang Shijie wrote:
> > > On Wed, Sep 01, 2021 at 04:25:01AM +0100, Matthew Wilcox wrote:
> > > > On Wed, Sep 01, 2021 at 11:07:41AM +0800, Shijie Huang wrote:
> > > > >     In the NUMA, we only have one page cache for each file. For the
> > > > > program/shared libraries, the
> > > > > remote-access delays longer then the  local-access.
> > > > > 
> > > > > So, is it possible to implement the per-node page cache for
> > > > > programs/libraries?
> > > > 
> > > > At this point, we have no way to support text replication within a
> > > > process.  So what you're suggesting (if implemented) would work for
> > > 
> > > I created a glibc patch which can do the text replication within a process.
> > The "text replication" means the shared libraries, not program itself.
> 
> Thinking about it some more, if you're ok with it only being shared
> libraries, you can do this:
> 
> for i in `seq 0 3`; do \
> 	cp --reflink=always /lib/x86_64-linux-gnu/libc.so.6 \
> 		/lib/x86_64-linux-gnu/libc.so.6.numa$i; \
> done
> 
> Reflinked files don't share page cache, so you can do this all in
> userspace with no kernel changes.
This is not grace enough :)
And customers may not accept it..

For the shared libraries, it is better to change the glibc/ld.so.
For the program itself, it is better to change the linux kernel.

Thanks
Huang Shijie
