Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738D13BE8AA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 15:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhGGNV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 09:21:26 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:58323 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhGGNVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 09:21:25 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210707131844epoutp03a30e5da5f073069cacd270f25d435bc1~PhLnXY3Sc0969109691epoutp03K
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 13:18:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210707131844epoutp03a30e5da5f073069cacd270f25d435bc1~PhLnXY3Sc0969109691epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625663924;
        bh=o8J92ZD56YfCR8PaYA5rtPLFRQykTx4po3v3n6n1PyE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=jimH0HW7tVQQYaPv/RJH7K+nAB7TGvVZ/JpnCNWf4GtJ7aFFQq5OouUoRrvVk6whH
         IvWTgAQ/Zl+ZVhRmbWurdA1kex5w4sBDV0U+hC7hdbu2Lta7g9rSZQXZQjOYvpUdF7
         +KSvZc9pVqDqxy7OjSliuI1/4qt7CufKSX9UkRlI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210707131843epcas1p1c7c774015daab437e5749e1c5c99844e~PhLmqEzCO3047330473epcas1p1p;
        Wed,  7 Jul 2021 13:18:43 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.160]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4GKg3k3Tjsz4x9Pq; Wed,  7 Jul
        2021 13:18:42 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.7B.09952.2B9A5E06; Wed,  7 Jul 2021 22:18:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210707131841epcas1p2697afbb9f3e6e8040cb12f2f867329db~PhLlDbedB0670706707epcas1p2g;
        Wed,  7 Jul 2021 13:18:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210707131841epsmtrp2df8f080be40aaaf1780eefa9d287ca3d~PhLlCq1gC1853018530epsmtrp2j;
        Wed,  7 Jul 2021 13:18:41 +0000 (GMT)
X-AuditID: b6c32a35-45dff700000026e0-cd-60e5a9b29fc9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.05.08394.1B9A5E06; Wed,  7 Jul 2021 22:18:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.78]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210707131841epsmtip22844c25a9a9b6f5348f6470cc4cca18b~PhLk1KsTj2143821438epsmtip2U;
        Wed,  7 Jul 2021 13:18:41 +0000 (GMT)
From:   Ohhoon Kwon <ohoono.kwon@samsung.com>
To:     david@redhat.com, ohoono.kwon@samsung.com,
        akpm@linux-foundation.org, mhocko@suse.com
