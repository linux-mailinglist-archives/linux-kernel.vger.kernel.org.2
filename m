Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6533AB305
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhFQLwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:52:43 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:30996 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhFQLwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:52:38 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210617115029epoutp0414bb5b73c8a2207961ef855fb57f240e~JXE26CxlK1995919959epoutp04_
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 11:50:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210617115029epoutp0414bb5b73c8a2207961ef855fb57f240e~JXE26CxlK1995919959epoutp04_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623930629;
        bh=rMI+RV4RC6+EiI9z6lahzcBFLxKuu5PsXQiMC31v840=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T7gkA6KM0HA/X4GKgmuJegTABWGVGcVWztAuTOg2jS5UGPWhLe3aymh5mio2gg1RD
         7j1QOrGuEtSmYLsf77V7i+bGzDREj8Oroej/mgCBSutgBWFbHP1NLpmpwKWWuR7LoF
         IJk8CCSakbgA/C8gg6ZwLKytVtbAJeyJ3GPTb9Xw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20210617115029epcas2p2955ce7aeb813a43fbaa1eadeb53e6056~JXE2afZ3h0157801578epcas2p2B;
        Thu, 17 Jun 2021 11:50:29 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.191]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4G5L366XD6z4x9Pw; Thu, 17 Jun
        2021 11:50:26 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.DB.09694.2073BC06; Thu, 17 Jun 2021 20:50:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20210617115026epcas2p4b9154025a8061f02edc557c576850730~JXEzxR1aS0632006320epcas2p4L;
        Thu, 17 Jun 2021 11:50:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210617115026epsmtrp2243c4a22b06cf80ed60b90d0341e07d7~JXEzwTvaF3103431034epsmtrp27;
        Thu, 17 Jun 2021 11:50:26 +0000 (GMT)
