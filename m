Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC85B3EDACB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhHPQWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:22:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46742 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229542AbhHPQWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:22:34 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GGBrRC018564;
        Mon, 16 Aug 2021 16:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=DWDYP7lhAh7eTGcMYjZdgesbLGBL60Fx5q9mF5secME=;
 b=w2CdUiKqr95w8iDK+u9u8xUSrdoNwOI7hbAZ1H3W+YS6avKrepC7iUSyRQxZ4exVgw+X
 dVCTfPUbikwsLWewiOBCh3hEctRt0x8i4JdY5wUOdFNtBPYEQaEXc7QT85x+CETxI5LY
 KrfLxbuMQMxW+omo9sQYo+l90HNw7NqypfY0JVI73RCh2j3jU3fULAoK6Th1d5n3ihTc
 SpIOMLbDLuOF9lVHbPw8M9SBGBsw9zIKMvG+yIocSeYsgZ+0wKV14TuoRo+RZkHdgYwI
 cNSoUAdS3LiTkpK2kBJrP8adnU7g+z7nUjl+m/+uCp5XPnbR/kwMTiRdLXbcEtGwtOuU 1w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=DWDYP7lhAh7eTGcMYjZdgesbLGBL60Fx5q9mF5secME=;
 b=e5Xj2lO2GqN5CCfIsYumWk6XBp6NZKnrchslIAoTYUSjCqVD9208uDIZmmIBXEl1E7/O
 Fm28OiSG3LxQc5cUyb8JaAj4bgQ06SI5QlTV4aF4LtrqD/EDAxzVhKKvjjdxd838y5Kq
 snCxaxqaGLqYPlx099kJT0unmiVSJG1A4uuB/iX3/03y+/RbjWF6KcvFRPzWsnInFlww
 iINLlN9I0GnUdeNCLorSbAdx28wzyScNTPcvZWIJxOfiQbfBWMUm1wIN7BpbWfq+VxzE
 +V/5cbsiCctt/O1ujnUZv7os4z5FfJkujgobwPjxzSDCFzY7qtKnwh4oHHTOpOU2yZak CA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd1v02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 16:21:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GGCv1n052255;
        Mon, 16 Aug 2021 16:21:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3aeqksex89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 16:21:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2CnzUMuN6tg/MTdr5TSV/N5qgoLB3FPGCXjXAiVdINj5qJuPFAOTImeFJqIes1y+m6fdmtucad/T4sJIL2HE5pT0HgQ03lYowdZmM+tdOh4WVu7dmalRe6/D5HwhYfrWQHonFpWTkC+gagES+5R7gasYTAoY4W0gTBk/vu6RVH+fr5Yk/tRI1z1auDGIdTY/0BZvaSScTVsKGnA1bfIibRL22nBC657sbbwVNRKifyNGRUMbsU8ubhRAIGRzkpzXoGdQvxkgLbLNlZ7ueq998s0+OXGR/xWum1k7O9huI2eXTwSQEPzkBRk8WniUChQizLhF+qtFADZ6vq+4AWrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWDYP7lhAh7eTGcMYjZdgesbLGBL60Fx5q9mF5secME=;
 b=afMlXsMS3ujLhSfuXo+CEFNIuRHJ+J/sCDwkrPSbsdHJtEq6Muh/IypFSCv3mu+qRAPGGkyi9KcLJc7ZypNb++fGjCiObJmHbZg0/3qtrYXn+Vf1xMJP15F8QCfCRgfgdiAU8YAqfg4/Ho6NeeIgeqENzojTDF6tw0Q03AYdfyL+7cbLMTa4GhMotJvkjbPQCUhaUkZZPOJlelMKB8aVkbj/MPKdsInhLWXf6LXQBNto5Dzh+YDI7KJvtrKsDvY85QbSxrXACT+EUkrsA8ei0kkKvK2etVND2RrmstxK0/yeyRwf4Mc9UQ7Few/Dpymlq/AxEdiIMEOkK1y5rmPriA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWDYP7lhAh7eTGcMYjZdgesbLGBL60Fx5q9mF5secME=;
 b=GYfu2mnLJoTlqJxoI1TqDFd/rvW5mO+CIe5GfmsDzPMJtB7h+VI2uuFVBwy6syST4smagBM0Aex+IE52RvIY+gqcrTOmQshC8E43pG51GsxMBTL/HKsypwCFlxcqRJrXRdqiMQ1b/trxQvX0MF9zyYpykoR0tYVdBeSzTSuV8c8=
