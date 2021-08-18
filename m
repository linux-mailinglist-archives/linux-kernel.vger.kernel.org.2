Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395ED3EF9AB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 06:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbhHREsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 00:48:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39634 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229449AbhHREsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 00:48:01 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17I4kILe012587;
        Tue, 17 Aug 2021 21:47:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=/fGc9IOpJmj2V9FLkQMGS5/p8AgDBsRAu7Z6m2xNVxc=;
 b=VSt3yj/74kOxEDk66/vMnUzuVrNsY5UlCMnvTjAxHUM2MFpEvXrtbK+/9r6edA8QjY+L
 ToNZ+fIwgeTOjeY/drIVtAlp3OQKYIW+0bg30QMTg8u88TQCK+eGfdU6RoPgNNzjjFqN
 GvUseKDZV1LszW6LhkAXIeHgZcN/yC9hf+c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3agnh11pu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Aug 2021 21:47:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 21:47:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXDzAtbKZQor1WwBYg2MiYGLWot1IVsGVKJ5+xh04Mzrgj3fK3pzR3pIb0Gd9Y4l4Ly8tDP3nEHKAVzWga8M5CuNLRTPvOXOT+5Evkoy2HZYv9RDgL7o28nVtoeqB3UWO/D1GS2Z9OqFmXI7piFGq7vuFJ3kzCl7MJ7HLzUozXJz749NyMgJyUr88yVmWMYbitjnQuNB/HziZkJRaZWGWLNSlkG75P/ouBradMnnNXNzqATxmaQO3fP8i22H2Fn2Bv7fc4IoRtBUGVZk0pwLXUNVv4VfWc0QC8VVc1jGLtWO1cwTeOwbrtzMG2iwWhTrzQ7O5DsRiaeJf+4LJzwU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fGc9IOpJmj2V9FLkQMGS5/p8AgDBsRAu7Z6m2xNVxc=;
 b=WjlNt5JRzUD3/qxt+8sSiBDOKj7bS/i8dacIsY9LKyl7uR8FHGP8n+wjQ6ANAg94k6FzR1JhtctFO0kH5i7I/pzvk3/2CHiyWK61ky5HSIfKmptqHwhkAETPbcgvWYC6Psm5JePIPz03odJ1XeLMSJsfxUqRHvTpqrawRtL5fIXbGnljV3bNzIMiDSQKKIGztntFINyODeP3imQHfJHwnxrxjSnOAE0hS72t0SeqvicTy0olhgQEEozKItetew+rOjeX8jh0LeJk21vhaMWIpa8trWCNXrpK38ciDqPm6lhekUxqGKFxxEoIJNjEIFb0V0FMTcdpOwX3jLJYjVx3CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2279.namprd15.prod.outlook.com (2603:10b6:a02:85::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Wed, 18 Aug
 2021 04:47:13 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::75be:c42b:c0d2:2565]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::75be:c42b:c0d2:2565%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 04:47:12 +0000
Date:   Tue, 17 Aug 2021 21:47:10 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        <fam.zheng@bytedance.com>, "Singh, Balbir" <bsingharora@gmail.com>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v1 03/12] mm: memcontrol: make lruvec lock safe when LRU
 pages are reparented
Message-ID: <YRyQztAQaAKiuUns@carbon.dhcp.thefacebook.com>
References: <20210814052519.86679-1-songmuchun@bytedance.com>
 <20210814052519.86679-4-songmuchun@bytedance.com>
 <YRx76SlTkTT8a1BI@carbon.dhcp.thefacebook.com>
 <CAMZfGtWhQcfFwkTq59ZboHe5iaLqeGhb9M8GzjEMWZwwYxB43w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMZfGtWhQcfFwkTq59ZboHe5iaLqeGhb9M8GzjEMWZwwYxB43w@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:4bb9) by SJ0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:33a::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 04:47:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba4bac41-49b4-4017-78f6-08d962033ec7
