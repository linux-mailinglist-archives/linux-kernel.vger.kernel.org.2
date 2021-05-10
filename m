Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AA7377EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhEJJFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:05:30 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:50266 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhEJJF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:05:29 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210510090423epoutp045de4972afffc44387511d840cc6d1fcf~9qS_6NUT81837118371epoutp04k
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:04:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210510090423epoutp045de4972afffc44387511d840cc6d1fcf~9qS_6NUT81837118371epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620637463;
        bh=LyJ2/vrXA79R2bIzxqX+Panl8BD71MJWRMa3PlB7Z6c=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=mhSzJb+hfjCmCd2HQJ7ZGiBcREUWeTOpARrqhpi3tpTP3LTDWWoyzIku6Vy98wGeV
         7flKUUpzkhs00v1rXEUBBxX//FMYSUpFLtxfo0ihk6WcOeATyCdYUCKzwNFN0Qvnq3
         kqAUU1WY1HsY2DL5krTPXWhayWFZN6fTQcgb+FfE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210510090422epcas2p152c5088255ca59e456d325018be031eb~9qS_jFj100043500435epcas2p1d;
        Mon, 10 May 2021 09:04:22 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Fdw906g0gz4x9QS; Mon, 10 May
        2021 09:04:20 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.83.09433.217F8906; Mon, 10 May 2021 18:04:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20210510090417epcas2p39cbc55bfe85c5b22aedac38c62d54c5e~9qS55jlxD3141131411epcas2p39;
        Mon, 10 May 2021 09:04:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210510090417epsmtrp254f93fe9b4cae2ed9e925c438ec1fa66~9qS54xgzu2598725987epsmtrp2c;
        Mon, 10 May 2021 09:04:17 +0000 (GMT)
