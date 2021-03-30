Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6598A34E5F6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhC3LAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhC3LAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:00:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D55C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:00:44 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m12so23103448lfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=0APZS7qW26TQ2G+AjsqWhc2vH9zR/hdxgKlxQBPo6jY=;
        b=i2knyJ1sOyCrZOtRxP2K/kzwfl6hxexD9Rgft0GYDLtQQutWd5WSAfzSWkjSA6ynsb
         wxxEQ+lZtRH70LuUs8tWdz+WJRK4dZdQaey9OlXNMY1Eli0Ybq0tyfuXo4SpxDv0OQHB
         hQoEwmisCyJeEvffAZPnX2REsyje4r4D55QmZSpSX8w08Cf9qdGmsjMWWTj3YapnU6VJ
         0jryFctoc2KLsDvoClWWgRa+4jGf4vDsTVZzpQ19PgEObPyd3/d4//osE+L47O/fs5xt
         3qg6GZ4jxGNsZrPE7zW01VJAFlw8jbiaKsdVjwXuVC1LpKM6e8IHG17GH1Ak8QkRVBIC
         xVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0APZS7qW26TQ2G+AjsqWhc2vH9zR/hdxgKlxQBPo6jY=;
        b=j068z7dgE9Whuc34KbJWFQO61U6JDpvyp9V2vB8FMtpOrWgeairOR96jVnj1R7HIia
         u8m7HLIZDVjxsojdI5MlDgt7mDa2q7zp+qLIIr8NGo0x5NsG2YkDtZK95VsRC2mBlIW6
         2TTKzQHxicnYa9zYRO8hmuRW18TGlgfaSPQG7y+J33hYhBBDwKn/KuccDcAEz6P2CXXa
         Yxk1dmD3au5QHLyF52oDmbLuTMXh/uCjHh8acqecdBAkOPqNODHFelNtFkpDZnO5lNdc
         RSGXItG3XnzRPsEzOFNOsPphtFe6Q8bU4nrII244UFb0n4faRMnzhPIUG0cnkNJuithO
         qF6g==
X-Gm-Message-State: AOAM531BhdIalFlV62Kl31+07glOiYcLQ+kvbwNApxK/Yv3Bn7EnwL+3
        HcqVu9w0TXsYG9n9iGrymPEegw==
X-Google-Smtp-Source: ABdhPJzgc2H73wOp9fwexyN8u+OrDRs+gsXXnZr5n49qEctr+PRLJjclKcSQoNWMtMy0TGrk3YOglg==
X-Received: by 2002:ac2:4ac4:: with SMTP id m4mr18924716lfp.404.1617102042945;
        Tue, 30 Mar 2021 04:00:42 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id h4sm1324240lfv.22.2021.03.30.04.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 04:00:39 -0700 (PDT)
Date:   Tue, 30 Mar 2021 13:00:37 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jerome Forissier <jerome@forissier.org>
Subject: [GIT PULL] OP-TEE memref size check for v5.13
Message-ID: <20210330110037.GA1166563@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small patch for the OP-TEE driver to remove the invalid
size check of outgoing memref parameters. This code path is only
activated for a certain configuration of OP-TEE in secure world
(CFG_CORE_DYN_SHM=n) so this problem isn't always visible.

Thanks,
Jens

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-memref-size-for-v5.13

for you to fetch changes up to c650b8dc7a7910eb25af0aac1720f778b29e679d:

  tee: optee: do not check memref size on return from Secure World (2021-03-30 10:44:50 +0200)

----------------------------------------------------------------
OP-TEE skip check of returned memref size

----------------------------------------------------------------
Jerome Forissier (1):
      tee: optee: do not check memref size on return from Secure World

 drivers/tee/optee/core.c | 10 ----------
 1 file changed, 10 deletions(-)
