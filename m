Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC9C362672
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbhDPROA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:14:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52372 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235011AbhDPRN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:13:59 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13GHAbLH032119;
        Fri, 16 Apr 2021 10:13:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=VVkzhOfdTKnLjT0RPbRflfmYWLd2vK7B8hR/Ux9QOfQ=;
 b=P4HET3jETuP9+L2NlyNPmfy3LPT4qBJBv8iacj9ZuaK59WW5aBVHAkOygBSdM+HU1zwH
 1xNoQZ6Lf7gVtDvWphq3dWq8O1foMd0QgEeucXgWRdAxwXSOhG4uU6WjUkaWBPlCCtM+
 m3N8vnxyQ8BZasHdLu0ViXae0CuELI53WV4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 37yb39heus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Apr 2021 10:13:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 10:13:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUWx0Lmv/VrpSGTEZzhHBXgDGB+jy6I0xmsw+Qu9G88PIu5HQKgDuRMIVIlf23kkVWWCTgjnu8XdwRk1YEdnAfNWTErkDrWWzqiKMJM6AEh1qw65BM7142jEhEj+4i4CEeJ+zODCiPYPot8jRT4hOY8yzygKXTXKir8tzm7t6pOCFrR+tEaEW7/z1BucqQnIB3V+R1vSdt5JnpPNUvfxvi6GbpOFBD/6BiSqP6evzzp+8OMAV0308p49/QUMtfcj4tlfqSSQ7p6T2DSXI0F6yVc0Lvlovf1YLhcfoLfq8I+wXbmapQYX4VdkpTeLQQDcdsXKXOY619KHFO1WzoMxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL8a6NS7wF/S0PlNgSfLf5/we7wKfzrrpiRooiI19kY=;
 b=S9RmX5uBTnzo3VUSPs+RFHUa0pXnBcWa/BrFTStSzGsWsS5P7OaIxJOEG9zQfBgf+84kRumrbd1HEnznvDTBL/hFvAzXagQI1AsRYFhdRfTrNYipeGQVLkaucjxj3VIuvaeOyAQn113K3jz1SAExT1WG4CLaubvNVwMD78ufG/V89vrANOCBA6VWNKGUAmcRGraXDOOlIJKTEokRv4nmno9zVp020/byFSY3WfPsu/fxi9pZkSaQaX2+jHV8mxsH93Lwnb02Sj8LOYwzZxHYotI2KAi9PtoTwo/rRSEITDpklVdFi6oAxzWHKvnf4q/fLgFm8nDouwgguGwps6ruIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4373.namprd15.prod.outlook.com (2603:10b6:a03:35a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 17:13:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.025; Fri, 16 Apr 2021
 17:13:24 +0000
Date:   Fri, 16 Apr 2021 10:13:20 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Pratik Sampat <psampat@linux.ibm.com>
CC:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <pratik.r.sampat@gmail.com>
Subject: Re: [PATCH v3 0/6] percpu: partial chunk depopulation
Message-ID: <YHnFsL2G2bpOH8ML@carbon.dhcp.thefacebook.com>
References: <20210408035736.883861-1-guro@fb.com>
 <25c78660-9f4c-34b3-3a05-68c313661a46@linux.ibm.com>
 <YHmcorqNE5NpAN3G@google.com>
 <7a001bf6-5708-fb04-4970-367d9845ccb9@linux.ibm.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a001bf6-5708-fb04-4970-367d9845ccb9@linux.ibm.com>
X-Originating-IP: [2620:10d:c090:400::5:3149]
X-ClientProxiedBy: CO2PR04CA0166.namprd04.prod.outlook.com
 (2603:10b6:104:4::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3149) by CO2PR04CA0166.namprd04.prod.outlook.com (2603:10b6:104:4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 17:13:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 810c7e5a-0d35-4eac-0921-08d900faf1b2
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4373:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4373472E8945E5F195FB6BAABE4C9@SJ0PR15MB4373.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fF3X1SmivYXDii0lNY7bnQbht5+FhKliEfBgGMyB6u56tXxbuHhN6EIMVTGmWnzoO8RCA4JuiHc9a3FVL35ZivLGqz4LXUodvP4NGkDZBdLWJSd+J5ryIbsA6SvzOM3bv8zAtWInAitsv8gmbo3CW/xQDmTjLZdnkdHi1g+O0riiKXsG5ddDkqXlF6RrOYBw29Wc4uh55aTkl5ZQsYsMis98Jn8DYpLflIbQx8TuuRd/JlRqnCYwR0LIpoAx92P9snhSigCsSuVsfOHhSkTq9M8OttOG0htu2c52wI7cI+W/ij9dA+65kAh9FgNdR19H+yBkSO1Xx5NaFUDKs5kcO4UWQyPF51Xn1xm2HZUaO/cczvz42SfNECcpBoPwdBCnToN3Jvl6hI6ZCGeYGL+clLoHCXYGwloGWaQO5fG40nRmkuoW60TyalRCh+BBT61UCbjIu2nqVgDD9rOQQUICuoWvzEeu9RUEGvphtl+Vs5EEICbxhlkBtcvhFkgAgUwR14cgtmEdnGoOJXISgTjuMy2A1BCB+CYxZWAKPkY0kjiaJK7/ioppnCzHG7TPI3gWeLXZjDe5mnDD+yHmgv7V5mFav8Lv12f7ODIqkFZacc8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(39860400002)(396003)(376002)(66476007)(66946007)(4326008)(55016002)(54906003)(38100700002)(2906002)(9686003)(66556008)(6506007)(316002)(86362001)(8936002)(53546011)(52116002)(7696005)(6916009)(16526019)(186003)(83380400001)(5660300002)(478600001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?Hqh6aeqg50QxZpYJUF+bLqjOb1cokjDM7IKj5MX4F0ze4zuzQI/7TJrtH+?=
 =?iso-8859-1?Q?hzeT/caUuyYHh0Jxc9mw5zIDVybQDUpDqq8e3A9C6B+Z7zXQdlLWQDl5YC?=
 =?iso-8859-1?Q?AI0GhTspSjRUK+P7uzey4KvBgFs+3jAnf70MI7aq8O66DYQ1RVMa51lDqU?=
 =?iso-8859-1?Q?SaHq+fkNobRTF92MuS66Lc4blVnf0QsvDyQabCu36nOWzpeg+J5LjXvLYF?=
 =?iso-8859-1?Q?eKSOGtrSDz3lqLc9k808gF9DKSeBpbH5m6UvW7QAPb034XZBJQENPkGwLk?=
 =?iso-8859-1?Q?sW8YL7+qw6wTys4ArR0lBcDbYHVaWbdGLp7+PitGxD21iDLXzFp2dDV51Q?=
 =?iso-8859-1?Q?AmRVZRRJimpbG46/vRjeqRTvQwHhqKckMcrcVUEZ1C0yXgYHtd7Z5e4gLW?=
 =?iso-8859-1?Q?7rnqDLCj2wB/Y1ReXu+xBiQJSyq5tKhYIpFFUTVkt26VFMmcpyae8iwT+u?=
 =?iso-8859-1?Q?VHsgeo+kSLFbCjxXrh90A3YbIY0yxpFO0SdXiFCvgmoB6fSSvmDwJpjPJg?=
 =?iso-8859-1?Q?0xvdX6azlSe9GRMdL6A5rIXok9hkOq3o2Vg6+D67XMylgOgTJIueh3rLaM?=
 =?iso-8859-1?Q?x2DjHEsvFBr7QQ3ZLG3852/nyDgD8Ii13uvUnYHJRbXJhAloJ+YR4/pHzH?=
 =?iso-8859-1?Q?LNHddySC33Elxpz2Ax7Q3GQHMKag9jSPai651IqB60OgMH0O0QOujK3ZRY?=
 =?iso-8859-1?Q?8IJ7c6aJsFk3IsBNfC5SGpibCahtoWWzM22kPoIpCAtllr7Xt7Vfis0Ipd?=
 =?iso-8859-1?Q?oOLgWo6+ymC1Wl/o4m8W1aSjNLWsdXrOAtO8W/2+nB/b6B8ZMK+m35SdOP?=
 =?iso-8859-1?Q?Ij8/S8PtdDY+tptwiI6ivZxZb0x87kiEhrEfvwshdHBuS8vzJfXyZp83UN?=
 =?iso-8859-1?Q?uIb0x0d9C8tdEFIWlKQCJg+88fd2IvV2GqgBIPPz4FYLaiDcTDt3DrHmN7?=
 =?iso-8859-1?Q?b1S+xkOUYfrHkIIBEaOdmRNVSyCq5TP9bjwQx3cVEN9mZbj9Z21ra0WZUq?=
 =?iso-8859-1?Q?zENbyWBluMEedVPfcJvhPylRhpxsaPsw8L8ZDPZP778VwyRlWqgrerQafh?=
 =?iso-8859-1?Q?P32ztkeUuKp/z2oOLUpt0qA+hT4GltWWF3NMO69vk/O0BTDrQpIXh0DtFe?=
 =?iso-8859-1?Q?AnIMBUwI/LHkp/penbIdzZrbP8XYr3xlxvw4m7A73mKGArjMynd5O4XCAX?=
 =?iso-8859-1?Q?3OgMcceDjlpOObyYLLc2mP38DSLRWi688TOBo9RjSkou8F0DjLq+JtioEC?=
 =?iso-8859-1?Q?9RbjkM1Ii2Dzq6H6iAMhTNwtuKe0eCvu9In94etsc3UifA4Yk83Rvw8BOk?=
 =?iso-8859-1?Q?nkegwm5OgJau7iUcM+QwJo0FC9mBaQ2msGLnjfFL4T33EFPz4X0KU/gzX5?=
 =?iso-8859-1?Q?wlXl3INIAzRUJxDwx1UbGwmejz6jzHHQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 810c7e5a-0d35-4eac-0921-08d900faf1b2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 17:13:24.7795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGuR+UbP0JXGdJugVstcmN24m0tkjD8e0NxVDHAU6haSeqKPIdXcCdwBmI5om3dJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4373
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: fpvfa4kzp7i6IkgaP-9sl4e7oxdxzKLr
X-Proofpoint-GUID: fpvfa4kzp7i6IkgaP-9sl4e7oxdxzKLr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 08:58:33PM +0530, Pratik Sampat wrote:
> Hello Dennis,
> 
> I apologize for the clutter of logs before, I'm pasting the logs of before and
> after the percpu test in the case of the patchset being applied on 5.12-rc6 and
> the vanilla kernel 5.12-rc6.
> 
> On 16/04/21 7:48 pm, Dennis Zhou wrote:
> > Hello,
> > 
> > On Fri, Apr 16, 2021 at 06:26:15PM +0530, Pratik Sampat wrote:
> > > Hello Roman,
> > > 
> > > I've tried the v3 patch series on a POWER9 and an x86 KVM setup.
> > > 
> > > My results of the percpu_test are as follows:
> > > Intel KVM 4CPU:4G
> > > Vanilla 5.12-rc6
> > > # ./percpu_test.sh
> > > Percpu:             1952 kB
> > > Percpu:           219648 kB
> > > Percpu:           219648 kB
> > > 
> > > 5.12-rc6 + with patchset applied
> > > # ./percpu_test.sh
> > > Percpu:             2080 kB
> > > Percpu:           219712 kB
> > > Percpu:            72672 kB
> > > 
> > > I'm able to see improvement comparable to that of what you're see too.
> > > 
> > > However, on POWERPC I'm unable to reproduce these improvements with the patchset in the same configuration
> > > 
> > > POWER9 KVM 4CPU:4G
> > > Vanilla 5.12-rc6
> > > # ./percpu_test.sh
> > > Percpu:             5888 kB
> > > Percpu:           118272 kB
> > > Percpu:           118272 kB
> > > 
> > > 5.12-rc6 + with patchset applied
> > > # ./percpu_test.sh
> > > Percpu:             6144 kB
> > > Percpu:           119040 kB
> > > Percpu:           119040 kB
> > > 
> > > I'm wondering if there's any architectural specific code that needs plumbing
> > > here?
> > > 
> > There shouldn't be. Can you send me the percpu_stats debug output before
> > and after?
> 
> I'll paste the whole debug stats before and after here.
> 5.12-rc6 + patchset
> -----BEFORE-----
> Percpu Memory Statistics
> Allocation Info:


Hm, this looks highly suspicious. Here is your stats in a more compact form:

Vanilla

nr_alloc            :         9038         nr_alloc            :        97046
nr_dealloc          :         6992	   nr_dealloc          :        94237
nr_cur_alloc        :         2046	   nr_cur_alloc        :         2809
nr_max_alloc        :         2178	   nr_max_alloc        :        90054
nr_chunks           :            3	   nr_chunks           :           11
nr_max_chunks       :            3	   nr_max_chunks       :           47
min_alloc_size      :            4	   min_alloc_size      :            4
max_alloc_size      :         1072	   max_alloc_size      :         1072
empty_pop_pages     :            5	   empty_pop_pages     :           29


Patched

nr_alloc            :         9040         nr_alloc            :        97048
nr_dealloc          :         6994	   nr_dealloc          :        95002
nr_cur_alloc        :         2046	   nr_cur_alloc        :         2046
nr_max_alloc        :         2208	   nr_max_alloc        :        90054
nr_chunks           :            3	   nr_chunks           :           48
nr_max_chunks       :            3	   nr_max_chunks       :           48
min_alloc_size      :            4	   min_alloc_size      :            4
max_alloc_size      :         1072	   max_alloc_size      :         1072
empty_pop_pages     :           12	   empty_pop_pages     :           61


So it looks like the number of chunks got bigger, as well as the number of
empty_pop_pages? This contradicts to what you wrote, so can you, please, make
sure that the data is correct and we're not messing two cases?

So it looks like for some reason sidelined (depopulated) chunks are not getting
freed completely. But I struggle to explain why the initial empty_pop_pages is
bigger with the same amount of chunks.

So, can you, please, apply the following patch and provide an updated statistics?

--

From d0d2bfdb891afec6bd63790b3492b852db490640 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Fri, 16 Apr 2021 09:54:38 -0700
Subject: [PATCH] percpu: include sidelined and depopulating chunks into debug
 output

Information about sidelined chunks and chunks in the depopulate queue
could be extremely valuable for debugging different problems.

Dump information about these chunks on pair with regular chunks
in percpu slots via percpu stats interface.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/percpu-internal.h |  2 ++
 mm/percpu-stats.c    | 10 ++++++++++
 mm/percpu.c          |  4 ++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 8e432663c41e..c11f115ced5c 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -90,6 +90,8 @@ extern spinlock_t pcpu_lock;
 extern struct list_head *pcpu_chunk_lists;
 extern int pcpu_nr_slots;
 extern int pcpu_nr_empty_pop_pages[];
+extern struct list_head pcpu_depopulate_list[];
+extern struct list_head pcpu_sideline_list[];
 
 extern struct pcpu_chunk *pcpu_first_chunk;
 extern struct pcpu_chunk *pcpu_reserved_chunk;
diff --git a/mm/percpu-stats.c b/mm/percpu-stats.c
index f6026dbcdf6b..af09ed1ea5f8 100644
--- a/mm/percpu-stats.c
+++ b/mm/percpu-stats.c
@@ -228,6 +228,16 @@ static int percpu_stats_show(struct seq_file *m, void *v)
 				}
 			}
 		}
