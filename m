Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C090446908
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 20:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhKET37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 15:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbhKET3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 15:29:51 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF76C061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 12:27:11 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d70so10956060iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 12:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RyfWj4lDBm5JLTztNtdXlP2pvw82NplVvLHkINaddHI=;
        b=qVKTmYneIDNEr7QHbl1uC6bSNBSf8Y05Zcal5qyh/Ge6l2rhQUhbuYh+2D2KYkKQ9G
         J4rFBTBNnyGKvVx5DJSfolblJfPOyh6MuDPssEL8LsJcHDvEZAQFFG3GfEiv4JuMQIGO
         N11V26vDqADX5L/RiolUjg1mhFkqc6mSXpuNts8eUt+JmZBOsyf+ifOZDYZ1JDhsALjG
         AmhAH3TqBi7pkekDpm6WmDvgNkGlsI3Kch9bjzyIGMN+l822ChvRmhJ3iwP9tmP5Svnx
         LUtBbi7JjRk4d4Mbfsq+a0d/ZU78j9Pw4zsajEcn1iz/djvfSF4sRfHCR7l4XUgVa3pn
         tqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RyfWj4lDBm5JLTztNtdXlP2pvw82NplVvLHkINaddHI=;
        b=SBmiA5nMucJJqcNIkhjh4R36Mg6xrFMfsPy93Q5zU3uqKxjqn9fTxUIQalw9UMQFG4
         ZEgNxlUnL2WDY12UXNGU4icQ9MAxsxF7n6ovLkCM99G6QTvlDRmQZxt+TSkfzHLVgmiL
         zc1hdI9M+wIW6NjoFv1juyNe24kOpfjuKAgWSyCISVndwMPfGe5CKztpZcw2KqBjkne3
         EzSNcV1zoQr9qBjFemFkPfXuNHp1l3A39atY55v66wRVaSuLKB3xAhW92gmnqdGtK1bK
         OOPVQjF2JYDrnTLCMMMTRwt/y4/rQt666jPtt/RZY8uwIkFuI/dWJ0gMl9nBZ1ICq+rJ
         xY6g==
X-Gm-Message-State: AOAM530XWYN0cFrH9L8/xVB5iw4ZpAXxM+h2T9/mR0CKBtyswruSzJvL
        1BbK06HVtak52GwnXHPdEKg=
X-Google-Smtp-Source: ABdhPJxOYt+lweZYvxAHtCNFFp40e2qQJbUadz/cFaCrc5NMal45RzO9yik8UJRD2dfAWz1Q8V1Jqg==
X-Received: by 2002:a02:bb85:: with SMTP id g5mr10708401jan.130.1636140431271;
        Fri, 05 Nov 2021 12:27:11 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l18sm4338617iob.17.2021.11.05.12.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 12:27:10 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, lyude@redhat.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v10 04/10] i915/gvt: trim spaces from pr_debug "gvt: core:" prefixes
Date:   Fri,  5 Nov 2021 13:26:31 -0600
Message-Id: <20211105192637.2370737-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211105192637.2370737-1-jim.cromie@gmail.com>
References: <20211105192637.2370737-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taking embedded spaces out of existing prefixes makes them more easily
searchable; simplifying the extra quoting needed otherwise:

  $> echo format "^gvt: core:" +p >control

Dropping the internal spaces means any trailing space in a query will
more clearly terminate the prefix being searched for.

Consider a generic drm-debug example:

  # turn off ATOMIC reports
  echo format "^drm:atomic: " -p > control

  # turn off all ATOMIC:* reports, including any sub-categories
  echo format "^drm:atomic:" -p > control

  # turn on ATOMIC:FAIL: reports
  echo format "^drm:atomic:fail: " +p > control

Removing embedded spaces in the format prefixes simplifies the
corresponding match string.  This means that "quoted" match-prefixes
are only needed when the trailing space is desired, in order to
exclude explicitly sub-categorized pr-debugs; in this example,
"drm:atomic:fail:".

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/i915/gvt/debug.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/debug.h b/drivers/gpu/drm/i915/gvt/debug.h
index c6027125c1ec..bbecc279e077 100644
--- a/drivers/gpu/drm/i915/gvt/debug.h
+++ b/drivers/gpu/drm/i915/gvt/debug.h
@@ -36,30 +36,30 @@ do {									\
 } while (0)
 
 #define gvt_dbg_core(fmt, args...) \
-	pr_debug("gvt: core: "fmt, ##args)
+	pr_debug("gvt:core: " fmt, ##args)
 
 #define gvt_dbg_irq(fmt, args...) \
-	pr_debug("gvt: irq: "fmt, ##args)
+	pr_debug("gvt:irq: " fmt, ##args)
 
 #define gvt_dbg_mm(fmt, args...) \
-	pr_debug("gvt: mm: "fmt, ##args)
+	pr_debug("gvt:mm: " fmt, ##args)
 
 #define gvt_dbg_mmio(fmt, args...) \
-	pr_debug("gvt: mmio: "fmt, ##args)
+	pr_debug("gvt:mmio: " fmt, ##args)
 
 #define gvt_dbg_dpy(fmt, args...) \
-	pr_debug("gvt: dpy: "fmt, ##args)
+	pr_debug("gvt:dpy: " fmt, ##args)
 
 #define gvt_dbg_el(fmt, args...) \
-	pr_debug("gvt: el: "fmt, ##args)
+	pr_debug("gvt:el: " fmt, ##args)
 
 #define gvt_dbg_sched(fmt, args...) \
-	pr_debug("gvt: sched: "fmt, ##args)
+	pr_debug("gvt:sched: " fmt, ##args)
 
 #define gvt_dbg_render(fmt, args...) \
-	pr_debug("gvt: render: "fmt, ##args)
+	pr_debug("gvt:render: " fmt, ##args)
 
 #define gvt_dbg_cmd(fmt, args...) \
-	pr_debug("gvt: cmd: "fmt, ##args)
+	pr_debug("gvt:cmd: " fmt, ##args)
 
 #endif
-- 
2.31.1

