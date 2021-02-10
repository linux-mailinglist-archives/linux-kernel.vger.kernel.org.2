Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66562316078
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbhBJIAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhBJIAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:00:38 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD2C061574;
        Tue,  9 Feb 2021 23:59:57 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id l12so1765931edt.3;
        Tue, 09 Feb 2021 23:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6+Y+v0mf5SvNQeLGUI6zmXJKmFCPE8MP5k1v0xa403Q=;
        b=b4XWVQ7l167lCCU8tm3PcBUEZenz+6KZuxZicTmhBF6ZaqXf4F0WpbEgmO9odZSyeQ
         QS+gwT1guxNGc8txE8JNkjHmnHOZ4fIjhcYnZj8iomLcMmEXouN1ErVvR8+vh74T4Kq0
         VStESSSuV9kkuVn4d/9QFL9YAVhnu9+9/ASSbKaRUXyxDixTkQQK29PulZ04pv7PJ/bN
         1r4Yt3wwXFEQA4XGt3Qm8OY0KJ6SFwlBVo7lZP3iI4iMPqgUQhpB7zT0ejz42c4zIE+z
         cgpPTfyHpwR/P/CVBG/giG4QxD1/N//ZEw4k7jOl9eQF0B1pLMz7l8l2iEQ6y4lf8x63
         rJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6+Y+v0mf5SvNQeLGUI6zmXJKmFCPE8MP5k1v0xa403Q=;
        b=BKwcGqn2YBSSRz1NwKDi2fLTbHBWsQitTrxOAMJs/hlOukS4ptwEZ2qxlQP69tm/Xt
         sOyfQmacjjVinRtcTQDujlsz48mtpSyTI7QRxkskN5DwMN10q9rzll2lcyHQLNfwXpUl
         laGYruyHZnRKIBx8OgJI6tZd9piKrklqlwOj7/cxrymdwumPDOG8cJOP8Xv7ouBq1ne1
         DnElvnUVkED+vIce4gvxsidmieiQdXOKhPT6fJK0TGZFSYjokJeuUNAoOFzA6dub679g
         pG8wcmousA8C7CmjDaLC18IbCPuILOa/OYk3+5gIJy1WFsioIV5mxjzfJsA9g9C/k0nD
         sfPQ==
X-Gm-Message-State: AOAM533wHD0WH+GZaEwt1D7k0UwE/yAfMG9QiFCcvGLSjzA8U44p/b5D
        8YFn3LIv/gPrmSiqQwuEjUrAk4EKcfYGZw==
X-Google-Smtp-Source: ABdhPJw2mVlmcWbZgsGJ6E4Ewxaxytwh9nNbkSiFkNHSY5JfY9tBfHckwV+HRFWfPpaYFdLoLONV6w==
X-Received: by 2002:a50:e882:: with SMTP id f2mr2028558edn.35.1612943996343;
        Tue, 09 Feb 2021 23:59:56 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d7e:e500:60d3:cde9:82a5:6b47])
        by smtp.gmail.com with ESMTPSA id l5sm433116edv.50.2021.02.09.23.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 23:59:55 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org
Cc:     Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: replace non-matching patterns for loongson{2,3}
Date:   Wed, 10 Feb 2021 08:59:47 +0100
Message-Id: <20210210075947.15604-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ffe1f9356fbe ("MAINTAINERS: Add Loongson-2/Loongson-3 maintainers")
adds quite generic file entries for drivers/*/*loongson{2,3}* and
drivers/*/*/*loongson{2,3}* to be informed on changes to all loongson{2,3}
files in drivers.

However, only the pattern 'drivers/*/*loongson2*' matches to one file in
the repository, i.e., drivers/cpufreq/loongson2_cpufreq.c; all other
patterns have no file matches.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F:    drivers/*/*/*loongson2*
  warning: no file matches    F:    drivers/*/*/*loongson3*
  warning: no file matches    F:    drivers/*/*loongson3*

As in the last two and half years, no further files and drivers have
showed up to match those patterns, just name the one file that matches
explicitly and delete the others without a match.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201102

Keguang, Huacai, Jiaxun, please ack.

Thomas, please pick this minor non-urgent cleanup patch.

 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b4197e9da495..fc08f628e196 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11719,8 +11719,7 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	arch/mips/include/asm/mach-loongson2ef/
 F:	arch/mips/loongson2ef/
-F:	drivers/*/*/*loongson2*
-F:	drivers/*/*loongson2*
+F:	drivers/cpufreq/loongson2_cpufreq.c
 
 MIPS/LOONGSON64 ARCHITECTURE
 M:	Huacai Chen <chenhc@lemote.com>
@@ -11729,8 +11728,6 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	arch/mips/include/asm/mach-loongson64/
 F:	arch/mips/loongson64/
-F:	drivers/*/*/*loongson3*
-F:	drivers/*/*loongson3*
 F:	drivers/irqchip/irq-loongson*
 F:	drivers/platform/mips/cpu_hwmon.c
 
-- 
2.17.1

