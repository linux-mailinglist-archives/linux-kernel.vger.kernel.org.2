Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA49E45779F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 21:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhKSULJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 15:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbhKSULH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 15:11:07 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFA2C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 12:08:05 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r8so19975194wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 12:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kryo-se.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w8lQv0HLZhnRec/rbB5x/dMfBhfYGtylv6Ap7LH5bUk=;
        b=jA/cTwTaHvC7XQjxDw83w8voZwXKhCHUMsdEL4O3ZCS+PLDlHmR55GaMIuLy4RlAAm
         6yPCkKQJFjBjxxWFMVWlY5580IoFLFz96F3gOHWdJbG/sDcS5z21Yg543bINRYnySdvc
         ibmuQzhC8ZSPdvC8JnK+LyA1emxjeAUtPWRhBD3xBan1PvvCs+JdD9xMSlzUsgn4mAmG
         dS3BlwgUJD7GXy3PYdnUrYbLhelWRY0qaYa3eRZnSaLAPOTzJQ7Y2dJtd1EYxtMx07SI
         mB6irDWY6z/NBcrsxMRH/cBTujGtKEfbJjjiNnSgmASiQ6GXmZffyTQlL9lqVL1GFw0F
         45Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w8lQv0HLZhnRec/rbB5x/dMfBhfYGtylv6Ap7LH5bUk=;
        b=JuM+fwi2KbjOilkl3IKW2LMEEFMEwqpetKvydmbyZmRs4B9UXIyU+S5dxcKfRcXBSA
         ZhDgEvm9E1h3l3xYo4C2alBmYrSzgNc7T4gZ2cu/hlCGBwkx4fYt5Rzw1obCmGs8Bqrz
         JlFwd1P/rX6n7DPg3EWWXqDY/ywg5+gB7+GeZ3GIW8mFqWL2UOKvwnR8Taxka3mFpfAO
         f3tgdWc9G9meac1mHmsd5GQZRXPNYKiFeA54hb9p8sskLP4fuFCAeeyk8hx+AU2hmMWN
         qXumdfj9k3vdUCCCRUNK7WcXCfi7P3ezygUqMPo/paNxKlLnPLy4L65bbNkeC2naUrxx
         bDtg==
X-Gm-Message-State: AOAM531jhBFyEDY/mYkcb1/3XLYgcrc7USOI4QWtAJ9MTep9Jx7O63rX
        J5vazXGRqDgdszn9aUfr24MEAeQzLCvh3Q==
X-Google-Smtp-Source: ABdhPJwaPfT0uv82oG0+6+zEoC1EApuq/q/Bhsv5Szck70aWaneH6smLCTobQ2jMRHYWvN8l8DbWPQ==
X-Received: by 2002:adf:df0d:: with SMTP id y13mr10859091wrl.176.1637352484048;
        Fri, 19 Nov 2021 12:08:04 -0800 (PST)
Received: from kerfuffle.. ([2a02:168:9619:0:b7be:fc14:9072:c69a])
        by smtp.gmail.com with ESMTPSA id g5sm1090015wri.45.2021.11.19.12.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 12:08:03 -0800 (PST)
From:   Erik Ekman <erik@kryo.se>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Erik Ekman <erik@kryo.se>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/process: fix self reference
Date:   Fri, 19 Nov 2021 21:07:58 +0100
Message-Id: <20211119200758.642474-1-erik@kryo.se>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead link to the device tree document with the same name.

Signed-off-by: Erik Ekman <erik@kryo.se>
---
 Documentation/process/submitting-patches.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index da085d63af9b..6b3aaed66fba 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -14,7 +14,8 @@ works, see Documentation/process/development-process.rst. Also, read
 Documentation/process/submit-checklist.rst
 for a list of items to check before submitting code.  If you are submitting
 a driver, also read Documentation/process/submitting-drivers.rst; for device
-tree binding patches, read Documentation/process/submitting-patches.rst.
+tree binding patches, read
+Documentation/devicetree/bindings/submitting-patches.rst.
 
 This documentation assumes that you're using ``git`` to prepare your patches.
 If you're unfamiliar with ``git``, you would be well-advised to learn how to
-- 
2.33.1

