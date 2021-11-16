Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE80453BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhKPVhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:37:18 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:62957 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhKPVhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:37:17 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20211116213419euoutp010d254bbca5aacd2047994b84fd77c31d~4JF-9TRZp0435904359euoutp01b
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 21:34:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20211116213419euoutp010d254bbca5aacd2047994b84fd77c31d~4JF-9TRZp0435904359euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1637098459;
        bh=53zbEZ3ajOhbubsa0FjB1p0MHkaTbDa+Mx+mqbAH8Ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P4honvjx4sfG+IIrjSDTFs7Y9vA9iGnVkhXBaZcfmAzXG79N3OKen3HSt/gYVIKUA
         SVHlEOUTJo/RK3sRC3P6QoZ6O4B1Jv8QURy5waIkSHx9sOcNhxthtYQej/wEpR/xjI
         6PxmX7ui6rKWGg25fIoBio3XKj+n4lIGN1K72xXg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211116213418eucas1p1fbe13de0c2d2e88963751803d9aa065a~4JF-Jg3yC0377703777eucas1p12;
        Tue, 16 Nov 2021 21:34:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3B.A0.10009.9D324916; Tue, 16
        Nov 2021 21:34:18 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211116213417eucas1p133783708f01c8cf82bd341a4cf95a833~4JF_zM4P-0377303773eucas1p1C;
        Tue, 16 Nov 2021 21:34:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211116213417eusmtrp2ad1973e176dd147a0775827a4df75b93~4JF_yo1da1546415464eusmtrp2d;
        Tue, 16 Nov 2021 21:34:17 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-a7-619423d902af
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 32.C8.09404.9D324916; Tue, 16
        Nov 2021 21:34:17 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20211116213417eusmtip1d2b38be6f3c3268c43afebb955a96f04~4JF_o578o0369903699eusmtip1C;
        Tue, 16 Nov 2021 21:34:17 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Joe Perches <joe@perches.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] get_maintainer: ignore "my" e-mail address
Date:   Tue, 16 Nov 2021 22:34:02 +0100
Message-Id: <20211116213403.820336-2-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211116213403.820336-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djP87q3lKckGpyew2gx+/5jFoubh1Yw
        WlzeNYfNYu2Ru+wOLB5fVl1j9ujbsorR4/MmuQDmKC6blNSczLLUIn27BK6MvYfvsRZMFqmY
        1buCqYFxuUAXIweHhICJxPK3vF2MXBxCAisYJVYd2ccO4XxhlPjzcQkzhPOZUeJG81fWLkZO
        sI6nc/uhqpYzSvQv28gG4TxnlHjdt4gZpIpNwFGif+kJVpAdIgKKEne38IPUMAv0MUr8nr0R
        rEZYwF7i3MejLCA2i4CqxKw5L8FsXgEbiYUnJrNAbJOXaLs+nRHE5hSwlZh7ay4jRI2gxMmZ
        T8Bq+AW0JNY0XQezmYHqm7fOBjtbQmAPh8SG5y+YIAa5SLRvmsQMYQtLvDq+hR3ClpH4v3M+
        EyQw6iUmTzKD6O1hlNg25wfUEdYSd879YgOpYRbQlFi/Sx8i7CixbMJjRohWPokbbwUhTuCT
        mLRtOjNEmFeio00IolpFYl3/HqiBUhK9r1YwTmBUmoXkmVlIHpiFsGsBI/MqRvHU0uLc9NRi
        w7zUcr3ixNzi0rx0veT83E2MwLRx+t/xTzsY5776qHeIkYmD8RCjBAezkghvStXkRCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK8In8aEoUE0hNLUrNTUwtSi2CyTBycUg1MxrVLZhzaGuZ83zct
        I+mwweG6cpMZz91tLRtcjy6ezHtu79bbendKpd5/6nlrdbjp0Gyh2nsPjneG3LeLmRYor1aQ
        P2ljbCT7l4a80vqIkHs/9vIvOCPUc/qT55OUGxVv7pyK2/UijO+CbxDzq+4FLF7TdLdv/Xvh
        icbXb/K62nsiahgfLhSVunSJf+OLvy83KIZ+K16vNm3yIS91meWqcx7vWmUg9mhLYOSKLNHM
        stpNhz1OeaqHX3R0Vzr0NvHjtu9We6InzW7zSfU+e1zSVlaVfQMrP/uN/zuE2faqV6VyFwQf
        f86dMjVT3PKN9unV19LMbqeZ2u/Z6WjZt/aEvOrPG7diT6SVh7dcvhy6WomlOCPRUIu5qDgR
        ADHSzRKKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42I5/e/4Xd2bylMSDR6361nMvv+YxeLmoRWM
        Fpd3zWGzWHvkLrsDi8eXVdeYPfq2rGL0+LxJLoA5Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLP
        yMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j7+F7rAWTRSpm9a5gamBcLtDFyMkhIWAi8XRu
        P3sXIxeHkMBSRolbExYydjFyACWkJFbOTYeoEZb4c62LDcQWEnjKKDF7KiuIzSbgKNG/9AQr
        SLmIgKLE3S38IGOYBfoYJX7P3sgMUiMsYC9x7uNRFhCbRUBVYtacl2A2r4CNxMITk1kg5stL
        tF2fzghicwrYSsy9NZcRYpeNROeKPiaIekGJkzOfsIDsYhZQl1g/TwgkzC+gJbGm6TrYGGag
        Mc1bZzNPYBSahaRjFkLHLCRVCxiZVzGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTGyLZjP7fs
        YFz56qPeIUYmDsZDjBIczEoivClVkxOFeFMSK6tSi/Lji0pzUosPMZoCfTaRWUo0OR8YpXkl
        8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUwrOlb4Llzl8EBB9vCu
        u/XGc8oSNK1b5XflrdCT3Coavj2lbpbgtVITl5ZTl8M2XmjZeedpMT9X0p+f5/Zf0M1cv75t
        nqvRsmOHvJgX6C4QnurL9/atRHayjtHkdYujtz36dVBcl4n/wpKO15qcLfsfL61uuvXpus0Z
        0Z9rubcrNpt9nji7f/u+nQkai08tsbA94Gu0kkvAKOWyw/mfZ+NL999d/WKHQtrGhmV3g/Uz
        Hi/rSfZwn9z3533Hn283654v2L51kkeSv8WXpJOskxUEImW71+Scbrm98lz7D/1lckbuKZmM
        Bg8LVY3+P5MIn6p0T+/Xfo69/zRZdNyubs6YI/qyzPG++tHpL1R/meecUGIpzkg01GIuKk4E
        ANKQ/p4aAwAA
