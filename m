Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7153FE770
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 04:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhIBCKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 22:10:42 -0400
Received: from mail-dm6nam11on2127.outbound.protection.outlook.com ([40.107.223.127]:62439
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232517AbhIBCKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 22:10:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FS49ErYsP+jqq0zlrsjohJEg7iFc+nHaIYr3cZOWLHn6ATNocW50VqkDAG9S175QbGlqx69xKvMeG7EG6LN0wmP2OPyk3lX62L33Wt+eDtJjWGDm4JTy2y/kEwT2mz0PcC9txPY7uuaGSlyBX43xvgZH6QQ7XzswPdEDpdSKK131bqsoUiMyWgQUllmQ8ZeGEoxc/a4iW/0PO/XfTBcLvW5wfALhJMUh6JyKvLUWf6QXY35QjLMUQVDLyYK1rbzTXzb0P50pr9FJUe/MMKmgrvlCygHL8wvIDz2pfuhOpjBnF+z/q1zTkI4Plqase/4kgkR9pMVd23PPt4654F5gRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrpuFmjL5FzZ2YOQmrFPRHu1YbgqBCZci4SrJE0dtY0=;
 b=ZWaGF3SfRqc6UDx9Qex2bJk6Z+eCkVpRgpoqujkjrbYslo8H1yIeb+t9teQoBn4q1b8kJnzX9O22LJ/WjxP9XASVSwnn3fcxN3zevM4glh5W0WyVMu0vUeGHD7uu+nQxZiSWos915eFEhVZXohq+34//eYp72FTg4GRJZi3j+STo0P66+NsZ3OeU5ITK0IU91zTM5ev/I82evaTwDBydvlWBLIySVwQQaDMAoKcyOjSvrMxpx7vUkTuKU05Zl1IBDmynmCTgKootDLxHTqc5lvWvBufWartJO9fLKLT7M0eKwyxWHT8CJT56nfLYYtnAcvcBA7x6C5PW2mZt/SLFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrpuFmjL5FzZ2YOQmrFPRHu1YbgqBCZci4SrJE0dtY0=;
 b=BxwP5a4JE1OYYHKxFAgsfJ7oe8qDwSQzg75XeRQ68j0wwudogKX13DQ6zOiH0CslbdwmiEjc8uTWUFXfjcfqRN4ugIMHS6A2QAgdh+eJTLDAuYtyX9dolLLfFBRiYqx5T9AOLwVGkN3mPhKhL3RYioPlZ9yF1JiDmqAcWIvjGDY=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 MW2PR0102MB3529.prod.exchangelabs.com (2603:10b6:302:2::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.23; Thu, 2 Sep 2021 02:09:40 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::ed89:1b21:10f4:ed56]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::ed89:1b21:10f4:ed56%3]) with mapi id 15.20.4478.019; Thu, 2 Sep 2021
 02:09:39 +0000
Date:   Thu, 2 Sep 2021 10:08:06 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Wang <zwang@amperecomputing.com>
Subject: Re: Is it possible to implement the per-node page cache for
 programs/libraries?
Message-ID: <YTCihsPZL0HtO2lp@hsj>
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
 <YS8HpUz9FUcFWt0V@zeniv-ca.linux.org.uk>
 <CAHk-=wiwAC8L7UsRsd-sHNS8ZETbrTB0EELvYV1qMOUo86R7kg@mail.gmail.com>
 <CAHk-=wjAPEs3HRGswJ-AE1R048j2MBsBtMfg3GOsaFykHoeKsg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjAPEs3HRGswJ-AE1R048j2MBsBtMfg3GOsaFykHoeKsg@mail.gmail.com>
