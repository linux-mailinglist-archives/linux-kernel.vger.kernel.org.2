Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B01F323678
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 05:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhBXEwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 23:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhBXEvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 23:51:55 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7D8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 20:51:15 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id g20so472019plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 20:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dEwXz4+jn8x7LF/D5VYIkqgEzo6p7MYhxhZ97dWxdl4=;
        b=Wirhkv3lB/2mO7FFMCSG37rZn/iQn5OX3WMxfe9QlrSPHputSX2eZ+Fv4LFWyPOeRP
         5NKcYIV+3RQ+PlVTEnrCsDvt/xpEWSr3FKa2/3qjp0Ergey4z+3OG64jcPMqgSk+bz7g
         CXDBKG+vS0eC+wBzw9o65v3HbC0WKT/e3ZNMgeyoWk7OYE2UsnW3sJrWS6xcTnC/yuOZ
         UD80Q4UeOoqAx0U+WsHgaMT8ZGnxnGfzsMfKyeHD1oznEW5tA6sQqquhglaSShSWY65i
         tjmVI9f6ovSbSZ9SjVS0uxg2C+uIzMO+wtSIJ+q0lMt8xWvvA0nSdEwipQTNp39cxkUI
         X3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dEwXz4+jn8x7LF/D5VYIkqgEzo6p7MYhxhZ97dWxdl4=;
        b=c5pJ/LJSR+yAr7mK35KChfjWrOUVAwfe1Tx3TkeIBPQfK+JIXPLcEY6kMReJAAu0V9
         Q+HMEnrlYDtaD04pFtMzfpYUaFZ2nsaZibK5n6z6tRo2byYmV0/Ax0cjxo+roWhGZtgj
         rcSZyFoOi/U52sH2QQvAMYUC0PL29TIXeitmasMd/54ni62/n7gg/boU6KCoeQEgJymU
         j6pmIpP6lGVr7mSBQ8PGjLBkr9D9aHcbdFOmIJAcx64NDQA1YRPKMyPiYe4ltRUtXpyr
         p1i/tBeZSt4+S1S3VVUOAO/QP7LKj65q4wgcZVxlqfqlwfseFAUDVN7/iaQHl3OofjQv
         pZuA==
X-Gm-Message-State: AOAM532AUjZlgkpex94RTp6MOdNO9du55zzJp2LOQ4azLCpPKV1Fjxhj
        UUmjpdoO4BXZb4ESngSXlATFooiC+XWk/fJjyYxwUQtnC9k=
X-Google-Smtp-Source: ABdhPJwIDVnnCxAPo+BAgKebfHF+B5T0Di2RfdxjsvtJY6SesZuBjguloUbs+NVOFjs1MBsRNZvfSOgYWiH78viCQO4=
X-Received: by 2002:a17:90b:1c0c:: with SMTP id oc12mr2431751pjb.180.1614142275075;
 Tue, 23 Feb 2021 20:51:15 -0800 (PST)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 23 Feb 2021 22:51:04 -0600
Message-ID: <CABb+yY1kZ-6Lo5z3h0tcSD_o8GH9uCdd2d9+2xvVV22+2hRTcQ@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.12
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3=
:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.12

for you to fetch changes up to 6b50df2b8c208a04d44b8df5b7baaf668ceb8fc3:

  mailbox: arm_mhuv2: Skip calling kfree() with invalid pointer
(2021-02-22 13:34:27 -0600)

----------------------------------------------------------------
- sprd: fix a macro value
- omap: support for K3 AM64x
- tegra: fix lockdep warnings
- qcom: support for SDX55 and SC8180X
- arm: fixes for sparse, kfree and void return

----------------------------------------------------------------
Bjorn Andersson (2):
      dt-bindings: mailbox: qcom: Add SC8180X APCS compatible
      mailbox: qcom: Add SC8180X apcs compatible

Magnum Shan (1):
      mailbox: sprd: correct definition of SPRD_OUTBOX_FIFO_FULL

Manivannan Sadhasivam (2):
      dt-bindings: mailbox: Add binding for SDX55 APCS
      mailbox: qcom: Add support for SDX55 APCS IPC

Mikko Perttunen (1):
      mailbox: tegra-hsp: Set lockdep class dynamically

Suman Anna (2):
      dt-bindings: mailbox: omap: Update binding for AM64x SoCs
      mailbox: omap: Add support for K3 AM64x SoCs

Uwe Kleine-K=C3=B6nig (1):
      mailbox: arm_mhuv2: make remove callback return void

Viresh Kumar (2):
      mailbox: arm_mhuv2: Fix sparse warnings
      mailbox: arm_mhuv2: Skip calling kfree() with invalid pointer

 .../devicetree/bindings/mailbox/omap-mailbox.txt   |  4 +++
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    | 34 ++++++++++++++++++=
++++
 drivers/mailbox/arm_mhuv2.c                        | 30 +++++++++---------=
-
 drivers/mailbox/omap-mailbox.c                     |  6 +++-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |  8 ++++-
 drivers/mailbox/sprd-mailbox.c                     |  2 +-
 drivers/mailbox/tegra-hsp.c                        | 15 ++++++++++
 7 files changed, 81 insertions(+), 18 deletions(-)