X-CMS-MailID: 20211116213417eucas1p133783708f01c8cf82bd341a4cf95a833
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211116213417eucas1p133783708f01c8cf82bd341a4cf95a833
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211116213417eucas1p133783708f01c8cf82bd341a4cf95a833
References: <20211116213403.820336-1-l.stelmach@samsung.com>
        <CGME20211116213417eucas1p133783708f01c8cf82bd341a4cf95a833@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore one's own e-mail address given as a parameter to --ignore-me
or in the EMAIL environment variable.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 scripts/get_maintainer.pl | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ff10c2878522..0719d575c682 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -42,6 +42,7 @@ my $email_git_max_maintainers = 5;
 my $email_git_min_percent = 5;
 my $email_git_since = "1-year-ago";
 my $email_hg_since = "-365";
+my $email_ignore_me = undef;
 my $interactive = 0;
 my $email_remove_duplicates = 1;
 my $email_use_mailmap = 1;
@@ -251,6 +252,7 @@ if (!GetOptions(
 		'git-since=s' => \$email_git_since,
 		'hg-since=s' => \$email_hg_since,
 		'i|interactive!' => \$interactive,
+		'ignore-me:s' => \$email_ignore_me,
 		'remove-duplicates!' => \$email_remove_duplicates,
 		'mailmap!' => \$email_use_mailmap,
 		'm!' => \$email_maintainer,
@@ -338,6 +340,17 @@ if ($tree && !top_of_kernel_tree($lk_path)) {
 	. "a linux kernel source tree.\n";
 }
 
+if (defined $email_ignore_me) {
+    if ($email_ignore_me && rfc822_valid($email_ignore_me)) {
+	(undef, $email_ignore_me) = parse_email($email_ignore_me);
+    } elsif (!$email_ignore_me && defined $ENV{EMAIL} && rfc822_valid($ENV{EMAIL})) {
+	(undef, $email_ignore_me) = parse_email($ENV{EMAIL});
+    } else {
+	warn "$P: \"$email_ignore_me\" is not a valid e-mail address\n";
+	$email_ignore_me = 0;
+    }
+}
+
 ## Read MAINTAINERS for type/value pairs
 
 my @typevalue = ();
@@ -1062,6 +1075,8 @@ MAINTAINER field selection options:
     --rolestats => show roles and statistics (commits/total_commits, %)
     --file-emails => add email addresses found in -f file (default: 0 (off))
     --fixes => for patches, add signatures of commits with 'Fixes: <commit>' (default: 1 (on))
+    --ignore-me => ignore one's own e-mail address passed as a parameter or
+        via EMAIL environment variable
   --scm => print SCM tree(s) if any
   --status => print status if any
   --subsystem => print subsystem name if any
@@ -1401,6 +1416,11 @@ sub push_email_address {
 	return 0;
     }
 
+    if ($email_ignore_me) {
+	my ($myname, $myaddr) = parse_email($email_ignore_me);
+	return 0 if ($address eq $myaddr)
+    }
+
     if (!$email_remove_duplicates) {
 	push(@email_to, [format_email($name, $address, $email_usename), $role]);
     } elsif (!email_inuse($name, $address)) {
-- 
2.30.2

