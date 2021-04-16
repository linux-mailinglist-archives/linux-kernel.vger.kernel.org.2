Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135A0361A55
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 09:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbhDPHG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:06:57 -0400
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83]:35553
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229555AbhDPHG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:06:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xy/fZja4v9aw88khDP9t2scKsLjoHRELfZC7co4ebmMP/woMk1XD4TXA4PLkBNXKwP65EnNcOB/nDvbGhWBt1/b0UXGjUZmcul1nyHGz+vU0ejNdRXwVc6JGzKOF1nk5Dbgg1KfxsYRivECauB+fueNQcH6GmkSNJEJrPz3NtSeapZaI2jVA0+SSPmEYPZHh5CGiHWF8XF7GU3auYsWTg422+feko+AhqHDYrSbVQArXVJ8a/vfUQdpYWIII49Yq6rN+yDxvpJvwgsFIG4gY2Qyj8yGl25uR2oFLWHLU7mewwwTbWS/odktH0kyMGbooGI7VDlOR0/4Qt8ly5lhChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJpC/xDMHbX0a9YKkiZjdUKTbFVNYbRg/xkyiXRl6+E=;
 b=ZapFyuHYyutgAF+z9nd6GAtrnwLvIdVM6I01C8I34jJdPcefJJl5jV7rGMDf8qP+Z83jVfFzymMHDRHq/mNV9ZhXM9LasKyUa+dcurxjg5187IXfRdkiHFdmao8k78ZF5+4gFpBb3cVVgkyufJiaCi4GlnlamJ5g5YSoYJ3qVqbIyYRlcvM2YUxPhF2GT1zXRPjznuL+2gz+6kECT2ErVvna7dMAQ9kF2w4HSbWRhYWrf0gHEItaD8ZyTbgFKc52gmUcOm7EOV4DittQ1aeXX112eDYF4ihStgcSU14im8CEQp8BYhiO4jwlmbiElWaW2HBycwFLmM2gVFw9mKFgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJpC/xDMHbX0a9YKkiZjdUKTbFVNYbRg/xkyiXRl6+E=;
 b=Dz92Q149Cdzb0IB0esmp9wj1dCN8z1SXiBagnCQ+YwEaDJlefECb0Hgy5aXhszKacsoizAybTehtWhVWbtaWIOGo/+BIJ+Ht0ol3bfi6BiPWKiGhPkkoDLLceMGlZAA9CVB/jVp2huQKDyD72E9F6Qq9Odq1xILsVtYxcvv0lpE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by BY5PR03MB5080.namprd03.prod.outlook.com (2603:10b6:a03:1ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 07:06:29 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%9]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 07:06:29 +0000
Date:   Fri, 16 Apr 2021 15:06:16 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kprobes: Simplify alloc_insn_page() with
 __vmalloc_node_range
