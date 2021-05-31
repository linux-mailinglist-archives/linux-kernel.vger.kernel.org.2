Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A683A395882
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhEaJ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhEaJ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:59:27 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2FBC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 02:57:47 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r11-20020a0cb28b0000b02901c87a178503so8575098qve.22
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 02:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8fReuMdCoAcvO7ejaCNc/y44/KE8D3vmhMB7psbwQpI=;
        b=R0DfqvjhtO+v5AiLIe1ZYXGAIOnQNWFEOS0027cd07uE/o9Z+f4HcdZXOzG24uq5Zw
         rCPp4KFPiZb5hzVHO0I2Q07l+TAUQDUJ4dC/28sEhxu/6wGr82cx4HSpGshlqFuagyox
         EgpSiTGyThSGCAEbst7B+uTY4TwWdnW8qhVfRDJ3pPw2c9ok/7lw6863ykpvwrY4btOq
         Kv8QW3W9bxiYiqypfR4YeJ/QMGSs405Pnp6fT/tG7EcRu72jbY7cEh8Mu3hxJ721Q3Fc
         bUQJDFFH2GfNZxharCC8fVrpUpaJlDbZ3b7f4AxPgztIez8FnsuPmH/ok4OEH+SgVfjk
         PAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8fReuMdCoAcvO7ejaCNc/y44/KE8D3vmhMB7psbwQpI=;
        b=k7DzvDjk7Yi7AAPDChlCUqOUqbnVtGvi17hgWiz8Mkw0WpMqZLt2z7rYdjHBBoms1X
         gQMrpYQyZJZl7sdu9Y4TwxdoZ5JrHnNzqkHhys/T3MFKLYqhh8PIsVTkMY1rrJnwcbAb
         nOVugcnoPlmhJ2N+UB8+g/uxZE7TCs1qBWff2OLTLYtyjl29J65MFeIxFr+kiNK59voH
         MaGBvdutEXK6xYWOwfsy75uHU3UAtlSNqsUco4FyX50j8WVlHEgF2IIWymqedP1laLn/
         iJ8YVvgO+N4jCY9tHwNoYT6LGCqFFG2RuJkX98Cjq0Ddbz8mSDegP3bbk6DqcaxRZTgN
         gTUA==
X-Gm-Message-State: AOAM530CYE9wPFslJXgsFKnqr08ErJklWA4yd7WBHhjM7Ei8f3jTm84j
        vY4wSPOm5+I0n7fQY1Aqee6RsX8bZshd
X-Google-Smtp-Source: ABdhPJzY2fxdQ4i9TFUl47UHxvvNtiHzqOYZ57PKxOkd9YgYfbonMukdmsh4VIMxNqFv0Fah4fqmhG6fdjmA
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:1330:7a47:8be2:d9b7])
 (user=kyletso job=sendgmr) by 2002:ad4:4b71:: with SMTP id
 m17mr13311850qvx.45.1622455065173; Mon, 31 May 2021 02:57:45 -0700 (PDT)
Date:   Mon, 31 May 2021 17:57:34 +0800
Message-Id: <20210531095737.2258642-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 0/3] Add the support of SVDM Version 2.0 VDOs
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got the Ack by Heikki so I re-examined the patches and found a *stupid*
bug in the patch "usb: typec: tcpm: Introduce snk_vdo_v1 for SVDM
version 1.0" that I separate the "for loop" into two parts, which is not
only necessary but also redundant.

Changes since v1:
usb: typec: tcpm: Correct the responses in SVDM Version 2.0 DFP
- no code change
- add Acked-by tag

dt-bindings: connector: Add PD rev 2.0 VDO definition
- no code change

usb: typec: tcpm: Introduce snk_vdo_v1 for SVDM version 1.0
- merge the assignment to array element 1 into the for loop. No semantic
  code logic change.
- add Acked-by tag


=== v1 cover letter

The patches are primarily for the responses to the Discover Identity
command. This part was changed a lot from PD rev2.0 to PD rev3.0 (now
it's rev3.1 :D). e.g. DFP can respond to Discover Identity command with
ACK in PD rev3.x and the Product Type VDOs are quite different. Given
that tcpm.c moved on to PD rev3.x and PD rev2.0 is still supported, some
changes need to be made to support both PD rev3.x and rev2.0.

usb: typec: tcpm: Correct the responses in SVDM Version 2.0 DFP
- This patch is to unblock the responder ACK to Discover Identity if the
  port is DFP and the SVDM version is 2.0

dt-bindings: connector: Add PD rev 2.0 VDO definition
- similar changes to Commit 2a1673f0f1de ("usb: pd: Reland VDO
  definitions of PD2.0")
  https://lore.kernel.org/linux-usb/20210204005036.1555294-1-kyletso@google.com/
- add a new property sink-vdos-v1 to store the PD rev2.0 VDOs

usb: typec: tcpm: Introduce snk_vdo_v1 for SVDM version 1.0
- populate the legacy VDOs from fwnode
- send these data if the port partner is SVDM Version 1.0

===

Kyle Tso (3):
  usb: typec: tcpm: Correct the responses in SVDM Version 2.0 DFP
  dt-bindings: connector: Add PD rev 2.0 VDO definition
  usb: typec: tcpm: Introduce snk_vdo_v1 for SVDM version 1.0

 .../bindings/connector/usb-connector.yaml     | 15 ++++
 drivers/usb/typec/tcpm/tcpm.c                 | 52 ++++++++++----
 include/dt-bindings/usb/pd.h                  | 69 ++++++++++++++++++-
 3 files changed, 118 insertions(+), 18 deletions(-)

-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

