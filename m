Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303C033A18E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 23:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhCMV7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 16:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbhCMV7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 16:59:40 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FB6C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 13:59:40 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id q2-20020a17090a2e02b02900bee668844dso12452897pjd.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 13:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=O7+2eZP2W86H2DLexjazqWbJPqedwA+wictLUHpSxcs=;
        b=qVfJMzeOrAtnNbLOwEyjkoOr0oLuRHf+pTiHwYdIIHsbZSj1lVRQcgApQJTlYj/Iuo
         JvggtYXkSDXnUUNrz/nNvpOrGkg8Ap52BA8FQfqMjelJePtzIw5pi2/9V3Kg34smibP4
         LsIQL+cuakP7ASfmA9kCYx08XnlSl1zPYgUI3dWAgZezKPhTsDg9F1ZYp+Ll4aU/qeAY
         dyu5tJHnAmgWQROGAbhvMjNqy1Gs+xyXaa+OkeZ+vKK7N2S0IUpaA1TqnrlIc8QOvL2V
         6p+PQVzDxwg3jvu6m4fDKh8pdshNK5CmQnt3hgzBWuTZk3mm+Paj68WRP8E9W/xIfCoE
         nukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=O7+2eZP2W86H2DLexjazqWbJPqedwA+wictLUHpSxcs=;
        b=asdOMZd4w1GjI/91fwWjReRy6A2So8Q2qPfWsIgnzz9BNkBBzgor4wt0rAlaW4CnFS
         ba1r5jLilKDSh5M/Kcm/YAT879LGjanm2fdO1jIrwpW+RGpG5i4CMbDG+q0EgwOr8r+C
         Q31imrIbJzxiqDFF7XegWb6F+x58vYlSttvR9KhHpfdBorHMrbsF9Jra633UUrjIvMIT
         qI+B17ox1VsxoUM7H/XVKBLuaSa3fJeYSbvmu4lMiWKy4njoloLgqldVCZmEeLxFKpbh
         fwCXNJ96fWWmXC4iFBxlFufePfwuzahW0T15LyOTdIkS24x/G1j/AAQrWgxG595LsaKI
         HmvA==
X-Gm-Message-State: AOAM531wLFl+F/dVbP29AUUxI2QMwyp1+b278DCW0CyvF2yxc0FzulTx
        61T+6FETl5ejYiD1o9xBRHU=
X-Google-Smtp-Source: ABdhPJybchg4iBw3bSpMm4rz2sxmlLG5WQ6fRzk+Nk8gMiew3PYNZhNhekQu7qk2pyNE5xLDadhJfA==
X-Received: by 2002:a17:90b:358:: with SMTP id fh24mr5392777pjb.109.1615672780356;
        Sat, 13 Mar 2021 13:59:40 -0800 (PST)
Received: from localhost ([122.179.34.200])
        by smtp.gmail.com with ESMTPSA id c22sm8642891pfl.169.2021.03.13.13.59.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Mar 2021 13:59:39 -0800 (PST)
Date:   Sun, 14 Mar 2021 03:29:37 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     jason.wessel@windriver.com
Cc:     daniel.thompson@linaro.org, dianders@chromium.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bkkarthik@pesu.pes.edu
Subject: [PATCH 2/2] drivers: misc: kgdbts.c: Fix indentation warning.
Message-ID: <20210313215937.iiw22mj5jxvd7sef@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An extra space has been removed before tab. This is to maintain
code uniformity.

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/misc/kgdbts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index 3ee5acc1c391..e6e7c5144ab3 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -41,10 +41,10 @@
  *
  * To invoke the kgdb test suite from boot you use a kernel start
  * argument as follows:
- * 	kgdbts=V1 kgdbwait
+ *	kgdbts=V1 kgdbwait
  * Or if you wanted to perform the NMI test for 6 seconds and kernel_clone
  * test for 100 forks, you could use:
- * 	kgdbts=V1N6F100 kgdbwait
+ *	kgdbts=V1N6F100 kgdbwait
  *
  * The test suite can also be invoked at run time with:
  *	echo kgdbts=V1N6F100 > /sys/module/kgdbts/parameters/kgdbts
--
2.17.1

