Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEAA3330C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhCIVR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhCIVRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:17:05 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648C7C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 13:17:05 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v13so23253666edw.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 13:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HO0uGEK90QjK/b5e9bd7oIsiLaNfdUGW3RlZE/kuVEE=;
        b=fCiJzOjVNsWblpzj6XZMO2ZkXKhGEFTSQuwSN6S+bZS0HJvLu333i9JCn7MI2+sTQc
         4FWQSu/Fg5rp3kCd7z44dJfwLKBizKpKPsfZKqScWOqRXTbXy2yM0uspJ5UFTFZBKmin
         /+Iey2MIP8baSHaPf+pIl+mXQJB8lRTE07F1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HO0uGEK90QjK/b5e9bd7oIsiLaNfdUGW3RlZE/kuVEE=;
        b=R52VUzjT3PCee7E+IgdAMJT7sDfDHoMYdVE2z40/owJdbrTtMmgTRkeWmHk7D/RnyC
         P6jQPzFYRSV1XKBtdqyA9nov9fedWg7qIF3GCmzBHW201IXqUWQPh0rPfNioUdJpUPUk
         HUCELk/5Y8V9u36I7nCD1W8vj+fcxsU+G5Vl4V95Ebsh5+dovNwHJEoPn/Qk5KGlbVcr
         tzkKxxf5pMtIeuqmmZpYjmHx2LFVAHcbvqYnwCLjCf987pH2zbrZbzmaecz35jVCSreo
         kiaXNKAV+e91FHlmLfM2pryYISQ8ejxeTci/oFdTl9oGRv6HSBkmWHaUxYTT1IS3JY7z
         /7lA==
X-Gm-Message-State: AOAM533N8TnBbxQSnnvTQTNC1qkGB/7q+M5hpm8BFsvpoV4tEN1AaFfj
        Vj9aOJtzCzbmBtHH0QB+stua9g==
X-Google-Smtp-Source: ABdhPJwJ8g/6CV/2n/q4PVLdpsXsko00RLx3PgaMBnnzZtfKyyADWABJO202M5KwA35T49rzZjg6xw==
X-Received: by 2002:a50:9ea4:: with SMTP id a33mr6539217edf.295.1615324624137;
        Tue, 09 Mar 2021 13:17:04 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id n26sm5205725eds.22.2021.03.09.13.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 13:17:03 -0800 (PST)
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
Subject: [PATCH v2 0/2] background initramfs unpacking, and CONFIG_MODPROBE_PATH
Date:   Tue,  9 Mar 2021 22:16:58 +0100
Message-Id: <20210309211700.2011017-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches are independent, but better-together.

The second is a rather trivial patch that simply allows the developer
to change "/sbin/modprobe" to something else - e.g. the empty string,
so that all request_module() during early boot return -ENOENT early,
without even spawning a usermode helper.

The first patch allows delegating decompressing the initramfs to a
worker thread, allowing do_initcalls() in main.c to proceed to the
device_ and late_ initcalls without waiting for that decompression
(and populating of rootfs) to finish. Obviously, some of those later
calls may rely on the initramfs being available, so I've added
synchronization points in the firmware loader and usermodehelper paths
- there might be other places that would need this.

There's not much to win if most of the functionality needed during
boot is only available as modules. But systems with a custom-made
.config and initramfs can boot faster, partly due to utilizing more
than one cpu earlier, partly by avoiding known-futile modprobe calls
(which would still trigger synchronization with the initramfs
unpacking, thus eliminating most of the first benefit).

Routing-wise, I hope akpm can handle both patches. Andrew, Luis?

Changes in v2:

- Rebase on master, piggy-backing on the include guard and #ifdef
  CONFIG_BLK_DEV_INITRD added to initrd.h in fade5cad93 and
  c72160fe05.

- Use existing async_* API instead of wait_for_completion/complete_all

- Drop debug leftovers from wait_for_initramfs().

- Fix initialization of initramfs_async variable.

Rasmus Villemoes (2):
  init/initramfs.c: allow asynchronous unpacking
  modules: add CONFIG_MODPROBE_PATH

 .../admin-guide/kernel-parameters.txt         | 12 ++++++
 drivers/base/firmware_loader/main.c           |  2 +
 include/linux/initrd.h                        |  2 +
 init/Kconfig                                  | 12 ++++++
 init/initramfs.c                              | 41 ++++++++++++++++++-
 init/main.c                                   |  1 +
 kernel/kmod.c                                 |  2 +-
 kernel/umh.c                                  |  2 +
 usr/Kconfig                                   | 10 +++++
 9 files changed, 82 insertions(+), 2 deletions(-)

-- 
2.29.2

