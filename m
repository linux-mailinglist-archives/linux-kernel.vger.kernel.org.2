Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E2B377EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhEJIzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:55:39 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:47439 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhEJIzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:55:35 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210510085429epoutp0387d9f9a16439a9af3f8fbf913befd929~9qKV1WhPt0563305633epoutp03I
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 08:54:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210510085429epoutp0387d9f9a16439a9af3f8fbf913befd929~9qKV1WhPt0563305633epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620636869;
        bh=AAbwIBgFEEfh/sqOv6OyskOU8JBhKsZ1g1ZiN2jF3Y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htXlxdl8nCoTKxYoHc5nUhJP2GpAgTjGaFrMep2h39N/NUFn9UaP0yY1lYMQpXD1V
         trUTONLMPtAuObXAV06cAVOR+3OsdIGvXZDUKsPtsw8UGhDDbpLWcLxGVWH5BRipx5
         ZXPLFbmgRO3cCwqKEHL+53nBCJQuXoSWVqVuZ5E4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210510085429epcas1p12d74019b0baad7c181b64c86435b993e~9qKVgIWXJ1786517865epcas1p1r;
        Mon, 10 May 2021 08:54:29 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FdvxY6gXlz4x9Q2; Mon, 10 May
        2021 08:54:25 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.1A.09824.BB4F8906; Mon, 10 May 2021 17:54:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210510085419epcas1p3e72ea9d956bcf811167b14e06fb08149~9qKMPKGp92011620116epcas1p3C;
        Mon, 10 May 2021 08:54:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210510085419epsmtrp1858a1f6a4d3bac50d694727cdfee083b~9qKMOhU4A2318223182epsmtrp1I;
        Mon, 10 May 2021 08:54:19 +0000 (GMT)
X-AuditID: b6c32a37-061ff70000002660-a6-6098f4bb3e9f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.DA.08637.BB4F8906; Mon, 10 May 2021 17:54:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.223]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210510085418epsmtip183eaaeb37b3eaf8a503223b56a15da87~9qKL_MZPD3199731997epsmtip1s;
        Mon, 10 May 2021 08:54:18 +0000 (GMT)
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
To:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, chao@kernel.org,
        sw0312.kim@samsung.com