Cc:     bhe@redhat.com, rppt@linux.ibm.com, ohkwon1043@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] mm: sparse: pass section_nr to section_mark_present
Date:   Wed,  7 Jul 2021 22:14:42 +0900
Message-Id: <20210707131443.6242-1-ohoono.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmru6mlU8TDJrf81nMWb+GzeL8g19s
        Fl/X/2K2uLxrDpvFvTX/WS3u9zlY7N3va7Hr5wpmixtTGtgcOD12zrrL7rHp0yR2jxMzfrN4
        TFh0gNHj/b6rbB59W1YxeqzfcpXF4/MmuQCOqBybjNTElNQihdS85PyUzLx0WyXv4HjneFMz
        A0NdQ0sLcyWFvMTcVFslF58AXbfMHKDrlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkF
        KTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJORn/L51iK5jEUtE7pYWtgXEBcxcjB4eEgInE
        88chXYxcHEICOxglXn5bzALhfGKUmHBjHSOE841R4tGVn0AOJ1jHrpkbWUBsIYG9jBL7r1RB
        2EAdy1okQGw2AW2J/b0nmEFsEYFoidlXO5hAbGaBAomG/k9gvcIC3hLvT65lAbmCRUBV4uP3
        ZJAwr4C1RO/rNywQq+QlVm84wAxyg4TAJXaJ4/fnQCVcJC58X8oKYQtLvDq+hR3ClpL4/G4v
        G0RDP6PEob7trBDOBEaJ9V2N7BA/20u8v2QBYjILaEqs36UP0asosfP3XEaIO/kk3n3tYYWo
        5pXoaBOCMFUllv32gKiWluibfpkNwvaQ2PD4MCMkFGIljrUsYJvAKDsLYf4CRsZVjGKpBcW5
        6anFhgWGyDG0iRGc3LRMdzBOfPtB7xAjEwfjIUYJDmYlEV5Gh6cJQrwpiZVVqUX58UWlOanF
        hxhNgcE1kVlKNDkfmF7zSuINTY2MjY0tTMzMzUyNlcR5d7IdShASSE8sSc1OTS1ILYLpY+Lg
        lGpgkrj3PzVl6lV5kU0Nexb+PfVlT8gxuwifosmpq+49XxdqvNPPqmFjh0Kc11mPDxU9Z0/b
        H46Ut7nwa41RmqX2r7Uu9Q/UTfekLbDiuVJ2tWxdguTdbyqhExWNJSKuXJsvUMTQ3GWsw5ot
        dOtR5+qnPllV724tEfjOG/l/u3fx/eWCahs+l2S7KK0VmJM0N7pyzoq0UtU1/ic+iC4K22k4
        uUrN7bbC9AVH1XttWBQt35s6mHOcu808XWyXypsGbvba2S+sRR49PSOwWtTFvGGGxZn4590K
        19Mv2DPe59Ly3F5gIta9Za218cUjkR3vkq/m857S1F5fO/vgbHteueR6lwmqEX/P/FmbqZGy
        5HGSEktxRqKhFnNRcSIASz0+2fcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsWy7bCSvO7GlU8TDHa8ULOYs34Nm8X5B7/Y
        LL6u/8VscXnXHDaLe2v+s1rc73Ow2Lvf12LXzxXMFjemNLA5cHrsnHWX3WPTp0nsHidm/Gbx
        mLDoAKPH+31X2Tz6tqxi9Fi/5SqLx+dNcgEcUVw2Kak5mWWpRfp2CVwZ/y+dYiuYxFLRO6WF
        rYFxAXMXIyeHhICJxK6ZG1m6GLk4hAR2M0rM/97GCpGQlnj6YhdQggPIFpY4fLgYouYDo8Sa
        F3/BmtkEtCX2955gBqkREYiXmH+NHSTMLFAmcXXlX7AxwgLeEu9PrgUbwyKgKvHxezJImFfA
        WqL39RsWiE3yEqs3HGCewMizgJFhFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcLhp
        ae5g3L7qg94hRiYOxkOMEhzMSiK8jA5PE4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8k
        kJ5YkpqdmlqQWgSTZeLglGpg4mEO3f+D6f7DRz++L5++QXLSifdPrBg7hDLebDa6dEtV/31A
        yVa9C28dgotKnh39WpO/W5D5o3PGIXGJFQxaGesjps8y4dB6e99MyyxQ/401a8Zi9uj93zT6
        dIz2bjdR0Tu6TWPvqakHvym/5ZgbbzZxR2nJt7lbJr+fvfkY8wuhpUonpMv0Lev/iCrdevzG
        5onaV7NV7PsSdt29cMvShbvi8Nt2l+S3HU+vJl1luzZ3Tl3xvG0u/HHfjs5Inip/Zt7My0Ii
        jd0hsj/fSJxXerfoxWXnG80Te7pPv+96xmU5/eqlyfkBjcZdcYkRnxP+Xz+dyeykbtu33E1l
        tWqryI0XW9zOPDy/fsESk7NBT22VWIozEg21mIuKEwHS7neepgIAAA==
X-CMS-MailID: 20210707131841epcas1p2697afbb9f3e6e8040cb12f2f867329db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210707131841epcas1p2697afbb9f3e6e8040cb12f2f867329db
References: <CGME20210707131841epcas1p2697afbb9f3e6e8040cb12f2f867329db@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Michal.
I have updated my commit as suggested in your review feedback.
Please check if the change looks okay.

I temporarily separated the mail thread since re-sending mails for the full
patchset might seem as spam.

If you confirm, then I will merge this change with other patches and
re-send the full patchset again.

Thanks,
Ohhoon Kwon.

Ohhoon Kwon (1):
  mm: sparse: pass section_nr to section_mark_present

 mm/sparse.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.17.1