Authentication-Results: baidu.com; dkim=none (message not signed)
 header.d=none;baidu.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by SJ0PR10MB4768.namprd10.prod.outlook.com (2603:10b6:a03:2d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Mon, 16 Aug
 2021 16:21:08 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::203c:7f44:c562:b991]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::203c:7f44:c562:b991%3]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 16:21:08 +0000
Date:   Mon, 16 Aug 2021 12:21:03 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.co" <bristot@redhat.co>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH][RFC] sched/cpuacct:
 Fix cpuacct charge
Message-ID: <20210816162103.dup2hbho24wtmsgs@oracle.com>
References: <20210720060441.22550-1-lirongqing@baidu.com>
 <YQKAzWT/bdwgepbU@hirez.programming.kicks-ass.net>
 <4bf6cd58adb5411e989530e1443f9698@baidu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bf6cd58adb5411e989530e1443f9698@baidu.com>
X-ClientProxiedBy: BL1PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:208:257::18) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oracle.com (98.229.125.203) by BL1PR13CA0043.namprd13.prod.outlook.com (2603:10b6:208:257::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.11 via Frontend Transport; Mon, 16 Aug 2021 16:21:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6af64822-a042-4040-c0c5-08d960d1da30
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4768:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB476806148C01E7F110F39FB6D9FD9@SJ0PR10MB4768.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbsIrfO5JNJyYfxdKujJzjt9Bo9i+ZKVvfzmSpYWTV2NARdoUKIMh3N3YBSsf30lpvX1vZyJ6BgT94JwEDzpfRzBKe8AKp4k1fbQaftn+q2OQ3v+vmAwOt+BxV2uyTMjwo07gYxLv/sAKSflXu3vWyF2vA/PiPE1MRNTM3U1S2GjgZFxGkScqTnjAXR+Ly0j5FC79oPzrcRpzBsIv68ACxWo+o7PZTDABgy+osn2RGBbA9ggB9W2p6cSvLVcV1p7KG6T+zZrKYXtzOq/C5sVgXFoZ628k4497L4QxMgd1oVtBjdju9aZR6FWYkCFqTiPqThyur76mhqO5/RZOvv2x2s015S48yoMLgWCv2MF5SHkm/4FuPw4Aq+bK6YwVZwiCp1TJNowlsYLtBsvEczjKWMML0WeuwCDDzSbu1D1bE93QeFw7orq18p+B22zWaIiGcP3tFkZw5sgC8swB9V7dGBFSP/j/daSteu38gxcqySEdz2ENlni9y9fvJuCScPp2/EWTZ25dKntZ3v11xEyQDYz8FbLcdCfzfO2XrSdEi5g9oIg+4vpiDwj2DwWCzNLXyBYlpicuTzD5lXKLGiV9jJoAEVn9NhJAcd1+mPCtwtEEEOexYrn0RgDJztHLKqX2PZslB5msD9D19FQmqIYd33M1ugNZiYuqOnFAaqPouGATwygshAw/kwR2SiZzNOEkqDiFi8Qw/hQgrQQq/ZdtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(366004)(39860400002)(38350700002)(2616005)(316002)(956004)(83380400001)(26005)(186003)(86362001)(8886007)(55016002)(6666004)(8936002)(6916009)(38100700002)(5660300002)(66556008)(66476007)(66946007)(4326008)(224303003)(7696005)(7416002)(478600001)(36756003)(2906002)(54906003)(52116002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W8xlhoYbn/aNsxc9hcZIe6/y7ihJGvOioXcB1F+rofuG5Bk0YQXJ5jtSs0FZ?=
 =?us-ascii?Q?SoZ8c+2ec/xSBDzSam1PdtwlLOIi9dvaBZMid9oAHBI35zPsynFz2mNcGRX9?=
 =?us-ascii?Q?q5EfWhfGcpiHZmy0kXqsE2+32jRBwuXEinheeyX9sDoIkYFuftHfSTcaKWKB?=
 =?us-ascii?Q?VCvTptPB5bz24Z3KNX4fEQXDKrrZ1VxuzKo+AThfZrOiC77cCIHsZKBUIvkZ?=
 =?us-ascii?Q?H8/0G1EUtMujP6pdjKU1ZuQta5PXoHSsutf4IvK0mqo2OyV9g9Dp+lHGIbpi?=
 =?us-ascii?Q?YAVP8zIMgv2+1SqjQOMGhb9QRqat1sZV6Nw9sAxFwm4BTBobqR27oL4nqzF1?=
 =?us-ascii?Q?NqwBzsLJhu5IFrWtHikQkKMkF2FR/Ywqv+0lwxE5+LD4j+J2VAVLwEsacVvF?=
 =?us-ascii?Q?KVzo4/sqlGMbliwVcYETM/ne/Okd2Vk5bZwMsT7RlDw6r/mUeMNt0cDvwHJG?=
 =?us-ascii?Q?Iknkj9+SfxOeKCqqahw/HfgSZ8IVuSPBPCKfw3BmYRRPo263Rlkj6UKVUrWA?=
 =?us-ascii?Q?jUearuDIvHLV8Qouz7y7a2Iv5VSLDwYM4/VtMuH1FuI+KzB4iJ4P4kJoQG4u?=
 =?us-ascii?Q?aFDTQIsH/i6kHcJLJYMypUEB6bA9HYDJzjIDCodJFjarUFcDRHu5sVUqwSLR?=
 =?us-ascii?Q?DInHEPXIPHHqWgFWlPYKJ3w+teK5be1tMGSLXVjnTgvgQE2b1K2J5JgTOWfU?=
 =?us-ascii?Q?nFTLilyFu/viSdH4tDWOhA/z5sociOd9+9quCT9xndULf81ZmJY8CVkKIcfG?=
 =?us-ascii?Q?wMIk+ClCIOBCGjaMShWkOJSEX4vvog/UB7isKei0cUbm44e7vf00RJFppdLa?=
 =?us-ascii?Q?wtklHXnUVKTJW3rFaJtUIXTXkrf84nxw2K5FiT4vJdkvSm7bJmGJkJcMQiX9?=
 =?us-ascii?Q?yZGd9Ey17FyzEFzNn5IHcd+nuDCaHZoEZBmArJLcp7KIF/NlPEijshq4Wzyp?=
 =?us-ascii?Q?1DXxPNW3rHNEMkQc2QDWacj6OAumxggdHWrLpHRqrOnf8bScAHc/lRqPg1BB?=
 =?us-ascii?Q?kIlBHEnMx6fJmQk8DfUXGQLaYWRY1pf+w2+xH5d8mZEmqbxdSLFhSNYtRqp2?=
 =?us-ascii?Q?33vcrUGNAo98R7HvlA+t0ReayRZPBzjyjTrfiASj94tTzU6PeuQ9+UTUPvCU?=
 =?us-ascii?Q?Nq+NTxZXpFxxqLkHyf/z4ZBOcYP5LBgyMRq8rjH6pV7rH/9W64Id5OvNz9Ty?=
 =?us-ascii?Q?fO+xYzGGnbib4RIHYztQPh5oNAiQ35M3dRc9kV1PJt/l0FHb0W4TcaG/fgY/?=
 =?us-ascii?Q?S/0kgkfWRcO+cYQt/zFhTXVAHWUjoYFgWL3aM+fVquHmqFiIHOgXLd1RgEk+?=
 =?us-ascii?Q?o/JAD7Dq5JerLf2eTdTzvuNo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af64822-a042-4040-c0c5-08d960d1da30
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 16:21:08.1441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wl/jy/vMwnOkgGhu/+AUisRi6OFpe90+suXjA+iyAhJLfOpFUr2f/6yzi2OIUU/c06Kk76WV80cDjkvoZTJD//3vitbjNZw9eaPwc45d3P4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4768
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160103
X-Proofpoint-ORIG-GUID: peY81g02E6I8EIotk7AEZ0z43PZt1rAN
X-Proofpoint-GUID: peY81g02E6I8EIotk7AEZ0z43PZt1rAN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 08:16:54AM +0000, Li,Rongqing wrote:
> > On Tue, Jul 20, 2021 at 02:04:41PM +0800, Li RongQing wrote:
> > > get_irq_regs only work for current running cpu, but the task, whose
> > > cpuacct will be charged, maybe run different cpu, like Cpu 2 wake up a
> > > kernel thread to CPU 3, cause CPU 3 task are charged with the
> > > following stack
> > >
> > >   cpuacct_charge+0xd8/0x100
> > >   update_curr+0xe1/0x1e0
> > >   enqueue_entity+0x144/0x6e0
> > >   enqueue_task_fair+0x93/0x900
> > >   ttwu_do_activate+0x4b/0x90
> > >   try_to_wake_up+0x20b/0x530
> > >   ? update_dl_rq_load_avg+0x10f/0x210
> > >   swake_up_locked.part.1+0x13/0x40
> > >   swake_up_one+0x27/0x40
> > >   rcu_process_callbacks+0x484/0x4f0
> > >   ? run_rebalance_domains_bt+0x5a/0x180
> > >   __do_softirq+0xe3/0x308
> > >   irq_exit+0xf0/0x100
> > >   smp_apic_timer_interrupt+0x74/0x160
> > >   apic_timer_interrupt+0xf/0x20
> > >   </IRQ>
> > >  RIP: 0033:0x456947
> > >
> > > so define a get_irq_regs_cpu which returns the required cpu irq
> > > registers
> > >
> > > BUT it should be not safe, and do not know what it should be like in MIPS?
> > >
> > > Fixes: dbe9337109c2 "(sched/cpuacct: Fix charge cpuacct.usage_sys)"
> > > Co-developed-by: Zhao Jie <zhaojie17@baidu.com>
> > > Signed-off-by: Zhao Jie <zhaojie17@baidu.com>
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > ---
> > >  include/asm-generic/irq_regs.h | 5 +++++
> > >  kernel/sched/cpuacct.c         | 3 ++-
> > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/asm-generic/irq_regs.h
> > > b/include/asm-generic/irq_regs.h index 2e7c6e8..93e2579 100644
> > > --- a/include/asm-generic/irq_regs.h
> > > +++ b/include/asm-generic/irq_regs.h
> > > @@ -21,6 +21,11 @@ static inline struct pt_regs *get_irq_regs(void)
> > >   return __this_cpu_read(__irq_regs);
> > >  }
> > >
> > > +static inline struct pt_regs *get_irq_regs_cpu(int cpu) {
> > > + return per_cpu(__irq_regs, cpu);
> > > +}
> > 
> > This primitive just cannot be right... it'll get you some random data.
> 
> True
> 
> Seem no easy to fix. How about a partial fix
> 
> diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
> index 893eece..48b117e 100644
> --- a/kernel/sched/cpuacct.c
> +++ b/kernel/sched/cpuacct.c
> @@ -340,7 +340,12 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
>  {
>         struct cpuacct *ca;
>         int index = CPUACCT_STAT_SYSTEM;
> -       struct pt_regs *regs = get_irq_regs() ? : task_pt_regs(tsk);
> +       struct pt_regs *regs;
> +
> +       if (task_cpu(tsk) == raw_smp_processor_id())
> +               regs = get_irq_regs() ? : task_pt_regs(tsk);
> +       else
> +               regs = task_pt_regs(tsk);
> 
>         if (regs && user_mode(regs))
>                 index = CPUACCT_STAT_USER;

It still suffers from task_pt_regs().

Why not make cpuacct use cgroup2's approach?  Remember only delta_exec
here, then on reading cpuacct.usage_*, use cputime_adjust() to scale the
user/sys from cpuacct_account_field().

It's arguably more than just a fix for cgroup1, but there have been a
few complaints about this function lately.

>         rcu_read_lock();
> 
>         for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
>               __this_cpu_add(ca->cpuusage->usages[index], cputime);
> 
>         rcu_read_unlock();

By the way, I think the __this_cpu_add() can be wrong in cases like you
originally describe.  Seems like a bug in 73e6aafd9ea8 ("sched/cpuacct:
Simplify the cpuacct code").