Subject: [PATCH 2/2] dump.f2fs: fix memory leak caused by dump_node_blk()
Date:   Mon, 10 May 2021 17:57:26 +0900
Message-Id: <20210510085726.12663-2-sw0312.kim@samsung.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20210510085726.12663-1-sw0312.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmge7uLzMSDP60alqcnnqWyeLJ+lnM
        FpcWuVtc3jWHzWLG5JdsDqwem1Z1snnsXvCZyaNvyypGj8+b5AJYorJtMlITU1KLFFLzkvNT
        MvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DWKimUJeaUAoUCEouLlfTtbIry
        S0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyMw4fnsxcMIu14uiWL2wN
        jH+Zuxg5OSQETCTePfjN0sXIxSEksINR4t/SfkYI5xOjxPJ7t6Ey3xgl5q6YxgLTsrj3ABtE
        Yi+jxLRdf1ghnC+MEouWTmIEqWIT0JHYv+Q3K4gtImAnMePCMaAODg5mAU+JBZMiQMLCQObW
        fZeZQMIsAqoSh45Vg4R5Bawlbn1pZ4TYJS9xYcMtVpASTgEbiZe7jSFKBCVOznwCdg4zUEnz
        1tnMIBdICJxjl7i15zsrRK+LROeaa1BvCku8Or6FHcKWknjZ38YO0dDMKLF0yS8WCKeHUWLO
        ottQ3cYS+5dOZoK4WVNi/S59iLCixM7fcxkhNvNJvPvaA3achACvREebEESJisTOo5PYIMJS
        ErM2BEOEPSQm3F/LBAmpfkaJD/e/ME1gVJiF5J9ZSP6ZhbB4ASPzKkax1ILi3PTUYsMCY+QI
        3sQIToVa5jsYp739oHeIkYmD8RCjBAezkgivaMe0BCHelMTKqtSi/Pii0pzU4kOMpsCwnsgs
        JZqcD0zGeSXxhqZGxsbGFiaGZqaGhkrivOnO1QlCAumJJanZqakFqUUwfUwcnFINTNdnCSr8
        stzy8e7qT2fNy5bGs8y+etUkoS+h7kHyT7YAvvcai425NYU9q+TUV7PKFUzR69Vee7jFliH3
        rPyBhn+BLaIOYkcnHXqgop67y2f90tQ1c6sf2kz+t/xol8pae5YHjSY9xwQnBrrqTnuro+7a
        w5Po+fRx++yo0+H7r2hMUykuPqm61cmuVuKhFoO93pub216oMZkX/9nTvmGZNU/GbrspUxe9
        MYoLUpSp5VZvt5nKGaurefjzExm12pIzjJc23DtiJ3go9IriS/4DKfN8GlUOHz/DtIuzyvH+
        wcIbihPMTM9ECogd9Zgr9qlkmt7/oyEuS2wnpvxeF7tnzublhbU79L0cnvkGXH2YrsRSnJFo
        qMVcVJwIAMnd00AOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWy7bCSnO7uLzMSDN4tZrE4PfUsk8WT9bOY
        LS4tcre4vGsOm8WMyS/ZHFg9Nq3qZPPYveAzk0ffllWMHp83yQWwRHHZpKTmZJalFunbJXBl
        HD48mblgFmvF0S1f2BoY/zJ3MXJySAiYSCzuPcDWxcjFISSwm1FiReNsqISUxNxv2xm7GDmA
        bGGJw4eLIWo+MUr86VzJAlLDJqAjsX/Jb1YQW0TAQWLFti1gcWYBX4lpT1eygdjCAp4SW/dd
        ZgKZwyKgKnHoWDVImFfAWuLWl3ZGiFXyEhc23GIFKeEUsJF4udsYJCwEVNLRtJcVolxQ4uTM
        J1DT5SWat85mnsAoMAtJahaS1AJGplWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMEB
        q6W5g3H7qg96hxiZOBgPMUpwMCuJ8Ip2TEsQ4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8
        kEB6YklqdmpqQWoRTJaJg1OqgUmxaVYfZ3mtsvqiTaF7z+a1/HjVVnGh0rPzUbD1YyWLUt2c
        pVPeK2jUT/9+N4fpQAGDn5Zr1StxrhMyTu+dHW/puuVWhXDa9N56WWZj9Fm3Z2/l5WXsrb0X
        0i9HLVuQkWA3gWlh1cXqCXlMs7gUn/TO7WWKFk2bwVR4vtqtY0P+jvknZj1WZpTQP/UwpvC/
        gXaq07OwNVMl7nwr2HVpZ8BxIUf1x1HBpwIVDzPHFx4KvM33sX5v1FzNr+orKqZfFy+t69/E
        7l+fHN8Yp2XkfD97rvZs//LK7JvcPyLyc69/Pp2ZY/FfXY93idbSutMzlS5tD/nyOKZttZrn
        pmVMH5lZLqlb9kQKFLHsK6pWYinOSDTUYi4qTgQABHEAZscCAAA=
X-CMS-MailID: 20210510085419epcas1p3e72ea9d956bcf811167b14e06fb08149
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210510085419epcas1p3e72ea9d956bcf811167b14e06fb08149
References: <20210510085726.12663-1-sw0312.kim@samsung.com>
        <CGME20210510085419epcas1p3e72ea9d956bcf811167b14e06fb08149@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to free node_blk when nid is 0 from dump_node_blk().

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 fsck/dump.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 055ce09bb1cf..042a2e52edca 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -278,7 +278,7 @@ static void dump_node_blk(struct f2fs_sb_info *sbi, int ntype,
 
 	if (nid == 0) {
 		*ofs += skip;
-		return;
+		goto out;
 	}
 
 	for (i = 0; i < idx; i++, (*ofs)++) {
@@ -297,6 +297,7 @@ static void dump_node_blk(struct f2fs_sb_info *sbi, int ntype,
 			break;
 		}
 	}
+out:
 	free(node_blk);
 }
 
-- 
2.19.2