X-ClientProxiedBy: CH0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:610:cc::20) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
Received: from hsj (180.167.209.74) by CH0PR03CA0075.namprd03.prod.outlook.com (2603:10b6:610:cc::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Thu, 2 Sep 2021 02:09:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c07b6aa-2003-40c4-09f3-08d96db6b870
X-MS-TrafficTypeDiagnostic: MW2PR0102MB3529:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR0102MB3529DF36B5E20447F0FEFFAEEDCE9@MW2PR0102MB3529.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBwJzt199XW/Oci/bUZjCRG0aJyLB3KcxOFeTE+DZzWhuYl59Ls8plmSGQFKYeNHGwMbFlhHS5Sai/kT464ViLrWcfDzEp2brv8I+eWnKey01h/dcqfBdPyOVx4zLdc3bDgH7CjjR9LNnge0cG4l2J9i2P4Bp6ecBrGkZOFLrVM97tdEpx9FOBo/KvkfJf83j/NAE3cSSVG6Q1J+XX+cn7uJXODAFc5DuyJETfcWkTqsepFWJttiHrSvSXrlBbpb8JtmBhy70hljfZ+UbR7Hj7GRij5Zm0zY5X6S8rPHWLLrosqksixhqIXT6QrljdG/IT5ZVxA+1EDb2bYaCKrJGHSn17W4CcQjVVYIHprX2BEYkhG/OX+MmQlrwiqku3CnkUfbItlspD/puu1QRXUuRe70RULohCWKjG7FDy1I1YzWvWK6CU6LXHWP1paiw/OkfMG5Quf6sH2cf+zP1JZWCIz8CPwwC9KTT64mbNtiDqZJkLDquoLdPb0P+7DvOilvLMwgm454GZckXOIAurg9VIAfigjg2a+y5hww5wNf/zgDpdOGsHNebojtsLJwkQ3X1S3TF6UFBkT+v5JfyLXTEboDukzpIBrp4eJjgZPwH/lub+d2LMDxLcQJrnoV9U1NTkDfffQ/m5DyFH8Ebqy8FcYW8DGJQxq6/vPN65ofpMuwCzFZVrM9YOjzWvAcG94UqZ1R7buP2mnkvIIJSAtyvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(39850400004)(346002)(186003)(66476007)(6916009)(55016002)(6496006)(9576002)(956004)(66556008)(9686003)(316002)(107886003)(86362001)(5660300002)(83380400001)(53546011)(66946007)(2906002)(52116002)(38350700002)(8676002)(8936002)(38100700002)(4326008)(26005)(6666004)(54906003)(33716001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J79CUGleBRQHvTKdyw8T/WKONz/nohoCntvDcewvkQpbyNkFi3ivnVl66MRY?=
 =?us-ascii?Q?I4f8OTBfoJuE5BsW+k4IWaeDR/4decCRbNTdGqDfjK/QP5lPDZDvWgnqUEUi?=
 =?us-ascii?Q?jLmt4+DcdX4ygkRZ99GV8+y+HBJ4WlP5affoA8YauFLubdLkO4tIsO9wYH4S?=
 =?us-ascii?Q?3DaPwXStKKJz/XZlPFmB8W8zrIUdROB+WJr+60v7iXiYFI4pJTvpKTnbS7jG?=
 =?us-ascii?Q?2MrVFVHRc1+GvQMYYXpA+ezOlAA7DEmmpx+ov7pma4b/fQnAtNofQO1hkBJY?=
 =?us-ascii?Q?khrtUheJ+6jiSZPMgIzfG7ZsDzml7BYUISciUPlcUcL8sT9KoSSd7IkarEXp?=
 =?us-ascii?Q?27z1xLK0GB/evZhFmlpJoZnSISV/ppN474l3kEvhxUds1ez1eP08tNP4Lc+m?=
 =?us-ascii?Q?6WqVGIgZBPp6CviA6x6N1WyyTA2G69R6DoqaXBAc1d0N7/d2dsWUGAsS45f0?=
 =?us-ascii?Q?xviwWyygVqgrA7XEmcLbXi0hPLOH33YDtlvRID7U+Ytamt217qDpkrjnLLrA?=
 =?us-ascii?Q?4SP6UsVG0IfmoJJuECB9Thx1W6TuoVf/NDelhBpPIPU2Bk8LVe0psSamGa8Z?=
 =?us-ascii?Q?gmane+TkSaRh7eHrEvz/B5WSyPNMR0vUG2eHCtj9W32DLBfEHHcX4dNS2o9Z?=
 =?us-ascii?Q?nihzDJTbzwM8gYufhJgXRM1nYDy5lyMMbXFKH0ewNd1w7LPogyxGHgIBOoKy?=
 =?us-ascii?Q?AjDV3VjQ7zLPfMN+FX9Nq5R6HkA2jt5gBoeUilewSKdKsyQm0dxHhF19tdyL?=
 =?us-ascii?Q?y4lKGUo1NerdJXV7hFRkRsK68n3EgLGF6WsDnpvkIP/+YOtRyVXYiLPWiMDC?=
 =?us-ascii?Q?Hm1hf6f9pnYaMPQ3Si0tzaLqQ/kxINp0YMI7Ab4TfBp+invJJWAumLeT1YMx?=
 =?us-ascii?Q?FpTGC1WKwiKsJaHrJtZLBrUH0GW3PNGJpdDO7+u+m+BEPzcGiIZBzQmYBB9A?=
 =?us-ascii?Q?5SdGqt2M3vr+LiGmVYihZezA/YWUEOSfA5juF6qQ3kVi8iKDrlstBNK0d5uS?=
 =?us-ascii?Q?1yD8BVZ6ZOG6MMuXbJx58oC6f0tXJOXRpsGo4LQ7vsScI69j34KX/qYzPZ4T?=
 =?us-ascii?Q?vwPfs2X7at4Ge7RL4Phg84Z5XRIUBkegsk3dWFg+iXQDKYEwwfwzc9GhafvO?=
 =?us-ascii?Q?Wb6xUtvJb6TgECD76kK5QNXX+JFlnd60zxkj+ICFk375JSp7nT7iWe6MmEK1?=
 =?us-ascii?Q?KjVHTphS0NyMQEBFtf9mBMSAOIbk9ozo+7oWLwbFtHp3xCi4YX2jx5FGZhVz?=
 =?us-ascii?Q?gORmRjcnA6eiU5c0J2iWGHl5Gex+IIOP5VsOLHH1T6F0zlC/Fzo+3opy6jsn?=
 =?us-ascii?Q?11W99rQQ6nThzLf6HicAtuMb?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c07b6aa-2003-40c4-09f3-08d96db6b870
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 02:09:39.7210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WTNBDnjHCCsvXzCOtzje06kZ0x4Tcsh1fIWZixvA6ktrJguI4yyY5tcV5TjEeP5actrOmXstd/0O43j7sr+xiY/XK5hSi3fmxa9XlnX2Tz8TlbIBLIrk7KYw0/BjLlZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR0102MB3529
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
On Wed, Sep 01, 2021 at 10:29:01AM -0700, Linus Torvalds wrote:
> On Wed, Sep 1, 2021 at 10:24 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > But what you could do, if  you wanted to, would be to catch the
> > situation where you have lots of expensive NUMA accesses either using
> > our VM infrastructure or performance counters, and when the mapping is
> > a MAP_PRIVATE you just do a COW fault on them.
> >
> > Sounds entirely doable, and has absolutely nothing to do with the page
> > cache. It would literally just be an "over-eager COW fault triggered
> > by NUMA access counters".
Yes. You are right, we can use COW. :)

Actually we have _TWO_ levels to do the optimization for NUMA remote-access:
   1.) the page cache which is independent to process.
   2.) the process address space(page table).

   For 2.), we can use the over-eager COW:
        2.1) I have finished a user patch for glibc which uses "over-eager COW" to do the text
	   replication in NUMA.
        2.2) Also a kernel patch uses the "over-eager COW" to do the replication for 
           the programs itself in NUMA. (We may refine it to another topic..)
> 
> Note how it would work perfectly fine for anonymous mappings too. Just
> to reinforce the point that this has nothing to do with any page cache
> issues.
> 
> Of course, if you want to actually then *share* pages within a node
> (rather than replicate them for each process), that gets more
> exciting.
Do we really need to change the page cache?
          The 2.1) above may produces one-copy "shared libraries pages" for each process, such glibc.so.
          Even in the same NUMA node 0, we may run two same processes. So it produces "two glibc.so" now.
	  If We run 5 same processes in NUMA Node 0, it will produces "five glibs.so".

	  But if we have per-node page cache for the glibc.so, we can do it like this:
	  (1) disable the "over-eager COW" in the process.
	  (2) use the per-node page cache's pages to different processes in the _SAME_ NUMA node.
	      So all the processes in the same NUMA node, can use only one same page.
          (3) Processes in other NUMA nodes, use the pages belong to this node.

	  By this way, we can save many pages, and provide more access speed in NUMA.

Thanks
Huang Shijie
