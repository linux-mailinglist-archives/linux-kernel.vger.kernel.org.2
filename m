Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A003947F5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 22:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhE1Ucg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhE1Uc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:32:29 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14130C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:30:54 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b12so6848938ljp.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EyvgwRI+ps+5cZkOoI1nKyi/eTvA8tNSToZ1i/xJfHs=;
        b=pZtHbzfNZT0l32ly8ZjAkBQBqTYRrsBOsrvg9W43j/9U5fUtyPPQakbfC5+eN6OXzD
         Tz/RcuK3FNFKeMGNYTrmtMkkL4q8QE1r8hk1KG7tHvD242nwimuzt1sy988vSyhq2jAX
         Ur+HWapaE0Ps+LNQm3AkXkwEOiwLiDhU3hmwWjmrG+M8/3VGRrJXanxtIacfSNvHnj0E
         fSw1Q5dOjQE47KNonictsJ0Z4sHuuSVHeM1N45TpazX25VeTB5MXBFmgKjAaSu+UqxHH
         PApAyMonACbTzGCzuvvlCdWJ8YmG7KU2E5OjFiFtEuDnK7CX8UxDa1CCUngLtI0PGOcL
         KqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EyvgwRI+ps+5cZkOoI1nKyi/eTvA8tNSToZ1i/xJfHs=;
        b=YkcB1T3Ee7V11QfvbUGLKHNNOPGgJ3sPOWV46vakc4UzK6vm+i3WuYX+P2ju7b0+NL
         KR8HTxN9grfBTKC/EmbqsnOytAQnae/5G3gW7Z3t79azhEsP4YLQHIX/iaGG0/U7Cg1j
         X7salcTAgEW3M0J7PhK/ztybsn9LM3qDKVQwf52A4GnCN8QkNaz7Cpqfd9fcO9oELOY4
         wUsRCX22+7AZ04wGAfzNT5HUDXE+LA4jXdoUqjkDwhfvVxwU2cQFnRPJaZ0dvUU1taaO
         juyVXdaOk3zgCNzRzuXrsYUCTUYGldZHwcE3IJkQ/V46s7ymnOLDBJOu7DiPJhYSmx3Z
         n6nw==
X-Gm-Message-State: AOAM533sPq872z4SEzBDAQtWfZbmRCI+irhv6v+LetP9pvf6GNwAAa/j
        28/rlUs1xv4cUciHB3hHvhsCcn70crM=
X-Google-Smtp-Source: ABdhPJx5zcOiUuDL6xseZn6lzPS63Y1BXiSrMEjSU2d2O8NQ4SzN/viQhRsxgmJNXs9MkmZLu0kalQ==
X-Received: by 2002:a2e:9d8f:: with SMTP id c15mr7932970ljj.111.1622233852168;
        Fri, 28 May 2021 13:30:52 -0700 (PDT)
Received: from roman-S500CA.. (72-28-179-94.pool.ukrtel.net. [94.179.28.72])
        by smtp.gmail.com with ESMTPSA id a12sm655820ljk.34.2021.05.28.13.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:30:51 -0700 (PDT)
From:   Roman Stratiienko <r.stratiienko@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        megous@megous.com, linux-sunxi@googlegroups.com,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 0/2] drm/sun4i: Set mixer frame to display size for DE2.0+
Date:   Fri, 28 May 2021 23:30:34 +0300
Message-Id: <20210528203036.17999-1-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes corrupted display picture when primary plane isn't
full-screen.

Please review/merge.

v2:
- Split commit in 2 parts
- Add Fixes line to the commit message

v3:
- Address review comments of v2 + removed 3 local varibles
- Change 'Fixes' line

v4:
Resend (author's email changed). Reword commit message.
Drop fixes line to allow more testing before back-porting.

 drivers/gpu/drm/sun4i/sun4i_crtc.c     |  3 +++
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 28 ++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 30 ------------------------------
 drivers/gpu/drm/sun4i/sunxi_engine.h   | 12 ++++++++++++
 4 files changed, 43 insertions(+), 30 deletions(-)

