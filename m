Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B484A45A98C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbhKWREw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbhKWREu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:04:50 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3975CC061714;
        Tue, 23 Nov 2021 09:01:42 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d24so40183249wra.0;
        Tue, 23 Nov 2021 09:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YAopufrfMZ51IGtrg3jTbLpMge5spZgYt27uOrZnXBA=;
        b=nKO46A64Nn9kSMXB1SEY4C49GXR5FBaHOG0W6j27DYcBsFT/YWWtkBApRX3vpIupGx
         B5e/ro1ZWXln9QHkxTIBAbazIcHlLJfN2WKs+2PmfwVGAyN4qbYg7BDb0NspnbJfdUz0
         4UGCPZCuaGaBNUebs3MRN8Mr1DPg5902DGzdR8+8DoNMI1ldmpsxJ2FrltYEBz/EMfVY
         oAZhcou27Z8/yA4ImlANkG/bch0t1cz/LOzwqEud9sxhCcPv91HbOUBn7sxTNid1Cvoj
         7kgj+TmvY7jhfdWEN01iCaUrH3qvgCoV7pzTQl8eGgQEYGinm8iMpv3tVWJc8CBogTgd
         43zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YAopufrfMZ51IGtrg3jTbLpMge5spZgYt27uOrZnXBA=;
        b=uMEVk19djGlxt5rq/G1/gNaJUJhlIE3MesqlQiGb4Se4N9X3t84kBxwHiJtXstskDm
         jppXHP2cqM2PvYBNn8LSyBgQ3kQD5EAmMF7ikBJk2/+qzlesbFqj5y6GOGbHdM3Pd/Sn
         FJ+C6QQXrO6qqUSJHgnjcM7UsL7UX7NPrhtDu0FfaKILfZcaC+xy70SOEJwVdhrj6XRk
         CcPM822RmYv1JQmHeO9M3qw8KlTJ4kv0ozjbfIUWfsI5VHB/VCFA9VdTF00DtoOW37Zi
         UJjuSBZbV5EjZJ9GCnZxIi4auJ8Qq6ybgrhfur7eXgqMd5VEUBMVx1yeJDJRq47TQt4Z
         e+lA==
X-Gm-Message-State: AOAM533aPYiFZoCgmGLMuTyl44iPYs50MStrPbydxuEWAvpbEDlE9iLa
        BtJxSy4XZeqmWUCCkfU1oDU=
X-Google-Smtp-Source: ABdhPJyetI47JKwVIheOYqRKaeL4OcjedUkDWkJjuz1rRSB94ig0upCTfPO3LxIRnBqG2ICTzaw1NA==
X-Received: by 2002:a5d:4b8a:: with SMTP id b10mr8858909wrt.413.1637686899505;
        Tue, 23 Nov 2021 09:01:39 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g13sm17380689wrd.57.2021.11.23.09.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 09:01:38 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch, corbet@lwn.net, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/doc: Fix TTM acronym
Date:   Tue, 23 Nov 2021 18:01:26 +0100
Message-Id: <20211123170126.28446-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TTM acronym is defined for the first time in the documentation as
"Translation Table Maps". Afterwards, "Translation Table Manager" is
used as definition.

Fix the first definition to avoid confusion.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/drm-mm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
index e0538083a2c0..198bcc1affa1 100644
--- a/Documentation/gpu/drm-mm.rst
+++ b/Documentation/gpu/drm-mm.rst
@@ -8,7 +8,7 @@ the very dynamic nature of many of that data, managing graphics memory
 efficiently is thus crucial for the graphics stack and plays a central
 role in the DRM infrastructure.
 
-The DRM core includes two memory managers, namely Translation Table Maps
+The DRM core includes two memory managers, namely Translation Table Manager
 (TTM) and Graphics Execution Manager (GEM). TTM was the first DRM memory
 manager to be developed and tried to be a one-size-fits-them all
 solution. It provides a single userspace API to accommodate the need of
-- 
2.25.1

