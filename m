Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC9E32A08C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576046AbhCBEXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:23:24 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20568 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239873AbhCBAfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 19:35:41 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1220OeKc010496;
        Mon, 1 Mar 2021 16:34:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zUO6zSj+MU6d6RfKkBeqf+9O2ahWL/AGTqaAS02gVbA=;
 b=VeNNF1z6njq3sM3M+8cfiAJywvtRQ3O0g6Zw75otdJU6fDH1BR5F+CzQ3X8MSFbpbN/r
 VOfnZlSxA9odSjG+OMuePObVqW6ShJpBDcLZ2bFTx7yDEYEW2rXmZMylPSJKxlzE6FSh
 SSk+h3qAQmNghjy6ovHwKnWvktSNbt27LmI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 36yjf63h6k-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 01 Mar 2021 16:34:42 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Mar 2021 16:34:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMM3u7yfPWaInprfpBJH9RadkrTEFO7MlmlXsarlAO82NS3ni0mGPvsttBGuE9nlYYqCP2v1nKXYsjHNLK9VNV7dYYJabRouf5mv2Cw7aHGU63oiYdRMFuE4S5t9skFnFDQpfICJfUhV/5ZdmMKR5q5AYtCP/2PE5rqYGz6yPmcj96Br/YTH22rhPcbkmMyok6xLdj3TL4OSj4PanFCcAReaDJA+JzgQTqBmsp7LKYs/axUiXY/VmTJaQeF4faA0EeVh5cZ/HlWdZg9FKuPxwWSSmHJ4HLtAbp2yWyi6nGzuH0EsbpZfGg3E0yimFmQLCOWJ7ftQDlmjOou9RmjixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUO6zSj+MU6d6RfKkBeqf+9O2ahWL/AGTqaAS02gVbA=;
 b=DCEPmM9mPvtOdU3spSGEKWJDd9lnAPE6pszBa3KRUqy7vm91CspXyb79W0xpatYSRHR0Tgyc+4rAmU+Af+y+Ty2exKOS16Sg/9ALEAr51ikEbOuoECy4844J16sBGevUZL9b4hgi34sXnz01xZJP1kWiZMh1AUBR1NTH3JHFlZMM+MeRQR+qUVwrxW00IorK7L8pdhxnCP9qeVkVsaMMJlX0y9xfTCx1k5ZjJTfdnf8TRZmemdl4GwxbTsxHxWCrb1ULAd6J/H5CS0p1wq3Viq9cNNPQNTY724Jr9E6XgdHUXeNMhcK2zmygoyMU0x38Ut5YCXpFSZzjd7vOhROBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4357.namprd15.prod.outlook.com (2603:10b6:a03:380::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 2 Mar
 2021 00:34:40 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 00:34:40 +0000
Date:   Mon, 1 Mar 2021 16:34:35 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] mm: /proc/sys/vm/stat_refresh skip checking known
 negative stats
Message-ID: <YD2IGxfOE5AgYuzc@carbon.dhcp.thefacebook.com>
References: <alpine.LSU.2.11.2102251502240.13363@eggly.anvils>
 <alpine.LSU.2.11.2102251512170.13363@eggly.anvils>
 <YDw67lSx5vLTgx/O@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2103011301010.4832@eggly.anvils>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2103011301010.4832@eggly.anvils>
