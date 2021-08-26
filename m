Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971C63F843E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 11:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240924AbhHZJOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 05:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240883AbhHZJOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 05:14:40 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F304C06179A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 02:13:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f5so3828635wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 02:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LheJq9C51RQ5DWB1Tf2hPqzaPi3xdJvxhj11oVFW+lg=;
        b=Zf5OIRF9/TmyBjplaz9MxvYQIdkgnvf7MtJWhFj3U4DxdaZe52FP/rpaCa+X/zhww/
         GAxRNpu8FgCdRNwY0Yfo828xnw1TD6EHXup4Bqho9K7MK0NsS9KjlpPEZoDtcrZAwuue
         blfPq4masva3VxxY0qH0n++VVXYBmFX5VD6VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LheJq9C51RQ5DWB1Tf2hPqzaPi3xdJvxhj11oVFW+lg=;
        b=SODjsQfR9GUtg+259OsqeRBolLs0MUDowtN0sU1Sld4L8EPF02rZzRxhbLYaplRiIS
         p2O9r+rdjamZYWB5Dtd1WnrPF1Vx57vY6fFhzhAlZvgJ53W9Nc6pVEM8Gu1Wp688wzU9
         I3kPNrrLKWsGSWxmnT3FgYW23aYRMkIK3IKOF/sg9c4UyXJMMlN0Bat8odna580WT4/4
         07rhYoB7J/Q223tsS9LjlD8pNscLMkgkO+sRXhDHuSaurOjPLOFfmTM8OR60l0QxMAY0
         JiwzrAwj3pb/++qLtht7imMC2I54WEzEEx3jxGp78Hjb6ddLj53dLtCH/AE/ah/eEUNO
         Duvg==
X-Gm-Message-State: AOAM531B5PwOAjYfLiDywufRjtkNKDUv7WX8slUrDMBegfalQoGsEWPC
        tudQXhnyxWeRP561YiIcFMzI08hvIV3mRg==
X-Google-Smtp-Source: ABdhPJwBwXOa9q2M+caTrLd8CrrQjpc3NJ0hbf/XOSIVErz9DzgYIndPCJz9FnAwnPEoIc2tnjqshw==
X-Received: by 2002:adf:f646:: with SMTP id x6mr2706080wrp.0.1629969228810;
        Thu, 26 Aug 2021 02:13:48 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n10sm2411570wrw.76.2021.08.26.02.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 02:13:48 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] MAINTAINERS: Add dri-devel for component.[hc]
Date:   Thu, 26 Aug 2021 11:13:43 +0200
Message-Id: <20210826091343.1039763-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dri-devel is the main user, and somehow there's been the assumption
that component stuff is unmaintained.

References: https://lore.kernel.org/dri-devel/CAAEAJfDWOzCJxZFNtxeT7Cvr2pWbYrfz-YnA81sVNs-rM=8n4Q@mail.gmail.com/
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ac58d0032abd..7cdc19815ec4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5707,6 +5707,11 @@ F:	Documentation/admin-guide/blockdev/
 F:	drivers/block/drbd/
 F:	lib/lru_cache.c
 
+DRIVER COMPONENT FRAMEWORK
+L:	dri-devel@lists.freedesktop.org
+F:	drivers/base/component.c
+F:	include/linux/component.h
+
 DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 R:	"Rafael J. Wysocki" <rafael@kernel.org>
-- 
2.32.0

