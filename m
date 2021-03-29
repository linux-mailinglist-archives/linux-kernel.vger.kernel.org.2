Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBF234CDED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhC2K0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:26:11 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:43658 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhC2KZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:25:36 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210329102534epoutp0495e1280f732007a0cd10e3aa212e2eea~wyT3yaGnm1155611556epoutp04p
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 10:25:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210329102534epoutp0495e1280f732007a0cd10e3aa212e2eea~wyT3yaGnm1155611556epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617013534;
        bh=fl2nppVzI3fXJpRHYjF+CyBv6FygMrQDwvcBv4SomCY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u65VIUxVHFLCBdslZgWvTmKRmvLpwgx/TvXVpnj8Tr3Ug8kgrOqV5sMF8dtGKKBiG
         KBIaRTkZ4yeiuf35Yjs8PkW/mZpYEZyIXCazTEHuhCtCcE2TWIdpfebJouDXnzF31s
         RURNw2JhtMcwDzJHgWUl6v8HdZDIyDdWWfPhhH4Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210329102533epcas2p161adbacdb15e8332a5aef8ed627fb5c9~wyT3IVkj_1708617086epcas2p1B;
        Mon, 29 Mar 2021 10:25:33 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.189]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4F87y32sDdz4x9Px; Mon, 29 Mar
        2021 10:25:31 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.7F.61506.B1BA1606; Mon, 29 Mar 2021 19:25:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20210329102530epcas2p11e5de4a40264b9aeca33c89a46932b82~wyT0j2TIH1487114871epcas2p1O;
        Mon, 29 Mar 2021 10:25:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210329102530epsmtrp23ef0be1a059da5b9a230dd48463f0e49~wyT0jPMgN1012210122epsmtrp2a;
        Mon, 29 Mar 2021 10:25:30 +0000 (GMT)
X-AuditID: b6c32a46-e71ff7000000f042-15-6061ab1ba8d7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.F0.33967.A1BA1606; Mon, 29 Mar 2021 19:25:30 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210329102530epsmtip1b8660ec30e60bc2839a6687d353a89ff~wyT0Vz_1_2072320723epsmtip1J;
        Mon, 29 Mar 2021 10:25:30 +0000 (GMT)
Date:   Mon, 29 Mar 2021 19:12:55 +0900
From:   Hyunsoon Kim <h10.kim@samsung.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, dseok.yi@samsung.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add ___GFP_NOINIT flag which disables zeroing on
 alloc
Message-ID: <20210329101255.GA144155@ubuntu>
MIME-Version: 1.0
In-Reply-To: <YGF09yYtxeNj4Bcc@unreal>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdljTTFd6dWKCQU+3kMWc9WvYLK5M+8No
        MeXXUmaLy7vmsFncW/Of1YHVY9OqTjaPTZ8msXucmPGbxaNvyypGj8+b5AJYo3JsMlITU1KL
        FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslVILUnIKDA0L9IoTc4tL89L1kvNzrQwNDIxMgSoTcjK2XJvOVHBa
        uKLjx03WBsaJAl2MHBwSAiYSRzsLuhi5OIQEdjBKnDwxkwnC+cQo8bLjEJTzjVHi1Jdmti5G
        TrCOaWe/QSX2MkocWLANynnCKPFh4VlGkCoWAVWJtf8egtlsAhoSt6fMZAexRYDiKxfcZQWx
        mQXKJX7OP8gMYgsLBEpc7/rHAmLzCuhIHFp/jB3CFpQ4OfMJWJxTQE3i9tqPjCB3iwqoSLw6
        WA+yV0LgJbvEhDvHmSCuc5G4ffMJlC0s8er4FnYIW0ri87u9UB/US8y+fJIZonkC0J/n+qEa
        jCVmPWtnhDguQ+LV1cWMkEBSljhyiwUizCfRcfgvO0SYV6KjTQiiU1FixYmZUKvEJdoatzND
        2B4S81a9hobPZmAodqxlmcAoPwvJa7OQbIOwdSQW7P7ENgtoBbOAtMTyfxwQpqbE+l36CxhZ
        VzGKpRYU56anFhsVGCFH9iZGcMLUctvBOOXtB71DjEwcjIcYJTiYlUR4WU/HJgjxpiRWVqUW
        5ccXleakFh9iNAXG00RmKdHkfGDKziuJNzQ1MjMzsDS1MDUzslAS5y02eBAvJJCeWJKanZpa
        kFoE08fEwSnVwJR9/8WdlzeC+vjZi2bnsrI9E3T6YvZD4QIjC8elo9sTOe71PEv3z/x0/7XX
        vttiqhZ9yos/ivB0OyrbPHjMyXvMdeWO6yI+d0r12suvf/4hrn7i2dpzsrPexPbez6pgu7Nw
        UuOup2oySjGblszZMa8n+GEvu5npnZ/JryXO5nhoNDuUL7qardLGkrepozaZWYPz7du3S72e
        LL4Y1v3lyoG5XdMd1gpv8Y9fsjB0juetoykXA/LFjUMuyl5fx65tl/x9ZfXLtvodO7dxPTOe
        EvVwTqVWv9JJl81ZZ+JYVRiZOnzEVx5QdJZu1TvioRq2fb94+qSaGVL12u8r5oqbLA8t2KDY
        nTfrSnnWjH21sUosxRmJhlrMRcWJAJbq3XUhBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSnK7U6sQEg2WN8hZz1q9hs7gy7Q+j
        xZRfS5ktLu+aw2Zxb81/VgdWj02rOtk8Nn2axO5xYsZvFo++LasYPT5vkgtgjeKySUnNySxL
        LdK3S+DKOPT/GHNBt2DF9ovyDYyveLsYOTkkBEwkpp39xtTFyMUhJLCbUeLuw4OMEAlxiadL
        LkDZwhL3W46wQhQ9YpT4MrcZLMEioCqx9t9DMJtNQEPi9pSZ7CC2CFB85YK7rCA2s0C5xM/5
        B5lBbGGBQInrXf9YQGxeAR2JQ+uPsUMM3cwoMfPIEzaIhKDEyZlPWCCatSRu/HsJdB4HkC0t
        sfwfB0iYU0BN4vbaj4wgYVEBFYlXB+snMArOQtI8C0nzLITmBYzMqxglUwuKc9Nziw0LDPNS
        y/WKE3OLS/PS9ZLzczcxgoNdS3MH4/ZVH/QOMTJxMB5ilOBgVhLhZT0dmyDEm5JYWZValB9f
        VJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD0yKf82VzXK9PUfeW1e3U6mwq
        vMCj/2rdv4W/1m4xEmScf6A/dUvsWTnv4rc3VRcnSpSwP9h5d/dOD1WB+b4ckZXF73mPPa+X
        v2XhKHBo7kGFGAd+ybsFfoFBXxrj9fvasnfGl03O/d64XUvj94VjO9bbsXas38x4l+/qlut/
        HXef5vh09//dqR0bylpS91rHv22Q4DSVCwz5u0xFh72yv1L84sriVWYbBVQYG37ef7ulTtqy
        5Pdte5/Fi33SjM894DF68ER6R1B6sG5Guucq06OJj+0WBF1WjxUKfpbYUWJxnn2NDcuRKTMy
        KyPFREsVinp0d722qgy+dtDsdb32Z+GeS0ruSnmn9ONVg9mVWIozEg21mIuKEwFnIv8r5QIA
        AA==
