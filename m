Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF8A31AB4A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 13:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhBMMXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 07:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhBMMXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 07:23:14 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7AEC061574;
        Sat, 13 Feb 2021 04:22:34 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gx20so1163263pjb.1;
        Sat, 13 Feb 2021 04:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+ROuDXHApQcQIhQjqFc317qqeK0woD/n7w4itNrUPxk=;
        b=G9r1c9e7jUppWlnzvJNbts6jR+OAjitQcQt5rZGJFXSnws/II+AK8QpB0EgKzHb6Eq
         GRnPxy1jmS4LeJ9T52CGxeN0MncMUBaTHAtKu5pqvj9jlmRtr5aISlGvjS8vOMmgTbIF
         s2H4zxLDxalA591+AgRK2l73L3dGqVQTBLkLpRU4LipCmt3D6jwNzkncL4G3b8Wm4h7U
         XQ5XMbJiTzHQJ/Lvbd1Qx5HybqZbEGTtflEJRFhDIr5kK28jt2YAXEuDidLZg+NjJH7a
         jo9AKJpmsjF0rtdTXkbLNLjqoLi03xlFwGdvtNjRLMAEnA7Q07j0Yjq40inJhwyUYe2D
         h6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+ROuDXHApQcQIhQjqFc317qqeK0woD/n7w4itNrUPxk=;
        b=iKnSy3eVlA9/HMnMXvOWnTYxFP5JByYY5yZuwwS6IPZ70Rz5EUeAjjhq1/1YBAMEhS
         oijt1BVetbScMjLJe/eudbqmFJH3dn3DhViWd6YtT9+YgsflcxLW+tTrtZrDQXULIyVE
         uvmlhl2YAXMjn1+cA0F35/prOtAP5atGEB9lyYR4atQ47mt0+B1nGO/oGNyOcM8eehIB
         ++NtfRIlpXx95E7L3J7UvsQ/nnIFplImpYFio2mJv2ebjDPykSbdyopKQgq5m0UY5paQ
         bH7vBs2noaIRUWw9/ZxAOx3Na0pBnbkT3MJM8Vpycs8EiMlo9qPCTfq4DhMtcKw94Xu5
         qh8A==
X-Gm-Message-State: AOAM5316sl+S3zaC+nliVdlSirsnIAxvFu2Pq07arD5wgvO2yZl+PAkX
        b8anR6mb2YYQ2orS3ZwhiWk=
X-Google-Smtp-Source: ABdhPJzy0uaTL1u9QU/uOqysklBO7PYmqZ0XN0qndGLpF6r0onKpYmMV97SlVrGcG6cjTNCy9vk3Aw==
X-Received: by 2002:a17:902:e80b:b029:e3:3df1:5e93 with SMTP id u11-20020a170902e80bb02900e33df15e93mr1060938plg.80.1613218953899;
        Sat, 13 Feb 2021 04:22:33 -0800 (PST)
Received: from localhost (li1438-199.members.linode.com. [45.33.111.199])
        by smtp.gmail.com with ESMTPSA id j4sm11041517pfa.131.2021.02.13.04.22.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Feb 2021 04:22:33 -0800 (PST)
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haidong Yao <yaohaidong369@gmail.com>
Subject: [PATCH v2 0/3] Fixes & a new supplementary feature to SPRD mailbox driver
Date:   Sat, 13 Feb 2021 20:21:40 +0800
Message-Id: <20210213122143.19240-1-orsonzhai@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a real problem fot SPRD's mailbox driver in patch 1/3.
Add supplementary inbox support for newly added sc9863a in patch 3/3 and
change dt bindings yaml accordingly in patch 2/3.

Changes Log:
V2:
- Change patches order. (Yaml go to the head of dirver)
- Remove unnecessary initializing refcnt to zero. 
- Add fix of possible crash caused by NULL of chan->cl. (Actually move from
  changes to sprd-mailbox.c of patch v1)
- Remove unnecessary "inline" for do_inbox_isr().
- Fix yaml errors from Rob's robot checking.
- Add sc9863a compatible string for real supplementary inbox usage. (sc9860
  is not supported by supp-inbox)
- Add more details to supp-inbox in commit messages.

Orson Zhai (3):
  mailbox: sprd: Introduce refcnt when clients requests/free channels
  dt-bindings: mailbox: Add interrupt-names to SPRD mailbox
  mailbox: sprd: Add supplementary inbox support

 .../bindings/mailbox/sprd-mailbox.yaml        |  18 ++-
 drivers/mailbox/sprd-mailbox.c                | 135 +++++++++++++-----
 2 files changed, 117 insertions(+), 36 deletions(-)

-- 
2.17.1

