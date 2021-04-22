Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABFF3686CC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 20:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbhDVSyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 14:54:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33792 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236659AbhDVSyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 14:54:17 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13MImsl6002803;
        Thu, 22 Apr 2021 11:53:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=mLGHwsJYfGAeJfJbj97o1ZiBtHCPoRLfgqGzJQhKuO8=;
 b=LnP0za/F8YccRVMqGdMJK4+GbwdpNZWS2KQ9wtfHR7wPyDf9Y2B2jDTuO8bpAeS1xvdZ
 cNozvMjqoMZlYDyjwh574YnSDPrvm/sYVp5LLgSwhyzFvWUZ1fPtI1h4Lyi7ZXtbsbDW
 zs18mqI7uF8wmYfY57qWYW1o8r8EaELCpUY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3839vuj33y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Apr 2021 11:53:35 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Apr 2021 11:53:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6PsEF9dfhK11a+OkDqNutLJNI86IYCaxF1PHgq7Iado1So/qQB6MkjxorGMOC7VXlyLELIOAEajls6KBpVbDRaYATzaqHde7kpUYfACEUEK+eEZJOV05dd0wWNfwW3InSnktB8+o44i4dKA21WyBLqgra1/bn5o88TXYakxvN9FBlIYd1ejhRNBZPHjfC/nDOYme/HYmQyaxK/oilIeB2d5GAhd8i9jl5V+YEvb5a4b6EMNeX6w8W7VQd0gMKfJuEPtcQW1Qx0MWrGZnyG6O1aXBW/UuuqQE2ICw1XbnIk5aLiRbOMTaUHcl9uc4Xu0j1Cut6QaJqfn6xfw9ZyMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLGHwsJYfGAeJfJbj97o1ZiBtHCPoRLfgqGzJQhKuO8=;
 b=iXDgd/MECOC/c6NSErglvBGp+v8scZnKNDOVGAP40Nd4ZsiOF2ea0pDcX6ahUpskMmUEFKnXw07q9Ks27eTBKwwxBZ9mz9lSWNtVNSB1ZhC0vzp3ozz+/KNPEvcMwZ4TPgZUKdyPIrqqPcItbvCl/OaSteUO89q3IW+1RiTkGuhMzgNAZGjqxoKir12KRQ5Fi4LjrryQB8Z4CpIrejHw3Be7D7vX764SLit3sMAvVGNmqV4Z8ldk8UsLwt190lZMeEt7dGue5m37UzLqmtojm7tAMnb9UOcIhGM3m1xH+MOhoRSe6MP4XLMuWeucx1jVNB4hijm99PVAhT2xSvLL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2342.namprd15.prod.outlook.com (2603:10b6:a02:88::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 22 Apr
 2021 18:53:32 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 18:53:32 +0000
Date:   Thu, 22 Apr 2021 11:53:27 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix root_mem_cgroup
 charging
Message-ID: <YIHGJyhUT0o2vtFZ@carbon.dhcp.thefacebook.com>
References: <20210421062644.68331-1-songmuchun@bytedance.com>
 <YH/Vf8SDRy7VR7ur@dhcp22.suse.cz>
 <CAMZfGtVpz1FvzmhWFzXAJE3wWBMJwdwU+JqQ6a8KeOhV3FGJ4Q@mail.gmail.com>
 <YIAimEdqpen3/38Z@dhcp22.suse.cz>
 <CAMZfGtUOXyK3RDZ+P0GaO4p-P0XatFB8ZbmXEFvfet1HSrdFog@mail.gmail.com>
 <YIDKDQxOq8IK82Rt@carbon.dhcp.thefacebook.com>
 <CAMZfGtWHSVrJA3ERzZmV5k_1VNe+dic44ophaoF15jC1c_-BmA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMZfGtWHSVrJA3ERzZmV5k_1VNe+dic44ophaoF15jC1c_-BmA@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:ac40]
