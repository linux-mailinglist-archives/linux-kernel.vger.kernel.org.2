Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DAC3FDE05
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 16:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhIAOwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 10:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhIAOwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 10:52:03 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DC9C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 07:51:06 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id r6so3518616ilt.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=A0nlS22iBMThZqfXPVdS9Dl/ch7oDO0XrvxMcmZOkEg=;
        b=LHSRcRoSkLln3X891+DbV/aOttQkwtG6ItlAHN344XfzcxNRyDONi1LHvw8qvmU7WD
         b/xSZe67+mijmNJkIqHlaG/pteTkwozIoLVSyjR0FecxeoZ547bNPcOId3RSDTHShBtI
         DMf9mS0RXSqV8ZRi0K+rwKtqbrme1NLFcwlWaFQUhtYFmDdRySIY+9OasbTDqfdUwnG5
         8cXE58UFqInk6VrGDCCZAncIXBQaDPAI2/5GEvQNiIxWF+Axnhl+ePkmwwnKPU+mnkG5
         t/0MHstNs0hSyXVYPcldaCXExeo91289i3YRZUs0REzD5bK913jr+yMB9weityO88feh
         4C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=A0nlS22iBMThZqfXPVdS9Dl/ch7oDO0XrvxMcmZOkEg=;
        b=ipb7Wuxk74jHeeGlc0f0iP61B+PJ2z42Oo1TR2t6siAi+bAWU56bvqkwO0Y1WamfWy
         vyhHK/NtX2eE5Cyqe38hoJXDWQxYg+qkRyXEp6EmEHcn5HsMcsdwWIZNVmNm/3tltJb/
         Qw0c/vGY8vAaU+U90OCohyWR8ZkblfNfgXkJoVw9S9xLUZNXAFwkdLeGg6f7z+8kjdap
         mk3t2EEuxhwd3ndR1scCgudjMJIfbK74PigE9nyoV7QZcgwJIeJfps7wV4XRzZ0nU4DD
         lQRixP4+AWSQfqxbWvo9iJa3pq+PUjbTfF/JchgrKLPAK8FPMcrKir/3Kym3jdCmwovu
         AHiA==
X-Gm-Message-State: AOAM533tDXeXBooW+j6gI8S6ydBlK57NNh79dDwQe8WS7Rmtonh+v4LO
        IM1LQtHocpIlWEBNmXPwCt+vB7gRQl0I1G9sQBI=
X-Google-Smtp-Source: ABdhPJw1W230UQ6Lp40vKCd20J4n97P6kcBoZUSwlFnF/C/G7SNibbrxN8fp15yxct/DV+De+Y8+edphIyTFca6HUiw=
X-Received: by 2002:a92:ca89:: with SMTP id t9mr25557592ilo.178.1630507865881;
 Wed, 01 Sep 2021 07:51:05 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 1 Sep 2021 09:50:55 -0500
Message-ID: <CABb+yY08XqC40=vNuRfOU97bXHFo+R69LQvKavPv_N0NoF2PkQ@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.15
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:

  Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.15

for you to fetch changes up to 85dfdbfc13ea9614a2168ce4a7d2cd089d84cb64:

  mailbox: cmdq: add multi-gce clocks support for mt8195 (2021-08-31
22:57:45 -0500)

----------------------------------------------------------------
- mtk: added support for mt8192 and mt8195
minor fix regarding address shift.
- qcom: added compatibles for MSM8953, SM6350 and SM6115
enable loading IPCC as a module
- misc: change Altera maintainer
fix sti kernel-doc warnings

----------------------------------------------------------------
Amit Pundir (1):
      mailbox: qcom-ipcc: Enable loading QCOM_IPCC as a module

Iskren Chernev (2):
      dt-bindings: mailbox: qcom: Add SM6115 APCS compatible
      mailbox: qcom: Add support for SM6115 APCS IPC

Joyce Ooi (1):
      MAINTAINERS: Replace Ley Foon Tan as Altera Mailbox maintainer

Konrad Dybcio (1):
      dt-bindings: mailbox: qcom-ipcc: Add compatible for SM6350

Randy Dunlap (1):
      mailbox: sti: quieten kernel-doc warnings

Vladimir Lypak (2):
      dt-bindings: mailbox: Add compatible for the MSM8953
      mailbox: qcom-apcs-ipc: Add compatible for MSM8953 SoC

Yongqiang Niu (3):
      dt-binding: gce: add gce header file for mt8192
      mailbox: cmdq: add mt8192 support
      soc: mediatek: cmdq: add address shift in jump

jason-jh.lin (4):
      dt-bindings: mailbox: add definition for mt8195
      dt-bindings: gce: add gce header file for mt8195
      mailbox: cmdq: add mediatek mailbox support for mt8195
      mailbox: cmdq: add multi-gce clocks support for mt8195

 .../devicetree/bindings/mailbox/mtk-gce.txt        |   9 +-
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |   2 +
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |   1 +
 MAINTAINERS                                        |   2 +-
 drivers/mailbox/Kconfig                            |   2 +-
 drivers/mailbox/mailbox-sti.c                      |  16 +-
 drivers/mailbox/mtk-cmdq-mailbox.c                 | 109 ++-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |   2 +
 drivers/mailbox/qcom-ipcc.c                        |   1 +
 include/dt-bindings/gce/mt8192-gce.h               | 335 +++++++++
 include/dt-bindings/gce/mt8195-gce.h               | 812 +++++++++++++++++++++
 11 files changed, 1257 insertions(+), 34 deletions(-)
 create mode 100644 include/dt-bindings/gce/mt8192-gce.h
 create mode 100644 include/dt-bindings/gce/mt8195-gce.h
