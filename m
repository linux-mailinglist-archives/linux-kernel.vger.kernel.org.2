Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0022E395F03
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 16:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhEaOGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 10:06:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38456 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232468AbhEaNmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 09:42:03 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14VDdfZ2016586;
        Mon, 31 May 2021 13:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=+bEtGCo1uhHPhqESan+wsUXEcoXhXeuf/1fKcgnFV1Q=;
 b=GfKMkQLtyAz54dNNXey9XKD9Orng7kDTteOAM/YvosFwEINTQ64XoPADNSYe9QC0iYxx
 rdMESvjHc0RoNTu5VYEQiP2fsntxH0FGD+tptvrNT4ZmEbBc65cIxRB0CjhdaqZFuw8w
 bn9jcYuvxvGwz8Mk+4DKUbJxMKCDrxbyegr19PFma03Smjc594CH5vjfCb4OOtXlfzOR
 UD0SdXdao49eYHkb0tdHqDIk8fqqb5wM5AOVzvYck2aS0aU7cH/foTBy9Ziv1kunW00N
 5sL4Ceo4oH+SRc7uC0c/4gZzg34+ULsrnqd/3pku2rl1MJOiJd6cywhVgtu7k/3n2m+k pw== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38vng40714-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 13:39:41 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14VDdebX155376;
        Mon, 31 May 2021 13:39:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 38ude6dh4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 13:39:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2+m76EJPaOlIqleXNKPvJGn3vfuq9jSjvwvhdDKSMBjlgrM+1a2IUe9i8KQQyWH1B0cGioY1vV6svg4PBF3SgyED2HyPZCKkW/zMsYZOQDdTvvcAD1HwPnAgAiTezRvW3Z7IQtwh0j6ARgQoRtCO9kSyMAmcV3W6S8mOkH5PcbcMgDJAeE0FaRFmK5HiZQ+pa2bwHTaFkBDNEVORi+zx4WiR2wmHkNZibYLozuHbIaQ3IM0u2+g9XaKSexUpmRiHihB6LMiYGhi6YpSepc3X34JL8OvWA9CgJlRfq3C9yaahJjNAXVLzcXhuSfn3BZSJ1Ii9qb07JsFpKMVTFzVzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bEtGCo1uhHPhqESan+wsUXEcoXhXeuf/1fKcgnFV1Q=;
 b=RzefsgAO6R46q3Rf73JcNHy+pMmVqf+FTg86wmz3xV5sJsmBPuOeMF9Rf7F8oziYf/BiK0HJHsyb1yvl84fgN796dL+DQQCMt9m0R8EtmrJrcMPomzrqPtG5u2YNrf1MF/ppNSntyK330wuI7No++02e66h8M/iF8wUo140+U9P944E+3jfgwHqPBg+to6Elykvo5FqQEVQWtrQWtXYfdgPd8jppY8SEWj0keewIsWUAqGAJC2rLXXFDpB79ZUM8mX8g01Yr6970sNexlYapXTrmbE+eeGj/uaSoy5VDfZ+CJMDmEByIRYrSk6cD3WL3bdZTgNZwDjIzRRn5tey9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bEtGCo1uhHPhqESan+wsUXEcoXhXeuf/1fKcgnFV1Q=;
 b=dwsELILSd7R/gtAH/ghYCWknRtwHAFf/3E22iAz89MLpNaDELHzU1Hh4uZUi4Zk+Kjl3R40CawAbADRFyBgbsJmaKYzPbOkLu/GF2OmlG3KjO4hmK7w/Kmo2Eg4bOoAHxOTgMt2hrDGlGN1A4QJRS07/a3P2DFzvGw3aAbyF/RE=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR1001MB2334.namprd10.prod.outlook.com (2603:10b6:301:2d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.29; Mon, 31 May
 2021 13:39:37 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 13:39:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>
Subject: Re: [PATCH 32/94] kernel/fork: Convert dup_mmap to use maple tree
Thread-Topic: [PATCH 32/94] kernel/fork: Convert dup_mmap to use maple tree
Thread-Index: AQHXPEQzJedE/FbyXUah1XIctJgRAqr5zncAgAP9ugA=
Date:   Mon, 31 May 2021 13:39:36 +0000
Message-ID: <20210531131341.c7weinlwxnhnnaqt@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-33-Liam.Howlett@Oracle.com>
 <CAJuCfpEBnrTShvYN9G9PTHjBWnEBeibuMwNOER66r1TdqBWNzg@mail.gmail.com>
In-Reply-To: <CAJuCfpEBnrTShvYN9G9PTHjBWnEBeibuMwNOER66r1TdqBWNzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 559b9276-f7fc-43b1-8a01-08d924398882
x-ms-traffictypediagnostic: MWHPR1001MB2334:
x-microsoft-antispam-prvs: <MWHPR1001MB233415450ED9240CC0202731FD3F9@MWHPR1001MB2334.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ia/oIdyt4arCp7BVupHv9f8wlZ0yx8JO3a/8xTua5iq2q6EjBhX/2SgnTW20O3R+tmT4w8EN97E4YGhNaPnZfVH/Fdb3b9uQB6fNE4nm8SF1Qt1vtpHWDNgUj/QTMlEoZCmUgbl8nrocrxkvD+OV7KlrcewO/kDGVrMNt1OP/fNxt8CPBzOphCPx1Kj4Wm+PwJNFHOybzyhdX8wrIoTBSEcAPVkznTiBZ/uRm9qRnp3XjIJ6gIpH/mfEHr23ZxVHRW2szLiRWchcUta4jWumdgQt3llLSAtA6Nzx5o6Mzn4z0XByeeirlbRrHnZU+vFl5PpaJAjZtrpc+mkOSUiYI00d2UQgasCGEWomjOd8OCYhc6NHcMYkCeoQwdNr5g7p/LtjrpSYbdB59sKuGXhd4zcpqDuwm17BCJUEdw3qZwI6dM4hOfvCv0bJ3LroBUn18WtH9aJOxjw3jGPnAefCTpbq1+teQxiWgAcj6dtLTXb7DXfcqVJuT876ORzuFXJtLNQ1zxxuzp9qVN0YB6Ilc++WjgWFlpGOdL5B5UNmn2B1BY4ISQ1JGGcicabtwW0ufmhP0uQCP0EAd0oR7gLWar6XneuKVEClmxieEDKrqOw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(39850400004)(366004)(376002)(346002)(136003)(396003)(6916009)(91956017)(76116006)(64756008)(66446008)(66476007)(66946007)(2906002)(33716001)(83380400001)(1076003)(8676002)(5660300002)(54906003)(316002)(4326008)(7416002)(6486002)(6512007)(9686003)(8936002)(6506007)(53546011)(186003)(44832011)(26005)(71200400001)(86362001)(38100700002)(66556008)(122000001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jKfFhKRNtPkBkGQL7iz/+8watQdj68bK6QHDG+Wv330eA0WFxAFuOKTjwERD?=
 =?us-ascii?Q?NO5/Jak4sW4aF1D31iXAmeEKAFniEYN2fg/Jl4vO8gdvwX9qdEW7efA3DFM2?=
 =?us-ascii?Q?J2K0/Os8FBvF+5INJ4zBWcii1k8ZquUPgX0Z+0CwabQS0R53F7Snb7HbALlW?=
 =?us-ascii?Q?NXyZtgu2Fztwehhf60WZbmnsfDKNR6c7nYH08ynUBQ92VlK0I0fMlr3+sVov?=
 =?us-ascii?Q?XWJqopQCQ6muNJFVsib6QGWurxGOqZL9V2iffTf2Fw3fCT17HHev9sZtQCHn?=
 =?us-ascii?Q?LJr/PHfzwkKPiB7Nz9ihy9CxlMBj1wy1c9sPwdjT4RHK72aNow3pPpYnLV0d?=
 =?us-ascii?Q?5RCd7bHjKKi5/AkatwQAEcybJ0tjTC52EegIaTRrkNTXNY64l47Hahavxyx5?=
 =?us-ascii?Q?77EmHonSnMF1kwvzASmbt2CagzLmuZSm6Hj1hZsqt7NEiR/BNKH4mqEOspe4?=
 =?us-ascii?Q?gU4RVOx8s0rcHI1tQ1j/vgKtgxKw9VyMhZAFydi8rQBNnNe3DfYpXJdC5grq?=
 =?us-ascii?Q?b4j0vM5jvZLinMwuBTUHzgju8YvpGUegmuyVlSv0f8yqHuZQwPAj0FWTjGSi?=
 =?us-ascii?Q?7d/wFIDWnpD6x9MoFRKpIDiAa/O5SaXcCOb9UvheCz+jLmqRqSaPkZPhO8C4?=
 =?us-ascii?Q?u0xRq2wNdD31lxCI+oX9pLaREDzeX9TWaHHvpAPCqe5FTTbu/EbdjdbL9dlM?=
 =?us-ascii?Q?xPraFmHR8nJWTLlUIQ99avkwbmFV+wHkomHA1H7O6YtxqFW06a/xZ30N+1kB?=
 =?us-ascii?Q?jNZN190XIhfE8C8HYqHKFCZJo/OQkxakVT0fW9dNY5XpJ7f9WKsTSjuSAkfl?=
 =?us-ascii?Q?+0X+e6kUwfRBiHMtIGUd8Wz2x+kjIXORn508jxB7HL4UxkT29ds7s9+Ii9KH?=
 =?us-ascii?Q?uznaMwMUbPxxLcgZcchfUXlAtYKWlLxr/0HIxjnkHO/02OFXhEGnmfuLnTPh?=
 =?us-ascii?Q?c1xgyVJmYvx8EBmEeuzZS/1FBCfzLZxSAPQHy085kpFhEnO+IzzRkuQg2br/?=
 =?us-ascii?Q?eLo+wVc7oIV3s9Y81D1Seo7MmLbdciDsy9zaWlDUAtzUiH1jQLLRP5ITqO7w?=
 =?us-ascii?Q?JrvfVOayqpuoR0y6NBWi8GENkcXYIR2iWUN3dIhIux+XUXiqc93hRXgy4kBF?=
 =?us-ascii?Q?qsszy1NLMhrqmgFmoPtzZMcN8fW70XYvNnkIjAnD5xdCZ2If66aa+K/IQQJG?=
 =?us-ascii?Q?3aslHlT+gMoD55wL1LnAP22tZnjfwXS6eYyTJiHcKxHZwORjL+gCUQLsKsXS?=
 =?us-ascii?Q?K9vqr/5JNa/uXjgfZHMqexJ2SFUeaYjW0qgg8ZU2yqHWYGIxAVJjC1f79xeE?=
 =?us-ascii?Q?Ra8Sg0n8ws+GJZL6ary7uVQx?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AEB8093B8DC66D4F8DE7A44BB54AB1BB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559b9276-f7fc-43b1-8a01-08d924398882
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 13:39:36.9958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOYr8lef9NQkqhJHQ4FZCIemLSf5oKoCFqdNq8wzns0wuFmRtj2CokP6/Siy8SKxBVQRNo6tDbzrVuDmy8OLow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2334
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10001 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105310096
X-Proofpoint-ORIG-GUID: VHvLuzFAq_TogKY68QzVZdNV5oGYbog9
X-Proofpoint-GUID: VHvLuzFAq_TogKY68QzVZdNV5oGYbog9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [210528 20:42]:
> On Wed, Apr 28, 2021 at 8:36 AM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > Use the maple tree iterator to duplicate the mm_struct trees.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  include/linux/mm.h       |  2 --
> >  include/linux/sched/mm.h |  3 +++
> >  kernel/fork.c            | 24 +++++++++++++++++++-----
> >  mm/mmap.c                |  4 ----
> >  4 files changed, 22 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index e89bacfa9145..7f7dff6ad884 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2498,8 +2498,6 @@ extern bool arch_has_descending_max_zone_pfns(voi=
d);
> >  /* nommu.c */
> >  extern atomic_long_t mmap_pages_allocated;
> >  extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t)=
;
> > -/* maple_tree */
> > -void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
> >
> >  /* interval_tree.c */
> >  void vma_interval_tree_insert(struct vm_area_struct *node,
> > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > index e24b1fe348e3..76cab3aea6ab 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -8,6 +8,7 @@
> >  #include <linux/mm_types.h>
> >  #include <linux/gfp.h>
> >  #include <linux/sync_core.h>
> > +#include <linux/maple_tree.h>
> >
> >  /*
> >   * Routines for handling mm_structs
> > @@ -67,11 +68,13 @@ static inline void mmdrop(struct mm_struct *mm)
> >   */
> >  static inline void mmget(struct mm_struct *mm)
> >  {
> > +       mt_set_in_rcu(&mm->mm_mt);
> >         atomic_inc(&mm->mm_users);
> >  }
> >
> >  static inline bool mmget_not_zero(struct mm_struct *mm)
> >  {
> > +       mt_set_in_rcu(&mm->mm_mt);
>=20
> Should you be calling mt_set_in_rcu() if atomic_inc_not_zero() failed?
> I don't think mmput() is called after mmget_not_zero() fails and
> mt_clear_in_rcu() will not be called.

Good catch, but having it the way it is will be faster with the
possibility of re-entering RCU mode if there is a race during tear down.
Entering RCU mode during tear-down mean that the nodes that are not
already freed would remain for an RCU cycle before being freed.  I don't
think it is worth checking every time this is called for such a low
payoff.  I should probably add a comment about this though.

>=20
> >         return atomic_inc_not_zero(&mm->mm_users);
> >  }
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index c37abaf28eb9..832416ff613e 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -477,7 +477,9 @@ static __latent_entropy int dup_mmap(struct mm_stru=
ct *mm,
> >         struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
> >         struct rb_node **rb_link, *rb_parent;
> >         int retval;
> > -       unsigned long charge;
> > +       unsigned long charge =3D 0;
> > +       MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
> > +       MA_STATE(mas, &mm->mm_mt, 0, 0);
> >         LIST_HEAD(uf);
> >
> >         uprobe_start_dup_mmap();
> > @@ -511,7 +513,13 @@ static __latent_entropy int dup_mmap(struct mm_str=
uct *mm,
> >                 goto out;
> >
> >         prev =3D NULL;
> > -       for (mpnt =3D oldmm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
> > +
> > +       retval =3D mas_entry_count(&mas, oldmm->map_count);
> > +       if (retval)
> > +               goto fail_nomem;
> > +
> > +       rcu_read_lock();
> > +       mas_for_each(&old_mas, mpnt, ULONG_MAX) {
> >                 struct file *file;
> >
> >                 if (mpnt->vm_flags & VM_DONTCOPY) {
> > @@ -525,7 +533,7 @@ static __latent_entropy int dup_mmap(struct mm_stru=
ct *mm,
> >                  */
> >                 if (fatal_signal_pending(current)) {
> >                         retval =3D -EINTR;
> > -                       goto out;
> > +                       goto loop_out;
> >                 }
> >                 if (mpnt->vm_flags & VM_ACCOUNT) {
> >                         unsigned long len =3D vma_pages(mpnt);
> > @@ -594,7 +602,9 @@ static __latent_entropy int dup_mmap(struct mm_stru=
ct *mm,
> >                 rb_parent =3D &tmp->vm_rb;
> >
> >                 /* Link the vma into the MT */
> > -               vma_store(mm, tmp);
> > +               mas.index =3D tmp->vm_start;
> > +               mas.last =3D tmp->vm_end - 1;
> > +               mas_store(&mas, tmp);
> >
> >                 mm->map_count++;
> >                 if (!(tmp->vm_flags & VM_WIPEONFORK))
> > @@ -604,14 +614,17 @@ static __latent_entropy int dup_mmap(struct mm_st=
ruct *mm,
> >                         tmp->vm_ops->open(tmp);
> >
> >                 if (retval)
> > -                       goto out;
> > +                       goto loop_out;
> >         }
> >         /* a new mm has just been created */
> >         retval =3D arch_dup_mmap(oldmm, mm);
> > +loop_out:
> >  out:
> > +       rcu_read_unlock();
> >         mmap_write_unlock(mm);
> >         flush_tlb_mm(oldmm);
> >         mmap_write_unlock(oldmm);
> > +       mas_destroy(&mas);
> >         dup_userfaultfd_complete(&uf);
> >  fail_uprobe_end:
> >         uprobe_end_dup_mmap();
> > @@ -1092,6 +1105,7 @@ static inline void __mmput(struct mm_struct *mm)
> >  {
> >         VM_BUG_ON(atomic_read(&mm->mm_users));
> >
> > +       mt_clear_in_rcu(&mm->mm_mt);
> >         uprobe_clear_state(mm);
> >         exit_aio(mm);
> >         ksm_exit(mm);
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 929c2f9eb3f5..1bd43f4db28e 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -780,10 +780,6 @@ static inline void vma_mt_store(struct mm_struct *=
mm, struct vm_area_struct *vma
> >                 GFP_KERNEL);
> >  }
> >
> > -void vma_store(struct mm_struct *mm, struct vm_area_struct *vma) {
> > -       vma_mt_store(mm, vma);
> > -}
> > -
> >  static void
> >  __vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
> >         struct vm_area_struct *prev, struct rb_node **rb_link,
> > --
> > 2.30.2=
