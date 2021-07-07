Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8DF3BEA56
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 17:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhGGPIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 11:08:30 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:29140 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbhGGPIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 11:08:23 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210707150541epoutp04134dab69d9641f2f0a2702332af66877~Pio-n7sUS1435014350epoutp04Y
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 15:05:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210707150541epoutp04134dab69d9641f2f0a2702332af66877~Pio-n7sUS1435014350epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625670341;
        bh=P5M8iJ0a8JoZjAfb3+Emp7S0S3yFYTSdXdTiNiKaSQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oz2EID+NPPci3E7yui3aLjzoaF6bbmqpI6qTE2kW9akurRAH6IWDqCTZ6escq44iZ
         YzDNki4jFEUwgS9JDRwy+288rTLxggSTjyAyTf087P0RM2e6iF4oIcCm+pKfLkAo0p
         aHobp6FEF89CNS2BfMtO2jV6dB4u5BIp5Spmt4GU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210707150540epcas1p35127497ebc4c06bea2994816587d02b1~Pio-DHeUO2341123411epcas1p3Y;
        Wed,  7 Jul 2021 15:05:40 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.166]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4GKjR732q2z4x9Pv; Wed,  7 Jul
        2021 15:05:39 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.86.09586.3C2C5E06; Thu,  8 Jul 2021 00:05:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210707150538epcas1p149f866bf9b4c900a091c006df7162a23~Pio9gHBUq2525925259epcas1p1B;
        Wed,  7 Jul 2021 15:05:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210707150538epsmtrp2e431a65e97bd64b1b1f3fcdea03c8936~Pio9dxCx_0232302323epsmtrp2W;
        Wed,  7 Jul 2021 15:05:38 +0000 (GMT)
X-AuditID: b6c32a39-86dff70000002572-ee-60e5c2c3f8b7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.E7.08394.2C2C5E06; Thu,  8 Jul 2021 00:05:38 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.78]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210707150538epsmtip21326e8759022e7ff91c8dc79645e971f~Pio9W6_ob1222712227epsmtip2N;
        Wed,  7 Jul 2021 15:05:38 +0000 (GMT)
From:   Ohhoon Kwon <ohoono.kwon@samsung.com>
To:     david@redhat.com, ohoono.kwon@samsung.com,
        akpm@linux-foundation.org, mhocko@suse.com