X-AuditID: b6c32a47-f4bff700000024d9-7b-6098f7122b8b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.9C.08637.117F8906; Mon, 10 May 2021 18:04:17 +0900 (KST)
Received: from KORCO039056 (unknown [10.229.8.156]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210510090417epsmtip18096a2fa52447a4807b551688872e665~9qS5s2TS20529505295epsmtip1L;
        Mon, 10 May 2021 09:04:17 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Christoph Hellwig'" <hch@lst.de>
Cc:     "'Konrad Rzeszutek Wilk'" <konrad.wilk@oracle.com>,
        "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        "'Robin Murphy'" <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        "'Bumyong Lee'" <bumyong.lee@samsung.com>
In-Reply-To: <20210510084406.GA1093@lst.de>
Subject: RE: [PATCH] swiotlb: manipulate orig_addr when tlb_addr has offset
Date:   Mon, 10 May 2021 18:04:17 +0900
Message-ID: <002401d7457b$75171560$5f454020$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHf+D/7GCiM8g+JpPf60X7uhtFZNAFoIg0LAnrz/3Wqq+y8MA==
Content-Language: ko
x-msg-type: PERSONAL
x-drm-type: PERSONAL
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmma7Q9xkJBj/faVjsPW1hsXL1USaL
        BfutLZYtfspocXnXHDaLtUfuslsc/PCE1YHdY828NYwek28sZ/TYfbOBzePj01ssHn1bVjF6
        fN4kF8AWlWOTkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZ
        A3SJkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafA0LBArzgxt7g0L10vOT/XytDA
        wMgUqDIhJ2PyjjaWgp+cFbPWrmVvYHzA3sXIySEhYCJxZkE7UxcjF4eQwA5GiWcvD0I5nxgl
        9v2YyAzhfGOUuHazgw2m5XjPUlaIxF5GiYe3WxkhnBeMEh+vbGMCqWIT0Jd42bGNFcQWEVCT
        OPOzjR2kiFmglUmiYesdRpAEp4C2RMPlPhYQW1jAW+LXzQtgcRYBVYmDX1rA1vEKWEr0zDvK
        CGELSpyc+QSsnllAXmL72znMECcpSPx8ugxqmZPE/rY5rBA1IhKzO9ugakQkurfcBjqOA8y+
        sycF5B4JgSMcErt272OBqHGR2LdwG9SbwhKvjm+BhpKUxOd3e9kgGroZJVof/YdKrGaU6Gz0
        gbDtJX5N38IKsoBZQFNi/S59iF3KEkduQZ3MJ9Fx+C87RJhXoqNNaAKjyiwkj81C8tgsJA/M
        Qpi5gJFlFaNYakFxbnpqsVGBMXJsb2IEJ1Mt9x2MM95+0DvEyMTBeIhRgoNZSYRXtGNaghBv
        SmJlVWpRfnxRaU5q8SFGU2BQT2SWEk3OB6bzvJJ4Q1MjMzMDS1MLUzMjCyVx3p+pdQlCAumJ
        JanZqakFqUUwfUwcnFINTNwNchfU4tpnBPhu72jNPfB5duOUbtlmv6obpyXU0/qea6kuWBE0
        uVMqzcnJ4mN8R+Ycne17lboFKsNaF3gLXYvYnSN4xYFbqNGJP8tmk/xuIW6D3q+rS5dbW35q
        mmZZH34u6CfTWonCyrt3PS9JmWoYvopeu9G/ksH4vURyhFf9ksyypvvrt6zeaRr79HBfmoVq
        dKF8asLcR+dkj3+aytzy9KL+7aMb7KW8guz/PH97bgfPd3GJlMprcbdd1W1d5Dof1HN3BaZ3
        nvhXNf+Q2k3GXYLJ3O1Ocepys0RDOHd/ff3ZcqrDhBMLZ3xVqKnu+cX1dCHn4tiHp7u3eDz0
        V8tSjpFUt6pTTK2b26PEUpyRaKjFXFScCADPuGPuLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCSnK7g9xkJBn9+m1rsPW1hsXL1USaL
        BfutLZYtfspocXnXHDaLtUfuslsc/PCE1YHdY828NYwek28sZ/TYfbOBzePj01ssHn1bVjF6
        fN4kF8AWxWWTkpqTWZZapG+XwJUxeUcbS8FPzopZa9eyNzA+YO9i5OSQEDCRON6zlLWLkYtD
        SGA3o8S5+R+ZIRKyEs/e7YAqEpa433IEqugZo0TH1ccsIAk2AX2Jlx3bWEFsEQE1iTM/28Aa
        mAU6mSQaTnKB2EIC6xklen95g9icAtoSDZf7wHqFBbwlft28wAhiswioShz80sIGYvMKWEr0
        zDvKCGELSpyc+QSongNopp5E20ZGiPHyEtvfzoG6U0Hi59NlrBC2qcSFryuYYG5+dXwLO8Rp
        ThL72+awQvSKSMzubIPqFZHo3nKbCWQ8iH1nT8oERvFZSBbPQlg8C8niWUgGLWBkWcUomVpQ
        nJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERyvWpo7GLev+qB3iJGJg/EQowQHs5IIr2jHtAQh
        3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamHRXxU5aH3v3
        3pKqaT9r//+Y9Fvv4ew80dlHs8XNJBLX5Heb3D/vvTamn/ndLIeHuozMZ9c6mS6d/u/H5n8T
        +WNi3RssDycvWFNTvWv3jqYpKv0vQ50f7Diy5H1g5Xa/y31vtK6df/Gsjs3CyWZzB5fahjmr
        N/J61jQyPw+QCFNZOmWDNd/UcP4dyl5JfyrNtZJuHTH+enxHyh+/G3cz7/HY3d959WTGpYfr
        Fv1aNrfRrsYvqubsJI9ekdWtsqlH59sIPXm83mnmB5+A1nUVaSEdh9yD/OUEE11zLQ7Fa99K
        XnSkR/DtvZsn7W5xTlRmDp3Y8pFd/NFbyxt+z1kr+M41PViu4l04v3z2VcvVYcuVWIozEg21
        mIuKEwHCi91ARgMAAA==
X-CMS-MailID: 20210510090417epcas2p39cbc55bfe85c5b22aedac38c62d54c5e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210510083139epcas2p211d9bee16e5e8f8ea34e606c83ac3a55
References: <CGME20210510083139epcas2p211d9bee16e5e8f8ea34e606c83ac3a55@epcas2p2.samsung.com>
        <20210510083057.46476-1-chanho61.park@samsung.com>
        <20210510084406.GA1093@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(RESEND due to wrong encrypted message setting)

Hi,

> On Mon, May 10, 2021 at 05:30:57PM +0900, Chanho Park wrote:
> > +static unsigned int swiotlb_align_offset(struct device *dev, u64
> > +addr);
> 
> Please just move swiotlb_align_offset up to avoid the forward declaration.

Okay. I'll move the position of the function next patch.

> 
> >  /*
> >   * Bounce: copy the swiotlb buffer from or back to the original dma
> location
> >   */
> > @@ -346,10 +347,17 @@ static void swiotlb_bounce(struct device *dev,
> phys_addr_t tlb_addr, size_t size
> >  	size_t alloc_size = mem->slots[index].alloc_size;
> >  	unsigned long pfn = PFN_DOWN(orig_addr);
> >  	unsigned char *vaddr = phys_to_virt(tlb_addr);
> > +	unsigned int tlb_offset;
> >
> >  	if (orig_addr == INVALID_PHYS_ADDR)
> >  		return;
> >
> > +	tlb_offset = (unsigned int)tlb_addr & (IO_TLB_SIZE - 1);
> > +	tlb_offset -= swiotlb_align_offset(dev, orig_addr);
> 
> Nit: I'd write this as:
> 
> 	tlb_offset = (tlb_addr & (IO_TLB_SIZE - 1)) -
> 			swiotlb_align_offset(dev, orig_addr);
> 
> as there is no need for the cast, and just having a single assignment is
> easier to follow.

Great. It can be a single assignment as you suggested.

Best Regards,
Chanho Park

