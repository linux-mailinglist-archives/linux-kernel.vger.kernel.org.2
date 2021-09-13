Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A30408878
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 11:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238797AbhIMJp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 05:45:26 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:14860 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbhIMJpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 05:45:25 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210913094407epoutp020faf09ee6298a255801ab627c513c803~kWHp0ig8G0710207102epoutp02j
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:44:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210913094407epoutp020faf09ee6298a255801ab627c513c803~kWHp0ig8G0710207102epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1631526248;
        bh=dCkXm4fHON7XUJPNUI+cVlMtUE/ue9QWsDVq7MHdEbc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ms639+wAW/6D5jkpn+2Dic09d6ZNdm4LRGmO7xq5U3yInSN6VEUafxqb2k84HO5Bf
         Wrmlqyl7GYwWHwlX/HBAyAxeNYrRI5ghz48x1i10J3YOCwmjzA90+Y8yUG00nmUYIm
         0hv+D5TlUNUNZDBLoOyRLGgqW7wGWSkozQrdLDHg=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210913094407epcas5p32dbf70e45b2d465cccb54ceb3873fdbf~kWHpNrMV40107101071epcas5p31;
        Mon, 13 Sep 2021 09:44:07 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.31.10367.76D1F316; Mon, 13 Sep 2021 18:44:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20210913085226epcas5p2b516f0f591926c927faa9c60d211bf44~kVahwUt9a2007120071epcas5p2S;
        Mon, 13 Sep 2021 08:52:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210913085226epsmtrp1a9a8a7e350d74bf7ee144e80196a0057~kVahvYZY30592005920epsmtrp1U;
        Mon, 13 Sep 2021 08:52:26 +0000 (GMT)
X-AuditID: b6c32a4a-b2dff7000000287f-c2-613f1d66401a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.D2.08750.A411F316; Mon, 13 Sep 2021 17:52:26 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210913085225epsmtip1c5e347883937e55138ca7dd5e64222a2~kVagRsGog3150331503epsmtip1Y;
        Mon, 13 Sep 2021 08:52:25 +0000 (GMT)
From:   Ravi Singh <ravi.singh1@samsung.com>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     a.sahrawat@samsung.com, v.narang@samsung.com,
        vishal.goel@samsung.com, Ravi Singh <ravi.singh1@samsung.com>
Subject: [PATCH] psi: fix integer overflow on unsigned int multiply on 32
 bit systems
