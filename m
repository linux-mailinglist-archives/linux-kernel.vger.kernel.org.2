Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AC0324B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 08:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbhBYHqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 02:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbhBYHpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:45:15 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B68C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:35:54 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id h4so3200673pgf.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=kJbz9oyBnr1X+/Px11riUL5jIzHb5zzZatKCb9nINjU=;
        b=J+HkOXFzsPXIIsJpOj3m1R5sAqKbe861zkQASrQoNAHiAxL6ZV879Y58j3FPdCpTyW
         aQdxvCem773Lj5nDD5UxoOX3fhvF6tQci3RUGQx8lAajoHRQkY5EkieymSDATU1Xo0nx
         kFK1cYmwWIpp9msOhmagkgEfQBryD0FO8z1+QZypQ8fltUe4BqufF9fi/GDpA0Drlbog
         CPr0Asxp5wqVbzbeVrSrAHlrAqkI6DjQWRNijfOewOJCIYRcbYuxGglLzMM831l5lKPb
         4HPeNzf53jODgT/upPySSk8zhy2LiUQ34jWG6Uf8LDvLIWkqmayzKdWl5Cz3GdQRqlPR
         CSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kJbz9oyBnr1X+/Px11riUL5jIzHb5zzZatKCb9nINjU=;
        b=OplIWEglnBvSwTNZ1VhtYUdW4nAMbJfb3rUOlS5H3U33DnsGjlVHQcwZTvN6timhL1
         O2LLUKA4hfOLEskcxeERpWCAbIXM7CZ5nhrBTtm8J0GU0muqLZEnzlZF42EojsXPMAX4
         ppHhC+7k6H9eDcd+Y7hDjEe1l//fno3IglJz273OulmwEpWAW7/uCcnnxTj6qLeZoeJi
         kKgWsM4jU3OtV3id6X41h9GSR21eMlQK4paI7O5MlubPG+udylda96N73ZQVWGT08sKy
         aBlLUcect8tiNwJ+zv2AhFDbUYefTjweeL8A9EVXj+Ensp3BoN3fwP/fjDCWBP/AMs2C
         P3ig==
X-Gm-Message-State: AOAM532up/ruvHZgdZtxMF/IOuxsQtBhwBHAz9hBPtGKauMUtzdYlYW8
        0HIJz++VKaFgk3/j0K8Bnd7j9sKAD1vbxd8DK+s=
X-Google-Smtp-Source: ABdhPJyFja5QnIAR1ye/TwuJvWYqcvw9JaIzwKj1bDrERmrNGVwujwNnZaFAc8XqSqTqLPg/QyEpygiT2IlaKBY5A/g=
X-Received: by 2002:a63:1354:: with SMTP id 20mr1854844pgt.21.1614238554362;
 Wed, 24 Feb 2021 23:35:54 -0800 (PST)
MIME-Version: 1.0
From:   Greentime Hu <green.hu@gmail.com>
Date:   Thu, 25 Feb 2021 15:35:17 +0800
Message-ID: <CAEbi=3f2UN+zn+L6Umhn30nGULp94QtVOT=H9+iYGrxyzmcR=w@mail.gmail.com>
Subject: [GIT PULL] nds32 patches for 5.12-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Nickhu <nickhu@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

Please pull the arch/nds32 updates for v5.12-rc1.
Thank you.

The following changes since commit f40ddce88593482919761f74910f42f4b84c004b:

  Linux 5.11 (2021-02-14 14:32:24 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git
tags/nds32-for-linux-5.12

for you to fetch changes up to 40e0dd851e7b7afe219820fb270b09016e41d4fc:

  nds32: Fix bogus reference to <asm/procinfo.h> (2021-02-25 14:31:49 +0800)

----------------------------------------------------------------
nds32 patches for 5.12

Here is the nds32 patchset based on 5.11
Contained in here are
1. code clean up
2. code refine

----------------------------------------------------------------
Christoph Hellwig (2):
      nds32: remove dump_instr
      nds32: use get_kernel_nofault in dump_mem

Geert Uytterhoeven (2):
      nds32: Replace <linux/clk-provider.h> by <linux/of_clk.h>
      nds32: Fix bogus reference to <asm/procinfo.h>

Krzysztof Kozlowski (1):
      nds32: configs: Cleanup CONFIG_CROSS_COMPILE

 arch/nds32/configs/defconfig |  1 -
 arch/nds32/kernel/setup.c    |  2 +-
 arch/nds32/kernel/time.c     |  2 +-
 arch/nds32/kernel/traps.c    | 50
+++-----------------------------------------------
 4 files changed, 5 insertions(+), 50 deletions(-)
