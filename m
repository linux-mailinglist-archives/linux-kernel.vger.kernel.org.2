Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307C03C89E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhGNRlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhGNRlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:41:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E725613BE;
        Wed, 14 Jul 2021 17:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626284334;
        bh=lu4E99+VlD+VteTU0c7rsugJIogDlCtx+P3Ik3XMfmk=;
        h=Date:From:To:Cc:Subject:From;
        b=MgCEFF93YlBo+KW7/779T2U1km9osAwJn9tR+fdqek0uZrhKAGWAHvTFpv+WDWzra
         A0LjdKYZKbT0QjyGX4H41ZBnNfaUmqzaIxUWf0bDHM5o0RIRLbl0Cku7D5B1OdoAIu
         /qmBqc5yvhc0rwyYZEYwZpC5r0w/f/KP92OiYHNenxmgYWaU1CFHpr8hbhOqDQ+hZu
         RtvxJ/mLyRcyW+CwBWYXktov3uCkIyzlu/FL5PfzpcTqNrx1vDyVOJ8Ta5Rjaz8ash
         luc6Vukj0T8iPC6jYJMN/wSf/OflPYPN4mf9ey6Dx1MHbW/+PHgeFbHeopSPvWGPMn
         OK0NjBjOGkZcA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B297C403F2; Wed, 14 Jul 2021 14:38:51 -0300 (-03)
Date:   Wed, 14 Jul 2021 14:38:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] tools headers: Remove broken definition of __LITTLE_ENDIAN
Message-ID: <YO8hK7lqJcIWuBzx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, added this to my local tree.

commit adfb906cb3ee7b941a5de71dbb72b6de1ee258db
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Wed Jul 14 14:28:02 2021 -0300

    tools headers: Remove broken definition of __LITTLE_ENDIAN
    
    The linux/kconfig.h file was copied from the kernel but the line where
    with the generated/autoconf.h include from where the CONFIG_ entries
    would come from was deleted, as tools/ build system don't create that
    file, so we ended up always defining just __LITTLE_ENDIAN as
    CONFIG_CPU_BIG_ENDIAN was nowhere to be found.
    
    This in turn ended up breaking the build in some systems where
    __LITTLE_ENDIAN was already defined, such as the androind NDK.
    
    So just ditch that block that depends on the CONFIG_CPU_BIG_ENDIAN
    define.
    
    The kconfig.h file was copied just to get IS_ENABLED() and a
    'make -C tools/all' doesn't breaks with this removal.
    
    Fixes: 93281c4a96572a34 ("x86/insn: Add an insn_decode() API")
    Cc: Borislav Petkov <bp@suse.de>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/include/linux/kconfig.h b/tools/include/linux/kconfig.h
index 1555a0c4f34514bf..13b86bd3b7461d27 100644
--- a/tools/include/linux/kconfig.h
+++ b/tools/include/linux/kconfig.h
@@ -4,12 +4,6 @@
 
 /* CONFIG_CC_VERSION_TEXT (Do not delete this comment. See help in Kconfig) */
 
-#ifdef CONFIG_CPU_BIG_ENDIAN
-#define __BIG_ENDIAN 4321
-#else
-#define __LITTLE_ENDIAN 1234
-#endif
-
 #define __ARG_PLACEHOLDER_1 0,
 #define __take_second_arg(__ignored, val, ...) val
 
