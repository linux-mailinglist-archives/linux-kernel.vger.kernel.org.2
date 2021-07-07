Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDB43BEA54
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 17:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhGGPIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 11:08:25 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:46610 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhGGPIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 11:08:22 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210707150540epoutp03093a51dee66d2aeaa0d686ce74cde469~Pio-UjVGM1649216492epoutp03S
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 15:05:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210707150540epoutp03093a51dee66d2aeaa0d686ce74cde469~Pio-UjVGM1649216492epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625670340;
        bh=rxH1MTE5iSPn2QTa9bm+8Dri4iIDisD9a+Baloy8n0Y=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Jx5jYnhvzlu/09z/oPFZgnqwvyiTlKv+uELjGt0u/1hfVb8hlDHQW2BKZb8mI09Sp
         IL9kX+YmXwfXG/oeANzDKsUmSi8ozESvGGw0dqGdDJeT0YFrFxU3SAiyuvNu//cOLx
         s8s5H1BPnzlOCO/4xM+/LiCzWSaBXTDXWSGNaS8s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210707150540epcas1p2453c615b24ab4b83f969662815caebfa~Pio_wqbtj0474404744epcas1p2C;
        Wed,  7 Jul 2021 15:05:40 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GKjR716B2z4x9Pv; Wed,  7 Jul
        2021 15:05:39 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.7E.10119.3C2C5E06; Thu,  8 Jul 2021 00:05:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210707150538epcas1p35450f5b6058e2ea9e06446f10d9bf662~Pio9aO6n72211122111epcas1p3u;
        Wed,  7 Jul 2021 15:05:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210707150538epsmtrp1409df9ee8784187de7d57717d984ca5b~Pio9Y5BES3041830418epsmtrp1h;
        Wed,  7 Jul 2021 15:05:38 +0000 (GMT)
X-AuditID: b6c32a38-97bff70000002787-3a-60e5c2c3f1a8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.19.08289.2C2C5E06; Thu,  8 Jul 2021 00:05:38 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.78]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210707150538epsmtip296556ae74eb857e7101bf52a0e14aa74~Pio9MKvLp0536905369epsmtip2a;
        Wed,  7 Jul 2021 15:05:38 +0000 (GMT)
From:   Ohhoon Kwon <ohoono.kwon@samsung.com>
To:     david@redhat.com, ohoono.kwon@samsung.com,
        akpm@linux-foundation.org, mhocko@suse.com
