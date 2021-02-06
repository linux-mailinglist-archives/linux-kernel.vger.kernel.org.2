Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C857311D51
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 14:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBFNJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 08:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBFNJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 08:09:29 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB48C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 05:08:48 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d16so10911048wro.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 05:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wpbvjbVzWJ8qP7giT80E9ujhBsdt/0hlsyvy2z2DcHU=;
        b=Gkthy+G68K2CGL5lTek3C/cXIUS67V4nRgFehdukPcZw2DuuD/YncGAlpB66J60AYR
         6HyodIOWtci2pj99FM1E9buD/ZZ2dRWjofGOHUUHeu7ARxMiHNryT6HzFzgmuUl48S0D
         2OtWz/oiUt/mL75ZXalIStVoNl0fKi5nUybso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wpbvjbVzWJ8qP7giT80E9ujhBsdt/0hlsyvy2z2DcHU=;
        b=MJkZ6FoCeCXHkkaMUe42o5d8yRtpC/r1fI/9vvQaY8KRiPog0Qsz4W+pPSY1ksz6wB
         4sEU16IfC/Pzn94oUSfTRGiAH54xjYLaWOwFDjQsN75elL6l0xTY2Dz4hmb/+YPWBYYm
         AGOGYI5o4uSTehuMqfng9TuWrV/D/Lppoo0Qp2l13nThlRbEbOPJA9Ce8iN4Tu5IfwCu
         4s/RmnIY2jOn5RBrDd27m6EtGq9Qwd5A4mIhJYW+1bJ6M0DbdCSCF/4ngWGnp2dj+9g/
         KruuIvk7XsDc5lF1HITIDS8MZp1xigR/K5a1UqOCYDyNqIebybjrLINDhwyCM9DTV6am
         YHRA==
X-Gm-Message-State: AOAM533gZXm41yNvWwiVH+sO9D5Z5DyNmixhjdQYigF8vNaYTC88psP/
        3PhzUbsCOUIro2/e5MBQvrVXc0Mt5D7e6KfG+3g=
X-Google-Smtp-Source: ABdhPJwOm4H/+mYe8tszmtvvCYK1JpvTNKUO/ZAC6AH2z0zDySVXgrDXTFLbb7PI6ipY24rj6xifwA==
X-Received: by 2002:a5d:4b8e:: with SMTP id b14mr9929275wrt.130.1612616927697;
        Sat, 06 Feb 2021 05:08:47 -0800 (PST)
Received: from localhost ([85.255.234.177])
        by smtp.gmail.com with ESMTPSA id v1sm11593121wmj.31.2021.02.06.05.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 05:08:47 -0800 (PST)
Date:   Sat, 6 Feb 2021 13:08:46 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RESEND] checkpatch: Don't warn about colon termination in
 linker scripts
Message-ID: <YB6UsjCOy1qrrlSD@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check erroneously flags cases like the one in my recent printk
enumeration patch[0], where the spaces are syntactic, and `section:' vs.
`section :' is syntactically important:

    ERROR: space prohibited before that ':' (ctx:WxW)
    #258: FILE: include/asm-generic/vmlinux.lds.h:314:
    +       .printk_fmts : AT(ADDR(.printk_fmts) - LOAD_OFFSET) {

0: https://lore.kernel.org/patchwork/patch/1375749/

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4f8494527139..3bcffc5574ae 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5046,7 +5046,7 @@ sub process {
 				# A colon needs no spaces before when it is
 				# terminating a case value or a label.
 				} elsif ($opv eq ':C' || $opv eq ':L') {
-					if ($ctx =~ /Wx./) {
+					if ($ctx =~ /Wx./ and $realfile !~ m@.*\.lds\.h$@) {
 						if (ERROR("SPACING",
 							  "space prohibited before that '$op' $at\n" . $hereptr)) {
 							$good = rtrim($fix_elements[$n]) . trim($fix_elements[$n + 1]);
-- 
2.30.0