X-CMS-MailID: 20210329102530epcas2p11e5de4a40264b9aeca33c89a46932b82
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----gJqi5NNVyYI6Zwqm0SG9s49ZPiKtTbI8X5q.UcWq9Dw77Yu7=_23ab1_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210329054156epcas2p31650fa755e6cbcc55c4f33a79878256f
References: <CGME20210329054156epcas2p31650fa755e6cbcc55c4f33a79878256f@epcas2p3.samsung.com>
        <1616995751-83180-1-git-send-email-h10.kim@samsung.com>
        <YGF09yYtxeNj4Bcc@unreal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------gJqi5NNVyYI6Zwqm0SG9s49ZPiKtTbI8X5q.UcWq9Dw77Yu7=_23ab1_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Mar 29, 2021 at 09:34:31AM +0300, Leon Romanovsky wrote:
> On Mon, Mar 29, 2021 at 02:29:10PM +0900, Hyunsoon Kim wrote:
> > This patch allows programmer to avoid zero initialization on page
> > allocation even when the kernel config "CONFIG_INIT_ON_ALLOC_DEFAULT"
> > is enabled. The configuration is made to prevent uninitialized
> > heap memory flaws, and Android has applied this for security and
> > deterministic execution times. Please refer to below.
> > 
> > https://android-review.googlesource.com/c/kernel/common/+/1235132
> > 
> > However, there is a case that the zeroing page memory is unnecessary
> > when the page is used on specific purpose and will be zeroed
> > automatically by hardware that accesses the memory through DMA.
> > For instance, page allocation used for IP packet reception from Exynos
> > modem is solely used for packet reception. Although the page will be
> > freed eventually and reused for some other purpose, initialization at
> > that moment of reuse will be sufficient to avoid uninitialized heap
> > memory flaws. To support this kind of control, this patch creates new
> > gfp type called ___GFP_NOINIT, that allows no zeroing at the moment
> > of page allocation, called by many related APIs such as page_frag_alloc,
> > alloc_pages, etc.
> > 
> > Signed-off-by: Hyunsoon Kim <h10.kim@samsung.com>
> > ---
> >  include/linux/gfp.h | 2 ++
> >  include/linux/mm.h  | 4 +++-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> Let's assume that we will use this new flag, and users are smart enough
> to figure when it needs to be used, what will be the performance gain?
> 
> Thanks

For instance, there are four memory access (either read or write) done
by the system; memory write due to page allocation for reserving memory
for modem hardware, memory write on the page by modem hardware,
read and write incurred by copy_to_user operation by iperf reading
the incoming network data. Theoretically, we can expect 1/4 of power
saving on DRAM bandwidth. By performing simple iperf test with download
UDP 800Mbps, we saw 5-6mA power gain by disabling
CONFIG_INIT_ON_ALLOC_DEFAULT.

Thanks

------gJqi5NNVyYI6Zwqm0SG9s49ZPiKtTbI8X5q.UcWq9Dw77Yu7=_23ab1_
Content-Type: text/plain; charset="utf-8"


------gJqi5NNVyYI6Zwqm0SG9s49ZPiKtTbI8X5q.UcWq9Dw77Yu7=_23ab1_--
