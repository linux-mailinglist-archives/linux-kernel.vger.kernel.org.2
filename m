Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8858E3074F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhA1Lkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhA1Lkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:40:31 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3636C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:39:50 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id u25so7161784lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=khhCUju4o6sGLELHNBOL/gaDK1To8wap6eyjzJF+V/g=;
        b=K+8i079FrLwx5T7UFGpJVUja2zQ4wdF65QL9u+CcqAQlvTisuGIbaPlrNX5+3WeOQF
         cj7BQx74GGjRq1SMEJUXPGdAs7XW2ObDmI7kmzzFCvcRFM543Qs0SlWPwufMUZ9ljEj7
         K6JtyqUghVIVcrdfjgsHhh03NjFA+pr9zBuLPGpAsJrlRsIM0/HTbAAFP7Pp9cufyBMn
         2bLF6aXvx/sQBFJa4aqcC2zpCzelgZMuP4SU6WBsGimNa2aSTI0GDI9BKGJ8EDLYlbGM
         Y/dgsrITY+UJ50L1MZK/hFsLNKahAk3kIuNQifdhf+l+JA8B8l55Wjbr6LwlTr63Yz2V
         +Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=khhCUju4o6sGLELHNBOL/gaDK1To8wap6eyjzJF+V/g=;
        b=RD9xSCMySt76dKzKhVJ2G1ehQfnlNdy37DGnFlbYp8s05K17QRyhcy5ElagTu64TyD
         ifibBDbCbqpHBv46/97aQMbzlGmUE1LTYUrDmMX/VDavXC/FATTLGzTHXfIRo7iy1Z5T
         a3XHgGm8cUp9B57L2m+z4RvBS49VNX4ca5L9W3HfBI9y6kPs26klV6NaGL3Mc0yVCZq/
         GJu+yIHrGOlJIdK/B7BpYk5+zcRC6gkyWEon8JRiepV1rt2I1qb3VV2xHW8TPn2TiWN3
         S7rgZpKguR84pQrKswDx9qJ7rRejPo0geclQy7PfzuCJm9mVG88JIpLbPmJMxgUVEFs5
         87kg==
X-Gm-Message-State: AOAM531I+ydVqNZtcYJmUDUMXLrbzN7L0QWQwylBvbYpprCi2EaRpGSs
        PfxGnqMQalTav3SiyowjS1tus1E0Kqi9nQ==
X-Google-Smtp-Source: ABdhPJww4ISP5Q+ckx+Q5mwgtre2MwC+POyV0sFsirLMyrfDNhffQao3WGHQNWh2K7AMbujXbhxkrw==
X-Received: by 2002:ac2:5690:: with SMTP id 16mr7851305lfr.320.1611833989244;
        Thu, 28 Jan 2021 03:39:49 -0800 (PST)
Received: from localhost.localdomain ([188.163.52.44])
        by smtp.gmail.com with ESMTPSA id t4sm1934697ljc.50.2021.01.28.03.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 03:39:48 -0800 (PST)
From:   Roman Stratiienko <r.stratiienko@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        megous@megous.com, linux-sunxi@googlegroups.com,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v5 0/2] Implement DE2.0 and DE3.0 per-plane alpha support 
Date:   Thu, 28 Jan 2021 13:39:38 +0200
Message-Id: <20210128113940.347013-1-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please review/merge.

v2:
Initial patch

v3:
- Skip adding & applying alpha property if VI count > 1 (v3s case)

v4:
Resend (author's email changed)

v5:
Resend

drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 29 +++++++++++++++++++++++++++++
drivers/gpu/drm/sun4i/sun8i_ui_layer.h |  5 +++++
drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
drivers/gpu/drm/sun4i/sun8i_vi_layer.h | 11 +++++++++++
4 files changed, 85 insertions(+), 8 deletions(-)

