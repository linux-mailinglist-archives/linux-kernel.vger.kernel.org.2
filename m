Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE9634FCFF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbhCaJec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbhCaJeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:34:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B4EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:34:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id dm8so21523434edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UU43qIhMTe6edOnTRhDNuqs4/6Fcr5WC9xOEehVRvzQ=;
        b=AhlaDFvX1senwjL60n28pgpN8+6gKhh33Pt/Signy08TCbnbAPNqQ0nA9Z1wo0DACP
         XLUZZlIGeGzcaHTmd+JpG4KYSfM9vitIKd1P5deDTBfyxob4ozXwI/IAn7lD3A3FDrsB
         9tvyGYIlG1pW3EYDXNiuxvNTv/HFSTQFXS3NbWkMEyhachGVOP60aJdrz3UsGuVD9k2j
         0dDPpd0F13WpJTGvjKm5SPcShORoXEsa4HqN12CeKRjXrcZ9Z/m48px3DX2cnCZqoU0H
         6KKIHpuG1nf38wTPh0sf2PeJ5cMumO/rbCIj1xb2B9gEChBrFNqDxAbNTYCMnmu5Wez1
         syiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UU43qIhMTe6edOnTRhDNuqs4/6Fcr5WC9xOEehVRvzQ=;
        b=OKI5N65k6H1AfNPhdPmsqEZx8sr5YUa7Aunrem7rXGtehVpHmxxSunoo5mZkpLjYaB
         UJZHPXVnuxNwTvlnZ0pFuWSxem4zOKeElw/hxtCHJnBtitaTC+bD7KRG+n+RwuDOebLn
         SBIdMWaMQ/KhN1WdRyS43Slx1OOpYCSY/8/XccdRrghKnVw6pOnntaZ0E/xuje8cFy45
         /6De5RNziW/hlOlncetm2M4l+9oeB3SyUEFF0CiF1HypiPmsSjPu/8eICfCMczg3/Gxs
         hlat70Fph/hDZt/vX4AlGpdUcHy/XIExo8wVUpRaja48QyMOH4XM9YcaYfzRUJ3I3slj
         yFZg==
X-Gm-Message-State: AOAM530Fk6S64j6dl6o3EqpCRmoo52sZSZfHNntypVgtnJry/GU4Uiq7
        Sf/KrfUYfPS5wmtUxv5Ah2Q=
X-Google-Smtp-Source: ABdhPJzlZT+Dj0fdTynGmGpq9s5/jAaugbVporKqJvGfTNKbCnpA8I1EznveD1AzeWoSx1g2mSyCQA==
X-Received: by 2002:aa7:d74d:: with SMTP id a13mr2651401eds.199.1617183258604;
        Wed, 31 Mar 2021 02:34:18 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id bx24sm828657ejc.88.2021.03.31.02.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:34:18 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 0/2] staging: rtl8723bs: replace private macro with print_hex_dump_debug
Date:   Wed, 31 Mar 2021 11:34:05 +0200
Message-Id: <cover.1617183040.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patchset replaces RT_PRINT_DATA private macro for dump hex values
with the kernel helper used for this pourpose.

Fabio Aiuto (2):
  staging: rtl8723bs: use print_hex_dump_debug instead of private
    RT_PRINT_DATA
  staging: rtl8723bs: remove unused macro RT_PRINT_DATA

 drivers/staging/rtl8723bs/hal/hal_com.c       | 13 ++++-------
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  | 22 ++++++++++++++-----
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  3 ++-
 drivers/staging/rtl8723bs/include/rtw_debug.h | 19 ----------------
 4 files changed, 22 insertions(+), 35 deletions(-)

-- 
2.20.1

