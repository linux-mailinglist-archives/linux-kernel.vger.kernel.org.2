Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413AF3A94D4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhFPISk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:18:40 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:23071 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhFPISj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:18:39 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210616081632epoutp02083fe763cc305a817df556bada5ef4cf~JAgw7k-dz1853518535epoutp02M
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:16:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210616081632epoutp02083fe763cc305a817df556bada5ef4cf~JAgw7k-dz1853518535epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623831392;
        bh=pYjopewcdd+GpDtSo3CBBThAVcz0Vd2tC6hm2ZcKYeM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Sgkg5fK1yHszwkPErb3tqX4X9m9Vs/06FR38Z20uGIrhrM40As3UwL/84EU+3ofM5
         d8WyvtfsaqqATe9CYXKh7kjBhBB59OJKqCUc42X34Q2foUlDGJXxof0YJ0JDPUoOwb
         cQ+1iGLZWeXXZDWJ+VA0iepRTLvymHwyb5BWa2U8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20210616081631epcas2p456f0557bbdbaf572f7928fc63029a9ed~JAgwNXj9E1821618216epcas2p4Q;
        Wed, 16 Jun 2021 08:16:31 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.185]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4G4dLj0237z4x9QC; Wed, 16 Jun
        2021 08:16:29 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.4C.09717.C53B9C06; Wed, 16 Jun 2021 17:16:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20210616081628epcas2p3f919d10029cbe01efa1212a5b861af38~JAgtUBAEW1349313493epcas2p3W;
        Wed, 16 Jun 2021 08:16:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210616081628epsmtrp19caf06cb4a1327fcdd94c359d09fe6bf~JAgtTMRLw0114301143epsmtrp1U;
        Wed, 16 Jun 2021 08:16:28 +0000 (GMT)
X-AuditID: b6c32a48-4fbff700000025f5-51-60c9b35cb879
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.7A.08637.C53B9C06; Wed, 16 Jun 2021 17:16:28 +0900 (KST)
Received: from Dabang.dsn.sec.samsung.com (unknown [12.36.155.59]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210616081628epsmtip15d2c763f2fd9569597ff8e868dd2a75f~JAgtH4yMN1824718247epsmtip15;
        Wed, 16 Jun 2021 08:16:28 +0000 (GMT)
From:   Janghyuck Kim <janghyuck.kim@samsung.com>
Cc:     janghyuck.kim@samsung.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Atish Patra <atish.patra@wdc.com>,
        Gavin Shan <gshan@redhat.com>,
        Zhengyuan Liu <liuzhengyuan@tj.kylinos.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/2] mm: support fastpath if NUMA is enabled with numa off