Date:   Mon, 13 Sep 2021 14:21:35 +0530
Message-Id: <1631523095-8672-1-git-send-email-ravi.singh1@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsWy7bCmlm66rH2iwbd2AYuLu1MtVm/ytbi8
        aw6bxaUDC5gsjvceYLK4tIjF4tDJuYwW626fZnTg8Dj85j2zx+YVWh7v911l8+jbsorR4/Mm
        uQDWKC6blNSczLLUIn27BK6Ma6cvsRcc5ar48i6kgfECRxcjB4eEgIlE48ayLkYuDiGB3YwS
        q/YdYIVwPjFKNE/4wAbhfGaUONx/gamLkROsY+XZ34wQiV2MEo83wbR8YZToeLadHaSKTUBL
        4tHVP4wgtohAnMSDe7+ZQPYxCxRK7HlpBxIWFgiX+LX0NVgJi4CqxNKfv9lAbF4BN4nHf3pY
        IZbJSdw818kMMl9CYB27xM73F9khEi4SLxfdZ4OwhSVeHd8CFZeSeNnfBmVXS/T2bYVq7mCU
        2Np+BiphL/Hk4kJWiIM0Jdbv0ocIy0pMPbUO7EtmAT6J3t9PoD7mldgxD8ZWlfgxfT3UGGmJ
        xRc/QB3qIXH03WMwW0ggVmL70tXMExhlZyFsWMDIuIpRMrWgODc9tdi0wCgvtVyvODG3uDQv
        XS85P3cTIzjytbx2MD588EHvECMTB+MhRgkOZiUR3m1vbBOFeFMSK6tSi/Lji0pzUosPMUpz
        sCiJ8358bZkoJJCeWJKanZpakFoEk2Xi4JRqYOrI3p6znZtLTvv7jKDZKgrXU/g+77y8PHZ+
        k/KUw4uD/dYX/7qXPN8+fvs3rql5v4SqQiZwar/Zc7NaI//aon2nLQxMebvPbouU2nv1s5D5
        8kd79204cOzwjLc2G1cJZEz3N7LTv+iiInnylPuFhzd+X+PeKuiu5OJw4Fnmrypm/WVvClyT
        TayUw/u+fVRIVeiL4f8xN56febXhN4OcveeP9+alb811uThfiWlW0EuV9jbu7mgjgbUKLPXN
        8xXcF9jemdRntiNcyal4VvY09Ut3L0xkT4nMmNh2mPdIysE5lmzf7k7x/hZr+t2d58z98oqn
        b1yW/LO/d4nDfEXtAqMQ3lOry+RMsq6yrvQPDlZiKc5INNRiLipOBABpdEWAawMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPJMWRmVeSWpSXmKPExsWy7bCSnK6XoH2iwcnlRhYXd6darN7ka3F5
        1xw2i0sHFjBZHO89wGRxaRGLxaGTcxkt1t0+zejA4XH4zXtmj80rtDze77vK5tG3ZRWjx+dN
        cgGsUVw2Kak5mWWpRfp2CVwZ105fYi84ylXx5V1IA+MFji5GTg4JAROJlWd/M3YxcnEICexg
        lDj/9h47REJa4sqCxYwQtrDEyn/P2SGKPjFKnJ6wGayITUBL4tHVP2BFIgJJEkvu9LKA2MwC
        pRJnp59kBbGFBUIltpztBatnEVCVWPrzNxuIzSvgJvH4Tw8rxAI5iZvnOpknMPIsYGRYxSiZ
        WlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHEZaWjsY96z6oHeIkYmD8RCjBAezkgjvtje2
        iUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwnbJRM+LZ
        0L2s/NTy0zJvQ278K+V+aB34atsWlnsv1Sf9n8nT+bZ1Osfe3K7fTTuPC1U+vrv589al2X/n
        79zg0zkzReic5rYzXgz7fE89q1q22HWnaLX7qymH6xdqBen+OSyx+0yEjc4F1TNbTGMPq3RG
        SSbnxe9h+yftpr5m3pfDpkfKfjEdbJgsMX1ZhK5syKkM//wJESJNd98eX+U/Odb3dnV7Iq+w
        hE/cyrLZoZMij4sKsrDMqJULzZ7zjm/LV1Eus8/PWz8YX6v3XzrpwdFYy6smJf/X/M5hnbqk
        wuL7+4Y5GtuFhSayXZbQlNwryevNn7uj4vPm4oxu7omdK1TCxK1/Zq6ee+fI9jWpu5RYijMS
        DbWYi4oTAYoktmCSAgAA
X-CMS-MailID: 20210913085226epcas5p2b516f0f591926c927faa9c60d211bf44
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210913085226epcas5p2b516f0f591926c927faa9c60d211bf44
References: <CGME20210913085226epcas5p2b516f0f591926c927faa9c60d211bf44@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

psi accepts window sizes upto WINDOW_MAX_US(10000000). In the case
where window_us is larger than 4294967, the result of an
multiplication overflows an unsigned int/long(4 bytes on 32 bit
system).

For example, this can happen when the window_us is 5000000 so 5000000
* 1000 (NSEC_PER_USEC) will result in 5000000000 which is greater than
UINT_MAX(4294967295). Due to this overflow, 705032704 is stored in
t->win.size instead of 5000000000. Now psi will be monitoring the
window size of 705 msecs instead of 5 secs as expected by user.

Fix this by type casting the first term of the mutiply to a u64.

Issue doesnot occur on 64 bit systems because NSEC_PER_USEC is of type
long which is 8 bytes on 64 bit systems.

Signed-off-by: Ravi Singh <ravi.singh1@samsung.com>
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 1652f2bb5..a2cc33dc2 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1145,7 +1145,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	t->group = group;
 	t->state = state;
 	t->threshold = threshold_us * NSEC_PER_USEC;
-	t->win.size = window_us * NSEC_PER_USEC;
+	t->win.size = (u64)window_us * NSEC_PER_USEC;
 	window_reset(&t->win, 0, 0, 0);
 
 	t->event = 0;
-- 
2.17.1