X-MS-TrafficTypeDiagnostic: BYAPR15MB2279:
X-Microsoft-Antispam-PRVS: <BYAPR15MB227966FE666FEFF102B910B4BEFF9@BYAPR15MB2279.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McAtWl+WF83IU8pW0QADZ/Vy8FxMN9yiXuK7XkuduLKe6t9jl69xNpSOOM5MuHcFblZe6TBDBpC+X2d7rz/HUyz/KvkHuDACICmw4ovYDQXK2ZW09f+0Ab7XNQi/FkRxHBdKuPd5ATWxw9Mj00Sx5O4ULou3yihhkLCiUvvVLVasTzWBS0l4yfziM6k1CjNM8dhpWrvyzDMdsiDYWEVKNxlGWOTGeIoY7/E7OS3Hk08dkFV550VWeQCKS70EE8qiE2ZD9KkqbtRqI01erJNtZ1lmDVPwqvlwpKuOjhW49T+4C5aXikDRtOyjQdc5lreXWBwyTWpbFQriWs+9WUTPTxOj9yL62phKmr27Yabx8aHDAbS0ilX96wA6/cuZ4DNd9yv8m5t0H2K2jMjH5wRedKHt1ELawO25NBAn//e0+Ib+d9EL9NbcpdyVOKSZQI8A1iphjiBYXBkXY9QucMQN3guzEVaBHFxUBJz7FPiKcoeRVoAPbVuUxfaZM8lS1dNNJOGn8OdEonJ75+305m7ZEwic6EUkIyDRiJNzbYFCtjBv/DzqF21GeQdZO+04iz6UhotwP+5jZ8+3okcbVi+rifdfarfaxEVbCysl3DaPnPaW+4nF/eVwb6GoifOeM+sBkcipT3HWvdnw5Seu6fMgQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(5660300002)(478600001)(83380400001)(66556008)(2906002)(54906003)(38100700002)(66946007)(9686003)(66476007)(316002)(52116002)(7696005)(8936002)(6506007)(186003)(4326008)(55016002)(7416002)(86362001)(6916009)(53546011)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6atzixQVlsmzJ2wHjVIG4BBwj+037v3w8ZjpcqGPKCFZbji3P26xGHpChq4z?=
 =?us-ascii?Q?SLRkhtcUeNwzQcCwMKJGXnkSa20Lh98j9jUztY4oAEHuq3RAASNAV+NyV2cT?=
 =?us-ascii?Q?QE5EKR4+V3hGP8D/pz1k1L4wEvwZFW7lTQUgEHeeA0rvhP8gcnAit7sOru9x?=
 =?us-ascii?Q?juVrSN7HNNtddJcc/T2+HMpDdZr4V+NnuiHhtFZlGf28cl0HuA0v1tw5nrr3?=
 =?us-ascii?Q?L52jm5G64h5A1+C1N51/dAfelJ3nv5Hj8ZEaNf97GwWBgnzDGDQDWTh58H84?=
 =?us-ascii?Q?lUL/AJ0F2LCq4cW3IY1p7+cEU3JYdcn60F4zDpZVJtafaxvkCx7Hhf5sdG1G?=
 =?us-ascii?Q?LlPIa1Qn6d7P+BFXI7LXcFpOOVXcfcFH6sum+iSzW44A2NXnc6OheFVvEIZR?=
 =?us-ascii?Q?xCwG86TLNuCdFiOmkdUsbI++6jwVBM3Bf7EacowRDPjAF/oZGkxmaUa6NjTg?=
 =?us-ascii?Q?8stikBCjbXBsyreufSWSvhzK0rRoRFlhBB9TGxWiimyhygaq2LEI/lxDthWH?=
 =?us-ascii?Q?gL4rognOnYV+JpdtANjRNp7A/wwkMnkemidCtTTvhN7J6m09EZ/6cdteMrLp?=
 =?us-ascii?Q?VXL6H7nwbj9LJFkyxJwNw05SLFTfIXLuzjRJ31sFY8oZLiyIo35jIkGwTobX?=
 =?us-ascii?Q?RP9Ll6HOLVnu0CxM7Z7hOnwJx/CB+lywaJ7J7Pyb2n7dGXdeNB4SxpqHRrIJ?=
 =?us-ascii?Q?/EyE0WBAMEf+ndpZvZgmJCRIY29qzvKb4NDgJD/LzjfjuP/g6J4hIaInEM44?=
 =?us-ascii?Q?E0aHWrHC9qW5Wz6QCtjQxeFWhIgrEBQ4EJweXxgEy5VaH7uFvuWrF33WKhAh?=
 =?us-ascii?Q?jEL5tmLraEfacloXiXkGufOXSEG3heeJlAqy0Oy316+gQCBIRUfZFHk4w6uR?=
 =?us-ascii?Q?BbpU9PNIDylnJpyMnCgOoLtTnXsWgAgrQ2R61Q+V+UEcCTSgJazfsQsCdsX2?=
 =?us-ascii?Q?HDafkdGUVn8FJNB4VZJWKbSy1isZa8l1+dmrN8AZyVQ6tVeAP5yZvPCYZoZw?=
 =?us-ascii?Q?UgnlGiPGFptemfR75rFYjQb+Ym2lgExOXF24YdV2bX2fxBc8UBxDKA5fNhp0?=
 =?us-ascii?Q?TrRRK4CAEJiVX23JPahrqy/OGxYqTZCXAQymNd0ZpvgIBeRsddYGEJYMqDFa?=
 =?us-ascii?Q?AIfHqWo+1MW73PjK1psxodcQm93HcyO/4dMUSui03iaOBoX52ovpq/Pm2L1O?=
 =?us-ascii?Q?lXxUseZA/uXWiCkuIzAQ1OEPLUa7DGYNsXKSHbtJ3skSIBHBqF1AC1RhyrWV?=
 =?us-ascii?Q?utsmUdMMH2UtT+kTiKfgBtjpeDngTiQ0fsljSIy5zV7QVSiO/UtJdRG9OLFh?=
 =?us-ascii?Q?FoY+/5n7kFsaokamkWhA8lJIfq48tAWLgAFEaFbXTjh5WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4bac41-49b4-4017-78f6-08d962033ec7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 04:47:12.8029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpuFKsDHMwnGSkvwT81/1ftBLhk3Vfm4FQZw6C/84VUDY610ckjzBHavR7p9g2IM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2279
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Uc7QeG-izrRBOY50Iu9G_wgvSVIcNAGi
X-Proofpoint-ORIG-GUID: Uc7QeG-izrRBOY50Iu9G_wgvSVIcNAGi
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-18_01:2021-08-17,2021-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108180029
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 12:28:02PM +0800, Muchun Song wrote:
> On Wed, Aug 18, 2021 at 11:18 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Sat, Aug 14, 2021 at 01:25:10PM +0800, Muchun Song wrote:
> > > The diagram below shows how to make the folio lruvec lock safe when LRU
> > > pages are reparented.
> > >
> > > folio_lruvec_lock(folio)
> > >     retry:
> > >       lruvec = folio_lruvec(folio);
> > >
> > >         // The folio is reparented at this time.
> > >         spin_lock(&lruvec->lru_lock);
> > >
> > >         if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio)))
> > >             // Acquired the wrong lruvec lock and need to retry.
> > >             // Because this folio is on the parent memcg lruvec list.
> > >             goto retry;
> > >
> > >         // If we reach here, it means that folio_memcg(folio) is stable.
> > >
> > > memcg_reparent_objcgs(memcg)
> > >     // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
> > >     spin_lock(&lruvec->lru_lock);
> > >     spin_lock(&lruvec_parent->lru_lock);
> > >
> > >     // Move all the pages from the lruvec list to the parent lruvec list.
> > >
> > >     spin_unlock(&lruvec_parent->lru_lock);
> > >     spin_unlock(&lruvec->lru_lock);
> > >
> > > After we acquire the lruvec lock, we need to check whether the folio is
> > > reparented. If so, we need to reacquire the new lruvec lock. On the
> > > routine of the LRU pages reparenting, we will also acquire the lruvec
> > > lock (will be implemented in the later patch). So folio_memcg() cannot
> > > be changed when we hold the lruvec lock.
> > >
> > > Since lruvec_memcg(lruvec) is always equal to folio_memcg(folio) after
> > > we hold the lruvec lock, lruvec_memcg_debug() check is pointless. So
> > > remove it.
> > >
> > > This is a preparation for reparenting the LRU pages.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > Acked-by: Roman Gushchin <guro@fb.com>
> >
> > Maybe it's mostly s/page/folio, but the patch looks quite differently
> > in comparison to the version I did ack. In general, please, drop acks
> > when there are significant changes between versions.
> 
> Got it. I'll drop all acks in the next version. Thanks.

Thank you!

The code look correct though. But the locking scheme becomes very complicated
(it was already complex). I wonder if there are better ideas. No ideas out
of my head, need to think more. If not, your approach looks ok.
