Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EAC3306E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 05:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhCHEgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 23:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbhCHEgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 23:36:15 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE878C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 20:36:14 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso15812pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 20:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=frFr0rEwZ1mvFx0ODNHz2Mn0uGUh3IUayStZXkwe3Y4=;
        b=oS/pZFhfYsLgWpBMD4U3ondO/K8Dlcn5ex9y+wNgTIJbS6v2IOE/SRXl2p6TL8OFGv
         HUJ1yNbIbYQxJthZQA0Cm41Dx593QLs7qhSoqDrKX9xkwfgHh4TxVYaqB8iyI/q18WOX
         Kj1yLcZRMuMVX0nYsESD3NORPOnyM9AtN9Gic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=frFr0rEwZ1mvFx0ODNHz2Mn0uGUh3IUayStZXkwe3Y4=;
        b=MxIlqZ697UpbsTU7WlQ5Ipt/27fRLady9rMVjNIfusbThSljpmclf/JD8nTvJ+jnLK
         HW0i7FqWm44oHyuYIhYnXA5/kmbNOIrip1/HdOXWGGdLcI4PtuySf9yQ8mlrD2Z58SWS
         dSdiHd323sHipuZ85BWC9UiBHihaL/fln4/GahCc6TpZjfJkAAeq/dbqaeyCQkKC97RO
         5ZqV3zpZEDO5Cj6NxaI5T4LfmtYCp9ynMWFdfg9PUzSdLDyLiGUFwyoJbOoQ2pa6zX9k
         VVlZOgVlEjYYzGTBskpLLI/2SuDG3dirbbFyrr62EU/YlcONP34bRUnveojTJGVOudw3
         0b4Q==
X-Gm-Message-State: AOAM533H1IMf/X+a3e8jiERMZwTHz2O5bPdahbJ76SAkoHfQk2JG3YJD
        PLDzKQDoYl1A11NecyLfRDVRKw==
X-Google-Smtp-Source: ABdhPJzjTHgZfblSCwgJ8vilflebyR1Y+UKGgoiG73tGWtfd+EgXsnrLI5gUCZ/UqbMJyjDyZQpraw==
X-Received: by 2002:a17:90a:1049:: with SMTP id y9mr22687217pjd.173.1615178174280;
        Sun, 07 Mar 2021 20:36:14 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5da1:da1b:5bcf:2d46])
        by smtp.gmail.com with ESMTPSA id q2sm8191562pfu.215.2021.03.07.20.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 20:36:13 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Wolfram Sang <wsa@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-i2c@vger.kernel.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v16 0/2] add power control in i2c
Date:   Mon,  8 Mar 2021 12:36:05 +0800
Message-Id: <20210308043607.957156-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although in the most platforms, the power of eeprom
and i2c are alway on, some platforms disable the
eeprom and i2c power in order to meet low power request.

This patch add the pm_runtime ops to control power to
support all platforms.

Changes since v15:
 - Squash the fix[1] for v15.
[1] https://patchwork.ozlabs.org/project/linux-i2c/patch/20200522101327.13456-1-m.szyprowski@samsung.com/

Changes since v14:
 - change the return value in normal condition
 - access the variable after NULL pointer checking
 - add ack tag

Changes since v13:
 - fixup some logic error

Changes since v12:
 - rebase onto v5.7-rc1
 - change the property description in binding

Changes since v11:
 - use suspend_late/resume_early instead of suspend/resume
 - rebase onto v5.6-rc1

Changes since v10:
 - fixup some worng codes

Changes since v9:
 - fixup build error
 - remove redundant code

Changes since v8:
 - fixup some wrong code
 - remove redundant message

        [... snip ...]

Bibby Hsieh (2):
  dt-binding: i2c: add bus-supply property
  i2c: core: support bus regulator controlling in adapter

 Documentation/devicetree/bindings/i2c/i2c.txt |  3 +
 drivers/i2c/i2c-core-base.c                   | 93 +++++++++++++++++++
 include/linux/i2c.h                           |  2 +
 3 files changed, 98 insertions(+)

-- 
2.30.1.766.gb4fecdf3b7-goog

