Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4312438292E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbhEQKAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:00:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34613 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbhEQKAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:00:05 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1lia1Q-0002Uj-Pn
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 09:58:48 +0000
Received: by mail-ej1-f70.google.com with SMTP id p25-20020a1709061419b0290378364a6464so820585ejc.15
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MuIfAQM2fPksT8Cjpn/L4q8gn5avsGeJOiJIGmWyxz0=;
        b=abAh/0EOfqo7UcYbEXnIRL6dWPsWfPitJ3qeuDtyKVVLzy3VHigEGXwvZDbY1Bk9Xl
         qJy4fX1tgpJhqBxp/mBf9IkQ9SKJWx41WMabIoZZ8Jor6CnJm1YtU1FpdP7vRyiq8L24
         SVVoQro7ZD8PSoYoEbc7D/jb8hQvmpYk0WP+oI70yBeFfXmVPv3BVwPtqCAvxjKwBmm+
         RYbEZn15qtl16YdCVuoK0EDa8rfksWJlsQ1Y65+LHEOOdx/P0+zU3uwdJ8/zbeqfILiO
         z6R1IzHtDjb5y7XJUiVthuxqzESE7wANqbQ0n1J/c9WXQXYI50CjO10FCF/ArX4xtRKO
         K9BQ==
X-Gm-Message-State: AOAM531QD4yk2OShve4d2kb9o6XgS07VLODd1oxmXVE8qRHpWu8aiJGG
        aI1grCA9seXwZOruAjXz0jBiH2rsgj/CAQZsB0e/PJyF4BOG2e66PgNjtcIpRxtxwLdmva2iqPL
        qVauUBFEcX/90IAuBSE1jCjq6KKJgBlU2SfcmSxIcZw==
X-Received: by 2002:a17:906:2b4b:: with SMTP id b11mr13130490ejg.379.1621245528514;
        Mon, 17 May 2021 02:58:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+S4g2qplOrmASgq0AGDZuzl5+rpuqj0iJRBdrNJn4cONC8fuW4IDa6uiC/zJeD8ei1c/3TA==
X-Received: by 2002:a17:906:2b4b:: with SMTP id b11mr13130475ejg.379.1621245528377;
        Mon, 17 May 2021 02:58:48 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id f7sm10907881edd.5.2021.05.17.02.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:58:48 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     adobriyan@gmail.com, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, juergh@canonical.com
Subject: [PATCH] proc: Remove leading spaces in Kconfig
Date:   Mon, 17 May 2021 11:58:46 +0200
Message-Id: <20210517095846.81983-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leading spaces before tabs in Kconfig file(s) by running the
following command:

  $ find fs/proc -name 'Kconfig*' | xargs sed -r -i 's/^[ ]+\t/\t/'

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 fs/proc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index c930001056f9..e8410a99a0ca 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -81,10 +81,10 @@ config PROC_SYSCTL
 	  limited in memory.
 
 config PROC_PAGE_MONITOR
- 	default y
+	default y
 	depends on PROC_FS && MMU
 	bool "Enable /proc page monitoring" if EXPERT
- 	help
+	help
 	  Various /proc files exist to monitor process memory utilization:
 	  /proc/pid/smaps, /proc/pid/clear_refs, /proc/pid/pagemap,
 	  /proc/kpagecount, and /proc/kpageflags. Disabling these
-- 
2.27.0

