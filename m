Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7603B3A94D5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhFPISs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:18:48 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:29310 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhFPISn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:18:43 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210616081635epoutp01f44f52e512014930a8873e89043218eb~JAgz6dbkb2899528995epoutp01N
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:16:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210616081635epoutp01f44f52e512014930a8873e89043218eb~JAgz6dbkb2899528995epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623831395;
        bh=Wjgxu9Mdz8rE2HMaZLgf7AvA24jsz0YnoESyLc9nyMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2YZq6rzY6ZyRsW1+8eGquL0neQGNqGRc8aEwiJqCk2huWRNf2vFx4AF75bnW2AE9
         ET7Q33epah8+BFdLq5/0VjKxznA2D+hsYIVsNUFnwVIktxg0R7MP/38agKbmth9lUH
         ZUMFjtFOcpkRFp6zPe3Fzy/7slRgdq5iqm49bFSc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20210616081634epcas2p4eafd15a8b7e3e9e291e7c9b6bed5d26f~JAgzUYLPW1472814728epcas2p4H;
        Wed, 16 Jun 2021 08:16:34 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.191]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4G4dLn0yn6z4x9Pr; Wed, 16 Jun
        2021 08:16:33 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.D3.09694.063B9C06; Wed, 16 Jun 2021 17:16:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20210616081632epcas2p46436c362f3d97c9c1fb09dbb11d64ad7~JAgxRhC9g1213112131epcas2p4N;
        Wed, 16 Jun 2021 08:16:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210616081632epsmtrp2ec4a75c48ffa1c612228aa6686836aca~JAgxQcT2M0773607736epsmtrp2I;
        Wed, 16 Jun 2021 08:16:32 +0000 (GMT)
