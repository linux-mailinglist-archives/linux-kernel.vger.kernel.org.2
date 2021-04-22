Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904753686A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 20:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbhDVSiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 14:38:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14974 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236668AbhDVSiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 14:38:23 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MIS5ob027525;
        Thu, 22 Apr 2021 11:37:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Oe4iEzfNzZVBkxHHGJCa0wN0rXes2ei4Yli7RwcCGSA=;
 b=fpbSR0npbTbJHiRSmnheyYIfZgsEFGW/YYfZ/S4uwzIcfa5YzGuau2Ksc7KPsLRmm0q5
 /raOIOUm+/6DSn+5eMxx+QQARb7W75I03UswLuL3KIehs6jTC+vwxl/pq3UY5NN5jA90
 6iiE4FAudSKinWsa+h3asEbx/0IEp9B9NNY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 382kqp1nbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Apr 2021 11:37:37 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Apr 2021 11:37:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXrO+479iv7xwIp5o9CO9fjgHR/6xpWcGhpPbuG6ZapC04WKFJjK74Yj7q6rFkKgZ/JpPcH7l8MnxhqVRpLytL0xke/iXz4pBqvpZAMcK5bTwQKuycr+9rr3/TN1ENWoFu9M5MSLvvHp6mkQH3MgYGAKFUO+jxdEOu1IfCGsUswdF33Xb4Hgv5ZH+QIjUN9A1Fh6cKFbGcVfE0cWXqmUURIkyEnxh5mKTHq+AHjM+X87Kubg92uiJ8DPR524fyHrsdLMmwzAfcXTfnJZLMu7bCGgagCLiN4bMPcFuE7yyIawcYcYSHUCaDSmjYziPVZEX+gacRKC2aOq6LyZTbfX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe4iEzfNzZVBkxHHGJCa0wN0rXes2ei4Yli7RwcCGSA=;
 b=KbfdK8t22/loWSXZFpakHCzSHr+0wzduC9TDnLfGM17ZrHj2pEfbtsDHJYmpJX19qClP5aCl+5dxoo2M/7tdWb6Fk1j4iloRc2HlGE9DRVgspqwdUZmfbsczJjzJF3A6cMg0VKDrPYY6royN4TpQgmCOmVeHhBVitJ0MT2GgW8wksuXhc2Qlb12fatuScNyaiR/hNxS+6s8Q49QIfc0XXYpE3v+IMdzbEhKUa7Tg0+QPf+EB+4ZFovTHP5PzOqMSRsMtiZzhWAzPs9dZtGG/zzFh6HrHV6pgpu9vCflHf+rFkc6lS8lzE/7PIjsUKHg78ULtnnvAIjIp06ITo+/Vxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2936.namprd15.prod.outlook.com (2603:10b6:a03:f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Thu, 22 Apr
 2021 18:37:33 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 18:37:33 +0000
Date:   Thu, 22 Apr 2021 11:37:28 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
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
Message-ID: <YIHCaK/gT/4k19ko@carbon.dhcp.thefacebook.com>
References: <20210421062644.68331-1-songmuchun@bytedance.com>
 <YH/Vf8SDRy7VR7ur@dhcp22.suse.cz>
 <CAMZfGtVpz1FvzmhWFzXAJE3wWBMJwdwU+JqQ6a8KeOhV3FGJ4Q@mail.gmail.com>
 <YIAimEdqpen3/38Z@dhcp22.suse.cz>
 <CAMZfGtUOXyK3RDZ+P0GaO4p-P0XatFB8ZbmXEFvfet1HSrdFog@mail.gmail.com>
 <YIDKDQxOq8IK82Rt@carbon.dhcp.thefacebook.com>
 <YIE3e3fVboWfIq7r@dhcp22.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YIE3e3fVboWfIq7r@dhcp22.suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:4915]
