Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03386334984
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhCJVK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhCJVK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:10:28 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2585EC061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:28 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id s7so9116910plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O30AauLLCCWTiPzSso6IXev67cYW6S1/IqV74YHyhWQ=;
        b=FriG3dvtnkFMjLm8sZa8Oy0H4+IJZKzMN2i5TDzv3wnwRbG5qEUL5LWRJ+nUqu1crD
         gAabEJXuCjclUlvnm6CKTratENHDMeCpOXDPFY21F9kuEl9KR22S9Dlen8aJfLovVJB2
         GgDI5GLcXg8RUT/EgPnnBJk2KiH6Iv7ij+0HpAa8NKkeKmlFvec6BKB6KvsiSYYvvY6a
         KJmGWwDCbCXfMF6pGVXZLxcVJAnFS/i8SR0dPsrgClKULwnJ4Zo7SGY7OaGFqgH3OTjx
         m5+8EJjfv9uJ93aPMOVIRObo2c/bKqQ9KTYR/ObcYBK4hIIsDthRK/FAIlDn85EJ78r4
         mBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O30AauLLCCWTiPzSso6IXev67cYW6S1/IqV74YHyhWQ=;
        b=VywiSB6prE9Ko5T0pq0/UlM77nwtz7/BDdgysNAbcR3BMp9Ql8x/dOZMnaVgvwN56Z
         a5GWEMnYPOj2dBLNA15rVdCN0sP6L6+AOERj740AJeCQSD2FGomkroIjsXof3VM3fDAP
         /H6/2oGnyYf2Llxb3RCXLT++gxVnAWXk9o4ti6bn78rXmOK5ZuDCzTXFf250aUsx9GhR
         WRQku+xOiWWGscIAZwhJeCb3LMzqopzxBCu/EEl1AWZo/sj3Ff6h+Zfj36P6sdL+vCKF
         BlaPjb6uuXve6FjYwRfTiSKiHAgTaH+QQALZOah6rPQD62QvRr790MM0S5NSAOrLDR9u
         n8SA==
X-Gm-Message-State: AOAM532Z0rmW0r3USFomrUawpTX7qLUKlXBtkfxs0cD54FGcuVliCJHq
        PpzGBqdJuDuCqn8PEIvC8z2erA==
X-Google-Smtp-Source: ABdhPJwzBTPelGYUKqKxucbpmDS8MIjmdhCIWUnH1q2YfqvTIX/zU2DFb2Q6rmajFgiuydqlckaZgQ==
X-Received: by 2002:a17:90b:4d0f:: with SMTP id mw15mr5468392pjb.92.1615410627547;
        Wed, 10 Mar 2021 13:10:27 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j21sm371508pfc.114.2021.03.10.13.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:10:26 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 00/17] remoteproc: Add support for detaching a remote processor 
Date:   Wed, 10 Mar 2021 14:10:08 -0700
Message-Id: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set provides support for the remoteproc core to release resources
associated with a remote processor without having to switch it off. That
way a platform driver can be removed or the application processor power
cycled while the remote processor is still operating.

The main difference in this revision is patch 11/16 (in V6).  It was split
split in two part in order to simplify handling of the resource table when
the remote processor is detached or stopped.  Other modifications are
detailed in the changelog of each patch.

Applies cleanly on v5.12-rc2.

Thanks,
Mathieu

Arnaud POULIQUEN (1):
  remoteproc: stm32: Move memory parsing to rproc_ops

Mathieu Poirier (16):
  remoteproc: Remove useless check in rproc_del()
  remoteproc: Rename function rproc_actuate()
  remoteproc: Add new RPROC_ATTACHED state
  remoteproc: Properly represent the attached state
  remoteproc: Add new get_loaded_rsc_table() to rproc_ops
  remoteproc: stm32: Move resource table setup to rproc_ops
  remoteproc: Add new detach() remoteproc operation
  remoteproc: Introduce function __rproc_detach()
  remoteproc: Introduce function rproc_detach()
  remoteproc: Properly deal with the resource table when detaching
  remoteproc: Properly deal with the resource table when stopping
  remoteproc: Properly deal with a kernel panic when attached
  remoteproc: Properly deal with a start request when attached
  remoteproc: Properly deal with a stop request when attached
  remoteproc: Properly deal with a detach request when attached
  remoteproc: Refactor function rproc_cdev_release()

 drivers/remoteproc/remoteproc_cdev.c     |  21 +-
 drivers/remoteproc/remoteproc_core.c     | 302 ++++++++++++++++++++---
 drivers/remoteproc/remoteproc_internal.h |  10 +
 drivers/remoteproc/remoteproc_sysfs.c    |  17 +-
 drivers/remoteproc/stm32_rproc.c         | 168 ++++++-------
 include/linux/remoteproc.h               |  21 +-
 6 files changed, 401 insertions(+), 138 deletions(-)

-- 
2.25.1