Date:   Wed, 16 Jun 2021 17:37:41 +0900
Message-Id: <20210616083745.14288-1-janghyuck.kim@samsung.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmmW7M5pMJBle3WlrMWb+GzWLRiu8s
        Fu+X9TBavNy1jcli85xii02Pr7FaXN41h83i3pr/rBarn5xjtdi6cR2jRcsdUwdujzXz1jB6
        LNhU6rFpVSebx6ZPk9g9Tsz4zeKxeUm9x/t9V9k8+rasYvQ4dOAGq8fnTXIe7Qe6mQK4o3Js
        MlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4COVlIoS8wp
        BQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUGBoW6BUn5haX5qXrJefnWhkaGBiZAlUm5GSs
        3fOTveAib8X0xU9ZGhjXcXcxcnJICJhInFy+i7WLkYtDSGAHo8Sh62cYIZxPjBKLJ91ignC+
        MUos3zeNHablbMdMdojEXkaJAytOQvV/Z5TYt2cxE0gVm4C+RPvUy2AdIgIsEiu/f2cBKWIW
        6GWWOLpkJliRsICXxKkNO8GKWARUJa59PssMYvMK2ElM2fOJGWKdvMTT3uVQcUGJkzOfsIDY
        zEDx5q2zmUGGSghM5JBYdXoSVIOLxJqz/SwQtrDEq+NboO6WknjZ3wZl10vcX/KCHaJ5AtAP
        S5ZBNRtLzHrWDgwCDqANmhLrd+mDmBICyhJHbkHt5ZPoOPyXHSLMK9HRJgTRqC7xbuYmJoiw
        rMT1P+YQYQ+JT0s6wDqFBGIlZja9Zp/AKD8LyTOzkDwzC2HtAkbmVYxiqQXFuempxUYFJsix
        uokRnHK1PHYwzn77Qe8QIxMH4yFGCQ5mJRFe3eITCUK8KYmVValF+fFFpTmpxYcYTYHBO5FZ
        SjQ5H5j080riDU2NzMwMLE0tTM2MLJTEeTnYDyUICaQnlqRmp6YWpBbB9DFxcEo1MOksTl42
        v70g5eb9PXeFXXn+a3+UaXFlXPmo9PetY43SucqvuR9GmVRwNLRGVLPLLnB2COba9+FeZMdW
        i9cFExYFqq0+/VZp3Z1lfWxtfWxK7WLLrm1k6X6+vsxVY1J68X2HBa1295KaJP7K3WW72cRc
        OcFJ61asG7/ahl2GPasL637Ov1zKel7u0N68YpV6zUkuD6PKzuY4Vvkfypaf9J9Z+1m+pnnE
        pjydkKsPefbNeuVQcDzxXYJS8cS6twdL363vkRFUYTo8aZreouVrNr/OZDkxJ0T22tJn5epK
        26xmzHzSOteWRUk98/FUbnOlpspPe29YRoV9tVG8e3jXptNzyptLA1tSOTgUtVf1K7EUZyQa
        ajEXFScCADtOtIRCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSnG7M5pMJBmee81rMWb+GzWLRiu8s
        Fu+X9TBavNy1jcli85xii02Pr7FaXN41h83i3pr/rBarn5xjtdi6cR2jRcsdUwdujzXz1jB6
        LNhU6rFpVSebx6ZPk9g9Tsz4zeKxeUm9x/t9V9k8+rasYvQ4dOAGq8fnTXIe7Qe6mQK4o7hs
        UlJzMstSi/TtErgy1u75yV5wkbdi+uKnLA2M67i7GDk5JARMJM52zGTvYuTiEBLYzShxYfYL
        JoiErETPik3MELawxP2WI6wQRV8ZJb7camAHSbAJ6Eu0T70MZosIsEis/P6dBaSIWWA6s8SE
        la/AuoUFvCRObdgJVsQioCpx7fNZsDivgJ3ElD2foDbISzztXQ4VF5Q4OfMJC4jNDBRv3jqb
        eQIj3ywkqVlIUgsYmVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgRHgZbmDsbtqz7o
        HWJk4mA8xCjBwawkwqtbfCJBiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2amp
        BalFMFkmDk6pBqYCqSm1+nUNwRG/je48nLB+zZK6fJMS/xPC7vtLl1UqmP9c6mQwb7OyzZ/A
        /FyHQwvyz+9zspy5tvDBxRNW8a3nJqacevtBpH/GlBDbhoC9bUdDWf/kNjKxq9669YfX78kr
        LZFKwZoHdXL3P7klbS8TDzz15e2k8GuTtr+pX1DUz174W+6muv+Sllr+LNl1W/Jmeh5hPVLD
        +C5Bqf7SqbmXrVxLpQMX3rR2kPv/iU3dk+nQ7OKL76XPzZjUIauSw/rto+sxmxCjrRcKV0xv
        f1Zosv6aluLUR08cE461LJ19pLt+71bLK4zXO7kdrKqWbJ4uWu8u//qCSVrjfR7P6TOnzvtt
        fmdi7M/K2A2ld5OUWIozEg21mIuKEwHDFHgx8QIAAA==
X-CMS-MailID: 20210616081628epcas2p3f919d10029cbe01efa1212a5b861af38
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210616081628epcas2p3f919d10029cbe01efa1212a5b861af38
References: <CGME20210616081628epcas2p3f919d10029cbe01efa1212a5b861af38@epcas2p3.samsung.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architecture might support fake node when CONFIG_NUMA is enabled but any
node settings were supported by ACPI or device tree. In this case,
getting memory policy during memory allocation path is meaningless.

Moreover, performance degradation was observed in the minor page fault
test, which is provided by (https://lkml.org/lkml/2006/8/29/294).
Average faults/sec of enabling NUMA with fake node was 5~6 % worse than
disabling NUMA. To reduce this performance regression, fastpath is
introduced. fastpath can skip the memory policy checking if NUMA is
enabled but it uses fake node. If architecture doesn't support fake
node, fastpath affects nothing for memory allocation path.

Signed-off-by: Janghyuck Kim <janghyuck.kim@samsung.com>
---
 mm/internal.h  | 4 ++++
 mm/mempolicy.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index 31ff935b2547..3b6c21814fbc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -36,6 +36,10 @@ void page_writeback_init(void);
 
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 
+#ifndef numa_off_fastpath
+#define numa_off_fastpath()	false
+#endif
+
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 		unsigned long floor, unsigned long ceiling);
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e32360e90274..21156671d941 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2152,6 +2152,9 @@ struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 	int preferred_nid;
 	nodemask_t *nmask;
 
+	if (numa_off_fastpath())
+		return __alloc_pages_nodemask(gfp, order, 0, NULL);
+
 	pol = get_vma_policy(vma, addr);
 
 	if (pol->mode == MPOL_INTERLEAVE) {
-- 
2.28.0

