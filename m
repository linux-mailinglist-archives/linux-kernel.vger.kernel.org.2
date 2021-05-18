Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71D1387618
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348368AbhERKIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348341AbhERKIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:08:35 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78DEC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:07:15 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y9so10846766ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 03:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=zuwdeAPUpN79x5GuaLRBL3CmBAv3cElVGO0nQDT8pgg=;
        b=dOddR+RZh8FPgN0Hy3+Tbb5TGSLunQQ9yYAD4rNn19MBDdv5GyWH8FzcAriBMxmcjL
         XlJkuPyqR7eEpzZjK4Ujn7CvOL86843Zjcky20VYxqotRYfICScleBQpqgQlLLepGwqD
         pqAe29fwO7AKOGE/3UG7pGRJq7j8zUDwVbBAdkkneqcrltmLA3TrEqVaCkD4wFUWcZ9f
         VV7Z1ejE6rfELszkkTiGVsUfp+vdPJfb4mWuF+rRg4cDC256RncTvbzHiWs3iA7YOT8b
         iagqYVgxitcc1BTKOfDD7FjWonv28yhznXveoTDu7MCOZlkuclFHt2lBlAe+pZ2yLXo2
         UagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zuwdeAPUpN79x5GuaLRBL3CmBAv3cElVGO0nQDT8pgg=;
        b=KTBcOqhr1fIzy2ZZ6QXu1Bg0fDRk0J4J0/36SukH4AAKNVhegOJNefuiJcfzJaB4fS
         tg2r4DuE/9vQ61CoX3wbdibbBl0H6V/c9SOB3xLdxjS33UZLwzVC8cWHgjNEGJE5VGXB
         91AEYuPL68wkguPn/caHh5ntUDaGbgIRa3qo9ou2beF2ePUpZ8bVl+F92dtNg3dc262F
         NHzAXN7oQ8y76h0o8Vk/2QIEQnnQKv0Vv1kr+HCPz4d/0beyJbkRnfS3q8/vAutEe3e8
         4upSHvbP6hSRdj9vmocaV9rZRz4a6tZmOkknIhZy1gIhAfn080J7g5kHsE9zlCevUQuF
         1gJA==
X-Gm-Message-State: AOAM530OByCMDJz18oe1l89D1jwbl8W5BBdf6h14GtyTI5VW0S02H3e2
        sf1nZOYl7JA8dk+TJMWON/8gKwX8lrXAyQ==
X-Google-Smtp-Source: ABdhPJwgYeWUM1gLeYEBPloQMQfy3RcflzWXk1IBzIfC7kzQfQ2g6NQCJJURbpi1AuwyPdq8lZFmXQ==
X-Received: by 2002:a2e:a547:: with SMTP id e7mr3507237ljn.408.1621332434186;
        Tue, 18 May 2021 03:07:14 -0700 (PDT)
Received: from jade (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id u23sm1586531lfq.287.2021.05.18.03.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 03:07:13 -0700 (PDT)
Date:   Tue, 18 May 2021 12:07:12 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL] OP-TEE fix for v5.13
Message-ID: <20210518100712.GA449561@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small OP-TEE driver fix which uses export_uuid() to copy
the client UUID instead of making asumptions about the internal format of
uuid_t.

Thanks,
Jens

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix-for-v5.13

for you to fetch changes up to 673c7aa2436bfc857b92417f3e590a297c586dde:

  optee: use export_uuid() to copy client UUID (2021-05-18 07:59:27 +0200)

----------------------------------------------------------------
OP-TEE use export_uuid() to copy UUID

----------------------------------------------------------------
Jens Wiklander (1):
      optee: use export_uuid() to copy client UUID

 drivers/tee/optee/call.c      | 6 ++++--
 drivers/tee/optee/optee_msg.h | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)
