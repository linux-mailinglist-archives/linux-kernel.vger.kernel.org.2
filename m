Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E768531731E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 23:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhBJWQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 17:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbhBJWPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 17:15:48 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB72EC06178B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 14:14:48 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id w1so6866717ejf.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 14:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TLQHZYiHAcfMtJij9bBMXiJV8bp7vLmKRqNCBw8+ijc=;
        b=CftyxJd0nXVsoqE3oViLeFHCTpBEQpvE37TwZ4oqafTgxDVd/JhRl0Vn5oIAVTGqpn
         rZ9JU4qVG68o13ozYG6Iz7KLEQpn1kV8JnCFP2FeQx3CXlRj7uEStWu/1pTOnYkMUW3v
         Og67ih/fSNfujPjwbczEsIPytMH/H+HVgDlEuAF803pTtgUifWV+rtJtJJ8UxJGjlkq6
         M9XUAFm26X1wisgDUcgY9g3N+MGWPDjDlPPXxgDxMsXso+Hyvr/XErFk3SvJeahixVXU
         q7N9F5otSddC2CMpV8zs50IXiDPCH3JbaY6zw3BN8y5wb8/H7HKcTJgGSS0Zj9zMXNNp
         elGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TLQHZYiHAcfMtJij9bBMXiJV8bp7vLmKRqNCBw8+ijc=;
        b=rnx53ui1Y5K/TwkRMFu4QYctXNwp/K+ywW9/Ujvz4Iswg5K8wZuFJXK2/oAc0k1WxI
         /Fc41TFSmy74O7XaDDkhiYZp9OwZG4qxRkVfpfLUJy1uuySzTYS34GGXI0yDhbrdutDC
         q82NtULnzLdhTxwIKHf8637hmPsa1st6yptPs8XtC6AgFDqaCF4zEVGVc7VPkNipgBuc
         CfGbkccCeApEOnqrpcPl8r+uNOSjZmUw2ErxGDzQdVdaSYfOe73t/uKNAoMQUfTmzGIh
         UbqPt6FWEE5hshtRhHIE1RO1v5833ioCCzMtpIYRSoGmuhCrki+F+gu06Dh7MZ9vgMoy
         he9A==
X-Gm-Message-State: AOAM533kemD4bzH9UN1Nrzwo5lkr/o3OJmypatRC1QioGQ+ZwmD/wzmc
        uSfDMWDLeLrwLlb/xeZJWSE=
X-Google-Smtp-Source: ABdhPJz2EFGkeo94PcaY8UQDCUVYJyF/C0qFCnJHLmZHnw28VJfmsI5BiIngRgNAzmaLQti6EEKcaA==
X-Received: by 2002:a17:906:390c:: with SMTP id f12mr5187225eje.31.1612995287367;
        Wed, 10 Feb 2021 14:14:47 -0800 (PST)
Received: from TRWS9215.usr.ingenico.loc ([78.190.146.52])
        by smtp.gmail.com with ESMTPSA id b3sm2130578edw.14.2021.02.10.14.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:14:46 -0800 (PST)
From:   Fatih YILDIRIM <yildirim.fatih@gmail.com>
To:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, yildirim.fatih@gmail.com
Subject: [PATCH 0/1] Coding style fix
Date:   Thu, 11 Feb 2021 01:14:38 +0300
Message-Id: <20210210221439.3489-1-yildirim.fatih@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a coding style fix in greybus subsystem.

By the way, I'm following the Eudyptula Challenge Linux kernel tasks and
this patch is related to my task no 10. I hope I'm doing it the right way.
Thanks for your understanding and kind comments.

Fatih YILDIRIM (1):
  Macros with multiple statements should be enclosed in a do - while
    loop.

 drivers/staging/greybus/loopback.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.20.1

