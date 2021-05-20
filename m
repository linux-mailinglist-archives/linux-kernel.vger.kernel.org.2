Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D1438AF73
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbhETNA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243534AbhETNAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:00:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC4CC07E5F2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:25:51 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h4so17431482wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iake2F5SCqL96uP7ue4UGSnXZRKlzS1m33y5dac9NCQ=;
        b=oDFTfAAAWe1ZccivV9vnUbldHQghKuaYh75rny/yV4nmtno8d05eavadzGyGqJbhg5
         bIhmDo5beDOYKUM0xCZKhT7cWw6XZOqpJ3LlkeUPmN/wx9w3rBns6zoxTXBsDeHxYrOA
         98vJwg4Ai42N7ZxorY4kQKVHcGRZcnw3bx0zLDoJF9g+i0BPszT0CQbhmdheSp56jz4h
         tdgyN4Rnuya/RsCTNrm9REX1XwC41GZHWIVikyXyS15iS2HcURA8jg/zd66XAKKaBEqz
         tcIcB4lnZyMw29FsdAc+9phu/LDJj4UuFlLT3C98crUHMfqD/aezKyqckbXT+X5K4HKr
         zmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iake2F5SCqL96uP7ue4UGSnXZRKlzS1m33y5dac9NCQ=;
        b=CEVIrgjVXeWRcTlSvTYHeL9Op1Y9V9hGpcMdc87MLzozpQtPjO2mzqhFLo5AK9TV4D
         663AaqX1NtXmMSeJSNxUFI5cFXP+q9Xva2isMOejcu8VOUC6Pqby963Fzl4Be2VhRCDP
         VFry7JHf581D+UC8k/wOwfhOLu/roOODDTMWjfbqlPobs4ozf5J7GcgpEi3+mZjuRjEJ
         JnJRHFok1rnatdB4+bOtfDt+ugQmHdTFvSPW4dB2mTedqRPkFXE4xSh7wrI+/Cj3tlff
         RAMayerN3GWcddhemrLhpRbbVo4e++uWUpJLdUHBqzHz7Wjys3rR226Fi5mw4WvtAWN2
         KnEA==
X-Gm-Message-State: AOAM533AeGvumPLTVSw5VFHBRPysgCYkn0pwNq34AcZko9RlOJtw9Wnr
        wtbKJ72kxI+zYTaU0fGK0W/ncw==
X-Google-Smtp-Source: ABdhPJyw/pJKuyjGhmfBWQzQ095HIZL4gldZsVBTphZkrJrj9Hn0Sp0waI2jo1RWYamFVis+mj/7Mw==
X-Received: by 2002:a05:6000:180e:: with SMTP id m14mr4035783wrh.229.1621513550423;
        Thu, 20 May 2021 05:25:50 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id i11sm3205643wrq.26.2021.05.20.05.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:25:49 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Spencer E. Olson" <olsonse@umich.edu>,
        linux-staging@lists.linux.dev
Subject: [PATCH 4/6] comedi: drivers: ni_routes: Demote non-conforming kernel-doc headers
Date:   Thu, 20 May 2021 13:25:36 +0100
Message-Id: <20210520122538.3470259-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520122538.3470259-1-lee.jones@linaro.org>
References: <20210520122538.3470259-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/comedi/drivers/ni_routes.c:249: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/staging/comedi/drivers/ni_routes.c:398: warning: Function parameter or member 'routes' not described in 'ni_route_set_has_source'
 drivers/staging/comedi/drivers/ni_routes.c:398: warning: Function parameter or member 'source' not described in 'ni_route_set_has_source'
 drivers/staging/comedi/drivers/ni_routes.c:524: warning: Function parameter or member 'src_sel_reg_value' not described in 'ni_find_route_source'
 drivers/staging/comedi/drivers/ni_routes.c:524: warning: Function parameter or member 'dest' not described in 'ni_find_route_source'
 drivers/staging/comedi/drivers/ni_routes.c:524: warning: Function parameter or member 'tables' not described in 'ni_find_route_source'

Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: "Spencer E. Olson" <olsonse@umich.edu>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/comedi/drivers/ni_routes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/comedi/drivers/ni_routes.c b/drivers/comedi/drivers/ni_routes.c
index 1f2aa3b239a0d..f0f8cd424b309 100644
--- a/drivers/comedi/drivers/ni_routes.c
+++ b/drivers/comedi/drivers/ni_routes.c
@@ -245,7 +245,7 @@ unsigned int ni_get_valid_routes(const struct ni_route_tables *tables,
 }
 EXPORT_SYMBOL_GPL(ni_get_valid_routes);
 
-/**
+/*
  * List of NI global signal names that, as destinations, are only routeable
  * indirectly through the *_arg elements of the comedi_cmd structure.
  */
@@ -387,7 +387,7 @@ ni_find_route_set(const int destination,
 }
 EXPORT_SYMBOL_GPL(ni_find_route_set);
 
-/**
+/*
  * ni_route_set_has_source() - Determines whether the given source is in
  *			       included given route_set.
  *
@@ -506,7 +506,7 @@ s8 ni_route_to_register(const int src, const int dest,
 }
 EXPORT_SYMBOL_GPL(ni_route_to_register);
 
-/**
+/*
  * ni_find_route_source() - Finds the signal source corresponding to a signal
  *			    route (src-->dest) of the specified routing register
  *			    value and the specified route destination on the
-- 
2.31.1

