Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3BE44F77C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 11:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhKNLCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 06:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhKNLC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 06:02:29 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431EEC061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 02:59:35 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n29so24369896wra.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 02:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=r4t9BR8VAOitRk+LAuuKc6ToUvR36oKcaAyCY1ETxmQ=;
        b=d1dN1pDW3ot3Zx3Cpx4uNoYEUj5p2I5ACJWnaZ1LWk+j8Lz/QPxBnQaWnEjbwCU4Oq
         yPRH2cmKW8rWbmhG9Rof+Ar+j6m0HSB8wLQ4azMdbyAGY4xi1dniW84vkPjLkduaKTlA
         lntfJLuYXJGJV6JAFZbS0a+01dvIKffLGUxmIm1152X7wsJ5EsFMM3KxPdHPWbXfEHau
         BdlW1I6WNO18cpQqCFb02gIOy89snVksow7JXWMKYKaETkUBHhtmIaF7sIlCxcvectDP
         Ef7VJPE1j3nx+zdDfbRBfGd/lxjsCVxUGV7SBJWdCdiZgBTOguwJhr8Rk+UkknJu7sJy
         yJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=r4t9BR8VAOitRk+LAuuKc6ToUvR36oKcaAyCY1ETxmQ=;
        b=oVjsvIM1grw4ft8c9tPRr/QL0g4+t7kgx7Kbsis/QNaTOvV2LnTTtXIjEgfVF/hw38
         f3udAVUKnGcgNJNiUO+2Jjmh4I0L8itd7WJjetY+Q+L1HSFmYVGcYaiBbXN9YWSpX56s
         Tz9gyyJyGS1VWFO14RyQtowq5mLElWiWDg7Sm7KcCQEQkSDN1zXjZGcYwXZ0W0AqwW72
         rVU+lhAbpvJp1sPa/uVVg2ftUKzIv3uxQ2Z/EjVXbHFQlzQn62ua/JqsIjGpT6JIA5wh
         jElly06VJOweMoTZM2esHCbq6H4WRFGfJiEa9mDtzwk/cHKzDMPqfiNITuUYxpdhbHzo
         U6nQ==
X-Gm-Message-State: AOAM530BrWbBrZgzsIDjYiSeHwFjo54pp0tzf+3aRr4S5V9kJps+s5Xw
        hTU3YyXiqTzmFWIx+6wxUfeHZLza1w==
X-Google-Smtp-Source: ABdhPJzV2UHICxUAbS66OPyZ9Nr05OEVExQL5wrgp4u8w3XQDmkeYToR8XQ6Ef7wW97WEeY0kEarjA==
X-Received: by 2002:a5d:6152:: with SMTP id y18mr36444291wrt.271.1636887573883;
        Sun, 14 Nov 2021 02:59:33 -0800 (PST)
Received: from localhost.localdomain ([46.53.249.106])
        by smtp.gmail.com with ESMTPSA id t4sm16374867wmi.48.2021.11.14.02.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 02:59:33 -0800 (PST)
Date:   Sun, 14 Nov 2021 13:59:32 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kstrtox: uninline everything
Message-ID: <YZDsFDhHst4m2Pnt@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've made a mistake of looking into lib/kstrtox.o code generation.

