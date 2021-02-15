Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529B031B6BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 10:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhBOJuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 04:50:44 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:54911 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhBOJuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 04:50:37 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210215094954epoutp03ada53c47c2e69b4ab91bc5d8df52dee7~j4uv7A5rK2952629526epoutp03A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 09:49:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210215094954epoutp03ada53c47c2e69b4ab91bc5d8df52dee7~j4uv7A5rK2952629526epoutp03A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613382594;
        bh=huiqRNL7zXfjqmkPv5crq6USQ9vxoqRBSSnIBaa4LnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IwdRjjZHopug+FbDAPZj0jH4A/OKBVg6OS9Yb18iVjMcBfnqZd4LuN6RfvtAyRI06
         J5q8va3pkAjd7zF34/WFkrzRyzNVTFWYAzWvyxBwPZ8gUa66Kxa7nZkEhipO5NXzMd
         8Ub3FdDopeGAphl/bkNUBoQWK313gXcFuajWyvjc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210215094954epcas1p27e17cca8674965c5b514930cdc4b27fe~j4uvjYUKJ2959529595epcas1p2S;
        Mon, 15 Feb 2021 09:49:54 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4DfK8H4RFcz4x9Q3; Mon, 15 Feb
        2021 09:49:51 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.D3.63458.FB34A206; Mon, 15 Feb 2021 18:49:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210215094951epcas1p154078de1f5752fdcbb080056771c0c66~j4usv8hFQ1168411684epcas1p1X;
        Mon, 15 Feb 2021 09:49:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210215094951epsmtrp1706e8c74718998cff58a57fb45fdb442~j4usvWQbS2219322193epsmtrp1_;
        Mon, 15 Feb 2021 09:49:51 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-dc-602a43bfc377
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.1F.08745.FB34A206; Mon, 15 Feb 2021 18:49:51 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210215094951epsmtip2385ea7a652f066fd5d83dc6aed4025c5~j4usiwtSJ1840318403epsmtip2J;
        Mon, 15 Feb 2021 09:49:51 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     gregkh@linuxfoundation.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org,
        Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH 2/3] extcon: max8997: Add CHGINS and CHGRM interrupt
 handling
