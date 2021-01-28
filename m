Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024FA307A44
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 17:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhA1QEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 11:04:51 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:50042 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhA1QEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:04:42 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210128160359epoutp02bf941fd884d22d7278b76f4ae47e8372~ecOOsGW891592515925epoutp022
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 16:03:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210128160359epoutp02bf941fd884d22d7278b76f4ae47e8372~ecOOsGW891592515925epoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611849839;
        bh=FsjU8c1bivXOBROmwAViTma35lYMYvaKeTl7tbxOmKQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=miTP+Vfga3ixT/BKI1tTD6XcMh2ObBDz+BVqTEBvHxEkFLsVc50UW8MEMqaWYWVcy
         J9regO0HAvmpQugz5g0WQH/rZiKsVsSgoG5hQA7LmP8xXurR513a6qZkWv4uRbhhNc
         5jUZbkLwaQjcKIvojkc5l9bjDYj0LSQH63Pn5lPw=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210128160358epcas5p1b91936fd49694b195801f36fe4f38f94~ecONlzNSc0337303373epcas5p12;
        Thu, 28 Jan 2021 16:03:58 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.14.50652.E60E2106; Fri, 29 Jan 2021 01:03:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210128152646epcas5p3e0ceb57e0a2e668b4281b5733dd117d4~ebtvMVtJH1394113941epcas5p3P;
        Thu, 28 Jan 2021 15:26:46 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210128152646epsmtrp2b408b1a93969ba27035b8350dc2bd57f~ebtvLq9S41128611286epsmtrp2q;
        Thu, 28 Jan 2021 15:26:46 +0000 (GMT)
X-AuditID: b6c32a4a-6b3ff7000000c5dc-8e-6012e06e05f5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.F5.08745.6B7D2106; Fri, 29 Jan 2021 00:26:46 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210128152645epsmtip177db73be12043a92395a268a4eb6dd1a~ebtuKkaNN0232802328epsmtip1B;
        Thu, 28 Jan 2021 15:26:45 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, joe@perches.com, pankaj.dubey@samsung.com,
        Shradha Todi <shradha.t@samsung.com>,
        Lakshay Mehra <l.mehra@samsung.com>
