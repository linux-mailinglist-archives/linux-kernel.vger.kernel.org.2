Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7C6428646
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 07:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbhJKFk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 01:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbhJKFk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 01:40:27 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD78C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 22:38:27 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id g6so36290107ybb.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 22:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Rdn9D4x0MOe4OFaPDRRNFwa5LDZPW7fTkIH7dJRvtJo=;
        b=fQnLkl/4ss325T4Ag7bFo97Pl94QbRtaKWnoI/kJ8hbfJBqcmPwv5pSbrVta6Pi3vo
         kKQuqQE8jHHzsupDKHotwshPcqgym6msU82pK07AenEwqPo0qPzCoK4vKFqJh8utYiML
         IsUd3Cyu7v/akVT+guEqEviOe/LzzHZRaLYWRzp7y6/DbfsJQQfWrZG0qOtoJFmuAVlN
         c9W+DXpG06920sb1MVLoGavAvwEZu89Rfl/u/LbTuZdeSPibd8/MFj0Fo+RYXB0V4poI
         BcUi2elFBMySMsWXZLfCv6BQ5VxfP+iePF8c//Tg5XCmumLZ0zZZh1gZAHM5E/t8O4qn
         iUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Rdn9D4x0MOe4OFaPDRRNFwa5LDZPW7fTkIH7dJRvtJo=;
        b=JjhvX4OyT/afHeiiKBpUM+QlkpNOoV4WlMq2jKEgc7M0SLctjWgYJvezcweT3CATQO
         zBAy9GyxiHc63jSD0G9CzK/hYbVu+Fno3MMJjF+C4zCsrNnjWuXBIKbGQMpZu645evx2
         FtOh5ZRzuri3DLM1JVyXiIlNOB7reXk74lbNYEmxJtxz+2l7a+E5DrrlRVw+ZgqVMpJB
         huUTin/sUmeAJh+ajv7/5dEtFpEnOnTgEz4lSoJhrpqZ7lnTQ6DbPiTt83iG0hqVFtu/
         k0Nd16BBBtZ98t+tivPwdU1YGxX5fo5wq6h007rBZYyTJeDrytPneS+ae92RBF3siaCU
         630A==
X-Gm-Message-State: AOAM530FJucZuUTvwNSvaaREg5hndzxjTZ+JnJsNEBHqjw3yEQrxu4h8
        Na+OTbYVk5lHw+HnWpV6MebTprQT3RK323U9alZmKl6PbmI=
X-Google-Smtp-Source: ABdhPJxeI/+ttylIYXk2yhhAl4GZB8qsPyQr/goYyEkDHzOO0Ft3WrIzt+j6OvNIgVHCcrT9172zIG8NbDGkQcTQxRw=
X-Received: by 2002:a25:7ec4:: with SMTP id z187mr19715743ybc.35.1633930707041;
 Sun, 10 Oct 2021 22:38:27 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 11 Oct 2021 07:28:32 +0200
Message-ID: <CAKXUXMy0FUv25cUGDnhnv=3pTd7NGjepbHao7QoQw8h0hh3CRw@mail.gmail.com>
Subject: Non-existing config symbols DEBUG_OMAP{3,4,5}UART{1,2}
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Tony,

With commit d2b310b0234c ("ARM: debug: Use generic 8250 debug_ll for
omap2 and omap3/4/5 common uarts"), you added address definitions of
DEBUG_UART_PHYS for OMAP2, OMAP3, OMAP4 and OMAP5 in
./arch/arm/Kconfig.debug.

These definitions depend on:
  - DEBUG_OMAP2UART1 || DEBUG_OMAP3UART1 || DEBUG_OMAP4UART1 ||
DEBUG_OMAP5UART1, and
  - DEBUG_OMAP2UART2 || DEBUG_OMAP3UART2 || DEBUG_OMAP4UART2 ||
DEBUG_OMAP5UART2.

As of now, only DEBUG_OMAP2UART{1,2} are defined in
./arch/arm/Kconfig.debug, but DEBUG_OMAP{3,4,5}UART{1,2} are not
defined. Hence, ./scripts/checkkconfigsymbols.py warns here on
non-existing symbols.

I am unsure about the best way to resolve this issue.

- Would you like to simply reuse the config DEBUG_OMAP2UART{1,2} also
for OMAP3, OMAP4 and OMAP5? Then, we probably just need to delete the
dead references
to DEBUG_OMAP{3,4,5}UART{1,2}. If you consider this further change
helpful, we could even rename the configs to DEBUG_OMAP2PLUSUART{1,2}
to make the architecture more specific.

- Do you see the need for separate config definitions for UART{1,2} on
OMAP3, OMAP4 and OMAP5? Then, we would need to add further definitions
DEBUG_OMAP{3,4,5}UART{1,2}
in this file and link those to the specific architecture.

Once the direction is clear, I am happy to provide a patch to address
this issue or you can quickly take care of this yourself.

Best regards,

Lukas
