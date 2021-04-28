Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B2536D68F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 13:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbhD1Lek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbhD1Leg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:34:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2109C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:33:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i24so14183371edy.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SRL7LAkBzsLUShMKaYemtSvs+IVP4TH25c50jQgyGbc=;
        b=H22f8cenNNUgyJ6uU1FRqxyvANwieddNRC0SaSE9AWvvRIu/qY9xgul+uvp/EZ1jab
         6OxfuFXHEtQvscV9yZTCaK3gyXP3Us4OXlyRDmnPwCPvj3+jonhU78rdVHGuSY78FyIH
         icOWJ0nSmxenTalBCqaBaft4/j3eLuqK44WiMwPcIgCpX7qXVAhO8q8xkGk2vu1PjqJU
         Jl7YRdTUbtnxjLgAKXfYt7EuvXU/+qImrFu32lNNe4HYl/BtGIsPibtE5lU2Wc1EhTBA
         dJcgQ+XtQaHnsCPGbzk6N0fesutFyOHwAOUOhZqnt4WjgRPp1citkMhU5TgFHeNtXyFo
         2FrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SRL7LAkBzsLUShMKaYemtSvs+IVP4TH25c50jQgyGbc=;
        b=K4K7cMY6Z9iH2lc7zXIgwF8nO5xs2lB/TRcx58Vi6RZRXvqU6Lt7iiH/RYoA1mrZEI
         dYMbK4ADMQzTLZ/btn/luHIWfoYSgETScbRZFVDAGk9ITnTI/CYcvKLrgBYyqA3YvZtT
         fTm+izAMF0bK+IseFO6rWsYex3qtqwSimuYZHBm/n1bFDJmF0YcQEVKWXTZODFN/QmTk
         51T/VoTK52SFe+RFhp8wufifsEexq+e/YjKkQRC/j0qnkrMl37LHi0G8qUY9SYECKMNW
         HVHa1kpYAwJnKhfkWVATFMqb3VVUi4QYKcUuStVGB9eFZp6OpriDx9gdq6D4iQv3ZfA3
         BYMQ==
X-Gm-Message-State: AOAM532dY0dch72voUE6ZtUX656amO+kM3ABuPanEXkd4HaHegc/XA4j
        bgR2/HkQX6nIgprZh0Ef8wQ=
X-Google-Smtp-Source: ABdhPJzYnYVJv0HaNf5CJzsCVTYjnZ6cQLmgLajSsTiPi+o3b8ZVk3e+EHb2xL0Yu+Z4JXatJuuM0Q==
X-Received: by 2002:a50:fc99:: with SMTP id f25mr10711029edq.147.1619609630443;
        Wed, 28 Apr 2021 04:33:50 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id u19sm4677187edy.23.2021.04.28.04.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 04:33:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH 0/2] Removed set but unused variables
Date:   Wed, 28 Apr 2021 13:33:44 +0200
Message-Id: <20210428113346.28305-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed set but unused variables. Issue detected by gcc.

Fabio M. De Francesco (2):
  staging: rtl8723bs: hal: Remove set but unused variables.
  staging: rtl8723bs: core: Removed set but unused variable.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c     | 4 +---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 5 -----
 2 files changed, 1 insertion(+), 8 deletions(-)

-- 
2.31.1

