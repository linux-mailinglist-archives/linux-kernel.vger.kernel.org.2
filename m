Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FC2362598
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbhDPQW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:22:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24214 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235507AbhDPQWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:22:14 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GGK0lG002033;
        Fri, 16 Apr 2021 09:21:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cDdXrSKOv1KEhREir67rHNeUTWRgxqSl7pQnA6crp/k=;
 b=DY58/sVgsXPgmBb8rcvdMvFLkuGy7Mm6OSa/y0mq5rjNO5HwIWlEOW88f3UywIAjAwRT
 xR3ktLpLM4e1TjCHklM3H0xbc4yBtBa7WPgHoBPawRWOO6ufOwUrJuMyLSAei1jEznZI
 txA/riggvSjywE34wrjURSc2C2IeGQIAvpw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37wv9qpyh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Apr 2021 09:21:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 09:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zu899Ig6ZZE2L4YveHPNGkn4Pq3MZb1TISUHIoyMNPK6am5kvNoEQjPXdCwwgTkNvhvd1bvMhrVnPzrFKJOcemtz+jY4H3HpQKKs2A3DmV/rhu3CFM3eEQWTm/FWPDFLxgaKg0LA/2rPhdUDASKGixgJ4twUbI/Spz4f/jqZ8SeDdcbQPWd9AuzIO0c4uQO1pGe0QpMbNmV9+0f674EaKsUnkLwZdVj0oX7y99cwJXZLBFofyaJEGFlOkS6R1AZMiqQVOt7zQDNgl24aVjAFgD47H/PUAa8g18788cTvzvxv9QFudBMnVahwH8ej74fagUWKJSfRGcJu+oFp41nGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21PTcwzHSJ254U92A845ZY1WBexatWsaYBkx62t6ZUw=;
 b=l9LneewlrU682A2ZSGW7+HebbseSKD+zS9jYx7PHlMLHP3W8mXBzOYaA9m1NWay7R77P4tIueHlM1COsWMFoutrP/ltrYexAbPNz26qbjD7N3bPlvmtaxu8rwGN2+/ZzIYB0K4etnZPg9kO7XIpRYTBSIjdgJuCKwfr1fcWLgYw3puze3cOjcpDGdlMEJRf6eEp9eGg+Mes34ctXYlAEYnhBO0qvTTbwByNXeiCWivOxM8AB9eydCgOmeqhiiO7he+hXrNIGmbnWktTJSwijww8hwYKo9RLwEosMDFIK0vwubcPDn3AztfWe2Bj3ZGvA3e+aWndePrpmeZ7gC//K5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3684.namprd15.prod.outlook.com (2603:10b6:a03:1fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 16 Apr
 2021 16:21:36 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.025; Fri, 16 Apr 2021
 16:21:36 +0000
Date:   Fri, 16 Apr 2021 09:21:31 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Pratik Sampat <psampat@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <pratik.r.sampat@gmail.com>
Subject: Re: [PATCH v3 0/6] percpu: partial chunk depopulation
Message-ID: <YHm5i9/j+RiKcONf@carbon.dhcp.thefacebook.com>
References: <20210408035736.883861-1-guro@fb.com>
 <25c78660-9f4c-34b3-3a05-68c313661a46@linux.ibm.com>
 <YHmcorqNE5NpAN3G@google.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <YHmcorqNE5NpAN3G@google.com>
