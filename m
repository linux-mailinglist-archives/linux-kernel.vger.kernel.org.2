Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A2437B2ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 02:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhELATb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 20:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhELATa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 20:19:30 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506A0C061574;
        Tue, 11 May 2021 17:18:22 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id d24so10069102ios.2;
        Tue, 11 May 2021 17:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXSeR9jPw54X42/hzVCKnW9V7a7Fp/RB7jF7rnjCJUw=;
        b=cPTkppKtPOrkAZ6nQARylT++pk44Lspab5bF4Y1dwmuQBYjN0Y3UuyDtFNRJx0iBpg
         9EHv6UTLsMbWxIJN3z9MPof9z9kmZE5mn3oRoU7l/paKObQqQY0DTK3GBr8Ys1CwM52V
         Ee1MxtvuDQLEH9HCoGgOCOueH024l3lX693zvuJtJeynCSOleAkV6uSYs/nnzUjCTvvU
         UVxynsT469vDP4YHIsKNmIOYKFSX2A4ZjZDC6OLL49vg2Tz+mQ7gH9GUfIuT5tM+7HqS
         4FN/Ba9X3JFWYRvBn6fdHSsH/GGtZjvqJcp/2tekEeP2dLEU4N1oubuqc+iLj+f8Huu6
         TCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXSeR9jPw54X42/hzVCKnW9V7a7Fp/RB7jF7rnjCJUw=;
        b=hfs/278XYimdbpxUQtTR+YGGFgKRkZ7Zie0TB8xEvH+XbfYeBmUGVgvBH2uDgwyZRN
         D8Oy9rd7mKnWkSHllwZuPy8DAyJgIXRNi8FEjkDjqbM0tcbssIImMisfx2fdnMdSKUVN
         W9adOWrJ6g8knlWVXXcstkQxiBF9v5vTtJGI8k2iFfXSB5e3ugwVvdKAbIEgN4MXSK67
         keP7+pBQWMAbKyqQZEDrGsA1phWEHf7wbtVF622P8uhP4PW+KvFOmxNGLjHJOeP7Xdl0
         PDnPCrx8nwN6yrLcLG3wCgLNZzLNx0BSIl3VXO0SyEptIj329MRutHB2FQZ6zn8RUrep
         AWVA==
X-Gm-Message-State: AOAM530uaS1B+caBAcusDEcbOI2odzkcIXPf4bVjQNsIILAOSwkIkQng
        qNSZqk2MrbwgND0l68AedDrP+3ZmtDBsjg==
X-Google-Smtp-Source: ABdhPJyGzEtP2429F0wetqYLv9fqk0nL/tFbD9fe/i3vDjKMOECPsuDdTpSelI1bEV3hT45X4JMc9A==
X-Received: by 2002:a02:1c81:: with SMTP id c123mr30707808jac.42.1620778702074;
        Tue, 11 May 2021 17:18:22 -0700 (PDT)
Received: from localhost.localdomain (142-79-211-230.starry-inc.net. [142.79.211.230])
        by smtp.gmail.com with ESMTPSA id v4sm8241490iol.3.2021.05.11.17.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 17:18:21 -0700 (PDT)
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
        Mathias Nyman <mathias.nyman@intel.com>
Subject: [PATCH 0/3] Support xen-driven USB3 debug capability
Date:   Tue, 11 May 2021 18:18:18 -0600
Message-Id: <cover.1620776161.git.connojdavis@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This goal of this series is to allow the USB3 debug capability (DbC) to be
safely used by xen while linux runs as dom0. The first patch prevents
the early DbC driver from using an already-running DbC. The second
exports xen_dbgp_reset_prep and xen_dbgp_external_startup functions when
CONFIG_XEN_DOM0 is enabled so they may be used by the xHCI driver.
The last uses those functions to notify xen of unsafe periods (e.g. reset
and D3hot transition).

Thanks,
Connor

--
Connor Davis (3):
  usb: early: Avoid using DbC if already enabled
  xen: Export dbgp functions when CONFIG_XEN_DOM0 is enabled
  usb: xhci: Notify xen when DbC is unsafe to use

 drivers/usb/early/xhci-dbc.c   | 10 ++++++
 drivers/usb/host/xhci-dbgcap.h |  6 ++++
 drivers/usb/host/xhci.c        | 57 ++++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci.h        |  1 +
 drivers/xen/dbgp.c             |  2 +-
 5 files changed, 75 insertions(+), 1 deletion(-)


base-commit: 88b06399c9c766c283e070b022b5ceafa4f63f19
--
2.31.1