X-AuditID: b6c32a46-e17ff700000025de-ba-60c9b360c417
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.7A.08637.063B9C06; Wed, 16 Jun 2021 17:16:32 +0900 (KST)
Received: from Dabang.dsn.sec.samsung.com (unknown [12.36.155.59]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210616081632epsmtip1ad0fc206d666af9a8ff9ca2a2a954039~JAgxB3P2d1931319313epsmtip1T;
        Wed, 16 Jun 2021 08:16:32 +0000 (GMT)
From:   Janghyuck Kim <janghyuck.kim@samsung.com>
Cc:     janghyuck.kim@samsung.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Atish Patra <atish.patra@wdc.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Zhengyuan Liu <liuzhengyuan@tj.kylinos.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 2/2] arm64: numa: support numa_off_fastpath
Date:   Wed, 16 Jun 2021 17:37:42 +0900
Message-Id: <20210616083745.14288-2-janghyuck.kim@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210616083745.14288-1-janghyuck.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmhW7i5pMJBvf6mS3mrF/DZrFoxXcW
        i/fLehgtNs8ptli18BqbxabH11gtLu+aw2Zxb81/VovVT86xWmzduI7RouWOqQO3x5p5axg9
        Fmwq9Wg58pbVY9OqTjaPTZ8msXucmPGbxWPzknqPvi2rGD0OHbjB6vF5k5xH+4FupgDuqByb
        jNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCjlRTKEnNK
        gUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhoYFesWJucWleel6yfm5VoYGBkamQJUJORk/
        u9azFTxjrdj55TZbA+Nnli5GTg4JAROJxhuvgWwuDiGBHYwSbddmsEE4nxglWp6tZ4dwvjFK
        LPr9hxGm5eztU8wQib2MElsu/4RyvjNK/NjZywpSxSagL9E+9TI7iC0iwCKx8vt3sCXMAguY
        JRY9/gqU4OAQFrCW2PlbA6SGRUBV4sDeRrB6XgE7iTe/VrFCbJOXeNq7nBnE5hSwl/i/5z0b
        RI2gxMmZT8CeYAaqad46G+wICYG1HBJ919+xQzS7SKyZ8h7KFpZ4dXwLlC0l8fndXjYIu17i
        /pIX7BDNExglDixZxgyRMJaY9aydEeRQZgFNifW79EFMCQFliSO3oPbySXQc/ssOEeaV6GgT
        gmhUl3g3cxMTRFhW4vofc4iwh8SWW5dZIUE1iVHi14ZjTBMYFWYh+WYWkm9mIexdwMi8ilEs
        taA4Nz212KjACDmGNzGCU7GW2w7GKW8/6B1iZOJgPMQowcGsJMKrW3wiQYg3JbGyKrUoP76o
        NCe1+BCjKTCsJzJLiSbnA7NBXkm8oamRmZmBpamFqZmRhZI4Lwf7oQQhgfTEktTs1NSC1CKY
        PiYOTqkGppO5WzSevpjzcrHBVp7v2879vLay5eM/ptYNEUqsE9KPzuZaWz7hSXWH7LTYz1uS
        V1m0vY6Ya3dpTWEj98JdQkqdzwPlft79UJBz8jSvnPD2/iKvB03bLm7NnXSvyu5Tloyih3fz
        ND6T7ueKzoJW0xoagrQ3NyRaxXJse1n/6U65fk1WbdL+KKOH/p/Mtqke/T1TulH1n+QEb5mv
        x2Q98rknTYlkfpt3ymx55uy5F4J4rpxeEML/fdX7Tx9FZde/KXgp+4DV1/nDPfYn9RL7XK01
        xJpVrjtwNez7dqXR+5XQ/fd7L7V93dj/bTufgerHnbeeRazY8LprtnXs9Xk+WdqGEWeOLNo9
        x1R1l6dIqqoSS3FGoqEWc1FxIgCIY06mTgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSnG7C5pMJBv1dMhZz1q9hs1i04juL
        xftlPYwWm+cUW6xaeI3NYtPja6wWl3fNYbO4t+Y/q8XqJ+dYLbZuXMdo0XLH1IHbY828NYwe
        CzaVerQcecvqsWlVJ5vHpk+T2D1OzPjN4rF5Sb1H35ZVjB6HDtxg9fi8Sc6j/UA3UwB3FJdN
        SmpOZllqkb5dAlfGz671bAXPWCt2frnN1sD4maWLkZNDQsBE4uztU8xdjFwcQgK7GSV6Z+9j
        hEjISvSs2MQMYQtL3G85wgpR9JVRYu232+wgCTYBfYn2qZfBbBEBFomV37+zgBQxC6xgllg4
        eRNbFyMHh7CAtcTO3xogNSwCqhIH9jaC1fMK2Em8+bWKFWKBvMTT3uVgyzgF7CX+73nPBmIL
        AdWsP/cHql5Q4uTMJ2BXMwPVN2+dzTyBUWAWktQsJKkFjEyrGCVTC4pz03OLDQsM81LL9YoT
        c4tL89L1kvNzNzGCY0ZLcwfj9lUf9A4xMnEwHmKU4GBWEuHVLT6RIMSbklhZlVqUH19UmpNa
        fIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAPT8ef3n39i2VEqtShhfUP1AXajBaY7
        WPmro3+5fHy67HbRh7QLszceMGf4XH93nZN62e1H/st8qn4c7bHo3TrpOdfdy30v5t+eGfPv
        R/kZq125fgt+XDo0u0RWZoaXvfI1He7c216uha4VF3qizQ/qS/6LUJ6Yr8l/lq3vjKCZV2FD
        YpNe+rGTahUGG9Mi9MxffW6teuiicuNp6/2W47tPsRZqXfd9z39ve+a1CwssluXmX1dI/5oy
        696i6C87mZ+dvLuiJeH74bvqX6YpRKmmrJye1Wh4/uE24cCurUrWlnfefc6rbZ14ln/KrWwL
        Fr4jnzwP9oduqV4fLugvLxDyXJbHO/NvvLlt1drYhG+rlViKMxINtZiLihMBJy+LRwgDAAA=
X-CMS-MailID: 20210616081632epcas2p46436c362f3d97c9c1fb09dbb11d64ad7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210616081632epcas2p46436c362f3d97c9c1fb09dbb11d64ad7
References: <20210616083745.14288-1-janghyuck.kim@samsung.com>
        <CGME20210616081632epcas2p46436c362f3d97c9c1fb09dbb11d64ad7@epcas2p4.samsung.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA can be disabled forcefully by command line, or no configurations
are provided. numa_off_fastpath can become true in this case to skip the
memory policy related process to reduce overhead.

Signed-off-by: Janghyuck Kim <janghyuck.kim@samsung.com>
---
 arch/arm64/include/asm/numa.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
index 8c8cf4297cc3..f7d4e0cb801b 100644
--- a/arch/arm64/include/asm/numa.h
+++ b/arch/arm64/include/asm/numa.h
@@ -5,4 +5,8 @@
 #include <asm/topology.h>
 #include <asm-generic/numa.h>
 
+#ifdef CONFIG_NUMA
+#define numa_off_fastpath()	numa_off
+#endif	/* CONFIG_NUMA */
+
 #endif	/* __ASM_NUMA_H */
-- 
2.28.0