Subject: [PATCH] checkpatch: add warning for line space after "Fixes:" tag
Date:   Thu, 28 Jan 2021 20:56:43 +0530
Message-Id: <1611847603-15736-1-git-send-email-shradha.t@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCmhm7eA6EEg+fP5S0+rNWwmH3/MYvF
        nec3GC0u75rDZrFo6xd2i97DtQ5sHrMaetk8vqy6xuzRt2UVo8fnTXIBLFFcNimpOZllqUX6
        dglcGZP77rAXzOao2LNsAnsD40G2LkZODgkBE4nm3w9Zuhi5OIQEdjNK7N64kgnC+cQosf3M
        AkYI5zOjxNPjTUwwLZ/f7YJq2cUosX76FyinhUli2b1/jCBVbAJaEo1fu5hBbBEBBYnNvc9Y
        QYqYBXoZJbqed4JtFxbwkrjx4S9YA4uAqsSu+w3sIDavgKvE4+Z+qHVyEjfPdTKDNEsIzGOX
        WP19KitEwkXizZSTLBC2sMSr41vYIWwpoPv2Qr2XLzH1wlOgGg4gu0JieU8dRNhe4sCVOWBh
        ZgFNifW79CHCshJTT60DW8sswCfR+/sJ1Am8EjvmwdjKEl/+7oHaKikx79hlqGs8JJpXTGIE
        GSkkECuxYi3rBEbZWQgLFjAyrmKUTC0ozk1PLTYtMMpLLdcrTswtLs1L10vOz93ECI5wLa8d
        jA8ffNA7xMjEwXiIUYKDWUmE9+0coQQh3pTEyqrUovz4otKc1OJDjNIcLErivDsMHsQLCaQn
        lqRmp6YWpBbBZJk4OKUamKwt3mlH1tzIqrG8KrmgZ47NjPSiTwaJlgt2z+lde/z9xpBrR2+t
        v1mkK28cLtNcbM92JWi9mqfFDxF3U4m1r5tWvlQJvX7/pheXm4OaJ1djpVyBwp96Y0brk4ka
        YguqZCS6NsVtd273qF6eKl+7q+7EK95vWposHtdiF9f9SVToexvws//Z+0cuLD+r30x+Znfx
        3O4IhT8ClxfIyCaX6Gydt9b49uVjmTPXq56rDPgk8SnKvH2htqPyhSupE0+ydl89HZSX8bPx
        vM4urptyD3sSHe982npI7ur7L9d9Lh9wZW1TvnA4NP7TCuNLjDsPTLt5cIaz9Pm0zO6WiEVy
        03+F5pWcerSgljemmmtluxJLcUaioRZzUXEiAG1cJA1fAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMJMWRmVeSWpSXmKPExsWy7bCSnO6260IJBi9v6Ft8WKthMfv+YxaL
        O89vMFpc3jWHzWLR1i/sFr2Hax3YPGY19LJ5fFl1jdmjb8sqRo/Pm+QCWKK4bFJSczLLUov0
        7RK4Mib33WEvmM1RsWfZBPYGxoNsXYycHBICJhKf3+1i6WLk4hAS2MEosXtfJ1RCUuLzxXVM
        ELawxMp/z9lBbCGBJiaJ1ikmIDabgJZE49cuZhBbREBBYnPvM1aQQcwCkxklVpxbxQqSEBbw
        krjx4S8jiM0ioCqx634D2CBeAVeJx839UAvkJG6e62SewMizgJFhFaNkakFxbnpusWGBUV5q
        uV5xYm5xaV66XnJ+7iZGcLhoae1g3LPqg94hRiYOxkOMEhzMSiK8b+cIJQjxpiRWVqUW5ccX
        leakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAdFkjqWWOZ6X/k+cqy3K3m7Ne
        DjiSKOsosux3jJCFzMVZxya/8OdfrfygnNfm7JJFX212+TPY6+hMyIvvWKVWZRorp7okrn1u
        ntKjt1s7StYEa5e7rEhbfYvbzX3SHlM52SPFa9InSify6ub3v+BkP+M79etiv+0ZN7ZtlNrk
        qMN0ZpajhTOjzloThmUWsXs3e8jN1fA49z/ol36s1u2N+zOjraJE9q8MPDprrn3Sxd8zoy6+
        i9e1cWg902ApzZo9v+XhicRnT/6lm8nP4LVfd0jyWLvjKbtHLKpWe02fXw3i0Y+X3Cb39c8G
        1kjnq7E8er5hnBkzzmafnvB13p3agn0PZildvdExp3C1Tt87JZbijERDLeai4kQAOmDBcIYC
        AAA=
X-CMS-MailID: 20210128152646epcas5p3e0ceb57e0a2e668b4281b5733dd117d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210128152646epcas5p3e0ceb57e0a2e668b4281b5733dd117d4
References: <CGME20210128152646epcas5p3e0ceb57e0a2e668b4281b5733dd117d4@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check to give warning for line break between Fixes tag
and signature tags as that is the commonly followed style.

Also add a --fix option to delete space lines after "Fixes:" tag.

Signed-off-by: Lakshay Mehra <l.mehra@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 scripts/checkpatch.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 92e888e..6c144c5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3027,6 +3027,15 @@ sub process {
 			$commit_log_long_line = 1;
 		}
 
+# Check for no line break after Fixes
+		if ($line =~ /^\s*Fixes:/i && $rawlines[$linenr] =~ /^\s*$/) {
+			if (WARN("UNNECESSARY_NEWLINE",
+				 "Newline is not required after Fixes:\n" . $herecurr) &&
+			    $fix) {
+				fix_delete_line($fixlinenr+1, $rawline);
+			}
+		}
+
 # Reset possible stack dump if a blank line is found
 		if ($in_commit_log && $commit_log_possible_stack_dump &&
 		    $line =~ /^\s*$/) {
-- 
2.7.4

