Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A9E37642C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhEGLBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 07:01:43 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:59919 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhEGLBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 07:01:42 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210507110041epoutp04459deae52e97297ee6f3e1850a086677~8w8rJxB4N0892608926epoutp04a
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 11:00:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210507110041epoutp04459deae52e97297ee6f3e1850a086677~8w8rJxB4N0892608926epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620385241;
        bh=l2PO2O1mNCyWTDvw4ULpOWi9veFuk56983ljENJwuV8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=co8e7MY0jb9ABLItQKk0eR7YHIW1CZOGOEIfbZnvH2QkiV+UDM2qK7MlSUtiywMgh
         2L/HEuWX7QlKoQH9Y9U0Vj+o3hsOwEj+O3j8n4DuvB4XfX6NcYXq9ld+DZiwzDGO4s
         Df+6aZ2WubW5DFugGh5G+CNkXKJ6xsktfmG2eftA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210507110040epcas1p19886113dccd83842829122df5bbccd07~8w8qdXJCb1649716497epcas1p1v;
        Fri,  7 May 2021 11:00:40 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Fc6tZ4mCXz4x9Pw; Fri,  7 May
        2021 11:00:38 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.E9.09701.6DD15906; Fri,  7 May 2021 20:00:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210507110037epcas1p4921563aaef2122e35118e77d1852652c~8w8nXON_p2591225912epcas1p4u;
        Fri,  7 May 2021 11:00:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210507110037epsmtrp25e1f4dc85c7d1ad7cf9f629a84733416~8w8nWiQDQ2429324293epsmtrp2f;
        Fri,  7 May 2021 11:00:37 +0000 (GMT)
X-AuditID: b6c32a36-647ff700000025e5-1c-60951dd654d2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.50.08637.5DD15906; Fri,  7 May 2021 20:00:37 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.223]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210507110037epsmtip13aa11e6aa2dfa5daeb6e8caee9af7d8d~8w8nEkduB0705007050epsmtip1G;
        Fri,  7 May 2021 11:00:37 +0000 (GMT)
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
To:     aegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, chao@kernel.org,
        sw0312.kim@samsung.com
