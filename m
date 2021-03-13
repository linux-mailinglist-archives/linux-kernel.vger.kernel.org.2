Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3014333A18B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 22:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhCMV6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 16:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbhCMV6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 16:58:18 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EB2C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 13:58:17 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id bt4so6888656pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 13:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lnk3PySiNNRNpdtAa9FMD7rzrJM24IssSyMpOzucki0=;
        b=TB3QGkEfYmt9sg9saceMJPJ07KHVMuJs6heKAUODzKBpM+IqmmmLX+kWeG1XBdDEym
         mhXq1SLQdeqSEt1X9SyTvJWYCkyHTDq6Wn0QUGBtlHyQxue3peSJGA+Aq13fci7GBSvr
         vnc7mlFbnzrAGhkQnmMMJAbI48LfA/uGoxXg3ZwT8Ir8eBDri/IQcV5LBv6E79KxVgwQ
         +tK0cGzcWzCuN+qa3OXHkVGMnsWPmwrPQna6gvTxK9hoBeWdeTQIMO1NtLsX9LB51sHY
         j9uWGJGQOqiJH0PCI6bXv/FokG4iv0B28+ytwg9vEQq+ivOTC6wUBbc08WVErKCGfTZL
         d/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lnk3PySiNNRNpdtAa9FMD7rzrJM24IssSyMpOzucki0=;
        b=BYRPvgPVFlZvyZzPYjLYDAN3vTZuVop/T3Tzm27HBDsID38T3AdmzYIvnx4a+iOH33
         nGttNV+EaeY2n5YK5RnDalZyoPa1QIrDaRdx0nW+/e/b7TIrKAf0eMXkrw3b8i29Xo32
         ZDxdH79Gkkel23uxJpRDQRPGBDEwOH9hIqcUt/k07I9vQ8VoHkWUKuYaOsShcyLHe9ij
         yFXkXJXf9P4gLv/5fpTT196xl/izjX4Tp/bLxyGWfls4eEyWFoW66YqFtY08n6HfIGSj
         tJhXgiRj3dr+81hzXrAo6fRBLYBQSv+O+yF6gJeU1XSrbq7ahaDrcgj3XEIeLXGmm7S0
         3VHw==
X-Gm-Message-State: AOAM530V61rnHepcrEiUmiB16Z2T5JQqEyOEgaW1WRZdBdr1m6ieA9+A
        58BKgmnV+Zo7JzErxVncQt66WyaNoRGTTed6
X-Google-Smtp-Source: ABdhPJxQHWm9NJRx4jcNAcEO1d4hLIzvLSSizFonvjqCRXggBiCFs/1LqY879k2L4eunpE0PK1F3Sg==
X-Received: by 2002:a17:902:d30c:b029:e3:f95:6da5 with SMTP id b12-20020a170902d30cb02900e30f956da5mr4813972plc.6.1615672697239;
        Sat, 13 Mar 2021 13:58:17 -0800 (PST)
Received: from localhost ([122.179.34.200])
        by smtp.gmail.com with ESMTPSA id q14sm2288747pff.94.2021.03.13.13.58.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Mar 2021 13:58:16 -0800 (PST)
Date:   Sun, 14 Mar 2021 03:28:08 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     jason.wessel@windriver.com
Cc:     dianders@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        bkkarthik@pesu.pes.edu
Subject: [PATCH 1/2] drivers: misc: kgdbts.c: Fix declaration warning.
Message-ID: <20210313215808.dt7uvt2suwq4z4x3@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new line has been added after declaration. This is done to
maintain code uniformity.

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/misc/kgdbts.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index 945701bce553..3ee5acc1c391 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -474,6 +474,7 @@ static int emul_sstep_put(char *put_str, char *arg)
 {
 	if (!arch_needs_sstep_emulation) {
 		char *ptr = &put_str[11];
+
 		if (put_str[1] != 'T' || put_str[2] != '0')
 			return 1;
 		kgdb_hex2long(&ptr, &sstep_thread_id);
@@ -502,6 +503,7 @@ static int emul_sstep_put(char *put_str, char *arg)
 			return 1;
 		} else {
 			char *ptr = &put_str[11];
+
 			kgdb_hex2long(&ptr, &sstep_thread_id);
 		}
 		break;
@@ -740,6 +742,7 @@ static int validate_simple_test(char *put_str)
 static int run_simple_test(int is_get_char, int chr)
 {
 	int ret = 0;
+
 	if (is_get_char) {
 		/* Send an ACK on the get if a prior put completed and set the			* send ack variable
--
2.17.1

