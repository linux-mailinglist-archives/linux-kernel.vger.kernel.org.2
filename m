Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA15D3A4FF1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 19:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhFLRmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 13:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFLRmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 13:42:10 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0CDC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 10:40:11 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id w4so10857863qvr.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=792MN8Q01TsEjQvOuKUTJLcam45aGsdx9B+TJ/7s/WY=;
        b=Kill2/I0AYROyL7hXkgFZNPRf4ZnD0HhJM1NwjBe6GbFys+CQo9iD34/j3KokskJ9+
         GSYMIEy0plvw1gFwNOJfneSDNoaTHcfd8nU5RBG9No8mVP6+X7QI6JMo23rqz9ALJOzT
         YCqMdQlEzAoLwv8GkCpDmZdgABOoy7KhK405c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=792MN8Q01TsEjQvOuKUTJLcam45aGsdx9B+TJ/7s/WY=;
        b=jqchevToOPYnzWXV6qmTNUEwcKxqG/oNtAxUTsSHe8Y0aEUlmoTJrMZ+hSC4d5ax4t
         Qpzrn0y/NQ7dEd0GZWfv5CtXQdz25QWitOpBlKC8XgiFm5d175gnTD3ZBP5654F1MDw3
         RREeNO6Q20klfpBXOb5+GXCCyWn8162zUkt03z6fAoNTCwVIoiNp/Xeps+WhU3z1B7c2
         jaopaR1g6BKy3GcL+T8fZoXfMxRAYmKbs5W33cRvfFn1VXtgYXmzrBeffjor3kry5TAd
         +jjIoopKZol6zjDl6mzOXC6qmPdD8mzYUN9Ln6hwLuOejrCdwGjVWPdPJY+apGoFZMF7
         JEMQ==
X-Gm-Message-State: AOAM531XozoOVHC2N+kI+Gi398lFj8TlhFXZ2KrF1AacWVPJteIEmF39
        6mgPIReA2xb4i2fJ9zyADESuiBrK5oPvciq39+tjBg==
X-Google-Smtp-Source: ABdhPJzsg8UxUaXch78d+uWHZZjCwPid4FgFs5BfE2DdGpneuGxgjKvCYQq8yl7I7K8wXeWtrlBbC2iz9MvFUV2O5qk=
X-Received: by 2002:a0c:f0c7:: with SMTP id d7mr10622178qvl.45.1623519610207;
 Sat, 12 Jun 2021 10:40:10 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sun, 13 Jun 2021 02:39:59 +0900
Message-ID: <CAFr9PXnBb7OmOAMumDodC+0usWqRT-RXwC+YUHZ2Y43Xe_uTQQ@mail.gmail.com>
Subject: [GIT PULL] ARM: mstar for v5.14 v2
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Romain Perier <romain.perier@gmail.com>,
        Mohammed Billoo <mohammed.billoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,

Here is a fixed version of the PR with my s-o-b for Romain's patch.

Content is as before:

- Romain has stepped up to clean up some of the ~300 patch backlog for
MStar and he added support for earlyprintk in the process.
- In an effort to do things properly I've moved work on the MStar
stuff from my personal github account to one for this project. So
people can find it I've added a link in MAINTAINERS.

The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:

 Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:

 https://github.com/linux-chenxing/linux.git tags/mstar-5.14-v2

for you to fetch changes up to eb5e7693630c6039d040e428840be82b7e3a8614:

 MAINTAINERS: ARM/MStar/Sigmastar SoCs: Add a link to the MStar tree
(2021-06-13 02:12:18 +0900)

----------------------------------------------------------------
Daniel Palmer (1):
     MAINTAINERS: ARM/MStar/Sigmastar SoCs: Add a link to the MStar tree

Romain Perier (1):
     ARM: debug: add UART early console support for MSTAR SoCs

MAINTAINERS            |  1 +
arch/arm/Kconfig.debug | 11 +++++++++++
2 files changed, 12 insertions(+)