Subject: [PATCH 1/2] resize.f2fs: fix memory leak caused by migrate_nat()
Date:   Fri,  7 May 2021 20:03:41 +0900
Message-Id: <20210507110342.29566-1-sw0312.kim@samsung.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmnu412akJBvOvqlpc+LmRyeL01LNM
        FpcWuVtc3jWHzWLG5JdsDqwem1Z1snnsXvCZyaNvyypGj8+b5AJYorJtMlITU1KLFFLzkvNT
        MvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DWKimUJeaUAoUCEouLlfTtbIry
        S0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyMw7uncBc8IalYsPdD8wN
        jD+Yuxg5OSQETCSmtl4Gs4UEdjBK3Onl6mLkArI/MUp8WNvPBOF8Y5T4fX87I0zH1wcfmSES
        exklHh1cDVX1hVHi48n3LCBVbAI6EvuX/GYFsUUEbCWW7z/G3sXIwcEs4CmxYFIESFgYyNx6
        cj07iM0ioCoxffUcJhCbV8BaonPzJnaIZfISFzbcYoWIC0qcnPkEbDwzULx562ywIyQEdrFL
        POk6CXWdi8Skuy0sELawxKvjW6AGSUl8freXDaKhmVFi6ZJfLBBOD6PEnEW3WSGqjCX2L53M
        BHGppsT6XfoQYUWJnb/nMkJs5pN497WHFaREQoBXoqNNCKJERWLn0UlsEGEpiVkbgiHCHhKt
        p56ygISFBGIllmxUnMAoPwvJN7OQfDMLYe0CRuZVjGKpBcW56anFhgVGyHG6iRGc8LTMdjBO
        evtB7xAjEwfjIUYJDmYlEd7TiyYnCPGmJFZWpRblxxeV5qQWH2I0BYbvRGYp0eR8YMrNK4k3
        NDUyNja2MDE0MzU0VBLnTXeuThASSE8sSc1OTS1ILYLpY+LglGpgmnPfh+ewj+TzbUJSPMFK
        7B0rGdRSj2wqyX+xb8rCkDUnbbqq5z9nla5kirl3yu1tY7Clg3Y9Wzubw+bA+Y6KD647WWqc
        qpw5rSVonUHTOckKAa/ri1zepCt1rmpkuRzeLFnW8pqzQedr9CcDtv2xF5c+Ki5OnfRUIObY
        yZIuHudYgeLJHZOz/socqZzhXH6dI/ZLYPL/yC17TYxO77pUcGuHWtdZO4dN1znSviT6rt1o
        mJ/p5PoivODlp7Wf5tdvrv82eYJatNcsjvI/b3j27n6SNvW37uIVjCavxeoyP/FfZbzGXPNW
        TH73a2mD2cYy89zseS9xBj1ZJ/m8rItJxcxIdW1gp2FxvVdz+20lluKMREMt5qLiRAA/16xx
        AQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsWy7bCSnO5V2akJBqebpC0u/NzIZHF66lkm
        i0uL3C0u75rDZjFj8ks2B1aPTas62Tx2L/jM5NG3ZRWjx+dNcgEsUVw2Kak5mWWpRfp2CVwZ
        B/dOYC54w1Kx4e4H5gbGH8xdjJwcEgImEl8ffASyuTiEBHYzSsy4cZAdIiElMffbdsYuRg4g
        W1ji8OFiiJpPjBJTOq6BNbMJ6EjsX/KbFcQWEbCX+Lr5LyOIzSzgKzHt6Uo2EFtYwFNi68n1
        YDNZBFQlpq+ewwRi8wpYS3Ru3gS1S17iwoZbrBBxQYmTM5+wQMyRl2jeOpt5AiPfLCSpWUhS
        CxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBAehluYOxu2rPugdYmTiYDzEKMHB
        rCTCe3rR5AQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUa
        mIIWcrqtvap+Z8W93zzBnQX/1G4/ffZS3CrgTrxLGu8a7/5NAnId7PVd2sWZ06aed8i5UFwX
        W665rah58sxbO1f9+eezm0l7hbHhguR/OwqKaqYyyjNuMH8vyntrzXyOp+GW/p1+WwKeGsXl
        e/6JnV0S8bNxAdNZJ5/XQU2nX6+0ed/x/Vr1F/3NM+66eupEr5uy/UsBm8f0vSclfvxm5WhX
        P9Z456RE6LfveR9fvbQ78Njjia7zxui4DQc5VX1/6e4y+D0nj2+qS1Ru6XLvHuUtjzz+3ug+
        tVWz7UHDwb5vZbOeTrrpqnXjVzn/z3Lf7bGZzm/qz+TEhxhcv1Bxa++O2rm8wavmM03eMNk1
        nFWJpTgj0VCLuag4EQAkbr3IsQIAAA==
X-CMS-MailID: 20210507110037epcas1p4921563aaef2122e35118e77d1852652c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210507110037epcas1p4921563aaef2122e35118e77d1852652c
References: <CGME20210507110037epcas1p4921563aaef2122e35118e77d1852652c@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alloced nat_block doesn't freed from migrate_nat(). Fix to free
nat_block.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 fsck/resize.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck/resize.c b/fsck/resize.c
index b043cd984dc6..78d578ec2cc1 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -383,6 +383,7 @@ static void migrate_nat(struct f2fs_sb_info *sbi,
 		ASSERT(ret >= 0);
 		DBG(3, "Write NAT: %lx\n", block_addr);
 	}
+	free(nat_block);
 	DBG(0, "Info: Done to migrate NAT blocks: nat_blkaddr = 0x%x -> 0x%x\n",
 			old_nat_blkaddr, new_nat_blkaddr);
 }
-- 
2.19.2