X-ClientProxiedBy: MWHPR01CA0040.prod.exchangelabs.com (2603:10b6:300:101::26)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ac40) by MWHPR01CA0040.prod.exchangelabs.com (2603:10b6:300:101::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 18:53:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39e82bfb-e1cd-4bb6-bfd0-08d905bfed09
X-MS-TrafficTypeDiagnostic: BYAPR15MB2342:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2342BDE1BB16476D5B854CADBE469@BYAPR15MB2342.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: or70WnA/OFrbh42WnrGb9qSVWJV2zK9rDuqRoiRsQoQk69cdteWjwblEzgPu+E+fZ63vfSD7aSQ7BI7j3dhr+nvED9TyehjM8r5M/7XyPEpz9UHuyGfKh2mAZ2Gos52JqoUkiQ7cYJDshRFqsaa81FcpqPZHpTE3cJo3kUYjUBk7/dMvuGPWDpE25KQgAHRFyF8K7X2rTzKVKmh3PV+1nY3pDUvY8Rh0ruP4AghAbpw/i/ajTpr7z/vl0WSoIhKhYar8p9ugkMy0a9EdrpegyqOp9ns4joWb5U3rhT1/sZbQ87SHkWEmijmpwMDpOVi0JUSK34es3Rk2+aJH/YhpCjdTVO1f4eOYMUkdhLOsm2txIWZ01zn6ut5sy50RKRKd3JRq8f0kspd5sr5uA0QvCglz3OKGRxX8XNUakdLFArWOUSwWRi9nnM0733unC+7SRUVD4qMeGI67uBhj1VFq1QGioMFH+O3d33fAqQ8kG8eemAaX/RnlmmOkLJKmHzMGbOUr9gTUCOChfxVng8bZhk4EBzSA3LH9BNQcs6Y+rx6iIGm7NccznaGMsYOcvkPaHcZu/MJ0GIcwv7+N9QRZWxlUS7gFxwIIFm++oP/xy5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(396003)(39860400002)(2906002)(478600001)(52116002)(186003)(4326008)(66556008)(8936002)(16526019)(66476007)(8676002)(6916009)(83380400001)(66946007)(54906003)(7696005)(6506007)(9686003)(316002)(6666004)(86362001)(55016002)(5660300002)(53546011)(7416002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zL2EAL+m8SY8ZBGGZSgmb4ClNHl0Hrq0pi1y5j91hi6mgDHGH6VZyPyCo97K?=
 =?us-ascii?Q?mE+ShMGT0UeDjh/M8Lv4lZE6rGWwq9RrYwBmlBzWuEjPQt+/G4670ie3RVJv?=
 =?us-ascii?Q?hWY7hvnb8Mw1xntnir5w30PsRvUX2Tex4E/wDoyc/A7rYVzvPfII7dXnB4XU?=
 =?us-ascii?Q?ukpMYC5MKErywoSRmdmAXPpsmTDSVIOJSWtBQoKV9+c3vJig4qOQGL5NPbKf?=
 =?us-ascii?Q?4Exf4dAjPj1aT96iRQc6y5mb57EDbLqFDeQMi/21klvXC9u0xvJ63qbGtbCZ?=
 =?us-ascii?Q?bzfO5HFkbb33PAxRxV8EMNoUQz3qqzyqsorY8UqVEqEW1OALZgYmPPsdzkSq?=
 =?us-ascii?Q?GB+hV9G4YCrlWN3ioThm9as178yx24VhE9cbSbGl2EfgQm9YygJIdXvwZogr?=
 =?us-ascii?Q?foO/pD55JMSj/hWxfmhb0VdxKyVGCfglHYq0b8gOmDQ9sBGaUu4niqj/YbuY?=
 =?us-ascii?Q?FivSTLa6ajCmn1rHzRc8VgKNqckfLOb8wOlm2+ayVCF6ajuJt+DG2ehYi9bl?=
 =?us-ascii?Q?2WrCjsWCw7jpUC/Q/6nF6pBX7TJvYXzRmJaLZJfNuPeF81qnrzIPkAD3S0Jg?=
 =?us-ascii?Q?IJ2t2PivjuNMv8Mqx1pAO0togAc90SNAooXWSjkboMbYFFixC62GLMU7RLn3?=
 =?us-ascii?Q?VDY7geTWYhG/orDCA0ORraNJCe5F6TFVwPBi0g/3OEeQqpOUjK/O3TeLP4oU?=
 =?us-ascii?Q?B9NQSM4REOIja4z9eS5HaIX0ayaaLZqHvfgN1UIN5W4Bnsi9piC2zO9MBSL+?=
 =?us-ascii?Q?o6raL2us3NUd+4BfB6Qz19/zbi4zvIEH5fzF8DNT1s3Phbq69t/I5yc5cC1X?=
 =?us-ascii?Q?IYTGAnB/LB/iAdIkTsei/AD3mi7xNiywPEqnoOWqbYYKOCU2DfJwxyFWrza7?=
 =?us-ascii?Q?8KPldApWLuJEC77z7lWIu20YYPVwZUT0+MG2txrVDnqJzyWu4UW0556fr1wF?=
 =?us-ascii?Q?KHDMnRK+gc9Ck9RsYzfNltj6dx6aR4ZT5R4su4xPeBVxxexazwowz9X23njn?=
 =?us-ascii?Q?byAX+Cbo96gSF58cSQ5InCG8TdXiWn8USrjZNWMaE0TRDGP5zDC59/Vce3zd?=
 =?us-ascii?Q?JGblpB6xuKTjCmLo/IVtrBk7kDxYvJB/5K0SHD5GEoiVu7WxRi6DiK4PH7yk?=
 =?us-ascii?Q?t4k+l40W0W/5AwGE/9LwfbeVTz/NnJDG3P9WEtrgllGIFQ5u0bACMrKkO2YA?=
 =?us-ascii?Q?2H31xI6uxg7pmHROfry+OSIdH9yXYNnsxdhWbvsT+eVzD7p8/xpsnpmjlDIo?=
 =?us-ascii?Q?SSInIsx/uC/7nF/Ew4PotiU3N/C7Hm13iB8ntVxJ2OoJh2XKNZ7koHrv26Ro?=
 =?us-ascii?Q?iOjg3pDFKTDLgKKp2GS1VxP9YgSlpKMgFOpAkSGd9Onmng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e82bfb-e1cd-4bb6-bfd0-08d905bfed09
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 18:53:32.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACqkPot0wSWFDFEZIHUd+N+zfh3BvcQxauMIwo4R3M+7d4ZKyXYCZnJpnf2TrxiR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2342
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: jj1-GIjICnc4WU_pFR6mqm2o2KaqZdV5
X-Proofpoint-GUID: jj1-GIjICnc4WU_pFR6mqm2o2KaqZdV5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_12:2021-04-22,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=728 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104220139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 11:47:05AM +0800, Muchun Song wrote:
> On Thu, Apr 22, 2021 at 8:57 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Wed, Apr 21, 2021 at 09:39:03PM +0800, Muchun Song wrote:
> > > On Wed, Apr 21, 2021 at 9:03 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Wed 21-04-21 17:50:06, Muchun Song wrote:
> > > > > On Wed, Apr 21, 2021 at 3:34 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Wed 21-04-21 14:26:44, Muchun Song wrote:
> > > > > > > The below scenario can cause the page counters of the root_mem_cgroup
> > > > > > > to be out of balance.
> > > > > > >
> > > > > > > CPU0:                                   CPU1:
> > > > > > >
> > > > > > > objcg = get_obj_cgroup_from_current()
> > > > > > > obj_cgroup_charge_pages(objcg)
> > > > > > >                                         memcg_reparent_objcgs()
> > > > > > >                                             // reparent to root_mem_cgroup
> > > > > > >                                             WRITE_ONCE(iter->memcg, parent)
> > > > > > >     // memcg == root_mem_cgroup
> > > > > > >     memcg = get_mem_cgroup_from_objcg(objcg)
> > > > > > >     // do not charge to the root_mem_cgroup
> > > > > > >     try_charge(memcg)
> > > > > > >
> > > > > > > obj_cgroup_uncharge_pages(objcg)
> > > > > > >     memcg = get_mem_cgroup_from_objcg(objcg)
> > > > > > >     // uncharge from the root_mem_cgroup
> > > > > > >     page_counter_uncharge(&memcg->memory)
> > > > > > >
> > > > > > > This can cause the page counter to be less than the actual value,
> > > > > > > Although we do not display the value (mem_cgroup_usage) so there
> > > > > > > shouldn't be any actual problem, but there is a WARN_ON_ONCE in
> > > > > > > the page_counter_cancel(). Who knows if it will trigger? So it
> > > > > > > is better to fix it.
> > > > > >
> > > > > > The changelog doesn't explain the fix and why you have chosen to charge
> > > > > > kmem objects to root memcg and left all other try_charge users intact.
> > > > >
> > > > > The object cgroup is special (because the page can reparent). Only the
> > > > > user of objcg APIs should be fixed.
> > > > >
> > > > > > The reason is likely that those are not reparented now but that just
> > > > > > adds an inconsistency.
> > > > > >
> > > > > > Is there any reason you haven't simply matched obj_cgroup_uncharge_pages
> > > > > > to check for the root memcg and bail out early?
> > > > >
> > > > > Because obj_cgroup_uncharge_pages() uncharges pages from the
> > > > > root memcg unconditionally. Why? Because some pages can be
> > > > > reparented to root memcg, in order to ensure the correctness of
> > > > > page counter of root memcg. We have to uncharge pages from
> > > > > root memcg. So we do not check whether the page belongs to
> > > > > the root memcg when it uncharges.
> > > >
> > > > I am not sure I follow. Let me ask differently. Wouldn't you
> > > > achieve the same if you simply didn't uncharge root memcg in
> > > > obj_cgroup_charge_pages?
> > >
> > > I'm afraid not. Some pages should uncharge root memcg, some
> > > pages should not uncharge root memcg. But all those pages belong
> > > to the root memcg. We cannot distinguish between the two.
> > >
> > > I believe Roman is very familiar with this mechanism (objcg APIs).
> > >
> > > Hi Roman,
> > >
> > > Any thoughts on this?
> >
> > First, unfortunately we do export the root's counter on cgroup v1:
> > /sys/fs/cgroup/memory/memory.kmem.usage_in_bytes
> > But we don't ignore these counters for the root mem cgroup, so there
> > are no bugs here. (Otherwise, please, reproduce it). So it's all about
> > the potential warning in page_counter_cancel().
> 
> Right.
> 
> >
> > The patch looks technically correct to me. Not sure about __try_charge()
> > naming, we never use "__" prefix to do something with the root_mem_cgroup.
> >
> > The commit message should be more clear and mention the following:
> > get_obj_cgroup_from_current() never returns a root_mem_cgroup's objcg,
> > so we never explicitly charge the root_mem_cgroup. And it's not
> > going to change.
> > It's all about a race when we got an obj_cgroup pointing at some non-root
> > memcg, but before we were able to charge it, the cgroup was gone, objcg was
> > reparented to the root and so we're skipping the charging. Then we store the
> > objcg pointer and later use to uncharge the root_mem_cgroup.
> 
> Very clear. Thanks.
> 
> >
> > But honestly I'm not sure the problem is worth the time spent on the fix
> > and the discussion. It's a small race and it's generally hard to trigger
> > a kernel allocation racing with a cgroup deletion and then you need *a lot*
> > of such races and then maybe there will be a single warning printed without
> > *any* other consequences.
> 
> I agree the race is very small. Since the fix is easy, but a little confusing
> to someone. I want to hear other people's suggestions on whether to fix it.

I'm not opposing the idea to fix this issue. But, __please__, make sure you
include all necessary information into the commit log.

Thanks!
