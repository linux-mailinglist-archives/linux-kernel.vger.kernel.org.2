Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8487A33A163
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 22:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbhCMVZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 16:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbhCMVZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 16:25:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD187C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 13:25:33 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mj10so60009137ejb.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 13:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TftrF7YA53I18eD6aeAx2Feucz+UL9bSHvI7JtG3dtg=;
        b=f5WiSY2SYfZ+X42mWWorVd4I49FzqNwBwiKH2df8+N1EPv/5JAISn7x/wSkU9z6uIq
         05bo9hW+ysAv4PlLHCjyL6jKXtU7ioKmJy1fLk04UZefBaQZTmNruqUClthV6oiVgsQb
         7b2qDKosu55zpLkXECNAZAPbcEquXljOJWh20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TftrF7YA53I18eD6aeAx2Feucz+UL9bSHvI7JtG3dtg=;
        b=U6CeVcMVp/i/Je1d9CacXnYeD2tcF/0le7CT/R+IMS8ic1O3TCLyn7h9OJR6vxoteo
         zonGanpje1iGBwhyMJbQPhvUfRm4SIfPl9V5SzasevDNmGeBYAgsDvNuEmIK5HmiHQU+
         l2MwaXtt5Kw2njvmPzLJgYQUnupE/3Nuf6cKt+Dhlazae/jgahaJBvSI1eHayEBPA8+4
         nEBodW3OsMyNkX1729rZmbsjb5rYXjuJh+4pjY1sToGHuFnFTMyFuI1pXrff7sfgjhZh
         Hacok5F18ehhpqAf/yaNLhmiCT+X/gbO76Vm1zT1/wOhx/pQtoNjaNgNCIXcfZWzFxXy
         GKqA==
X-Gm-Message-State: AOAM5306BQ7DSgkZ6MbZM0h8nuwzDtS9q5uePN+Ts/jKYdxY079QvjAK
        1c5Naoqz4ZgrkLzSN+DOHS0ckA==
X-Google-Smtp-Source: ABdhPJwfSBOWEhKBOmzo8dQALthh4C0zFEB2fgFBrWrfiCJTOckwgSHVEwVeN9q/1l03WqDL5iv5Xg==
X-Received: by 2002:a17:906:2710:: with SMTP id z16mr15875936ejc.176.1615670732381;
        Sat, 13 Mar 2021 13:25:32 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id gr16sm4827997ejb.44.2021.03.13.13.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 13:25:31 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 0/2] background initramfs unpacking, and CONFIG_MODPROBE_PATH
Date:   Sat, 13 Mar 2021 22:25:26 +0100
Message-Id: <20210313212528.2956377-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches are independent, but better-together.

The second is a rather trivial patch that simply allows the developer
to change "/sbin/modprobe" to something else - e.g. the empty string,
so that all request_module() during early boot return -ENOENT early,
without even spawning a usermode helper, needlessly synchronizing with
the initramfs unpacking.

The first patch delegates decompressing the initramfs to a worker
thread, allowing do_initcalls() in main.c to proceed to the device_
and late_ initcalls without waiting for that decompression (and
populating of rootfs) to finish. Obviously, some of those later calls
may rely on the initramfs being available, so I've added
synchronization points in the firmware loader and usermodehelper paths
- there might be other places that would need this, but so far no one
has been able to think of any places I have missed.

There's not much to win if most of the functionality needed during
boot is only available as modules. But systems with a custom-made
.config and initramfs can boot faster, partly due to utilizing more
than one cpu earlier, partly by avoiding known-futile modprobe calls
(which would still trigger synchronization with the initramfs
unpacking, thus eliminating most of the first benefit).

Routing-wise, I hope akpm can handle both patches. Andrew, Luis?


v2 at <https://lore.kernel.org/lkml/20210309211700.2011017-1-linux@rasmusvillemoes.dk/>

Changes in v3:

- Make it asynchronous by default, and drop the CONFIG_ knob (Linus) -
  the command line parameter escape hatch is still there.

  With that change, it doesn't make sense to have wait_for_initramfs()
  contain a micro-optimization in the form of an early return when
  !initramfs_async.

  I've opted to always push the work to the async machinery, but then
  just do a wait_for_initramfs() in populate_rootfs when
  !initramfs_async.

  I did consider changing the name and sense of the command line
  parameter to "initramfs_sync", but decided to keep the async, since
  that's also the name of the subsystem being used.

- Add A-b, R-b to patch 2.


Rasmus Villemoes (2):
  init/initramfs.c: do unpacking asynchronously
  modules: add CONFIG_MODPROBE_PATH

 .../admin-guide/kernel-parameters.txt         | 12 ++++++
 drivers/base/firmware_loader/main.c           |  2 +
 include/linux/initrd.h                        |  2 +
 init/Kconfig                                  | 12 ++++++
 init/initramfs.c                              | 38 ++++++++++++++++++-
 init/main.c                                   |  1 +
 kernel/kmod.c                                 |  2 +-
 kernel/umh.c                                  |  2 +
 8 files changed, 69 insertions(+), 2 deletions(-)

-- 
2.29.2