The only function remotely performance critical is _parse_integer()
(via /proc/*/map_files/*), everything else is not.

Uninline everything, shrink lib/kstrtox.o by ~20 % !

Space savings on x86_64:

	add/remove: 0/0 grow/shrink: 0/23 up/down: 0/-1269 (-1269 !!!)
	Function                                     old     new   delta
	kstrtoull                                     16      13      -3
	kstrtouint                                    59      48     -11
	kstrtou8                                      60      49     -11
	kstrtou16                                     61      50     -11
	_kstrtoul                                     46      35     -11
	kstrtoull_from_user                           95      83     -12
	kstrtoul_from_user                            95      83     -12
	kstrtoll                                      93      80     -13
	kstrtouint_from_user                         124      83     -41
	kstrtou8_from_user                           125      83     -42
	kstrtou16_from_user                          126      83     -43
	kstrtos8                                     101      50     -51
	kstrtos16                                    102      51     -51
	kstrtoint                                    100      49     -51
	_kstrtol                                      93      35     -58
	kstrtobool_from_user                         156      75     -81
	kstrtoll_from_user                           165      83     -82
	kstrtol_from_user                            165      83     -82
	kstrtoint_from_user                          172      83     -89
	kstrtos8_from_user                           173      83     -90
	kstrtos16_from_user                          174      83     -91
	_parse_integer                               136      10    -126
	_kstrtoull                                   308     101    -207
	Total: Before=3421236, After=3419967, chg -0.04%

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 lib/kstrtox.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -22,6 +22,7 @@
 
 #include "kstrtox.h"
 
+noinline
 const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
 {
 	if (*base == 0) {
@@ -47,6 +48,7 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
  *
  * Don't you dare use this function.
  */
+noinline
 unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned long long *p,
 				  size_t max_chars)
 {
@@ -85,6 +87,7 @@ unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned lon
 	return rv;
 }
 
+noinline
 unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
 {
 	return _parse_integer_limit(s, base, p, INT_MAX);
@@ -125,6 +128,7 @@ static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
  * Preferred over simple_strtoull(). Return code must be checked.
  */
+noinline
 int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
 {
 	if (s[0] == '+')
@@ -148,6 +152,7 @@ EXPORT_SYMBOL(kstrtoull);
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
  * Preferred over simple_strtoll(). Return code must be checked.
  */
+noinline
 int kstrtoll(const char *s, unsigned int base, long long *res)
 {
 	unsigned long long tmp;
@@ -219,6 +224,7 @@ EXPORT_SYMBOL(_kstrtol);
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
  * Preferred over simple_strtoul(). Return code must be checked.
  */
+noinline
 int kstrtouint(const char *s, unsigned int base, unsigned int *res)
 {
 	unsigned long long tmp;
@@ -249,6 +255,7 @@ EXPORT_SYMBOL(kstrtouint);
  * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
  * Preferred over simple_strtol(). Return code must be checked.
  */
+noinline
 int kstrtoint(const char *s, unsigned int base, int *res)
 {
 	long long tmp;
@@ -264,6 +271,7 @@ int kstrtoint(const char *s, unsigned int base, int *res)
 }
 EXPORT_SYMBOL(kstrtoint);
 
+noinline
 int kstrtou16(const char *s, unsigned int base, u16 *res)
 {
 	unsigned long long tmp;
@@ -279,6 +287,7 @@ int kstrtou16(const char *s, unsigned int base, u16 *res)
 }
 EXPORT_SYMBOL(kstrtou16);
 
+noinline
 int kstrtos16(const char *s, unsigned int base, s16 *res)
 {
 	long long tmp;
@@ -294,6 +303,7 @@ int kstrtos16(const char *s, unsigned int base, s16 *res)
 }
 EXPORT_SYMBOL(kstrtos16);
 
+noinline
 int kstrtou8(const char *s, unsigned int base, u8 *res)
 {
 	unsigned long long tmp;
@@ -309,6 +319,7 @@ int kstrtou8(const char *s, unsigned int base, u8 *res)
 }
 EXPORT_SYMBOL(kstrtou8);
 
+noinline
 int kstrtos8(const char *s, unsigned int base, s8 *res)
 {
 	long long tmp;
@@ -333,6 +344,7 @@ EXPORT_SYMBOL(kstrtos8);
  * [oO][NnFf] for "on" and "off". Otherwise it will return -EINVAL.  Value
  * pointed to by res is updated upon finding a match.
  */
+noinline
 int kstrtobool(const char *s, bool *res)
 {
 	if (!s)