Cc:     bhe@redhat.com, rppt@linux.ibm.com, ohkwon1043@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] mm: sparse: remove __section_nr() function
Date:   Thu,  8 Jul 2021 00:02:12 +0900
Message-Id: <20210707150212.855-4-ohoono.kwon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707150212.855-1-ohoono.kwon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmvu7hQ08TDFYfFLaYs34Nm8X5B7/Y
        LL6u/8VscXnXHDaLe2v+s1rc73Ow2Lvf12LXzxXMFjemNLA5cHrsnHWX3WPTp0nsHidm/Gbx
        mLDoAKPH+31X2Tz6tqxi9Fi/5SqLx+dNcgEcUTk2GamJKalFCql5yfkpmXnptkrewfHO8aZm
        Boa6hpYW5koKeYm5qbZKLj4Bum6ZOUDXKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVIL
        UnIKDA0K9IoTc4tL89L1kvNzrQwNDIxMgSoTcjL2ff/EVHCKr2L68zNsDYwNPF2MHBwSAiYS
        l87ZdjFycQgJ7GCUeL18OSuE84lRYsOli+wQzjdGiZ3XbjN1MXKCdSycv4QdxBYS2MsoMXOH
        MlzHlBUTwYrYBLQl9veeYAaxRQSiJWZf7QCLMwsUSDT0f2IBsYUFnCTmP3vDCmKzCKhK3H9w
        hw3kJF4BK4lV81IgdslLrN5wAGwMp4C1xOV198CukxB4yS6xecVFVogiF4k5t2+wQNjCEq+O
        b2GHsKUkPr/bywbR0M8ocahvO1T3BEaJ9V2N7JAAsJd4f8kCxGQW0JRYv0sfoldRYufvuYwQ
        N/NJvPvawwpRzSvR0SYEYapKLPvtAVEtLdE3/TIbhO0hMWHVZmZIkPQxSjya8IBlAqPcLIQF
        CxgZVzGKpRYU56anFhsWmCLH1yZGcOLTstzBOP3tB71DjEwcjIcYJTiYlUR4GR2eJgjxpiRW
        VqUW5ccXleakFh9iNAWG3URmKdHkfGDqzSuJNzQ1MjY2tjAxMzczNVYS593JdihBSCA9sSQ1
        OzW1ILUIpo+Jg1OqgUnU7nAmn36by7uOTTLcxwTX2x8zeCrZcNkrX3H/3lOmeqVSHD/kPh3n
        CWCYOruEK7hr75OMXdpqVs+aNmXaJqq1GF0TnfUosymK84fPko1c8iECJ8U4cl6EGndunpEa
        V22hFKTN/0Ln2KQpN7lqNp5tSNgis3L3uaWPJproKTc4LGd81rF1w+Q2pR7DK4dOGK1b8UBz
        YaKg+WsPA+kLP++zTXu+cO6XaVKrr84s32C6juWh2PyPlxS3uSpVOXGW7RN73qMq/+evlJ74
        r2cvxWc0L3PSmjPx//tA7vAv59atefio+tFXsdcZC5inv1e88cOh/oXjxSUJhcLFbs2qb/ha
        HJ/vuWtdvbcu/HLKlNVKLMUZiYZazEXFiQBeM0xrBQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvO6hQ08TDLYtMbaYs34Nm8X5B7/Y
        LL6u/8VscXnXHDaLe2v+s1rc73Ow2Lvf12LXzxXMFjemNLA5cHrsnHWX3WPTp0nsHidm/Gbx
        mLDoAKPH+31X2Tz6tqxi9Fi/5SqLx+dNcgEcUVw2Kak5mWWpRfp2CVwZ+75/Yio4xVcx/fkZ
        tgbGBp4uRk4OCQETiYXzl7B3MXJxCAnsZpTYOvMRE0RCWuLpi10sXYwcQLawxOHDxRA1Hxgl
        Wi7sYgepYRPQltjfe4IZpEZEIF5i/jWwMLNAmcTVlX9ZQWxhASeJ+c/egNksAqoS9x/cYQMp
        5xWwklg1LwVik7zE6g0HmEFsTgFricvr7rGClAgBlTQtcZjAyLeAkWEVo2RqQXFuem6xYYFh
        Xmq5XnFibnFpXrpecn7uJkZwcGpp7mDcvuqD3iFGJg7GQ4wSHMxKIryMDk8ThHhTEiurUovy
        44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamBauLLBdYvrJe4n+57X5Dkf
        Z1ap6azbcJz9z8cXqrv5IqbrM/u2Pgvhvxv9v+yItB37Sv4J0Wukoo7HzmAzuvBWT3LJk9SP
        TEoJEhd+ijEfiZ5bPd11t+8a4UmFfAf8O+tObEsNdssJenIjRfJ7TqhAxIPXKdx2dwKyHe9Z
        a1TaRIgtze5teh7A4Kjr8DrBRfzrLrUA26duuWo9fYJHmcTYnNcV81oZxRbqina4TntQ42d6
        d/21f6f1ImqPce2+5vcnek1mqtTLomle4v4Fa8O1VISO7/xX69HEePNWkNnGk03Zky+VRpiy
        xHeqBUf8+K5mumqChvnSmNn3lvSuX5G6VUzLUOZs6dFuE44DSizFGYmGWsxFxYkAOpX8Wb0C
        AAA=
X-CMS-MailID: 20210707150538epcas1p149f866bf9b4c900a091c006df7162a23
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210707150538epcas1p149f866bf9b4c900a091c006df7162a23
References: <20210707150212.855-1-ohoono.kwon@samsung.com>
        <CGME20210707150538epcas1p149f866bf9b4c900a091c006df7162a23@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the last users of __section_nr() are gone, let's remove unused
function __section_nr().

Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mmzone.h |  1 -
 mm/sparse.c            | 26 --------------------------
 2 files changed, 27 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fcb535560028..8827f4d081d4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1342,7 +1342,6 @@ static inline struct mem_section *__nr_to_section(unsigned long nr)
 		return NULL;
 	return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
 }
-extern unsigned long __section_nr(struct mem_section *ms);
 extern size_t mem_section_usage_size(void);
 
 /*
diff --git a/mm/sparse.c b/mm/sparse.c
index 8018ee7fcda5..d85655242ed9 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -109,32 +109,6 @@ static inline int sparse_index_init(unsigned long section_nr, int nid)
 }
 #endif
 
-#ifdef CONFIG_SPARSEMEM_EXTREME
-unsigned long __section_nr(struct mem_section *ms)
-{
-	unsigned long root_nr;
-	struct mem_section *root = NULL;
-
-	for (root_nr = 0; root_nr < NR_SECTION_ROOTS; root_nr++) {
-		root = __nr_to_section(root_nr * SECTIONS_PER_ROOT);
-		if (!root)
-			continue;
-
-		if ((ms >= root) && (ms < (root + SECTIONS_PER_ROOT)))
-		     break;
-	}
-
-	VM_BUG_ON(!root);
-
-	return (root_nr * SECTIONS_PER_ROOT) + (ms - root);
-}
-#else
-unsigned long __section_nr(struct mem_section *ms)
-{
-	return (unsigned long)(ms - mem_section[0]);
-}
-#endif
-
 /*
  * During early boot, before section_mem_map is used for an actual
  * mem_map, we use section_mem_map to store the section's NUMA
-- 
2.17.1

