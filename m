Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215BD342BCF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhCTLMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCTLMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:12:10 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB009C0611A3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 03:54:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a7so13625801ejs.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 03:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gzZBd8f5AR9iFEX57/luDriSVqJ/f6FPOwajCnIusZE=;
        b=r7sy4/Mezgjzt7NjAuyQO0VGRVSE4S6FoKDFcA9MaoYXVsO0Xsunv71eGWiEiMv3CF
         CwLcn8gMd7T7uEGlFQf/eYdnSXnr2rbIs05TykrHSqbLETeTD3nGy+yAgVbjZgmON+Z0
         hDMLmbRzoMsAMIFzWyszMyh3CqWdgH0sImpxhibGZEsGkM4+USUKaeRDJLAIMQitXfxr
         7Xvd2q0s4su8EVW9k+r9jxXhg4wV8WXZp232/mRokf+JE3yHu+I548YFQEbkClfTGZ1u
         pNWYjBA6kcqLClLGAjhBZxs3i5o0GgCGAKUOpM4vb37gJUhbjO1Fr3NxqejBoXbFj+HK
         3s2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gzZBd8f5AR9iFEX57/luDriSVqJ/f6FPOwajCnIusZE=;
        b=Dwuj38u+/Ya8FPUgJOv521EOqotsxhoyTQ8EqA3NSBBra9SN14IlGsAa2zIF+SOrJg
         OZeDWPd3M0IN+2+NY/xkQFSPwid6GFwvXnP3D0apRAE9O3LxJC9lhXMEfXUkN54+fkBV
         nH9aILONtSZrDcAPkULXvEUk1foLsC96P5I6ydy0oO0hDwVzXqy92asKabWFuaDDE9TZ
         8KBEK35+hi24+2JkfJvBw8mISM1qcNTDZrnXUrvP3k/4DDXBQegW4fGO2tFu3kIaFuyl
         iSZW4AqfxCem5RuzbYzKwa5eGQIPh9wfZkQBGs+lujFXXbkCxiMhLE6BphoR1faGyRkQ
         LDDA==
X-Gm-Message-State: AOAM533rX3OV6U74IPZW4x8GvvrUHijl0CDhQJXcYE3zx2qjcl4O3Lwn
        74Y8RERFzmb/eO93lFeiS+G3GjJ+odjFwQ==
X-Google-Smtp-Source: ABdhPJyS+YR/AkOThPoMdwfeIQ9+b21imIPHWLWTIlgsa1820qe9NeoUd18u9SWa7YfRX3Xm0NZCpg==
X-Received: by 2002:a17:907:3e12:: with SMTP id hp18mr9144017ejc.366.1616237667582;
        Sat, 20 Mar 2021 03:54:27 -0700 (PDT)
Received: from agape.jhs ([5.171.80.229])
        by smtp.gmail.com with ESMTPSA id hy25sm5109771ejc.119.2021.03.20.03.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 03:54:27 -0700 (PDT)
Date:   Sat, 20 Mar 2021 11:54:24 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        apw@canonical.com, joe@perches.com
Subject: CHECKPATCH: missing a warning soon after include files decl -c
Message-ID: <20210320105424.GA3698@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here's an issue in checkpatch.pl

$ perl script/checkpatch.pl -f drivers/staging/rtl8723bs/core/rtw_ap.c

I get three warning related to an extern declaration

WARNING: externs should be avoided in .c files
#14: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:14:
+extern unsigned char WMM_OUI[];
--
WARNING: externs should be avoided in .c files
#15: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:15:
+extern unsigned char WPS_OUI[];
--
WARNING: externs should be avoided in .c files
#16: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:16:
+extern unsigned char P2P_OUI[];
----------------------

but the file checked has 4 extern declaration:
-----------------------------
#define _RTW_AP_C_

#include <drv_types.h>
#include <rtw_debug.h>
#include <asm/unaligned.h>

extern unsigned char RTW_WPA_OUI[];
extern unsigned char WMM_OUI[];
extern unsigned char WPS_OUI[];
extern unsigned char P2P_OUI[];

void init_mlme_ap_info(struct adapter *padapter)
-------------------------------

If I add a ';' this way:
----------------------------
#define _RTW_AP_C_

#include <drv_types.h>
#include <rtw_debug.h>
#include <asm/unaligned.h>
;
extern unsigned char RTW_WPA_OUI[];
extern unsigned char WMM_OUI[];
extern unsigned char WPS_OUI[];
extern unsigned char P2P_OUI[];

void init_mlme_ap_info(struct adapter *padapter)
--------------------------------

the missing warning appears:
----------------------------------
WARNING: externs should be avoided in .c files
#13: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:13:
+extern unsigned char RTW_WPA_OUI[];
--
WARNING: externs should be avoided in .c files
#14: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:14:
+extern unsigned char WMM_OUI[];
--
WARNING: externs should be avoided in .c files
#15: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:15:
+extern unsigned char WPS_OUI[];
--
WARNING: externs should be avoided in .c files
#16: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:16:
+extern unsigned char P2P_OUI[];
-------------------------------------------
Applying this ugly patch to debug:

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index df8b23dc1eb0..ecbbb731361c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6810,6 +6810,11 @@ sub process {
 		{
 			WARN("AVOID_EXTERNS",
 			     "externs should be avoided in .c files\n" .  $herecurr);
+		} elsif ($realfile =~ /\.c$/ && defined $stat &&
+		    $stat =~ /extern\s+/)
+		{
+			WARN("AVOID_EXTERNS",
+			     "print stat value\n" .  $stat);
 		}
 
 # check for function declarations that have arguments without identifier names

--------------
I get:

WARNING: print stat value
+#include <XXXXXXXXXXX>
 #include <XXXXXXXXXXX>
 #include <XXXXXXXXXXXXXXX>
 
 extern unsigned char RTW_WPA_OUI[];
WARNING: externs should be avoided in .c files
#14: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:14:
+extern unsigned char WMM_OUI[];

WARNING: externs should be avoided in .c files
#15: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:15:
+extern unsigned char WPS_OUI[];

WARNING: externs should be avoided in .c files
#16: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:16:
+extern unsigned char P2P_OUI[];

I don't know if it's best to fix the regex of the particular "extern in .c files issue"
or maybe how the statement is computed. Should a statement represent a single line?

Suggestions are welcome,

fabio