X-ClientProxiedBy: MW4PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:303:6b::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:4915) by MW4PR04CA0069.namprd04.prod.outlook.com (2603:10b6:303:6b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 18:37:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da50ebf6-431f-4660-6d51-08d905bdb17b
X-MS-TrafficTypeDiagnostic: BYAPR15MB2936:
X-Microsoft-Antispam-PRVS: <BYAPR15MB293664205F40BCB4E2141D39BE469@BYAPR15MB2936.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 93IqV5gC3fUkvKsU+W+ON0aZHNID9fLbNVw69NKOVPBrRkiVTnmbHnh1nnuM1uM0JxZeb4KHQ3zPsquRfk1vk5Gyos81HS0CvMSyW/REtojp3xt3fYtJLu9lEN+4BuPmFgJpnXHV2fCPiyGDjcXk53zHlkqInUPJP8v+OXJ6f8jc7eatTOv7oNpQ3HEFXGS/p8smc1z7ESBuCuyEQnXddhH7up3b9HpE8+B/pDvZatG+JBf9SCyZ/dxB/Qa0CgH7IsmXp+3+fz1DapqrdU6WOv+PgrFXOiekIhy1ozfaoFwfGnaZzoT7AEWauCzNoM0wE0lTa/p7R5BlmtRs9Xg0UT2WICAoU/Yj5vIJq1h7AklOBG5KailfH3oFuH1LIlYugz2NVLTkr1T+/zF2gO8c7V0LIWKO8awjsTLdGaM6d90K6NocTbgDxYj0MNtwS9GeoeAIeJ8mYlp70UftMzbdLVtVO1aiTVN5kGFMFp1E6t0xJUr0BRa28CAZ0YQiCR9Dggx4F3hw6lJE+f0J0yPc9hWwd2T6ZnLmwF5dS+JBy0Gr1sI/Mzv7dCHG6Qo5EwUZThIA9+ufDrvkSP2d+lcKJwGexIuemWrFoi/Kzf4ojoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(136003)(346002)(366004)(5660300002)(8676002)(86362001)(6916009)(55016002)(9686003)(53546011)(83380400001)(66946007)(38100700002)(6506007)(66556008)(54906003)(7416002)(16526019)(6666004)(66476007)(4326008)(7696005)(52116002)(2906002)(186003)(316002)(478600001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LV5njHuDILPHSfkik+A3NCsB4Nl3EjuCTptKEkSDAjRkm8EMXUn6xFl4E1ix?=
 =?us-ascii?Q?rW/pVxVMwnuZKT4T2GWkqk/NJjF8xf7qSzdjWQeuYSNJ23DHiekPw/nhP7F4?=
 =?us-ascii?Q?ElbD7PiiGw1gk5uBp6OUzueo2CvoW83QjGhLm2S+n7yB1nQpBJn/8ZshgleJ?=
 =?us-ascii?Q?Ia2XtizAWAgEapYJpALxYVjurTk2uzZFGbhnwW6D3J33XYOdoth0r2X5Rzv7?=
 =?us-ascii?Q?Z6uq7K8EVfHfejUxJhPmJvgOb64euwcQXme6QIkE17DLYHZTNhD9GkUMIKtl?=
 =?us-ascii?Q?5ka5CZuDPDs/aILmuJLqFAMbo0szcl0rI0FfxfBYN2jnLyNOLW4azlNdtlTj?=
 =?us-ascii?Q?3S+n9/+Ur8S4jq/BUY+6y+hKQNA89KSFgaGNPK8+wtTMMIgkYv+Oa4Q29leV?=
 =?us-ascii?Q?fw+fwq8BtXTJBPw00+YqOGlGnPxLFFCyMGgE1u9sMo3WtQ9WlVtvDhBqZvg3?=
 =?us-ascii?Q?3Inw3dZSc0lyaiMy3KZq0un5DBsF1mY8JYBlDl+kny5tH0vaA+Dfv3lnzmQV?=
 =?us-ascii?Q?9aEy8BNFXMEYc51xUbiVvS3Dv3yS2rJhJ4m8KVpXo4bcGzWdkeU0VCM6i/qK?=
 =?us-ascii?Q?zOELoTpNMeCodklatPiXFInAJLhMaSbZFny6rnrQ4vs1kxaYPyh3AR95+CBq?=
 =?us-ascii?Q?0I2PlLu7u2yTKHBpMetrTSf+YH+enNp4XNv7cv1qthxdmB+ZRuTGxKVayNZ7?=
 =?us-ascii?Q?xNh19/xpR6g/xyody+Cmv0gGY4oqBgKheLKn9yHfL0kaYUR8QlcUB4FqDryQ?=
 =?us-ascii?Q?QkOZIBD6RM3Wp6n+ZJP45TtCFUceXk2chLH6Xt/v28cqRK2SUYH6xXS/P+1X?=
 =?us-ascii?Q?sPNfLvVKlUT1+ygp8xaAsXuOquySjGa4ubm3eXFDaYLal838U5vVfln5PL5t?=
 =?us-ascii?Q?ZnpNXxqEke3wY/NxdbdnoDPTUaMFeczcmgCzCjkXS7w4jO5xodJOLbOtR6DM?=
 =?us-ascii?Q?3rWESLxCXplRzhytQdP3zAoeRoFO0xtZuBFeXYZ0oS1hHPoJoaqaCLmrkJ6H?=
 =?us-ascii?Q?PZR80tF+ZD3sz7qQy58JMZpKhq1i0u5lXsnDRuCIXfV2g+AIj/A7fAON08e+?=
 =?us-ascii?Q?16nWfLCu42X/8VMMHL+viAjPaihvXKsWGsfcN8M16NiF18QzCQTkym2PczEA?=
 =?us-ascii?Q?ZzUovtRaHWxv2xU1sL0DMPXBG/7LygHo0rbBi38B8piurCVNl0TodOMTBPt+?=
 =?us-ascii?Q?D4/bFzw2z8+RSwwCl831wxte/9ocvuyTctWzjgN4ELko2R1+9R59aJomCfeO?=
 =?us-ascii?Q?wapaMEYGXyNBoDnkZLInw3f0HqrOSmDseEuUxRFVaaNZ6+ACuizOKUEOToI3?=
 =?us-ascii?Q?4m+Xe3Gf/OavZLRSXzN3muDdCfms7Q5UpJ280bI3CYUv4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da50ebf6-431f-4660-6d51-08d905bdb17b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 18:37:33.5808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xr8R/Bv0z0FFR/gsJZKFAcmMBnyVviCmmitBZ+IDYIZy+nBaX/W9FYaAGsNNnoHu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2936
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: pcpe9g_ZfN4A_4wi3ooBb2hngOk55o_W
X-Proofpoint-ORIG-GUID: pcpe9g_ZfN4A_4wi3ooBb2hngOk55o_W
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_12:2021-04-22,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 10:44:43AM +0200, Michal Hocko wrote:
> On Wed 21-04-21 17:57:49, Roman Gushchin wrote:
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
> > 
> > But honestly I'm not sure the problem is worth the time spent on the fix
> > and the discussion. It's a small race and it's generally hard to trigger
> > a kernel allocation racing with a cgroup deletion and then you need *a lot*
> > of such races and then maybe there will be a single warning printed without
> > *any* other consequences.
> 
> Thanks for the clarification Roman! As I've said I am not a obj-cgroup
> accounting insider but it would make some sense to opt out from
> accounting in the uncharge path just from clarity point of view to match
> the charging path (rather than what the patch is proposing and special
> case the charging path and make it inconsistent with non obj-cgroup
> tracking. What do you think?

I don't see how it's possible to opt out just for these bytes, but what we can
do is to stop propagating charges to the root mem cgroup in general. Not only
objcg-related, but all. That would even likely have some performance benefit.

The only downside is that we'll still need to propagate charges for cgroup v1
dedicated kmem and tcpmem counters, because those are exported to the
userspace (for the root cgroup). So it will make the page counters code more
complicated.
