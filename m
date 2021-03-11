Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49638337245
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhCKMTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:19:22 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:61970 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbhCKMSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:18:55 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210311121853epoutp022f6e1c29961c55befd9225295a0aa857~rSPrBb_xZ0903609036epoutp02N
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 12:18:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210311121853epoutp022f6e1c29961c55befd9225295a0aa857~rSPrBb_xZ0903609036epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615465133;
        bh=wAtw0PE5WrQ2GSxFaB/orPDOPYDQPN6CC+C/JMUUc7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZkLJl9wpokQbvfYu6vQ1j7FfSRfLGrYdArSNu3uu8kmxLm/LXLPCpG1oQYF3Wi8e
         DJKEjOGWeMqO3Ta3gNiWcoYRntIoyypAFQ5Lp+suiTJtGuRYjDsLtKbySzQ0BVw4PL
         +mAiQBdJgDERxyDQ02jN8yrUgM8hF/D7KZTvLBFQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210311121852epcas1p2e50b6cd6197d7b42373e2f7a0e520ffe~rSPqPCpG41756917569epcas1p2u;
        Thu, 11 Mar 2021 12:18:52 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.166]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Dx7K72r1Kz4x9Pr; Thu, 11 Mar
        2021 12:18:51 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.6C.11962.BAA0A406; Thu, 11 Mar 2021 21:18:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210311121850epcas1p493c255a586998916febfebaf994bc5dc~rSPouh7J00656806568epcas1p4x;
        Thu, 11 Mar 2021 12:18:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210311121850epsmtrp25df50b0b79efbfc1e0abb395f714d4c6~rSPot6Rii0643206432epsmtrp2B;
        Thu, 11 Mar 2021 12:18:50 +0000 (GMT)
X-AuditID: b6c32a39-5cbff70000002eba-65-604a0aabcf0c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.92.08745.AAA0A406; Thu, 11 Mar 2021 21:18:50 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.104]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210311121850epsmtip1ef553eca1c36349522744ef72fab2681~rSPofhWCp2872828728epsmtip1G;
        Thu, 11 Mar 2021 12:18:50 +0000 (GMT)
From:   JeongHyeon Lee <jhs2.lee@samsung.com>
To:     snitzer@redhat.com
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        JeongHyeon Lee <jhs2.lee@samsung.com>
Subject: [PATCH 2/2] dm verity: allow only one verify mode
Date:   Thu, 11 Mar 2021 21:10:51 +0900
Message-Id: <1615464651-23675-2-git-send-email-jhs2.lee@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615464651-23675-1-git-send-email-jhs2.lee@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7bCmvu5qLq8Eg65eXov1p44xW+x9N5vV
        4tL9O6wWl3fNYbNo2/iV0YHV4/2+q2wefVtWMXp83iQXwByVY5ORmpiSWqSQmpecn5KZl26r
        5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
        kV9cYquUWpCSU2BoUKBXnJhbXJqXrpecn2tlaGBgZApUmZCTseHNL7aCNsGKi3NnsjUw9vN1
        MXJySAiYSMxumcEIYgsJ7GCU+PVbrouRC8j+xCgx8fYPZgjnM6PEtiOnmboYOcA6Hm3Uhojv
        YpToXvKGBcL5wihx79ocZpBRbALaErdbNrGD2CICYhJH+h6wgtjMAnkSi1+0g9UIC1hJ7Gq5
        BVbDIqAqsXHeY7AFvAIuEq+ns0BcJydx81wnWDmngKvEq/vbwXZJCKxil5j5+g0bRJGLxJuj
        a5ggbGGJV8e3sEPYUhKf3+1lg2joZpS4f/41VMMERoneHqhv7CXeX7IAMZkFNCXW79KHqFCU
        2Pl7LiPEyXwS7772sEJU80p0tAlBlChJrPh3DepMCYkNh7uhhntIrPp/jhESJDMYJZr3rmGa
        wCg3C2HDAkbGVYxiqQXFuempxYYFpsjxtYkRnKK0LHcwTn/7Qe8QIxMH4yFGCQ5mJRFev+Nu
        CUK8KYmVValF+fFFpTmpxYcYTYFhN5FZSjQ5H5gk80riDU2NjI2NLUzMzM1MjZXEeZMMHsQL
        CaQnlqRmp6YWpBbB9DFxcEo1MPknydy5ymOjmXs60OJtgPCS/cWZpRcvCqRy+j+VrZ58MOXv
        xdRNJ1Zli+/e1rru3TbVvd2lC0L3y/F85Ve6y7/0EntcuJZS59OgswI3/gnpJs5b43xm0oYT
        OlvWmD9tnnFw/cG3TiuPhNzdNuNP7702t+kaSU4XfzeG24YdFw6/IylXfDSFmaGH+4urVkfg
        r40JmiG2jupCspd/vXZ8qt9jOWlilaWsWspChSmTAsvqOBxFJtqtO/UgauIUO8sShqjtu2Y+
        Vnvf92a78fFdd0U65TSfLWJ/Mvs8++277RcdlmTJLbF9mbJo3ctHfGuUUhboeDxQ5/FVWm0S
        enJz79Tc48qbmr+cKZ/RvlN6mqUSS3FGoqEWc1FxIgDVvm5r2gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42LZdlhJTncVl1eCwdv1ChbrTx1jttj7bjar
        xaX7d1gtLu+aw2bRtvErowOrx/t9V9k8+rasYvT4vEkugDmKyyYlNSezLLVI3y6BK2PDm19s
        BW2CFRfnzmRrYOzn62Lk4JAQMJF4tFG7i5GLQ0hgB6PE301/GbsYOYHiEhIbNq1lh6gRljh8
        uBii5hOjxI7Tz1lBatgEtCVut2xiB7FFBMQkjvQ9AIszCxRJPN+3gA3EFhawktjVcgushkVA
        VWLjvMdMIDN5BVwkXk9ngVglJ3HzXCcziM0p4Crx6v52sLgQUEnDxpOMExj5FjAyrGKUTC0o
        zk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA4kLa0djHtWfdA7xMjEwXiIUYKDWUmE1++4W4IQ
        b0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTGrK50Nabb9v
        WLbVtn/RtIATHDf7D3+f5CQcWv1Y7/iijWxqTBsqt62pcF6+v/fOV/G3Fsbrwj5Il2cqdO9I
        NXtw5FPtobAlztsP3vC7cFD8lruI+T/1fc8DGxbInIi99fZQYu3Eze1yqok6j11fNbMUFvJ7
        dJV/6LlyIXjz0RcXi3I9TN9c8/i54vQCnZ/i0pX79F7mBE7odQpYr+a3Vu76fT0rzpCWaUd0
        VT1+L3A9o97DbJa0x3tRuxCb3PwYjtP7zE87uFXt2c3wxifrpFvq0rmyF/Vy/TxXVr9yfX14
        8r0fqcw7dd6/EjjaeOAUm9qyDVG8Db6RnDXXfzc0H0l1OOSTMod/XfujA1ynOZRYijMSDbWY
        i4oTAT/hWhSTAgAA
