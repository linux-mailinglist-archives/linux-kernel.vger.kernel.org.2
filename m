Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6113643E8A4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 20:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhJ1SyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 14:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhJ1SyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:54:13 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53988C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:51:46 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j2so15624536lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xuK+PVCpGoo5TXNGceaR1z13nIhhcB5eydr90mLDPII=;
        b=SGJj+zOmM28+pJw7UAZXKqgJd5UpR393id6/o8uFKPAqrAJpW23gBSZxsOAldjRxsF
         e4TwMTj/tWNPmPCjjFnuG7cPNoSJldpBM2N0l+nwhwXAOvteE4NdqZH+Lsi7d9AkLE0E
         D1Xyn8tY4K7ASs7lQwgm6g2lRraa4+fMddrrA5JILFkt4hp0g8or7Po1jpJuP/v3TRpy
         VfiUj+OUn+RYbzfrr1YwdQag3Yqe4Qcz+Z810ibf//gme58Y/Pwrbxo1pjGSG1yNyOC6
         LTvAfihEiQokhzA/9Hy/kqSyriF8Q3dMH/HUQEuzkvUTXEQB0qy6ZTH9XcbwATyPeuc3
         9MzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xuK+PVCpGoo5TXNGceaR1z13nIhhcB5eydr90mLDPII=;
        b=iPQYGo28qXfIlstGsuAakJZ/8RiSea2jNQNSKLRolhXQYKhh8kPLJZQflyyARBShiD
         yI3ostazylReDwX42IwHWZcUFYzI6Qu5bAiEBQOrrsoItoB1NeqvQ1zW0r+zgFwLFa1d
         /GQI22jmlAWiTtRnEYLVdhNoHtAIdPVLzGLBx6AqdeEhqxKzDWCUcQnIy+fzkih+i5Sx
         5IRX11bjmcHIVfxBgffCR6BuNB03CVqwpgddjDG0hzWACdrtEbKshtGNRZ6631MLEFIE
         78DSLB9OpY5ddBWhNfnkdWIWDiuy7zOMgjNR9n0mkBKJrSfGqA8AFBVLbN38yVoBhWKq
         3xAQ==
X-Gm-Message-State: AOAM532Q5lEQwMRzU1DJPSYF/onTvkBG0u5moRmZK5NX0htABJHrKDqq
        phlOjjLJVr451pC7QQRlQV7/PQ==
X-Google-Smtp-Source: ABdhPJzBnfa4mBA0AnC37UOa9fGUbSIMG7jpPJRp30ImMtv7XDpSn8ilUPF1pyTBhW89l82LvVDBsQ==
X-Received: by 2002:a05:6512:5c7:: with SMTP id o7mr4449258lfo.105.1635447104690;
        Thu, 28 Oct 2021 11:51:44 -0700 (PDT)
Received: from jade (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id e2sm348226lfs.85.2021.10.28.11.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:51:44 -0700 (PDT)
Date:   Thu, 28 Oct 2021 20:51:42 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OP-TEE FF-A fix for V5.16
Message-ID: <20211028185142.GA2489375@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small OP-TEE driver fix which takes care of a couple of
spell errors in a few log messages. These log messages was added in the
recently pulled 4615e5a34b95 ("optee: add FF-A support").

Thanks,
Jens

The following changes since commit 4615e5a34b95e0d81467f6d2176f19a5d184cb5d:

  optee: add FF-A support (2021-10-18 11:44:23 +0200)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-ffa-fix-for-v5.16

for you to fetch changes up to 1b73a9e4986a4e9065bacf1e5ab2dfda17b54161:

  optee: Fix spelling mistake "reclain" -> "reclaim" (2021-10-28 11:41:39 +0200)

----------------------------------------------------------------
Fix spell errors in OP-TEE FF-A driver log messages

----------------------------------------------------------------
Colin Ian King (1):
      optee: Fix spelling mistake "reclain" -> "reclaim"

 drivers/tee/optee/ffa_abi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