+
+		list_for_each_entry(chunk, &pcpu_sideline_list[type], list) {
+			seq_puts(m, "Chunk (sidelined):\n");
+			chunk_map_stats(m, chunk, buffer);
+		}
+
+		list_for_each_entry(chunk, &pcpu_depopulate_list[type], list) {
+			seq_puts(m, "Chunk (to depopulate):\n");
+			chunk_map_stats(m, chunk, buffer);
+		}
 	}
 
 	spin_unlock_irq(&pcpu_lock);
diff --git a/mm/percpu.c b/mm/percpu.c
index 5bb294e394b3..ded3a7541cb2 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -185,13 +185,13 @@ int pcpu_nr_empty_pop_pages[PCPU_NR_CHUNK_TYPES];
  * List of chunks with a lot of free pages.  Used to depopulate them
  * asynchronously.
  */
-static struct list_head pcpu_depopulate_list[PCPU_NR_CHUNK_TYPES];
+struct list_head pcpu_depopulate_list[PCPU_NR_CHUNK_TYPES];
 
 /*
  * List of previously depopulated chunks.  They are not usually used for new
  * allocations, but can be returned back to service if a need arises.
  */
-static struct list_head pcpu_sideline_list[PCPU_NR_CHUNK_TYPES];
+struct list_head pcpu_sideline_list[PCPU_NR_CHUNK_TYPES];
 
 
 /*
-- 
2.30.2