X-CMS-MailID: 20210311121850epcas1p493c255a586998916febfebaf994bc5dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210311121850epcas1p493c255a586998916febfebaf994bc5dc
References: <1615464651-23675-1-git-send-email-jhs2.lee@samsung.com>
        <CGME20210311121850epcas1p493c255a586998916febfebaf994bc5dc@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are multiple verity mode when parsing the verity mode of dm
verity table, it will be set as the last one.
So set to 'allow only once' to prevent it.

Signed-off-by: JeongHyeon Lee <jhs2.lee@samsung.com>
---
 drivers/md/dm-verity-target.c | 38 ++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 808a98ef624c..b76431dc7721 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -893,6 +893,28 @@ static int verity_alloc_zero_digest(struct dm_verity *v)
 	return r;
 }
 
+static inline bool verity_is_verity_mode(const char *arg_name)
+{
+	return (!strcasecmp(arg_name, DM_VERITY_OPT_LOGGING) ||
+		!strcasecmp(arg_name, DM_VERITY_OPT_RESTART) ||
+		!strcasecmp(arg_name, DM_VERITY_OPT_PANIC));
+}
+
+static int verity_parse_verity_mode(struct dm_verity *v, const char *arg_name)
+{
+	if (v->mode)
+		return -EINVAL;
+
+	if (!strcasecmp(arg_name, DM_VERITY_OPT_LOGGING))
+		v->mode = DM_VERITY_MODE_LOGGING;
+	else if (!strcasecmp(arg_name, DM_VERITY_OPT_RESTART))
+		v->mode = DM_VERITY_MODE_RESTART;
+	else if (!strcasecmp(arg_name, DM_VERITY_OPT_PANIC))
+		v->mode = DM_VERITY_MODE_PANIC;
+
+	return 0;
+}
+
 static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
 				 struct dm_verity_sig_opts *verify_args)
 {
@@ -916,16 +938,12 @@ static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
 		arg_name = dm_shift_arg(as);
 		argc--;
 
-		if (!strcasecmp(arg_name, DM_VERITY_OPT_LOGGING)) {
-			v->mode = DM_VERITY_MODE_LOGGING;
-			continue;
-
-		} else if (!strcasecmp(arg_name, DM_VERITY_OPT_RESTART)) {
-			v->mode = DM_VERITY_MODE_RESTART;
-			continue;
-
-		} else if (!strcasecmp(arg_name, DM_VERITY_OPT_PANIC)) {
-			v->mode = DM_VERITY_MODE_PANIC;
+		if (verity_is_verity_mode(arg_name)) {
+			r = verity_parse_verity_mode(v, arg_name);
+			if (r) {
+				ti->error = "Already verity mode set";
+				return r;
+			}
 			continue;
 
 		} else if (!strcasecmp(arg_name, DM_VERITY_OPT_IGN_ZEROES)) {
-- 
2.17.1

