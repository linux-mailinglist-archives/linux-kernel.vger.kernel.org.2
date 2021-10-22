Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34B9437543
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 12:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhJVKMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 06:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhJVKMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 06:12:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF2DC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 03:10:33 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y12so1645227eda.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 03:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bv15z/HDZ35Wd616+xa+/jpdcT0apCXDkRvFnPklDls=;
        b=kiBdR54mITSRu5ns86DVh4gDUSrpfWCfMqH81je5wJYnJBlwI6wTR6qROG2sVgA7XZ
         cP8jzHgXCwaBav1WCCtK2/nHT2AZ2KMU5CAFsuNIDjPqpq6H0eddxRe5nImRDcWo2Nx0
         fGCqgD6vdO51CullAoKmny5za7gl/w8ZaRGLnUrt5Vj6Dd45Xs8JT6iW+IcO4BNtm9ze
         tPzluTmQNiLcN3CLTjUK1fFaD/dEN6rF39nfSnLzuzb7SOLcE0wuJCwA2J34r2r35DoB
         e11pgCEw/jDNHVMaSrksPxYPJOaFljksSEkTlXE0TRSUudv1VNecQky5a+lLUgG/c7Df
         btPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bv15z/HDZ35Wd616+xa+/jpdcT0apCXDkRvFnPklDls=;
        b=fndwXLXLvuvAINeeBBMF/orOlvfuyNWiq11TyoieKIVphQUHBo42FrAepc6RbzZCPu
         EPKSN+iBX7yCjCH/8cXpm9J6X7/lKlF19HC+WZrmZm64EZvH3WAfd9ACLyWpSbY446wl
         ydJ8vO0j06omK7ZVY6TMLcQRBPNo6gnCb9WopWETqvxsfTVT1ZikqIRXrNTeNc40AVD4
         HvKZ2t+IZUnJaIeajy+iN6POhq/AkAIYeod8kqrKuu3D97ysFBoWJJVYoOVquc7GLfV8
         v4RO9qcPpW3trhY+05eWNOzCzDkcq+PO15cjLxPzvnS5zAvvv2oleM71GTApWTsn2krj
         kS9g==
X-Gm-Message-State: AOAM531/F+w1A/RdcQ05GQuh4qOv5aQAILNRaXL376SNxM/64qUfjfBH
        ycHCEVgauqLLn0Amei58elYDeCOxTjw=
X-Google-Smtp-Source: ABdhPJyF4xoqdQfZaEt/p+BZgolJWRosGplKMdH3wi6wgMgnFEKwIFh0kfg8aY/4NVVLVe76gtzWDA==
X-Received: by 2002:a17:906:3542:: with SMTP id s2mr14081859eja.379.1634897431731;
        Fri, 22 Oct 2021 03:10:31 -0700 (PDT)
Received: from localhost.localdomain (host-80-181-148-119.retail.telecomitalia.it. [80.181.148.119])
        by smtp.gmail.com with ESMTPSA id j15sm4243446edl.34.2021.10.22.03.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 03:10:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 0/2] staging: r8188eu: Remove unused semaphores 
Date:   Fri, 22 Oct 2021 12:10:26 +0200
Message-Id: <20211022101028.30367-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove two unused semaphores.

v1 => v2: Add missing subsystem / driver name in cover letter.

Fabio M. De Francesco (2):
  staging: r8188eu: Remove initialized but unused semaphore
  staging: r8188eu: Remove unused semaphore "io_retevt"

 drivers/staging/r8188eu/core/rtw_xmit.c      | 1 -
 drivers/staging/r8188eu/include/osdep_intf.h | 1 -
 drivers/staging/r8188eu/include/rtw_xmit.h   | 1 -
 3 files changed, 3 deletions(-)

-- 
2.33.1

