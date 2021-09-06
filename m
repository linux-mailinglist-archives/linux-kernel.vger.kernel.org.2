Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B9C401B2F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242207AbhIFM2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:28:02 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:52505 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242100AbhIFM2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:28:01 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210906122655epoutp02269514ef4f930f5aef8c00d426d33b0b~iO0yUS0aj1221612216epoutp02v
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:26:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210906122655epoutp02269514ef4f930f5aef8c00d426d33b0b~iO0yUS0aj1221612216epoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1630931215;
        bh=5Scyun2f9vAe7f2WluCnvJycg0mdcot342qdWyjo0WU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=iIG7Fu0SBAeEzQervBTMcLfcy4eoakaA1f3uEi3Fh4UQQDpDX2xOSUfnLIBQDQ7y6
         WgYjURg6hu2EnxkmhzJT9SKVhwTmrKDbxdV1XqpAv7B9Rb52euYU3Q9w4cPqoBgC/K
         8/Nzg4YPmuklhEeyqcYkLlMZ88DEMxQdFcj6nKq8=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210906122654epcas5p2291014d722a311ab307eb76bb9807f9c~iO0xxhn0B1400014000epcas5p2Q;
        Mon,  6 Sep 2021 12:26:54 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.23.38346.E0906316; Mon,  6 Sep 2021 21:26:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210906122653epcas5p19c46576f0be4d4a101f851a751addde8~iO0wrC_mF0552505525epcas5p1A;
        Mon,  6 Sep 2021 12:26:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210906122653epsmtrp2884f31c37a01b0e1f0a412fb4e307975~iO0wqQt-71366813668epsmtrp2Z;
        Mon,  6 Sep 2021 12:26:53 +0000 (GMT)
X-AuditID: b6c32a4b-251ff700000095ca-c8-6136090e5274
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.E5.08750.D0906316; Mon,  6 Sep 2021 21:26:53 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210906122651epsmtip12adac5912126f63ce2592241171f4ca8~iO0vMCalX3207332073epsmtip1a;
        Mon,  6 Sep 2021 12:26:51 +0000 (GMT)
From:   Ravi Singh <ravi.singh1@samsung.com>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     a.sahrawat@samsung.com, v.narang@samsung.com,
        vishal.goel@samsung.com, Ravi Singh <ravi.singh1@samsung.com>
Subject: [PATCH] psi: fix integer overflow on unsigned int multiply on 32
 bit systems
Date:   Mon,  6 Sep 2021 17:55:24 +0530
Message-Id: <1630931124-27197-1-git-send-email-ravi.singh1@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCmpi4fp1miwZcnchYXd6darN7ka3F5
        1xw2i0sHFjBZHO89wGRxaRGLxaGTcxkt1t0+zejA4XH4zXtmj80rtDze77vK5tG3ZRWjx+dN
        cgGsUVw2Kak5mWWpRfp2CVwZXw6+ZS34zVXRe/0oSwNjI2cXIyeHhICJRMvyFcxdjFwcQgK7
        GSUmXlrEBOF8YpQ433OBDcL5zCjx5+ZeoDIOsJalOz0h4rsYJVovP2UGGSUk8IVR4soxNRCb
        TUBL4tHVP4wgtohAnMSDe7+ZQHqZBQol9ry0AwkLC4RL/Fr6GqyERUBVYuOJN+wgNq+Au8Ss
        f5tZIK6Tk7h5rhPsOgmBTewSm7bPYINIuEicvnaLHcIWlnh1fAuULSXx+d1eqJpqid6+rVDN
        HYwSW9vPQBXZSzy5uJAV4iBNifW79EHCzAJ8Er2/nzBB/Mgr0dEmBFGtKvFj+nqoTmmJxRc/
        sELYHhI7Tl+Hej1WounLZrYJjDKzEIYuYGRcxSiZWlCcm55abFpgnJdarlecmFtcmpeul5yf
        u4kRHN9a3jsYHz34oHeIkYmD8RCjBAezkghvtLNRohBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe
        3VcyiUIC6YklqdmpqQWpRTBZJg5OqQam47nNDDVLPfaz7xS/9LEuX/ml5qet8053v4oT43x/
        /99HHSW3XCcVWxF+lhMWVWdOd29fnNq1oyDcaZ0U42QPq6bPLKL5S5fVRkSac0aWT/b7Vb/4
        1bHQnAeF9q+kuCdf5mC5+fiH94cpdRUH5207Or1r/7KeKZ98y25PWrv7dpGZrkFD6wfFJLa+
        PkMul+DcPXPDLT72mYb+cDdPeT7Vpn1lgLvEZ5nfq7nDO/6+PW5kpWd07v/NXXe/md1fr7HJ
        z2Pn3WVx982miPOYvwwQS3ybspox4E/Jjt3nrA2WiivvD+6sqw+6tvBfO/uWt+eXLDPptvmv
        8PHqk8nJyqcnH5TJ32rAfGTnxfxzbHJ/lViKMxINtZiLihMBeCAWcF4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHJMWRmVeSWpSXmKPExsWy7bCSnC4vp1miwd1WAYuLu1MtVm/ytbi8
        aw6bxaUDC5gsjvceYLK4tIjF4tDJuYwW626fZnTg8Dj85j2zx+YVWh7v911l8+jbsorR4/Mm
        uQDWKC6blNSczLLUIn27BK6MLwffshb85qrovX6UpYGxkbOLkYNDQsBEYulOzy5GTg4hgR2M
        Er9/l4DYEgLSElcWLGaEsIUlVv57zt7FyAVU84lR4sjPiywgCTYBLYlHV/+AFYkIJEksudML
        FmcWKJU4O/0kK4gtLBAqseVsLzuIzSKgKrHxxBswm1fAXWLWv80sEAvkJG6e62SewMizgJFh
        FaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcBBpae1g3LPqg94hRiYOxkOMEhzMSiK8
        0c5GiUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwsf5f
        e7Dzxh3xMJWrJx0OrGKJ01i8fcPPU7l7K8uDnSKzGqNOb0/d8P64c+n08pAV3dOyMu8k3Jnr
        NfP5msgql8yVMefYLr8Ie1fZEmxc8dSEPUj7cEK+Jcvzy4t0V+yW637xu+zotBnrLgUs+cjN
        M5ff5XOU2vFkFfev3SceZf8waZmY6Xjo/9rVQr71XbqtRj5BKdOt4mbdqkpyY3Awt/qaWvvw
        WNy56L+NBg9iNsZtz89rfmu07a5LEMPsTZ+UuB4+a/KSKc0MW5CcwHxslatZQ2x/YEnP//W9
        zNsXCTDfvezFtJVfibert+CMtvU2xTPBBgl/9gVefcd309at5NfGTVKqyw+eyc6vDLiqxFKc
        kWioxVxUnAgAPJbH/pECAAA=
X-CMS-MailID: 20210906122653epcas5p19c46576f0be4d4a101f851a751addde8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20210906122653epcas5p19c46576f0be4d4a101f851a751addde8
References: <CGME20210906122653epcas5p19c46576f0be4d4a101f851a751addde8@epcas5p1.samsung.com>
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
Signed-off-by: Vishal Goel <vishal.goel@samsung.com>
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

