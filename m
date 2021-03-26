Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C88134AA0F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhCZOg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhCZOfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:35:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03587C0613B2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x7so5843030wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QyPG1WEqZFTBuDaWcANV4HkcWu30kB5AaRBOC44dMcU=;
        b=SnsafZq5e1+1/iZIm3WR65o+iG0/ODTGJk/7ETvhgN7CEu5HRWnJNdVg40nfYqWfbO
         UrEREZCk+q7udUP3bSU6brrWo0DOtTSI3CB7EiYpN7gXdmEQcOckMpy98SbOeP3fhTgr
         trT8s1skyIzCkbNsKuVRNWDT7iRn2yQlM1ci7v5Os1fDRxy7vdC+plqlnzyIRaik7+RT
         4xpRSsPSu0x+pBNYHgzwq9UqGThUsue8SOorkldDqqlMvWOgRYoWeyT6Chmu5UpbBFs0
         0Zwt3zL3d5AtE3n/fveorFHLgLuj2uawCORzzBqxKqvgx5bom7hWgYbrCOUIg5c8XKih
         BU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QyPG1WEqZFTBuDaWcANV4HkcWu30kB5AaRBOC44dMcU=;
        b=rKJi2NA9aSsJMwPxlpD931mgPWhEa83/HxnPVaTw2KLPTCZ1OhPe4g+bU2gahrvCB8
         kDRVrvNa9fSvgdn3GI1MLBI7ajvMbC0CCy4WYKOtr26wYzL+6EYnM/3P77ZTt7D6UwC+
         GeEJazKN0ZIYNbNJUnzo9VBlqYi6eAo6nZsjPLrVSA+bdZ/fQ/4DBFcx3heVupi8Hsh7
         KC0F4FuSS9qrUs+tNa7xcM14DqFHIuO7M3vd/sqDnkVvlAQE9NwzNegqVEbugHxbPwBj
         uR/0kW4COV9fp9zi/j4VzZAMDrBHNgUrNVnTdbON5lXCCs4yWHIfiUoMeLYRYnyr/CzJ
         rfkg==
X-Gm-Message-State: AOAM53242eqq0AnKUWXUf0Rve4M8n+0ajaxE2Pmzrp8/LZmfylSv4ZXc
        1mLg9kPu2V6SZdNQ160BTRFSRw==
X-Google-Smtp-Source: ABdhPJwOUj3cYauEQvI4kOqQkvYnSogsSqs1r7Xq61RvYSr9UXt0UirtesVDyK9o5Z5ECViF7WsNeg==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr15089412wrp.112.1616769318787;
        Fri, 26 Mar 2021 07:35:18 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 17/25] HID: hid-uclogic-rdesc: Kernel-doc is for functions and structs
Date:   Fri, 26 Mar 2021 14:34:50 +0000
Message-Id: <20210326143458.508959-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/hid-uclogic-rdesc.c:645: warning: wrong kernel-doc identifier on line:

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/hid-uclogic-rdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index bf5da6de7bba9..6dd6dcd09c8bc 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -641,7 +641,7 @@ const __u8 uclogic_rdesc_pen_v2_template_arr[] = {
 const size_t uclogic_rdesc_pen_v2_template_size =
 			sizeof(uclogic_rdesc_pen_v2_template_arr);
 
-/**
+/*
  * Expand to the contents of a generic buttonpad report descriptor.
  *
  * @_padding:	Padding from the end of button bits at bit 44, until
-- 
2.27.0

