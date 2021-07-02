Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66C53B9E7C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 11:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhGBJrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 05:47:39 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:22653 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhGBJrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:47:32 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210702094458epoutp01cdcdd9c332a2d2520416634054e666d5~N8CjExBb-3018730187epoutp01K
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 09:44:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210702094458epoutp01cdcdd9c332a2d2520416634054e666d5~N8CjExBb-3018730187epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625219098;
        bh=bDbXixnB4Y0V53jA7IW56VMxaCwE42cipQ84atzG2dQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VMvWJAGSENBtkvzAAVOsyypKneloqtVJc1AYLPpljAPJm+hDP8Isb3hsoDPBveog9
         hAjVp1n7zUAXZFYI/zriiYcNAhQnIF9i+ThQ99PKEzi/qqrmG0TDzfZLcDdDPayPCU
         4F8yAX5/Jmw8elYl9ByAv+rPLjWlVC73fImA2kak=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210702094457epcas1p3b019b64667baa19ec91b557a383ac11f~N8Cip74Ea2802228022epcas1p3o;
        Fri,  2 Jul 2021 09:44:57 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GGVYP3Gb9z4x9Ps; Fri,  2 Jul
        2021 09:44:57 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.93.09551.910EED06; Fri,  2 Jul 2021 18:44:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210702094457epcas1p295611b5799befffd016b8fccf3adceff~N8ChvI25L0305903059epcas1p25;
        Fri,  2 Jul 2021 09:44:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210702094456epsmtrp1721a2dd275185c378eb037136aabbb45~N8ChuZWNb2300123001epsmtrp1M;
        Fri,  2 Jul 2021 09:44:56 +0000 (GMT)
X-AuditID: b6c32a36-2c9ff7000000254f-97-60dee0190181
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.69.08289.810EED06; Fri,  2 Jul 2021 18:44:56 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.78]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210702094456epsmtip18bc48ca8222b462155320c3df5a83408~N8ChdUmM70979009790epsmtip1X;
        Fri,  2 Jul 2021 09:44:56 +0000 (GMT)
From:   Ohhoon Kwon <ohoono.kwon@samsung.com>
To:     david@redhat.com, ohoono.kwon@samsung.com,
        akpm@linux-foundation.org, mhocko@suse.com