Message-ID: <20210416150616.027f5bae@xhacker.debian>
In-Reply-To: <YHbqN0B5QnpWtzc/@kernel.org>
References: <20210413180231.19b72601@xhacker.debian>
        <20210413220030.d1cbbc63659dcbc52876696d@kernel.org>
        <20210414152728.418a41fb@xhacker.debian>
        <YHbqN0B5QnpWtzc/@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:a03:114::33) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR21CA0023.namprd21.prod.outlook.com (2603:10b6:a03:114::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.2 via Frontend Transport; Fri, 16 Apr 2021 07:06:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3772dbb8-8da8-4a88-5764-08d900a62842
X-MS-TrafficTypeDiagnostic: BY5PR03MB5080:
X-Microsoft-Antispam-PRVS: <BY5PR03MB50800B090013A0D05E76875CED4C9@BY5PR03MB5080.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWKhkEGFfbEkcgdHIw+pl2JPiDHQDM1JpvMet7y2noyXBJ67kbrqbp5zVcu4LgN8OXDGhLwm4A4bH46GJb+vf8arA7lOWvjwZuj1aIKwVfwavSGNfHuyVsvD+Pq8/f+Kaim+6wMQBTEK76LwQXMiWW46+q+I31fK5AvRXJvjOem956I0Rra+r88kuzwoiqU0yMxiK5DVEFGIDZvw9VwJuqSSRyIsw4WTsWFKCwDcbfyo+l8RXIUeZMH2ztCNUULbrnkS4yUHdjyXcCo2FLBMUXYJnmkgZSD41qskIXgYVqvOiI+FoEyQQUbTh4ULD4GP3XOrSKhCV2nfTMaM8HiUd8hWu8KwhhBHpogCAsJ5GHUkWzdoSBe1IQ8s4s7rCbNKi1sMfSmscIuWYK8Vbg2300rqrDZEZHqYzeB4wWMvR847CiSETU5h+qoOETZq6ip7s+7kXhcQHxXfjSvF+2nNQI7I13tglrj70DlCaCR5waFua1ZK+Dc4Oj6P5iW9lnqioBuPcpWZl91EWBdNS+umeEgVCo1IByVF/0CzU4ri7ucKuRMoGfSVPI1Tj6mfJoBWI6mMJnSCm30i/g9dfNMpSDlSibp8V4Ojf7xGE3z/6OFokbIsbJyyzLNSU1tanejOxrst4/WvDWfWMBFwuindhyG/Dkhvcc/ADCTF9+RSEg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39850400004)(366004)(136003)(66556008)(66476007)(478600001)(7696005)(956004)(66946007)(5660300002)(52116002)(6666004)(8936002)(1076003)(26005)(186003)(4744005)(2906002)(316002)(38350700002)(4326008)(38100700002)(8676002)(16526019)(55016002)(54906003)(6506007)(9686003)(6916009)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vOT+YAi06BVypt7JTjrz64XdZAUEwCyhvIluYxt3fkfoIviHdGw7jRMXFIJw?=
 =?us-ascii?Q?dFGwG6GNS8gkUZH+BDAtPZ3jFH72lso0LeL/3vBD6NwAHjjp+RtuVG3+eCeu?=
 =?us-ascii?Q?zNRXtQxTwtLid1S4sGXLt0iyEoUDLEFeGOa3Wkx92+cr5vVByw1r/pgz6dG7?=
 =?us-ascii?Q?vqiKEpxgMqAJ6Pd7esp5pz/VSQBF+pom3JNiBA61lNK+c6PfVXYvUuzHiu8D?=
 =?us-ascii?Q?OmDHyHt7FaQYGu57BkJlVCHSPYvYhYUqhk7O/Odzdafdyk7IgyFmFVjPuGEK?=
 =?us-ascii?Q?JtQruToL6IoXL1/8vuOA3HU8RcgllW/pMwJN2atQbaQ534kEJcqkfE+iwp9B?=
 =?us-ascii?Q?R7BU1WtOcba00TUUI5J1hgbyqY8Gu3rJuZx44aNmbxrunHetD5O1JJ0Y0zWf?=
 =?us-ascii?Q?hztGuqFEuSNtSi+Iq1Hacrs5DbU2rTPyZXaRYWA3lmxjDHtQFcc1wH/nH8s/?=
 =?us-ascii?Q?lPNM0n0pxe3TCVsvoWZWUbn77FbyKvGGTD/ggiUv4XJGxYh5KUFDmZaXWAhm?=
 =?us-ascii?Q?XOdG9bvCyfHEA6agOdtLe1VT/R3tJ+p6+5miXi0UVQUwpdGd7ifQNOADJ63N?=
 =?us-ascii?Q?6uWe1dg38ns5AM2lqUxr565FBs0XhhKk/Qbq1fwC67yXlc3yU0ylH6+ztt59?=
 =?us-ascii?Q?7lRaRtMxvFl8yM6Kslc5dEHKFzBBA4or9ggobxPxN4Mak8X87P0owHzf4g+T?=
 =?us-ascii?Q?vuRHESlwG+TIdM8M4T1hgE8SClDgjSFVN6qYMEw9LQKOZpgRKihy9i/Ln9UG?=
 =?us-ascii?Q?kE8sm6XB2dcmGzbhfWjpikE+DB0YJdLaAZ0mcDj5PRQa67lZzRvSl/7O5zzA?=
 =?us-ascii?Q?1PtZVtajNyi/1hJrXnwSrd9HstiJMUi8df8QBrFhpgfjGGGTJoXAI4k3r7VC?=
 =?us-ascii?Q?J5vcufsqfkQGZm58hqXWjBU3WiT6jsWh+h2Ullx26FC7qahaTB6b56/VFtqP?=
 =?us-ascii?Q?8HUbNglwZGE1oeKECUc9lDK0aKwZ6QeKUqyQIEtskFZa/nhYDzypENRN2MqR?=
 =?us-ascii?Q?wVZUGyy57tR73uY0pJfWPdsBzS/wwUdWC8mPdqMp7eePmhPuBxU2gwWROZqX?=
 =?us-ascii?Q?d9jvxBqFOFpf1BxamI6zBvAuLbhaukr+woS/LFdU3JtepjxDvYKR6OTjQRjv?=
 =?us-ascii?Q?rrosKDNEsBz18ZKGDsiMobyqbBS98b3ZYnJgPzpH9XFzYTQDW1lIR/qMSH/h?=
 =?us-ascii?Q?PxnmVi3Hg9ae0U/+pxOhVmnTZo7kVnuGW7i1/01wpmJXAemoG4dHY31TXMx8?=
 =?us-ascii?Q?1gs637mKKQrYKY9jg2FJSCONTtefLcg3zaQqrgA+AvdmQesMDX48PF6W8mnk?=
 =?us-ascii?Q?ghWHEaAiO6Q2/4sjW9GNOROG?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3772dbb8-8da8-4a88-5764-08d900a62842
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 07:06:29.1564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwFHMNsCfk8OWOs7HgBL4khqq7olLSsm05JROCuyTVo2PIZlKsJOWJMB6tebZdF/AqEunI/9LjZKIHzJqy2x3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 16:12:23 +0300 Jarkko Sakkinen <jarkko@kernel.org> wrote:


> > So kprobes ss ins slot page "must be in the range of relative branching only
> > for x86 and arm"
> >
> > And Jarkko's "arch/x86: kprobes: Remove MODULES dependency" series look
> > much better. The last version is v5, I'm not sure whether Jarkko will
> > send new version to mainline the series.  
> 
> Ya, I got really busy with upstreaming SGX. That's why this was left out
> (but luckily SGX got finally into upstream).
> 
> Thanks for reminding. Any motivation to pick it up and continue where I
> left of?
> 

I can try, I will try to send patches once next rc1 is released.

thanks
