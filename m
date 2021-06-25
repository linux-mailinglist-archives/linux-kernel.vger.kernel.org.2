Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39853B45D4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhFYOjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231811AbhFYOjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:39:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E409D6195F;
        Fri, 25 Jun 2021 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624631822;
        bh=PS8ZKE3pdHYqi+dT0eaCxhAkUEsUIJhdbc4pPLOtZm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4Hef/Uw30fg7G7y9HuBEPccLw9hgg3F2xR5NuiIlQWj3fVknpKJw3SNRufFIttux
         SpkgOCGm2b0YWDpY31y7sitgf+ERP1YI3y3WJTfythwRcy65dgH93lxuLfsAUAJyJD
         poQDX5ICdEOkbIPkxQZLGr9TWBVCD9wpPq4yAkbVhkFFwdthseY3TWsmKJLyfAcTP/
         Ybpp+D/w1GB/KMZT2dvVyuxhHK0HlR7Yz2qeaPinxdUbP6H9+ScPnKbH85Jg6RUg8/
         w0hKP7dpf+K238SeQR0Anupac6BKB1bmHgeTVhlFArv652P6UnUYMJNt0cb0KsEg4Y
         S7DzomdL/h0eQ==
Received: by pali.im (Postfix)
        id A46B760E; Fri, 25 Jun 2021 16:37:01 +0200 (CEST)
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 07/11] math64: New DIV_U64_ROUND_CLOSEST helper
Date:   Fri, 25 Jun 2021 16:36:13 +0200
Message-Id: <20210625143617.12826-8-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210625143617.12826-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210625143617.12826-1-pali@kernel.org>
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