X-Originating-IP: [2620:10d:c090:400::5:642c]
X-ClientProxiedBy: MWHPR14CA0070.namprd14.prod.outlook.com
 (2603:10b6:300:81::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:642c) by MWHPR14CA0070.namprd14.prod.outlook.com (2603:10b6:300:81::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 00:34:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93132354-e9fe-4324-432c-08d8dd12f6f9
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4357:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB435742F9B4C52CAEC2F0010FBE999@SJ0PR15MB4357.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVZ2Gy7sEw2wTDNIAVi3MPGh4sdwh7cG+Dv/3TDGOseFCFcKye7LVCSy/kzIyNZa8C120+CTbDSpEa48wHUZ4q0WI8lJN0+AlfN7yaeXriA5HeZT/3P7dVeTQfFJa/z2GTjsNYRvB4UEvvcCTCRPRWcUWyyryLBMx0ngVsl6nZOGWbbZedm8LjixD03N/k500uCl7FRp+yyADWknWdJpRR8h5Oje/ah5DDrHMnkZwfPDiE1ke0JJ5PZP0fks3jzG1BpC+knezu8oKj9p9OumwGhm0lL9EjYA4lN3EpzOqJKrLZ7HrDV6pcQz2C2Zo3L+VqJqag+vwhuiOOu6+P9uL1PmdsfP6lPvs3YXu/U6oz/v6fVBEKmpakwkVdQbTGXvK1XQgEL0MRkXAG6H2i95emcPKnS289JSJnvb41XafHofztwKNoJht2by6XsPInguALKUa1rnNm9niHjGvQK3BfnH6j1awhG1WwgCjkYzTjhodhAvtPIZTPReRSZC0KgYz6FgKW6RyteV9JMx5pasmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(396003)(136003)(366004)(4326008)(86362001)(66946007)(66556008)(66476007)(54906003)(8676002)(16526019)(186003)(5660300002)(8936002)(52116002)(6506007)(7696005)(55016002)(83380400001)(9686003)(6916009)(6666004)(316002)(478600001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jqIKi5p6X84BqDMjO3ORg1UO0sgEdzxRfW16y4kDgVceh+HzwJ2TP0wgHvld?=
 =?us-ascii?Q?2VU+Eycjedk8d0leSE//jaf0pFPTATDtrd38wbxDDX98pu49ADxeDonodLBB?=
 =?us-ascii?Q?ywFHktFqLLozW16F9VMpNfkLcQUVLJeSEMcOw8Ktp3HnQksgGPdBGe1M445Q?=
 =?us-ascii?Q?Hv6vfg5/AwFX2lObOvc4Sjb1YFW3Xdiy6y8f8Kvg8lUvM5e6D+j0WmmgdHqw?=
 =?us-ascii?Q?go9VchjvECDq2OLSUG9MuZ8dJCHQ/5tIcogC+waobQS+EfOQ0KzXKJbhmVOs?=
 =?us-ascii?Q?wAFaQCC2TGNSEvx2l444KRS+MAtszToUdvr7oac+a/CcF1on9Zb/7bjavW5M?=
 =?us-ascii?Q?xXkrFrkXMBpqdNtRkAjAb1jiOmMnsZP1nlz7C3ojxs61qQx+Kf8EYUUgSJO4?=
 =?us-ascii?Q?B0jzTb0rjYCJcXnkFPp1KzX+jZh6yj+IFDXO+yzKb6LFQgJMF/lrEM9zmUrK?=
 =?us-ascii?Q?EdpOu80eCiXhUJlph3/zzAkKTT4bLiHMmAuQSrZn9gZhO8cZ2zM0tA6+0yTk?=
 =?us-ascii?Q?IHq1qKfNsIlZotOqcMuEzCMNVlvDIeAVDuWpJJlVr5EVYI00fBM6pI4ufu9N?=
 =?us-ascii?Q?9aRNMVW3QGQi2+dgDi/CcDRkpoDppM0qrF00c2pM18zQSZ4eoWn2USZktAew?=
 =?us-ascii?Q?KVD0zM1zqi5Xs66dKys17Hq2fls87j5fuvY0h3StCvIyBcv72QgM+wZpSovz?=
 =?us-ascii?Q?GDH8DuZ3x85lJWNlkWAzPSe3/1k77tcc7ECcOH2XxdD24m1xZyYD3z5kLt2H?=
 =?us-ascii?Q?weLwEmqUS9blNh9LhLfUp5pEZxbw4Ndj4enS7EZozAGJYgRkt20AXbZhMufP?=
 =?us-ascii?Q?GzX/B3EAdoHkPqG3+doaYOsxGoexbn1WalRIwRjKwts5VBSGTLpt/8qLfnAq?=
 =?us-ascii?Q?/dmhnMJXH7q5POhIxTnojJlhYNtdTw9Dw++UrVaG6qvZaIYwRkDPDtGiveKW?=
 =?us-ascii?Q?9nSjtknOD9bUg3DCB1QkBm8IejxcOLHeKh27isSMK49sXPXehjQi2mA77RMR?=
 =?us-ascii?Q?zlUjWoCkrymuIfrtXXAhJ2PxoNRTp65i89bdktJCFakeFccGlFK9UlQRi3Wb?=
 =?us-ascii?Q?nvjzBGE8mh8+hmW6Z4qwxEtOL1k5AhhJOc1118G7JtvBnet4zYwntQ7SgklW?=
 =?us-ascii?Q?Uehnigcof89AReXGRM/3kzK87n596TtTT0bshNv8z72+YsSpXz8SbQsiRlIl?=
 =?us-ascii?Q?JySRF+/15P17erdZih2/6XEaRNrLfKgLBIxDgWkxlzp2xUHLrOcCIVXDYV+0?=
 =?us-ascii?Q?0w2NGUsh0pENySOmEgQj2KJysYdcEOGQcz2dcXAHq0kB3otfoWO6iS9Lu2hP?=
 =?us-ascii?Q?w0EZ3g5ppy/Wxd8VdD0SNAtMmvQh+Bqvb9E8lnJpZkkQbQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93132354-e9fe-4324-432c-08d8dd12f6f9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 00:34:40.1892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzZQk5GNfgIGqO/0BMK4Tok7kz08EmYf/rjwDZFWdo02F8gQr0bL9x4xuaEaC9q1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4357
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_15:2021-03-01,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 impostorscore=0 spamscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 01, 2021 at 02:08:17PM -0800, Hugh Dickins wrote:
> On Sun, 28 Feb 2021, Roman Gushchin wrote:
> > On Thu, Feb 25, 2021 at 03:14:03PM -0800, Hugh Dickins wrote:
> > > vmstat_refresh() can occasionally catch nr_zone_write_pending and
> > > nr_writeback when they are transiently negative.  The reason is partly
> > > that the interrupt which decrements them in test_clear_page_writeback()
> > > can come in before __test_set_page_writeback() got to increment them;
> > > but transient negatives are still seen even when that is prevented, and
> > > we have not yet resolved why (Roman believes that it is an unavoidable
> > > consequence of the refresh scheduled on each cpu).  But those stats are
> > > not buggy, they have never been seen to drift away from 0 permanently:
> > > so just avoid the annoyance of showing a warning on them.
> > > 
> > > Similarly avoid showing a warning on nr_free_cma: CMA users have seen
> > > that one reported negative from /proc/sys/vm/stat_refresh too, but it
> > > does drift away permanently: I believe that's because its incrementation
> > > and decrementation are decided by page migratetype, but the migratetype
> > > of a pageblock is not guaranteed to be constant.
> > > 
> > > Use switch statements so we can most easily add or remove cases later.
> > 
> > I'm OK with the code, but I can't fully agree with the commit log. I don't think
> > there is any mystery around negative values. Let me copy-paste the explanation
> > from my original patch:
> > 
> >     These warnings* are generated by the vmstat_refresh() function, which
> >     assumes that atomic zone and numa counters can't go below zero.  However,
> >     on a SMP machine it's not quite right: due to per-cpu caching it can in
> >     theory be as low as -(zone threshold) * NR_CPUs.
> >     
> >     For instance, let's say all cma pages are in use and NR_FREE_CMA_PAGES
> >     reached 0.  Then we've reclaimed a small number of cma pages on each CPU
> >     except CPU0, so that most percpu NR_FREE_CMA_PAGES counters are slightly
> >     positive (the atomic counter is still 0).  Then somebody on CPU0 consumes
> >     all these pages.  The number of pages can easily exceed the threshold and
> >     a negative value will be committed to the atomic counter.
> > 
> >     * warnings about negative NR_FREE_CMA_PAGES
> 
> Hi Roman, thanks for your Acks on the others - and indeed this
> is the one on which disagreement was more to be expected.
> 
> I certainly wanted (and included below) a Link to your original patch;
> and even wondered whether to paste your description into mine.
> But I read it again and still have issues with it.
> 
> Mainly, it does not convey at all, that touching stat_refresh adds the
> per-cpu counts into the global atomics, resetting per-cpu counts to 0.
> Which does not invalidate your explanation: races might still manage
> to underflow; but it does take the "easily" out of "can easily exceed".

Hi Hugh!

It could be that "easily" simple comes from the scale (number of machines).

> 
> Since I don't use CMA on any machine, I cannot be sure, but it looked
> like a bad example to rely upon, because of its migratetype-based
> accounting.  If you use /proc/sys/vm/stat_refresh frequently enough,
> without suppressing the warning, I guess that uncertainty could be
> resolved by checking whether nr_free_cma is seen with negative value
> in consecutive refreshes - which would tend to support my migratetype
> theory - or only singly - which would support your raciness theory.
> 
> > 
> > Actually, the same is almost true for ANY other counter. What differs CMA, dirty
> > and write pending counters is that they can reach 0 value under normal conditions.
> > Other counters are usually not reaching values small enough to see negative values
> > on a reasonable sized machine.
> 
> Looking through /proc/vmstat now, yes, I can see that there are fewer
> counters which hover near 0 than I had imagined: more have a positive
> bias, or are monotonically increasing.  And I'd be lying if I said I'd
> never seen any others than nr_writeback or nr_zone_write_pending caught
> negative.  But what are you asking for?  Should the patch be changed, to
> retry the refresh_vm_stats() before warning, if it sees any negative?
> Depends on how terrible one line in dmesg is considered!
> 
> > 
> > Does it makes sense?
> 
> I'm not sure: you were not asking for the patch to be changed, but
> its commit log: and I better not say "Roman believes that it is an
> unavoidable consequence of the refresh scheduled on each cpu" if
> that's untrue (or unclear: now it reads to me as if we're accusing
> the refresh of messing things up, whereas it's the non-atomic nature
> of the refresh which leaves it vulnerable to races).

I think we both agree that for some counters going slightly into negative
is possible and isn't an indication of an error, if only they don't become
too negative. For other counters it's unlikely: so you see a value in
raising a warning when they do. I don't think there is any disagreement here.

So the only question is how we encode the list of counters which we're
comparing to 0 (we can list them or list all others, as in your version),
and what we do with the rest (we can ignore them completely or compare
with the maximum drift value, as in my original patch). I actually don't
care that much how exactly it's implemented, if only we're not generating
too many false warnings.

How about putting something like this into the commit log (I'm sure you
can put it better than me. Please, do!):

"For performance reasons vmstat counters are incremented and decremented
using percpu batches. vmstat_refresh() flushes per-cpu batches on all CPUs
to get as accurate values, as possible. However, because this process
is not atomic, the resulting value is not exactly precise. As a consequence,
for some counters, which real value tend to oscillate around 0, it's possible
to obtain a slightly negative value. If the value is relatively small and
the state is transient, it's not an indication on an error."

Thanks!