Cc:     bhe@redhat.com, rppt@linux.ibm.com, ohkwon1043@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mm: sparse: remove __section_nr() function
Date:   Fri,  2 Jul 2021 18:41:29 +0900
Message-Id: <20210702094132.6276-1-ohoono.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7bCmrq7kg3sJBluvilrMWb+GzeL8g19s
        Fl/X/2K2uLxrDpvFvTX/WS3u9zlY7N3va7Hr5wpmixtTGtgcOD12zrrL7rHp0yR2jxMzfrN4
        TFh0gNHj/b6rbB59W1YxeqzfcpXF4/MmuQCOqBybjNTElNQihdS85PyUzLx0WyXv4HjneFMz
        A0NdQ0sLcyWFvMTcVFslF58AXbfMHKDrlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkF
        KTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJORnPZ5xmK3jHUdHbldvAeJCti5GTQ0LAROLT
        3x72LkYuDiGBHYwS3ybdZwZJCAl8YpTYsyoBIvGZUeJPQxs7TMfz25eYIRK7GCUuNb5nhXCA
        Oh6vXMgCUsUmoC2xv/cE2CgRgWiJ2Vc7mEBsZoECiYb+T2A1wgL2EtNf3QSyOThYBFQlTnUw
        goR5BawlHj2YxQyxTF5i9YYDYMskBM6xSyw9dpoJIuEiMeFcI1SRsMSr41ugrpOSeNnfxg7R
        0M8ocahvOyuEM4FRYn1XIzvINgmgze8vWYCYzAKaEut36UP0Kkrs/D2XEeJOPol3X3tYIap5
        JTrahCBMVYllvz0gqqUl+qZfhoaih8TpbQtYIQEXK3Gh6wXbBEbZWQjzFzAyrmIUSy0ozk1P
        LTYsMEKOok2M4PSmZbaDcdLbD3qHGJk4GA8xSnAwK4nwhs67lyDEm5JYWZValB9fVJqTWnyI
        0RQYXBOZpUST84EJNq8k3tDUyNjY2MLEzNzM1FhJnHcn26EEIYH0xJLU7NTUgtQimD4mDk6p
        BibDWI++mQlP3f7lGN7RalgjMl+wu4vhBetsXrmf7g1x/5t7/G5+LtE89dP27vPadFaHHR2z
        OvxYpFTO9W/ZWedoErityn/mn3y+r9M2qH4ztfXWY5UqyYuPnfzX8QK/ztusAO7rq320xXW+
        8T7yl2N1n7glr2CPmR2//G+ZoI/VSl1L03ffbanKLS+8nX3wt0Phxw+zFkWnvKtVeS4QZzgx
        3mjy7meXZFgYQ2fYKOSzMsnNz51uWqzCc/Gy1JTH2z/7qSVWhX3JTMy7ntlo9niHstOPGKVU
        N0nOD39CGpKXb/LVbWo7FBUt6ffbuf/rtuvrNpz65P7tQgbjCtEXXB8PPpj0XmDKszVcjtxz
        lFiKMxINtZiLihMBXz0HLvgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsWy7bCSnK7Eg3sJBgv+GlvMWb+GzeL8g19s
        Fl/X/2K2uLxrDpvFvTX/WS3u9zlY7N3va7Hr5wpmixtTGtgcOD12zrrL7rHp0yR2jxMzfrN4
        TFh0gNHj/b6rbB59W1YxeqzfcpXF4/MmuQCOKC6blNSczLLUIn27BK6M5zNOsxW846jo7cpt
        YDzI1sXIySEhYCLx/PYlZhBbSGAHo8SjJRwQcWmJpy92sXQxcgDZwhKHDxd3MXIBlXxglGjZ
        uAesnk1AW2J/7wlmkBoRgXiJ+dfYQcLMAmUSV1f+ZQWxhQXsJaa/ugk2hkVAVeJUByNImFfA
        WuLRg1nMEJvkJVZvOMA8gZFnASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4FDT
        0trBuGfVB71DjEwcjIcYJTiYlUR4Q+fdSxDiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQ
        QHpiSWp2ampBahFMlomDU6qBaWr8yj/zksPDHY5rLrK+LXJK33/GO+6nMXLOkS8W5t0WuViQ
        OOPuX62TFnbFRjdiTnpkc0ev3/+oRYXNuzr8QTYbc+rWhH5frskH5ZylGPKr1OdHHeOvvFX4
        5Vkhr67CCsV/FxZJS6vnbHOt2J5Uzn9PTJ6fbaILx0TPV/V11SLnjE5dLf6VeHLDypPP31fI
        vp7IGN7lrHJfWKZ094YHwg+57F+0buKX+Lj35KMZ7sZRwXyRO+YaRQsE6hyb3+dUqxjQvuqk
        V/zU1J/yb2v7mhMvfyv1Z/yjoDdhe87+wkqThQ+SZ9/r48oTPWPLbOUcFsf6s21dtRHj34jE
        zz8XZZ4vT3voeVPLefKk28FKLMUZiYZazEXFiQCZLMz3pAIAAA==
X-CMS-MailID: 20210702094457epcas1p295611b5799befffd016b8fccf3adceff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210702094457epcas1p295611b5799befffd016b8fccf3adceff
References: <CGME20210702094457epcas1p295611b5799befffd016b8fccf3adceff@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains cleanups to remove __section_nr().

When CONFIG_SPARSEMEM_EXTREME is enabled, __section_nr() could be
costly since it iterates all section roots to check if the given
mem_section is in its range.

On the other hand, __nr_to_section which converts section_nr to
mem_section can be done in O(1).

The only users of __section_nr() was section_mark_present() and
find_memory_block().

PATCH 1 & 2 changes both functions to use section_nr instead of
mem_section.
PATCH 3 finally removes __section_nr() function.

More details can be found in each changelogs.

Ohhoon Kwon (3):
  mm: sparse: pass section_nr to section_mark_present
  mm: sparse: pass section_nr to find_memory_block
  mm: sparse: remove __section_nr() function

 .../platforms/pseries/hotplug-memory.c        |  4 +--
 drivers/base/memory.c                         |  4 +--
 include/linux/memory.h                        |  2 +-
 include/linux/mmzone.h                        |  1 -
 mm/sparse.c                                   | 35 +++----------------
 5 files changed, 9 insertions(+), 37 deletions(-)

-- 
2.17.1

