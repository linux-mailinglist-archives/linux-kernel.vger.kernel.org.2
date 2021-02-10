Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBE5315E94
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 06:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhBJFHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 00:07:02 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6535 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhBJFGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 00:06:35 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602369b20001>; Tue, 09 Feb 2021 21:05:54 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 05:05:52 +0000
Received: from ubuntu.vdiclient.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 10 Feb 2021 05:05:50 +0000
From:   Timur Tabi <ttabi@nvidia.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        <akpm@linux-foundation.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        <roman.fietze@magna.com>, "Kees Cook" <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        <akinobu.mita@gmail.com>, <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH 1/3] lib/test_printf: use KSTM_MODULE_GLOBALS macro
Date:   Tue, 9 Feb 2021 23:05:27 -0600
Message-ID: <20210210050529.843005-2-ttabi@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210050529.843005-1-ttabi@nvidia.com>
References: <20210210050529.843005-1-ttabi@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612933554; bh=kgyfjShF7mas8HBfojx7GJ3B/MiEwf776XombejL4M0=;
        h=From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=B+No78WC4/4cq4n39fV7wS6lKmasY1HNrGKRE8EgL459sjJiquKLPlRF8KeQChA5x
         5WM5kZ3N3EosHqSbpFF+vpmfdvLu6SkTuwcD4HrXm/0p4Asc08JzFTtGLSNMZtfl52
         aG+PgI2xNgpvcwX6+LzKCpdTShhp8mkiAM9DDqVhqjCCnc6trZbMUvTVTUu701yYec
         Du0cdwsssXgK8uqvjxFrBooZy6ul/vOweYPGzvUA1kdbbxu+5emYNE5/vaKdp23mL8
         XPHscqJbogHd5v5A2vJoPT/cpIo8FfHPGPm+YN1MRYNZRjFrXfSp7u0LzHONcMgvVk
         v/vFQnl+7gIUw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of defining the total/failed test counters manually,
test_printf should use the kselftest macro created for this
purpose.

Signed-off-by: Timur Tabi <ttabi@nvidia.com>
---
 lib/test_printf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 7ac87f18a10f..ad2bcfa8caa1 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -30,8 +30,8 @@
 #define PAD_SIZE 16
 #define FILL_CHAR '$'
=20
-static unsigned total_tests __initdata;
-static unsigned failed_tests __initdata;
+KSTM_MODULE_GLOBALS();
+
 static char *test_buffer __initdata;
 static char *alloced_buffer __initdata;
=20
--=20
2.25.1

