Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40937336C55
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 07:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCKGgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 01:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhCKGg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 01:36:27 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1AFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 22:36:27 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id m7so410412qtq.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 22:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=cVlsegXfufNaWsPC2Pm9hUlY1IiJtpRTjvMZQUD8BbI=;
        b=Wd7YNatTrZoeu7QAs0OgU9bgMdxTtfKHArw6ehvO1Nrt7Jx0XenmVMQ//ZBzfBsKb5
         J+3XqT5QVHY55lnqomyCT79FUNZXX/0BGbE+ZZsqhA33FrBXG5d6fdNR78YKGSHc0zst
         5MGdrupGK9F2hsztP44T36Sle+jyAJi0scMOeivcUVTRfkBkE9+/fSqqlmmmNIfCkUSe
         tJJ9CSrAbOHRvsfUTG3h/S0WvG7p8Revm0L79NOvibmJxriRa/hlNpAsJ8pEFlS9xKmM
         0TTiPIHoTvGFfDQWGlN5vSH2kG0xZj6Thd2TfYFUCqpX+lp1FbsoeHBVEfr+ZEqzWm0O
         DFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=cVlsegXfufNaWsPC2Pm9hUlY1IiJtpRTjvMZQUD8BbI=;
        b=Q2J4toxd0A6qL3ex18JeyVtvO/0JImzjSKfU5yUivpmP5CJY95RLuh0FnOkBDCHqBL
         AINHULuAJL2sB0nSKd+2wi9uq4iHFIbUzGPLOdPmTlJ1HUPrnNdJGy4fXfVV9hkp2Arv
         Lrpz/xANN/nS5LNLgUS2v5t5vL1PEL6R962lVx0qcFv8h1tItskaSpPIl6YUZuF+P67i
         /5K6csK8R+A1QHAFufoCxWAxwlpvemEBa6OZCV7RzHiuxbS9QKMpz+9e4rY9eANewrO4
         tyyUf2t98x0aNugW7861lW+Ra0iDLP+y403xx3qlcE3cF+ZMOmXBhJ2ZxjSthI7xP+6x
         TSWw==
X-Gm-Message-State: AOAM532JJ9c2hKrfvONNn87gtoz5ObDWvIExEgtMbKl9OKKUqNHIgy67
        22u5fHzIESl9tlGjt3Ca+Lw=
X-Google-Smtp-Source: ABdhPJwhA43AFPOXtUyguUbbd4gB3Wb84tC3dF5zo7u5ivDQ/9ZVKwryKSIDHLSWUUaJN8EyAOpAFA==
X-Received: by 2002:ac8:550b:: with SMTP id j11mr6010076qtq.360.1615444586892;
        Wed, 10 Mar 2021 22:36:26 -0800 (PST)
Received: from Gentoo ([156.146.55.115])
        by smtp.gmail.com with ESMTPSA id z4sm1319094qkb.94.2021.03.10.22.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 22:36:26 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:06:16 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, glaubitz@physik.fu-berlin.de,
        linux-kernel@vger.kernel.org
Subject: [unixbhaskar@gmail.com: [PATCH] ia64: kernel: Few typos fixed in the
 file fsys.S]
Message-ID: <YEm6YJrKHUZx51Uu@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, glaubitz@physik.fu-berlin.de,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Bhaskar Chowdhury <unixbhaskar@gmail.com> -----

Date: Thu, 11 Mar 2021 11:40:58 +0530
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: unixbhaskar@gmail.com, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: kernel: Few typos fixed in the file fsys.S
X-Mailer: git-send-email 2.26.2


Mundane spelling fixes.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
   Randy and Adrian felt it should go through your tree..so...

  arch/ia64/kernel/fsys.S | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/kernel/fsys.S b/arch/ia64/kernel/fsys.S
index 0750a716adc7..2094f3249019 100644
--- a/arch/ia64/kernel/fsys.S
+++ b/arch/ia64/kernel/fsys.S
@@ -172,7 +172,7 @@ ENTRY(fsys_gettimeofday)
  	// r25 = itc_lastcycle value
  	// r26 = address clocksource cycle_last
  	// r27 = (not used)
-	// r28 = sequence number at the beginning of critcal section
+	// r28 = sequence number at the beginning of critical section
  	// r29 = address of itc_jitter
  	// r30 = time processing flags / memory address
  	// r31 = pointer to result
@@ -432,7 +432,7 @@ GLOBAL_ENTRY(fsys_bubble_down)
  	 *	- r29: psr
  	 *
  	 * We used to clear some PSR bits here but that requires slow
-	 * serialization.  Fortuntely, that isn't really necessary.
+	 * serialization.  Fortunately, that isn't really necessary.
  	 * The rationale is as follows: we used to clear bits
  	 * ~PSR_PRESERVED_BITS in PSR.L.  Since
  	 * PSR_PRESERVED_BITS==PSR.{UP,MFL,MFH,PK,DT,PP,SP,RT,IC}, we
--
2.26.2


----- End forwarded message -----
