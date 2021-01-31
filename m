Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEA3309CD7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhAaOYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbhAaNhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 08:37:46 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20ABEC0613ED
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 05:36:59 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id e2so15391861lfj.13
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 05:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2fUb+aaBELq0rEVzt2KbqsNvX2OnZcgMHSYwoPC7nS0=;
        b=YLLBr18wO6GGFEJyO8oWjW6NEljfLgWkFgF0WTiyLeiall8tdht1tG89L+cDUUTNvd
         ziIpe2n5D04eauPRhN1Ep4cMaX0d2neI77ppm0G91nyFiRGNb/XfKa702/bb5DdRN7QB
         03fQYfVQfj9595v7Vonr4WPKLmAJKdoD06kM5cJKKH6Rc7yID1zDi5gtPZ7ciamFX1eO
         E1QU+REDVIqoC+Y3XISn57nziqjVNGuDxxAC7b2251cEC9dpGw19C11ml4xLlH6ulxz9
         HCt7dhEbLvLIO2RZvRxbMUucEX3rNn2o3ziH9DECvN88nhOOjkdwX/PL+sv1Vc7vjXdH
         qaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2fUb+aaBELq0rEVzt2KbqsNvX2OnZcgMHSYwoPC7nS0=;
        b=Y2nUUlyLM+YNsgnWpZjYoHFU7DRbJ1kh+XFWZUcRtY0TGANYRoUzCR2vVe8hSVjUp1
         6eZVYGtBmEd6ZQZxr8/BQs3Vp+toamkosWV68i//1CJbTjegYHLoiob7blpPXq+kgAkY
         /yC0cT1J+vOq7Aj8bBdoz5TwZ/iIsnuvRIHFmuvzUU/aO82nTwsW4E5Blemine6H5Nu6
         OuFYxd3rpgYy3okv6Y9qaxO9FpnVCPCSwI44HcbOHsFMkxuFnysVUXTdrtJK5c8gjUYe
         a51IlUR+wZjiVGR9mHrsVxq7tg4gsl7Xa9Ap+SOwtQD1KbfVvXxB2xIVvQzvZopDOxpV
         aXqQ==
X-Gm-Message-State: AOAM532wxlBWIllsHypOONunXInLRCS3n4U+7KZZU27iRRP9Q7pKNF7q
        +BZ+rr0NxUxluCXB7riH2dk=
X-Google-Smtp-Source: ABdhPJwBxuDgFcRtCekS3hdsAjmvGF0+To+nhRUaHXoQHeqqQRslFjEW5KPvMLW+S0jQzbYejcOzPQ==
X-Received: by 2002:a19:8186:: with SMTP id c128mr600941lfd.377.1612100217702;
        Sun, 31 Jan 2021 05:36:57 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id m8sm3391216ljb.32.2021.01.31.05.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 05:36:57 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/3] mfd: pcf50633: Constify static struct attribute_group
Date:   Sun, 31 Jan 2021 14:36:44 +0100
Message-Id: <20210131133644.8834-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210131133644.8834-1-rikard.falkeborn@gmail.com>
References: <20210131133644.8834-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of pcf_attr_group is to pass its address to
sysfs_create_group() and sysfs_remove_group(), both which takes pointers
to const attribute_group structs. Make it const to allow the compiler to
put it in read-only memory.

Done with the help of coccinelle.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/mfd/pcf50633-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/pcf50633-core.c b/drivers/mfd/pcf50633-core.c
index 148bcd6120f4..0768d684113a 100644
--- a/drivers/mfd/pcf50633-core.c
+++ b/drivers/mfd/pcf50633-core.c
@@ -131,7 +131,7 @@ static struct attribute *pcf_sysfs_entries[] = {
 	NULL,
 };
 
-static struct attribute_group pcf_attr_group = {
+static const struct attribute_group pcf_attr_group = {
 	.name	= NULL,			/* put in device directory */
 	.attrs	= pcf_sysfs_entries,
 };
-- 
2.30.0

