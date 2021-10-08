Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498394266A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbhJHJZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:25:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237548AbhJHJZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:25:04 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1989LiA9002603;
        Fri, 8 Oct 2021 05:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=i52opo7weLiT2Mo70D6tVE9SK/x58BUu9Fp3oGHX7CI=;
 b=sZCpZpxSAVqDFxEFaVi+RnMohBoNjmCaApuhAy41wN+C23uY46TnikqJnTzJVtFMj6NE
 RXzP33wgar7oKwAHCMXlimeyHgGC1hOJPKMXK5H+VewWkCTppE2uZwch0l9eJ4H1xIDv
 7fov6Jnsguhaw4pg0o/LLSHTFZiq4bhHuzCzfSPeIrfmCKRLAUehlQERvSTJtlNx2P9P
 vrB0Rr2n1lVlEQ6OJQKYvHQr6a1ItBM0kybMfyzXXD5ogZzMw7C653FyaDFR663NVSjr
 hYOaFWZSdYeuZURf2lCMMduLJv0NVxeWhT4/rk7aQ+dk+e4l1vR9EEo062DKE2H/0S0J Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bja72bv93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 05:22:45 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1989MjCZ028509;
        Fri, 8 Oct 2021 05:22:45 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bja72bv8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 05:22:45 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1989CTPA014977;
        Fri, 8 Oct 2021 09:22:42 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3bef2b0v6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 09:22:42 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1989Md5s54264224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Oct 2021 09:22:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 150F3A4062;
        Fri,  8 Oct 2021 09:22:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62798A4054;
        Fri,  8 Oct 2021 09:22:38 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.5.116])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Oct 2021 09:22:38 +0000 (GMT)
Date:   Fri, 8 Oct 2021 11:22:35 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     ultrachin@163.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, brookxu.cn@gmail.com,
        chen xiaoguang <xiaoggchen@tencent.com>,
        zeng jingxiang <linuszeng@tencent.com>,
        lu yihui <yihuilu@tencent.com>
Subject: Re: [PATCH] mm: Free per cpu pages async to shorten program exit
 time
Message-ID: <20211008112235.1d37f2db@p-imbrenda>
In-Reply-To: <1db11d75-d2d8-ef71-471a-ddad5c90a733@redhat.com>
References: <20211008063933.331989-1-ultrachin@163.com>
        <d71e6021-777b-3ca9-b08f-64fe7ff51e08@redhat.com>
        <20211008105205.07d2f205@p-imbrenda>
        <1db11d75-d2d8-ef71-471a-ddad5c90a733@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4kE8NLJua1HC6tXwIUakYz-LungupaG-
X-Proofpoint-ORIG-GUID: 67eHlMzx8_aPPtq-_iXVZ27YkxEFcmpA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-08_03,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=777 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110080054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2021 11:15:25 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 08.10.21 10:52, Claudio Imbrenda wrote:
> > On Fri, 8 Oct 2021 10:17:50 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 08.10.21 08:39, ultrachin@163.com wrote:  
> >>> From: chen xiaoguang <xiaoggchen@tencent.com>
> >>>
> >>> The exit time is long when program allocated big memory and
> >>> the most time consuming part is free memory which takes 99.9%
> >>> of the total exit time. By using async free we can save 25% of
> >>> exit time.
> >>>
> >>> Signed-off-by: chen xiaoguang <xiaoggchen@tencent.com>
> >>> Signed-off-by: zeng jingxiang <linuszeng@tencent.com>
> >>> Signed-off-by: lu yihui <yihuilu@tencent.com>  
> >>
> >> I recently discussed with Claudio if it would be possible to tear down
> >> the process MM deferred, because for some use cases (secure/encrypted
> >> virtualization, very large mmaps) tearing down the page tables is
> >> already the much more expensive operation.
> >>
> >> There is mmdrop_async(), and I wondered if one could reuse that concept
> >> when tearing down a process -- I didn't look into feasibility, however,
> >> so it's just some very rough idea.  
> > 
> > I have done some experiments by unconditionally replacing mmdrop with
> > mmdrop_async in exit.c and nothing broke, and exit time of large
> > processes was almost instant (with the actual cleanup being performed in
> > background)
> > 
> > my approach is probably simpler/cleaner:
> > 
> > diff --git a/include/asm-generic/mmu_context.h b/include/asm-generic/mmu_context.h
> > index 91727065bacb..900931a6a105 100644
> > --- a/include/asm-generic/mmu_context.h
> > +++ b/include/asm-generic/mmu_context.h
> > @@ -73,4 +73,8 @@ static inline void deactivate_mm(struct task_struct *tsk,
> >   }
> >   #endif
> >   
> > +#ifndef arch_exit_mm_mmput
> > +#define arch_exit_mm_mmput mmput
> > +#endif
> > +
> >   #endif /* __ASM_GENERIC_MMU_CONTEXT_H */
> > diff --git a/kernel/exit.c b/kernel/exit.c
> > index 9a89e7f36acb..604cb9c740fa 100644
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -498,7 +498,7 @@ static void exit_mm(void)
> >          task_unlock(current);
> >          mmap_read_unlock(mm);
> >          mm_update_next_owner(mm);
> > -       mmput(mm);
> > +       arch_exit_mm_mmput(mm);
> >          if (test_thread_flag(TIF_MEMDIE))
> >                  exit_oom_victim();
> >   }
> > 
> > these are the minimal changes to common code, then each architecture can
> > define their own arch_exit_mm_mmput as they see fit (for example, to free
> > asynchronously only for certain classes of mm, like big ones, VMs, or so).
> > 
> > Another option is to simply always replace mmput with mmput_async, which I
> > expect will raise more eyebrows.  
> 
> Thanks Claudio.
> 
> I guess we'd use some heuristic to keep the eyebrows down. Having 
> something like
> 
> if (should_mput_async_on_exit(mm))
> 	mmput_async(mm);
> else
> 	mmput(mm);
> 
> whereby the heuristic can optionally consult the arch/config-knobs/... 
> doesn't sound too wrong to me if it works.
> 

yes, that is one of the possible solutions I had thought of.

although probably the small patch I posted above is even less intrusive
and should hopefully raise even fewer eyebrows, while also leaving the
door open to arch-specific code to do more than just mmput_async, if
needed.

in the end I really do not have any preference, I simply want something
everybody can agree on :)