Cc:     bhe@redhat.com, rppt@linux.ibm.com, ohkwon1043@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] mm: sparse: remove __section_nr() function
Date:   Thu,  8 Jul 2021 00:02:09 +0900
Message-Id: <20210707150212.855-1-ohoono.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmnu7hQ08TDFYcYrWYs34Nm8X5B7/Y
        LL6u/8VscXnXHDaLe2v+s1rc73Ow2Lvf12LXzxXMFjemNLA5cHrsnHWX3WPTp0nsHidm/Gbx
        mLDoAKPH+31X2Tz6tqxi9Fi/5SqLx+dNcgEcUTk2GamJKalFCql5yfkpmXnptkrewfHO8aZm
        Boa6hpYW5koKeYm5qbZKLj4Bum6ZOUDXKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVIL
        UnIKDA0K9IoTc4tL89L1kvNzrQwNDIxMgSoTcjI2zfvCXPCRreLjxUcsDYwfWLoYOTkkBEwk
        Dk1ZwwxiCwnsYJQ4PcWni5ELyP7EKHHpx2NWCOczo8T3ma/ZYDouv3zBApHYxSjx4vQrVriW
        u08+MoJUsQloS+zvPQE2V0QgWmL21Q4mEJtZoECiof8T2G5hASeJ95vOAdVzcLAIqEpM7ZUH
        CfMKWEmsX/2PCWKZvMTqDQeYQeZLCJxjl1j0pZ8VIuEisWzrdagfhCVeHd/CDmFLSbzsb2OH
        aOhnlDjUt50VwpnAKLG+q5EdZJuEgL3E+0sWICazgKbE+l36EL2KEjt/z2WEuJNP4t3XHlaI
        al6JjjYhCFNVYtlvD4hqaYm+6ZehYeIhcXlSLzQUYyUWrf3OMoFRdhbC/AWMjKsYxVILinPT
        U4sNC0yQ42gTIzjBaVnsYJz79oPeIUYmDsZDjBIczEoivIwOTxOEeFMSK6tSi/Lji0pzUosP
        MZoCg2sis5Rocj4wxeaVxBuaGhkbG1uYmJmbmRorifPuZDuUICSQnliSmp2aWpBaBNPHxMEp
        1cDk7q+jllNztYZNxkf98Tf2s2yK5wzWW6+aM93dMel4du3BW5ZmVw99U+Wqrmn6Mfeyi1/I
        lpnLHzF7b52y+bT1Rc4HNV+/HJ21fMLpI59O/Z63pN4vrsZ1/02dN1c7u7+znQyq2Nvi+tx4
        /YpZ77h/Mm2WX7RhZfTf3aYHZ9l8VGqpu67zu7b5rrWD0/vsqBezAhVzxbu3RG8xvflkpb7e
        sf95jsp2oWsP7k1lE7gb/yJ08bnJDvyr85fsmrvwVJluiP/pnuIUKdF97BeXnxT0fHOhui9B
        K+nO4+2mcUnWgWrarBcl+6/n3t21UnziQs3zmS/cRDiF1vnO4Eufqh1VE9PLw/n885fIrFsn
        G1WfKLEUZyQaajEXFScCACbhEUb5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsWy7bCSvO6hQ08TDPZ/1bKYs34Nm8X5B7/Y
        LL6u/8VscXnXHDaLe2v+s1rc73Ow2Lvf12LXzxXMFjemNLA5cHrsnHWX3WPTp0nsHidm/Gbx
        mLDoAKPH+31X2Tz6tqxi9Fi/5SqLx+dNcgEcUVw2Kak5mWWpRfp2CVwZm+Z9YS74yFbx8eIj
        lgbGDyxdjJwcEgImEpdfvgCyuTiEBHYwSlx78JgdIiEt8fTFLqAEB5AtLHH4cDFEzQdGifZ5
        r5hBatgEtCX2955gBqkREYiXmH8NrJVZoEzi6sq/rCC2sICTxPtN5xhBSlgEVCWm9sqDhHkF
        rCTWr/7HBLFJXmL1hgPMExh5FjAyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA43
        La0djHtWfdA7xMjEwXiIUYKDWUmEl9HhaYIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OF
        BNITS1KzU1MLUotgskwcnFINTBmL3/ZcT87h88nJYigzihS4sKSVeeLR/66aOodPvsk+499w
        J8Ks+ELjWg+3UP20mFfb+DunFe9n7XTqTUyZttuuUvmcYW/rOednv8U2S832fN/crr1eKUC7
        j3Wz6E+/q1tOTv58bWkOU/59Ty+xFeszuJK/Ldb+cH3aJ6a6lYfjWyJfX38o/Ir/SPMS2Qn6
        R6YXvGE2EwpQl339zepMZeKtV4cv3/uz6Bkb/z8GLZcuTbl3h9Snqno07Ey1To5nWjBfYeve
        oGXV27VlvYvkvq+X++FUKa2wzf1fhP/8JUar9kllzWq+/NSxzsPxhMHv/JQFpae7bPY1uRmc
        Wl9un5W8Tu5TDlNKsOXnv1PWKrEUZyQaajEXFScCAI2N8UOmAgAA
X-CMS-MailID: 20210707150538epcas1p35450f5b6058e2ea9e06446f10d9bf662
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210707150538epcas1p35450f5b6058e2ea9e06446f10d9bf662
References: <CGME20210707150538epcas1p35450f5b6058e2ea9e06446f10d9bf662@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains cleanups to remove __section_nr().

In contrast to v1, there were some modifications on commit messages
In contrast to v2, [PATCH 1/3] has been updated to pass section_nr as
well as mem_section, as Michal suggested.

Also, I appended acked-by's and reviewed-by's from the initial mailing
list for convenience.

Ohhoon Kwon (3):
  mm: sparse: pass section_nr to section_mark_present
  mm: sparse: pass section_nr to find_memory_block
  mm: sparse: remove __section_nr() function

 .../platforms/pseries/hotplug-memory.c        |  4 +--
 drivers/base/memory.c                         |  4 +--
 include/linux/memory.h                        |  2 +-
 include/linux/mmzone.h                        |  1 -
 mm/sparse.c                                   | 35 +++----------------
 5 files changed, 8 insertions(+), 38 deletions(-)

-- 
2.17.1