X-AuditID: b6c32a46-e17ff700000025de-53-60cb37027ee0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.69.08163.2073BC06; Thu, 17 Jun 2021 20:50:26 +0900 (KST)
Received: from KEI (unknown [12.36.155.227]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210617115025epsmtip1ecd625e5ee2a557138cc8924ac7aaae8~JXEzllMzX2230322303epsmtip1a;
        Thu, 17 Jun 2021 11:50:25 +0000 (GMT)
Date:   Thu, 17 Jun 2021 20:42:38 +0900
From:   Janghyuck Kim <janghyuck.kim@samsung.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Atish Patra <atish.patra@wdc.com>,
        Gavin Shan <gshan@redhat.com>,
        Zhengyuan Liu <liuzhengyuan@tj.kylinos.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: support fastpath if NUMA is enabled with numa
 off
Message-ID: <20210617114238.GA183559@KEI>
MIME-Version: 1.0
In-Reply-To: <55a95320-f356-86d2-26e4-11407f60de84@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjOaXtvL5q6uyruCAG7O3VWBrR1hcv4cMmMuwZ/gGy6uSb0Bq6U
        rF/rbbfBn3Y4LDKmiLAg5aPMBhWbgR0SVkGwQMTMjC3IBEdEBkM0CKzddAnq1vbWzH/P+7zP
        877vOe85GF88hMZgxXozY9LTWgJdI+gelJKJvNQf1bL2xmSyscONkt+eeywgl9uqAHnf280j
        PbO/IuSYtxEl77j/RcgLcz8h5KWL3wHS8cVxQH45pXx7LeVudgPK6bFQnvZjKOXx1wipkfpV
        AfW9y0otXxlHqRvOISHlG5hAqIAnnrIPfMXLWXtIm6Fh6ELGJGH0BYbCYn1RJpGdl/9OvjJF
        Jk+Up5GphERP65hMYve+nMQ9xdrg1ITkU1prCVI5NMsSyVkZJoPFzEg0BtacSTDGQq1RLjcm
        sbSOteiLkgoMurfkMplCGVSqtZrVGzPAuBL/uXM63waqN1WCKAzib8KW5SlBJViDifEeAM92
        L6Jc4Aew7M9bkUwAwKr7R4TPLed7HZGEF0D7klfIBTMAtvTZ+CGVAN8Kb87ZkBBG8WRorxsL
        uzfgW+DvncNIyMDH/TzYe7c/2BDD1uM5sGWsKKQR4VJ45lQZyuGX4fXTc4IQjsLT4fHJayAk
        jw7WeXDVGioD8SEMzjr+QbnpdsPWxUuRSdfDB9e6IjgGBpb6IhornHYtCDlzNYADrjY+l9gJ
        G+bt4QZ8XANHr+SGIMRfg0O3wyPw8XWwYvCpkKNFsOKomDO+DpdOe3gcHQdvPUnlaAr6XRWR
        qxoE8MxInaAabG544WAN//dqCDd4Azov+1GOjoVnn2EclMIOb7ITIO1gI2NkdUUMqzAqXty0
        B4Sf8449PaD24UqSD/Aw4AMQ4xMbRInsiFosKqRLShmTId9k0TKsDyiDSzrJj4kuMAT/g96c
        L1cqUlJkaUpSmaIgiVdEmNCnFuNFtJn5mGGMjOm5j4dFxdh41k+ssZqG/hSjJzrt68HmxRo1
        UlrqHn9/9RsJ48q6ut+Wrd4cyE1QxU5UC+dL/mLNx3ISPmqSnSjffv5wYPpRWaXvaK+98FVd
        uio7/dm6uPiDzaon1RPbjKLbJqz80T3Q5JypQdJb68/ZiHsI8VS6sk3V7CAdmqgjislhJHcr
        gpKl+IXplp3ZpPgm2OWOeegyVH240SCfieux122/fLgJzzqg6i9o76xXd86P3s2Dw8ShBNn4
        wnuzPZ+d6KqVWGcrF2szyIPLP5+S5v2h/kBQbgBI7uhM/NgBZOpxV2vbQvl1t2XSsevdl1pK
        fthP9/1yZ9NF+8jfv3VuyevYyycErIaW7+CbWPo/6o5181cEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTpfJ/HSCQc8uVos569ewWSxa8Z3F
        4v2yHkaLl7u2MVlsenyN1eLyrjlsFvfW/Ge1WP3kHKvF1o3rGC1mN/YxWrTcMXXg9lgzbw2j
        x4JNpR6bVnWyeWz6NInd48SM3ywem5fUe7zfd5XN48yCI+wehw7cYPX4vEnOo/1AN1MAdxSX
        TUpqTmZZapG+XQJXxuSVfYwFG2QqVvydzdLA+FKsi5GTQ0LARGLlntksILaQwA5GiT0rXSDi
        shI9KzYxQ9jCEvdbjrB2MXIB1dxnlJh+YBYTSIJFQFXiypMGVhCbTUBfon3qZXYQW0RAReLR
        hqNgDcwC35gk5kzZAdYgLOAncWXDIzCbV0BTYvHkJjaIqYcZJa4+X8oIkRCUODnzCdhJzAJa
        Ejf+vQRq4ACypSWW/+MACXMKWEv03TzOCBIWBVr26mD9BEbBWUiaZyFpnoXQvICReRWjZGpB
        cW56brFhgVFearlecWJucWleul5yfu4mRnCEaWntYNyz6oPeIUYmDsZDjBIczEoivLrFJxKE
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYJL5/EFs280D
        1V3nddQ4/4pvks+TqpVOUrGrmiy28pjhKtcqhiD9J81cnz1WmXFVH3j7kPGa36+oK9tPnDj4
        rsqfwa76RPM8kfBgXrEY9tj+C3n/95+rYVW6ev6R+5mlT0rYP2m+vNyiq7hS4ItDzrcPsdfT
        vBb9U9y3IKB8e/JOjxteqdnBSyPt2HbzaQY6rfl3KenDp9vW/8qmePQsXsnttft0VaLVt1M8
        H12rCkwi3vC/XuPfnHR1buCkRy/Vf+xdIspbz1X074cU8xfz9Wssdf4/fLjvxES1N3qFgaav
        Xtu9F3WLCdX5YNm7eN16wT0KxjUc1SUJM/ZsYOC6tXFDW+hG73NLp16L2rhW874SS3FGoqEW
        c1FxIgBCTkFbHwMAAA==
X-CMS-MailID: 20210617115026epcas2p4b9154025a8061f02edc557c576850730
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----BQd6e2h9GxUqVQlk.IQOvFPSTL_uu0j2Sxa4Btfe_8FVY.e-=_cbbf2_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210616081628epcas2p3f919d10029cbe01efa1212a5b861af38
References: <CGME20210616081628epcas2p3f919d10029cbe01efa1212a5b861af38@epcas2p3.samsung.com>
        <20210616083745.14288-1-janghyuck.kim@samsung.com>
        <55a95320-f356-86d2-26e4-11407f60de84@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------BQd6e2h9GxUqVQlk.IQOvFPSTL_uu0j2Sxa4Btfe_8FVY.e-=_cbbf2_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi,

On Wed, Jun 16, 2021 at 07:10:06PM +0200, Vlastimil Babka wrote:
> On 6/16/21 10:37 AM, Janghyuck Kim wrote:
> > Architecture might support fake node when CONFIG_NUMA is enabled but any
> 
> I suppose you mean the dummy node, i.e. dummy_numa_init()?
> 
> Because fakenuma is something different and I think if someone defines fakenuma
> nodes they actually would want for the mempolicies to be honored as if there was
> a real NUMA setup.
> 

You are correct. I mean dummy node, which shows "Faking a node at ..."
message at boot time. So I called it fake node.

> > node settings were supported by ACPI or device tree. In this case,
> > getting memory policy during memory allocation path is meaningless.
> > 
> > Moreover, performance degradation was observed in the minor page fault
> > test, which is provided by (https://protect2.fireeye.com/v1/url?k=32536af8-6dc85232-3252e1b7-0cc47a31bee8-e52eadd28e1e9a6e&q=1&e=39db7dd8-7f21-41a4-b4a9-9ad395d36e23&u=https%3A%2F%2Flkml.org%2Flkml%2F2006%2F8%2F29%2F294).
> > Average faults/sec of enabling NUMA with fake node was 5~6 % worse than
> > disabling NUMA. To reduce this performance regression, fastpath is
> 
> So you have measured this overhead is all due to mempolicy evaluation?
> Interesting, sounds like a lot.
> 

It's early to conclude, but mempolicy evaluation seems to account for a
large portion of the total overhead. Since this patch, performance
regression has decreased from 5-6% to 2-3%. It is still unclear whether
the remainder is within the margin of error of the measurement results
or is affected by other NUMA-related codes.

> > introduced. fastpath can skip the memory policy checking if NUMA is
> > enabled but it uses fake node. If architecture doesn't support fake
> > node, fastpath affects nothing for memory allocation path.
> > 
> > Signed-off-by: Janghyuck Kim <janghyuck.kim@samsung.com>
> 
> Sounds like an interesting direction to improve CONFIG_NUMA built kernels on
> single-node systems, but why restrict it only to arm64 and not make it generic
> for all systems with a single node?
> We could also probably use a static key instead of this #define.
> That would even make it possible to switch in case memory hotplug onlines
> another node, etc.
> 

I'm participating in arm64 project now, so I'm not sure if other
architectures will accept this way. So I tried not to touch other
architecture. Of course, it can be changed in the generic way if agree.

> > ---
> >  mm/internal.h  | 4 ++++
> >  mm/mempolicy.c | 3 +++
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 31ff935b2547..3b6c21814fbc 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -36,6 +36,10 @@ void page_writeback_init(void);
> >  
> >  vm_fault_t do_swap_page(struct vm_fault *vmf);
> >  
> > +#ifndef numa_off_fastpath
> > +#define numa_off_fastpath()	false
> > +#endif
> > +
> >  void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
> >  		unsigned long floor, unsigned long ceiling);
> >  
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index e32360e90274..21156671d941 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -2152,6 +2152,9 @@ struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
> >  	int preferred_nid;
> >  	nodemask_t *nmask;
> >  
> > +	if (numa_off_fastpath())
> > +		return __alloc_pages_nodemask(gfp, order, 0, NULL);
> > +
> >  	pol = get_vma_policy(vma, addr);
> >  
> >  	if (pol->mode == MPOL_INTERLEAVE) {
> > 
> 
> 

------BQd6e2h9GxUqVQlk.IQOvFPSTL_uu0j2Sxa4Btfe_8FVY.e-=_cbbf2_
Content-Type: text/plain; charset="utf-8"


------BQd6e2h9GxUqVQlk.IQOvFPSTL_uu0j2Sxa4Btfe_8FVY.e-=_cbbf2_--