X-Originating-IP: [2620:10d:c090:400::5:3149]
X-ClientProxiedBy: MWHPR12CA0035.namprd12.prod.outlook.com
 (2603:10b6:301:2::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3149) by MWHPR12CA0035.namprd12.prod.outlook.com (2603:10b6:301:2::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 16:21:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59de7d21-303d-4104-3c34-08d900f3b512
X-MS-TrafficTypeDiagnostic: BY5PR15MB3684:
X-Microsoft-Antispam-PRVS: <BY5PR15MB36844851265C7930A87EC6E6BE4C9@BY5PR15MB3684.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sW/p4Zra+V+s2COp9VNKlz7vPBGn6l7DVsM3wNfN6ybuoHb4f9tyfUlZN77Fcf1RFW5r0e7nRuzSThITPToPkFqzTdLI+UiQCNciYTVgCg9sZjweNtE2eq3siNtLk/txkoFJItUyq1w7K2gbC3uzF1tcjOf3NtM72Nzpbp5UeVjW06+wN+BGkD3k5b1KaSVWkLxV+Q0iCsoFUZVo38bW01kdPZ18l6txlFXinjWtYs+C//QOynWsUAWI8yKs0k+mDfFoyVSQkCRxWmA3coPfqGtoS43Dpxlv7+iFIfG9TvgPSDoRmW+Bld0mlwcqxszpYuWBElMgJ/jxFDu3xcVhRT8uk0d/SUgl+x9JMHZaoX75bb5cTXF3+GZf5Ysq1Et7eFJHCmK1nCpe6vOmBbDmD/XhIsQS2/HBj4WE/X0egzneS+icslYHvDECFygOvvJPUCdxRwsSvz98FKJBCIwjM4G12hGWpgj7CsOXSBNdU9anPBPxMxn/kL1VUbgNmHWi6mca7CVDiwKg48SeP8SSBFlLR03IEF4Psk42ovZPP93QLd+FY7Ib+619ejsOC9jvw0bA0QL4L5Iom864GQkaAHY8poFwvK9vbCDaEQZKQ/HjB2e3G2SIsSsDkR77izRWkCf9EdpVbfKRLhhjHHrRewazd27MrMmxtf6CK3pNAUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(396003)(366004)(346002)(16526019)(478600001)(6916009)(186003)(55016002)(66946007)(6666004)(86362001)(4326008)(8936002)(9686003)(5660300002)(316002)(83380400001)(6506007)(966005)(66476007)(53546011)(66556008)(8676002)(2906002)(52116002)(54906003)(38100700002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?DabIivbxlXLTmDG3b0nuDhYNVqNmzR2ZzocYt+37/4xnhN3WYVMm7lpFAa?=
 =?iso-8859-1?Q?v0Zq5tnqPJUh8JnmycBB50OTMC3u8ugxmOAHleGRsR4d03hoH/ccpxqya0?=
 =?iso-8859-1?Q?14GE/GrvY2rWRM4uk218Mg1RNohr2O6LBjkNtbrDhy5ScOOaRD3A8yMjKP?=
 =?iso-8859-1?Q?dDYMXvGIE4fJi5KTGcSk8ZM9d2x7KF1KknxxSP+/RpgHDjRj/FW2X/luM/?=
 =?iso-8859-1?Q?2CKdoCzqKre+bpDmmtBEL+q/NSwogS7tIeeN5EQxdz2UpRgtAT5uvb5/2m?=
 =?iso-8859-1?Q?mJNlX2on9msN7mCil/YmHta/U9I958qCJYtSKPWPzI1nGEabCKTARqnM2H?=
 =?iso-8859-1?Q?tpdYhA3WUd9jAbqOGbrnReQbnEdpnlGtxfsNCT17O/rYjPT/uz+DBw9EIc?=
 =?iso-8859-1?Q?FxMWZv5iZKyWHII0HaYD7mIuDMZxZbRMy3e0c8J8RlpfFq03rUzBmWdwMn?=
 =?iso-8859-1?Q?zPejWEKbGPg2Y3LuU7rU6XHtLG5CXgC+bIBz8XBu5TalwFiBmz4zaw3fmI?=
 =?iso-8859-1?Q?upHIIv+FiG3rFXq+4L/h7NKe7+akSZP2l+l2Bhpp75qtGoFyHg6xWn1kX2?=
 =?iso-8859-1?Q?8gn5E9SiJyK96rQkfjQcPgxNEXiPrds9lkmc8ULzbI6mr2ez842UqBpYZB?=
 =?iso-8859-1?Q?ogGjKXw7120pDiInojmnUy24s7P6x7u3V4M6CC2VD0hRa5kjnHZ/5ju6Qb?=
 =?iso-8859-1?Q?jPp3mahP453SbH+VXLaqhtmNSUMbN4+VeoNtPHMxLj/AExTNrfqj2utpkE?=
 =?iso-8859-1?Q?WKFVolVBDLhoALUBEQtqy9qonj2eIdTyHtkoZF2gII5n6etts6W6KezOAa?=
 =?iso-8859-1?Q?9KfyBl6+ZaZvNk4u6bbPh3UFX97IgZRiuUtSmizRIxbw1dCQnOeXUsx+4B?=
 =?iso-8859-1?Q?CkqYc/nhqte8+mFWxjrpyGzusFHqBY0HBdq+bBNKoBVRQ834fbHmA3k310?=
 =?iso-8859-1?Q?SuJkGUSI2BL5alp8uSfwHngGTzgCD7eZgdKvnw7gH3l4AeLMvIg+VaaE4W?=
 =?iso-8859-1?Q?LgqLoJLY78hpt75jYgqE6TWd5FPVDPiYyGCVoopd3km22xIV0+aOZt1qaD?=
 =?iso-8859-1?Q?DJ7DQSi3JuQ2hz/H6hTFTGy155QVOuYElrXiQ/xFrm27T0s9mGopFq5q7c?=
 =?iso-8859-1?Q?qCqHZlf8l0eHv3+AiRSOz6aVYEIsLMlTN3bdS6u/6ijoiJHbn+LtIuepVO?=
 =?iso-8859-1?Q?6CNFA2S3HHFlkhkxZLIwU7INouCEXQ3P1klt/OfszYlqjaaG3MlRHFewb3?=
 =?iso-8859-1?Q?dMuw0VA8ouPXx3Ide/qFGTIocI7P7jET4ZOKvO6RoWrudBnMQ+NGPM70Rq?=
 =?iso-8859-1?Q?2PeW/zIsu7i0AK31+J/jS+fYxdd9blQ7911LJugQ3KB15mshdnj1d5m8Bu?=
 =?iso-8859-1?Q?jx8Hf5bhRZ9ENzxBsZjuvPPTTXCaksiA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59de7d21-303d-4104-3c34-08d900f3b512
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 16:21:36.6708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzTFPuyWjDjhpOgE1cPLXqasTaqdnUSsWUr8nFmceyB3KVfnBawNg5luNZWEwkNk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3684
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: INire6wuhgkGAGsS1Vp_eOp7P2MCWqJl
X-Proofpoint-ORIG-GUID: INire6wuhgkGAGsS1Vp_eOp7P2MCWqJl
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_08:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 clxscore=1011 adultscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104160118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 02:18:10PM +0000, Dennis Zhou wrote:
> Hello,
> 
> On Fri, Apr 16, 2021 at 06:26:15PM +0530, Pratik Sampat wrote:
> > Hello Roman,
> > 
> > I've tried the v3 patch series on a POWER9 and an x86 KVM setup.
> > 
> > My results of the percpu_test are as follows:
> > Intel KVM 4CPU:4G
> > Vanilla 5.12-rc6
> > # ./percpu_test.sh
> > Percpu:             1952 kB
> > Percpu:           219648 kB
> > Percpu:           219648 kB
> > 
> > 5.12-rc6 + with patchset applied
> > # ./percpu_test.sh
> > Percpu:             2080 kB
> > Percpu:           219712 kB
> > Percpu:            72672 kB
> > 
> > I'm able to see improvement comparable to that of what you're see too.
> > 
> > However, on POWERPC I'm unable to reproduce these improvements with the patchset in the same configuration
> > 
> > POWER9 KVM 4CPU:4G
> > Vanilla 5.12-rc6
> > # ./percpu_test.sh
> > Percpu:             5888 kB
> > Percpu:           118272 kB
> > Percpu:           118272 kB
> > 
> > 5.12-rc6 + with patchset applied
> > # ./percpu_test.sh
> > Percpu:             6144 kB
> > Percpu:           119040 kB
> > Percpu:           119040 kB
> > 
> > I'm wondering if there's any architectural specific code that needs plumbing
> > here?
> > 
> 
> There shouldn't be. Can you send me the percpu_stats debug output before
> and after?

Btw, sidelined chunks are not listed in the debug output. It was actually on my
to-do list, looks like I need to prioritize it a bit.

> 
> > I will also look through the code to find the reason why POWER isn't
> > depopulating pages.
> > 
> > Thank you,
> > Pratik
> > 
> > On 08/04/21 9:27 am, Roman Gushchin wrote:
> > > In our production experience the percpu memory allocator is sometimes struggling
> > > with returning the memory to the system. A typical example is a creation of
> > > several thousands memory cgroups (each has several chunks of the percpu data
> > > used for vmstats, vmevents, ref counters etc). Deletion and complete releasing
> > > of these cgroups doesn't always lead to a shrinkage of the percpu memory,
> > > so that sometimes there are several GB's of memory wasted.
> > > 
> > > The underlying problem is the fragmentation: to release an underlying chunk
> > > all percpu allocations should be released first. The percpu allocator tends
> > > to top up chunks to improve the utilization. It means new small-ish allocations
> > > (e.g. percpu ref counters) are placed onto almost filled old-ish chunks,
> > > effectively pinning them in memory.
> > > 
> > > This patchset solves this problem by implementing a partial depopulation
> > > of percpu chunks: chunks with many empty pages are being asynchronously
> > > depopulated and the pages are returned to the system.
> > > 
> > > To illustrate the problem the following script can be used:
> > > 
> > > --
> > > #!/bin/bash
> > > 
> > > cd /sys/fs/cgroup
> > > 
> > > mkdir percpu_test
> > > echo "+memory" > percpu_test/cgroup.subtree_control
> > > 
> > > cat /proc/meminfo | grep Percpu
> > > 
> > > for i in `seq 1 1000`; do
> > >      mkdir percpu_test/cg_"${i}"
> > >      for j in `seq 1 10`; do
> > > 	mkdir percpu_test/cg_"${i}"_"${j}"
> > >      done
> > > done
> > > 
> > > cat /proc/meminfo | grep Percpu
> > > 
> > > for i in `seq 1 1000`; do
> > >      for j in `seq 1 10`; do
> > > 	rmdir percpu_test/cg_"${i}"_"${j}"
> > >      done
> > > done
> > > 
> > > sleep 10
> > > 
> > > cat /proc/meminfo | grep Percpu
> > > 
> > > for i in `seq 1 1000`; do
> > >      rmdir percpu_test/cg_"${i}"
> > > done
> > > 
> > > rmdir percpu_test
> > > --
> > > 
> > > It creates 11000 memory cgroups and removes every 10 out of 11.
> > > It prints the initial size of the percpu memory, the size after
> > > creating all cgroups and the size after deleting most of them.
> > > 
> > > Results:
> > >    vanilla:
> > >      ./percpu_test.sh
> > >      Percpu:             7488 kB
> > >      Percpu:           481152 kB
> > >      Percpu:           481152 kB
> > > 
> > >    with this patchset applied:
> > >      ./percpu_test.sh
> > >      Percpu:             7488 kB
> > >      Percpu:           481408 kB
> > >      Percpu:           135552 kB
> > > 
> > > So the total size of the percpu memory was reduced by more than 3.5 times.
> > > 
> > > v3:
> > >    - introduced pcpu_check_chunk_hint()
> > >    - fixed a bug related to the hint check
> > >    - minor cosmetic changes
> > >    - s/pretends/fixes (cc Vlastimil)
> > > 
> > > v2:
> > >    - depopulated chunks are sidelined
> > >    - depopulation happens in the reverse order
> > >    - depopulate list made per-chunk type
> > >    - better results due to better heuristics
> > > 
> > > v1:
> > >    - depopulation heuristics changed and optimized
> > >    - chunks are put into a separate list, depopulation scan this list
> > >    - chunk->isolated is introduced, chunk->depopulate is dropped
> > >    - rearranged patches a bit
> > >    - fixed a panic discovered by krobot
> > >    - made pcpu_nr_empty_pop_pages per chunk type
> > >    - minor fixes
> > > 
> > > rfc:
> > >    https://lwn.net/Articles/850508/ 
> > > 
> > > 
> > > Roman Gushchin (6):
> > >    percpu: fix a comment about the chunks ordering
> > >    percpu: split __pcpu_balance_workfn()
> > >    percpu: make pcpu_nr_empty_pop_pages per chunk type
> > >    percpu: generalize pcpu_balance_populated()
> > >    percpu: factor out pcpu_check_chunk_hint()
> > >    percpu: implement partial chunk depopulation
> > > 
> > >   mm/percpu-internal.h |   4 +-
> > >   mm/percpu-stats.c    |   9 +-
> > >   mm/percpu.c          | 306 +++++++++++++++++++++++++++++++++++--------
> > >   3 files changed, 261 insertions(+), 58 deletions(-)
> > > 
> > 
> 
> Roman, sorry for the delay. I'm looking to apply this today to for-5.14.

Great, thanks!