Date:   Mon, 15 Feb 2021 19:06:09 +0900
Message-Id: <20210215100610.19911-3-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210215100610.19911-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7bCmnu5+Z60Eg7lT5C0m3rjCYnH9y3NW
        i+bF69ksLu+aw2Zxu3EFm8X6Hy/ZHNg8Nq3qZPPYP3cNu0dP2yYmj74tqxg9Pm+SC2CNyrbJ
        SE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpASaEsMacU
        KBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpecn2tlaGBgZApUmJCd8WBf
        G2vBBc6KNXu3szUwTuLoYuTkkBAwkdjT+YodxBYS2MEosfNIeBcjF5D9iVFixopprBCJz4wS
        Hz4ZwjQc/rqMHaJoF6PE1AfdjBDOF0aJGw+6mEGq2AS0JPa/uMEGYosIyEk8uf2HGaSIWWAi
        o8T35R/AEsIC/hLdUyeB2SwCqhJtJz+zgNi8AlYSm3ZuZYNYJy+xesMBsKGcAtYSO+e1gm2T
        EDjGLrHs0UVGiCIXidbV/cwQtrDEq+Nb2CFsKYmX/W1QdrXEypNH2CCaOxgltuy/wAqRMJbY
        v3QyUxcjB9B5mhLrd+lDhBUldv6eCzafWYBP4t3XHlaQEgkBXomONiGIEmWJyw/uMkHYkhKL
        2zuhbvaQWPKxkwUSKn2MEvM3nmKcwCg3C2HDAkbGVYxiqQXFuempxYYFRshRtokRnMS0zHYw
        Tnr7Qe8QIxMH4yFGCQ5mJRHeqxIaCUK8KYmVValF+fFFpTmpxYcYTYGhN5FZSjQ5H5hG80ri
        DU2NjI2NLUwMzUwNDZXEeRMNHsQLCaQnlqRmp6YWpBbB9DFxcEo1MHmdF/bQdstK0QvaE+29
        vyb3wOEXrJe5q5N03F9UGb39d/mpimOBSNh0/hkb165VPntz2bp6KZbzy5eJf116na/sJW9E
        jswzs1pBwc//tCfLnL8Xfm4R+4Xpsyb9KzJtCLF4YhDC6+C0JWbe3pLeookm16V7i3cYFMiZ
        nD7s7HuH12WuWo+L5EudWdHXPKZt+VmpbvpATeqMnvZsM60E13X9OXMfrn7q3KGrPqP8s9oC
        0XnbbtwoMeFu37H5in6KL5Nq7lfGq3wu3C02x2fXxj/ylF1kerK9Y8+WTW5+8voVB3/+2eAo
        JC71J+/HGQE700keb+7MKesK3rXlz40aAQ/zpec9djyWO1n9N3FOnRJLcUaioRZzUXEiACh1
        XhbrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsWy7bCSvO5+Z60Eg61PeSwm3rjCYnH9y3NW
        i+bF69ksLu+aw2Zxu3EFm8X6Hy/ZHNg8Nq3qZPPYP3cNu0dP2yYmj74tqxg9Pm+SC2CN4rJJ
        Sc3JLEst0rdL4Mp4sK+NteACZ8WavdvZGhgncXQxcnJICJhIHP66jL2LkYtDSGAHo8TafW9Y
        IBKSEtMuHmXuYuQAsoUlDh8uBgkLCXwCqrllCGKzCWhJ7H9xgw3EFhGQk3hy+w8zyBxmgemM
        Eg/m7gGbIyzgK9H/o4ERxGYRUJVoO/kZLM4rYCWxaedWNohd8hKrNxxgBrE5Bawlds5rZYRY
        ZiWxbPpypgmMfAsYGVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgSHmpbWDsY9qz7o
        HWJk4mA8xCjBwawkwntVQiNBiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2amp
        BalFMFkmDk6pBqYt/mUN+ubrr0y9FG0oeeD07Xs7l3Cu7ZTfqafP0nw3XnZjyqOVZSml2us4
        okOMxbx/SExWPdfg9uW/weWjp/g5RFhu+2R4fCvevO3kV+6wDINNony19T+aw9eGzv888fi7
        Y68YdPvSC08bxzwLNFOLUDZaHLMs7vepHYvqt773vr/Sd7NdR5LHyi0P99StfFs9RULt4/tF
        gmntiRf1wwIWP9Lh+MX+vanXwYafvffEnmMOwd3bCgwPXQ9kV1Xezv8o7ofdxgcbO1guzQna
        dmeyx3c3AV8pya0vZf7JH+W8sorLMmCD2VZJnZvXW4oKd2jvvb2Qv/XUinkLb+yvOOmnNnGS
        9NIv/vuXMBU2zHNXYinOSDTUYi4qTgQA53+OPqQCAAA=
X-CMS-MailID: 20210215094951epcas1p154078de1f5752fdcbb080056771c0c66
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210215094951epcas1p154078de1f5752fdcbb080056771c0c66
References: <20210215100610.19911-1-cw00.choi@samsung.com>
        <CGME20210215094951epcas1p154078de1f5752fdcbb080056771c0c66@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timon Baetz <timon.baetz@protonmail.com>

This allows the MAX8997 charger to set the current limit depending on
the detected extcon charger type.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon-max8997.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index 337b0eea4e62..e1408075ef7d 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -44,6 +44,8 @@ static struct max8997_muic_irq muic_irqs[] = {
 	{ MAX8997_MUICIRQ_ChgDetRun,	"muic-CHGDETRUN" },
 	{ MAX8997_MUICIRQ_ChgTyp,	"muic-CHGTYP" },
 	{ MAX8997_MUICIRQ_OVP,		"muic-OVP" },
+	{ MAX8997_PMICIRQ_CHGINS,	"pmic-CHGINS" },
+	{ MAX8997_PMICIRQ_CHGRM,	"pmic-CHGRM" },
 };
 
 /* Define supported cable type */
@@ -538,6 +540,8 @@ static void max8997_muic_irq_work(struct work_struct *work)
 	case MAX8997_MUICIRQ_DCDTmr:
 	case MAX8997_MUICIRQ_ChgDetRun:
 	case MAX8997_MUICIRQ_ChgTyp:
+	case MAX8997_PMICIRQ_CHGINS:
+	case MAX8997_PMICIRQ_CHGRM:
 		/* Handle charger cable */
 		ret = max8997_muic_chg_handler(info);
 		break;
-- 
2.17.1

