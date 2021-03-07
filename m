Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D68832FE57
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 02:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhCGBdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 20:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhCGBdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 20:33:22 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641EDC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 17:33:22 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b15so1213927pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 17:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=odz3qsxKjryCQfF/I8BZ9Bit9VVwbcSu5aab+WzDkDM=;
        b=GdJ+bkiwiwMeoh+RezjeOedX1o4tHNAGN+wV1kic8jqjKuk/BcjdgaudI7QT/D9ud2
         A6tdevraLbgZCVZBTVg5iL93KyQAomACOTK/MbQL84MMdnyVSyyC+PG7SmDQ24XG4hT6
         0FUdj01OLzkj8DkjaawdoP7yQirRQMAtF8I/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=odz3qsxKjryCQfF/I8BZ9Bit9VVwbcSu5aab+WzDkDM=;
        b=jeB0NX4klWFRE5oYUD+ct08l0FIJMoK+h+3TgW0xVplq5noO/8xC+gKHxFLJzC/esi
         dSyRy6f1FLWqUBKKxYsGyLrxQqF8il2AeyBb7iRTWI3iAovq86v9ei562tjdNkRt4jJk
         U0MzQHc+7G4kC6Z8841GYmQeq/CUZ6EX/HuZ8acJTke5OD/sJiCMqzgy7+q/dR8VXLrQ
         N2l2WIwY2rWacJF6wsGZAGR2S9BWegnhNv+CF+3GW2VGQmGxI7zfQ7xMBTHwETQWfo3J
         geB6m834eh8qFHLNbb1zGXeDTictsV/99Rdl5Wvbq3yXHNahVx2/ZpsTmCzRIKjmZC7V
         oYIw==
X-Gm-Message-State: AOAM532eEkUS+V/ggRfpU1fGi2nV9Nq3siNoBUdOcwVJupoARWqZKbcz
        ZmR36jAJyxLNCGd59Xvdr9EVTSlBm5mwmw==
X-Google-Smtp-Source: ABdhPJzxz6CWc24so1S+D/77Q5LumcDuTMkAXBCbiJxm58vXRhjCTFMVI96DcJE3iazuanixEfR21w==
X-Received: by 2002:a17:902:8218:b029:e6:190e:48e with SMTP id x24-20020a1709028218b02900e6190e048emr603726pln.33.1615080800695;
        Sat, 06 Mar 2021 17:33:20 -0800 (PST)
Received: from braindead.localdomain (c-71-202-115-154.hsd1.ca.comcast.net. [71.202.115.154])
        by smtp.gmail.com with ESMTPSA id 68sm6340538pfd.75.2021.03.06.17.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 17:33:20 -0800 (PST)
From:   Wren Turkal <wt@penguintechs.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Wren Turkal <wt@penguintechs.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Expose the bus kernel docs to the build docs.
Date:   Sat,  6 Mar 2021 17:33:01 -0800
Message-Id: <20210307013301.39420-1-wt@penguintechs.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before, the bus type related APIs that were defined in the
include/linux/device/bus.h were not referenced anywhere in the docs, so
I linked it to the bus types api documentation.

Signed-off-by: Wren Turkal <wt@penguintechs.org>
---
 Documentation/driver-api/driver-model/bus.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/driver-api/driver-model/bus.rst b/Documentation/driver-api/driver-model/bus.rst
index 016b15a6e8ea..4cd237ded827 100644
--- a/Documentation/driver-api/driver-model/bus.rst
+++ b/Documentation/driver-api/driver-model/bus.rst
@@ -144,3 +144,5 @@ sysfs directory using::
 
 	int bus_create_file(struct bus_type *, struct bus_attribute *);
 	void bus_remove_file(struct bus_type *, struct bus_attribute *);
+
+.. kernel-doc:: include/linux/device/bus.h
-- 
2.30.1

