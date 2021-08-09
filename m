Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8F73E481B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbhHIOz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233412AbhHIOzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:55:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B17161019;
        Mon,  9 Aug 2021 14:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628520895;
        bh=PS8ZKE3pdHYqi+dT0eaCxhAkUEsUIJhdbc4pPLOtZm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UvIHWsh1gGS57HMoC2UXCoLdvYBkwKh0kDEcz3nnxTXhob8u0bj/wudta5rwPZD90
         HfTDPXYMPN0DslG6KJw8a0E22OsLj3nMO8pPbl3gY6QFm45jbXk/2Mrhg69aJZqZvK
         z799WVFe+6uB0qb81AfhhMjKfAZWLeK7FeBDjuQfawMrULAgJ95PGz4Aiu1fZYd/LU
         o/cRk+Sbweo1BZICtsXckAzxSZZUW6gi0awWQ/A8EGePkfGgA7iWCIfeY575aXUSbU
         moIUY5FsxKqmOKkXKVOj0BDzXmtH7LbzEvBu1JahR9XmK0pOdxTLuiFUOxTLym84ej
         /NCAAhcDJeBfQ==
Received: by pali.im (Postfix)
        id DF601286B; Mon,  9 Aug 2021 16:54:52 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/6] math64: New DIV_U64_ROUND_CLOSEST helper
Date:   Mon,  9 Aug 2021 16:53:24 +0200
Message-Id: <20210809145329.24177-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210809145329.24177-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210809145329.24177-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide DIV_U64_ROUND_CLOSEST helper which uses div_u64 to perform
division rounded to the closest integer using unsigned 64bit
dividend and unsigned 32bit divisor.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 include/linux/math64.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 66deb1fdc2ef..1cc61d748e1f 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -281,6 +281,19 @@ u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
 #define DIV64_U64_ROUND_CLOSEST(dividend, divisor)	\
 	({ u64 _tmp = (divisor); div64_u64((dividend) + _tmp / 2, _tmp); })
 
+/*
+ * DIV_U64_ROUND_CLOSEST - unsigned 64bit divide with 32bit divisor rounded to nearest integer
+ * @dividend: unsigned 64bit dividend
+ * @divisor: unsigned 32bit divisor
+ *
+ * Divide unsigned 64bit dividend by unsigned 32bit divisor
+ * and round to closest integer.
+ *
+ * Return: dividend / divisor rounded to nearest integer
+ */
+#define DIV_U64_ROUND_CLOSEST(dividend, divisor)	\
+	({ u32 _tmp = (divisor); div_u64((u64)(dividend) + _tmp / 2, _tmp); })
+
 /*
  * DIV_S64_ROUND_CLOSEST - signed 64bit divide with 32bit divisor rounded to nearest integer
  * @dividend: signed 64bit dividend
-- 
2.20.1

