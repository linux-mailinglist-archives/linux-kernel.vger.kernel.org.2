Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5D938014C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 02:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhENA6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 20:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhENA6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 20:58:37 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650A9C061574;
        Thu, 13 May 2021 17:57:26 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id i7so19221085ioa.12;
        Thu, 13 May 2021 17:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3wEUqD5QhLS2UhtL5j7UqBMamQk3HhwXmumgBPx1P8=;
        b=hcN6w+BypiE5zN1KXHBF4f9O0oom+Q2j0Uo1g9Gd/LiXSvBT4gUXeolwGYSAMv61Su
         GmZhr+7jNEd20bCPrT+SsrfZ53U+zbwlqr9z2QTnpm8oEEZ7Nm9Qdk/PvNgh9C7+rJLt
         DKcHhb1MgYUN08Ued/nwzuZ/lX7vaizEBXJOhGRm7vNn5/CBzEcJTOTBbnG3UF6pQOaR
         EVBLUd1K9yVT/2JunLG+yac246uWjJwWcrg4XgHvPrZmIYHHSwifnwzhD4cXcJyaswir
         zgg/SC0mFliMPn4HB7kfRUC/QydemZzgfZpwza4MT6selUltS0uKSrMJLq61uj0CJSti
         +Lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3wEUqD5QhLS2UhtL5j7UqBMamQk3HhwXmumgBPx1P8=;
        b=ui9p1meNDYfPLQKwwxWFJRQ/g2Krwi77XjtAzzWj7Zc+vCjZfg32qPetOxZmSuC23J
         pQclTWoR9GzUYSXX8IHoclnH6a7veu1w5rBMQYU9k1Ia4A+fZxC4WnAzIPFdeS2CAPpz
         JeYcGqIbnk9lJ2phFvi08gdI6tjXnGa9p3X/ZDiMuAM6gCXG14SdJRz53V0gPdeBS8j7
         S8pk4z+T4gpWDSp0AldfHv+PofspX1T+z82ViT9zdYJpTxLtFGcyI5vvlN7kF98ZoeHb
         AA2ZHVQPaVsXg/6mwi1cnRkhm2qQ1emNifC0vhadisg2caCOed7Hfn/sxjqUdh+FFMbP
         DBww==
X-Gm-Message-State: AOAM5334sjTn+pP8qAMuru+SUWEHF3jNhw6NbhCHqR5hUwcw2LSINVPi
        QLElaJoOcci8sgE3kycUWstDTbqNw6MQcQ==
X-Google-Smtp-Source: ABdhPJyB4KylG8BajfWzW2sICVndWhPHbf+Sta1dYqbL8ii+leuCVgYktVAW4oFkpqaC0W9obhMlLA==
X-Received: by 2002:a5d:89c5:: with SMTP id a5mr33586495iot.172.1620953845046;
        Thu, 13 May 2021 17:57:25 -0700 (PDT)
Received: from localhost.localdomain (142-79-211-230.starry-inc.net. [142.79.211.230])
        by smtp.gmail.com with ESMTPSA id g25sm1981538ion.32.2021.05.13.17.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 17:57:24 -0700 (PDT)
From:   Connor Davis <connojdavis@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Connor Davis <connojdavis@gmail.com>, linux-usb@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Jann Horn <jannh@google.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Petr Mladek <pmladek@suse.com>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 0/4] Support xen-driven USB3 debug capability
Date:   Thu, 13 May 2021 18:56:47 -0600
Message-Id: <cover.1620950220.git.connojdavis@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This goal of this series is to allow the USB3 debug capability (DbC) to be
safely used by xen while linux runs as dom0.

The first patch prevents the early DbC driver from using an
already-running DbC.

The second exports xen_dbgp_reset_prep and xen_dbgp_external_startup
functions when CONFIG_XEN_DOM0 is enabled so they may be used by the
xHCI driver.

The third ensures that xen_dbgp_reset_prep/xen_dbgp_external_startup
return consistent values in failure cases. This inconsistency illustrated
another issue: dbgp_reset_prep returned the value of xen_dbgp_reset_prep
if it was nonzero, but callers of dbgp_reset_prep interpret nonzero
as "keep using the debug port" and would eventually (needlessly) call
dbgp_external_startup. Patch three _should_ fix this issue, but
I don't have any EHCI hardware available to test unfortunately.

The last uses the xen_dbgp_* functions to notify xen of unsafe periods
(e.g. reset and D3hot transition).

Thanks,
Connor

--
Changes since v1:
 - Added patch for dbgp return value fixes
 - Return -EPERM when !xen_initial_domain() in xen_dbgp_op
 - Moved #ifdef-ary out of xhci.c into xhci-dbgcap.h

--
Connor Davis (4):
  usb: early: Avoid using DbC if already enabled
  xen: Export dbgp functions when CONFIG_XEN_DOM0 is enabled
  usb: dbgp: Fix return values for reset prep and startup
  usb: xhci: Notify xen when DbC is unsafe to use

 drivers/usb/early/ehci-dbgp.c  |  9 ++++---
 drivers/usb/early/xhci-dbc.c   | 10 ++++++++
 drivers/usb/host/xhci-dbgcap.h | 19 ++++++++++++++
 drivers/usb/host/xhci.c        | 47 ++++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci.h        |  1 +
 drivers/xen/dbgp.c             |  4 +--
 include/linux/usb/ehci-dbgp.h  | 14 ++++++----
 7 files changed, 94 insertions(+), 10 deletions(-)


base-commit: 88b06399c9c766c283e070b022b5ceafa4f63f19
-- 
2.31.1

