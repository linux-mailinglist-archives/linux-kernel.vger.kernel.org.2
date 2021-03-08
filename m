Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FC6330EBD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCHMzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCHMzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:55:22 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B41C06174A;
        Mon,  8 Mar 2021 04:55:21 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l22so5997082wme.1;
        Mon, 08 Mar 2021 04:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CKCqIHLFrC+gGGSZFvuGc8nO4BJSPqxwsfJgVhqQEVA=;
        b=sEdSuTzxZMuoDBSySrmZFkcpl9WPpHrNTw14EbrDa++gIbt5iFrHxQo8QuWmF0G9W2
         KBD94Ly5hBd6gb7OcZG+BFWe4hN1qUp91CBf3qMMDyB/F/DWzjVdLFgXFhGERhEbxIcY
         rRf28dxcfvHhG8OQyGMkQFsj0facdMDQ1e/dz0I7Y83H6aKkd/88lGV3e+mm2/vhDqT5
         BnZvJLLa3MzRTYfPnwW9uudqKgXm2IxM9sGw+MBX8ZQ+/pzZf/pQwq2BDvYqUt8oPQh3
         UsbJJ74h9ACVM0hK7QWkuj6VlTTqfqBgM70K0Jlalts74WyBSaozdYDN3ZEujfYPGPSj
         CPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CKCqIHLFrC+gGGSZFvuGc8nO4BJSPqxwsfJgVhqQEVA=;
        b=GlnJCHQeegmbwySeJ3NeFOXVFfnkt3GUILII1vpjAJ0X/qvjVCtAEOdkQMl9Mj3YRG
         Bh3GbeUCUxbD7Y3iEMbFIrSuLw0lREpxAw/Sj6+G1GypAldYxfns0a3FChoStypseSe7
         9karoYvhXr9APiSnoTnQfn76Stcfp8CGc5DAkEzMnAgdzUCo9iOT8Syhsj2EwF0/WaH2
         H+d8Ma4u99DF8Ktwu0nO4EAcePSm36pJrODUuRUswrdUyz3nBQwCvNhUb9yx7eyMlTJW
         0qj4nMvGx3qGIOkc9I0u88DRHGhvCarS0fQPaCx6p0Wy+PQjWrL/T8pozS153k/u93Tt
         uHmA==
X-Gm-Message-State: AOAM5315nPy1nwPiITli7JWnTmotFlMblxJwLQ1FxfM31SDQ5Xhjgv4f
        PnfklPvptKU3L/g3ZUB2QCo=
X-Google-Smtp-Source: ABdhPJzaTdxtz2RFMwCNu/INZp2/tBDs+RPtnXxQoj2O43vvEu3dBT28376D3al47L++EjgMXHsBEQ==
X-Received: by 2002:a7b:c4d1:: with SMTP id g17mr22069553wmk.101.1615208120646;
        Mon, 08 Mar 2021 04:55:20 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270095bc7625808eade0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:95bc:7625:808e:ade0])
        by smtp.gmail.com with ESMTPSA id o20sm18922033wmq.5.2021.03.08.04.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 04:55:20 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     m.felsch@pengutronix.de, devicetree@vger.kernel.org,
        will@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, catalin.marinas@arm.com,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 0/1] arm64: dts: imx8mm-nitrogen-r2: add ecspi2 support
Date:   Mon,  8 Mar 2021 13:55:17 +0100
Message-Id: <20210308125518.255216-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a repost of a missing patch on a previous patch set [1].
This patch adds the support of the ecspi2 on the imx8mm-nitrogen-r2
board.

Thanks,

Adrien Grassein (1):
  arm64: dts: imx8mm-nitrogen-r2: add ecspi2 support

 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

-- 
2.25.1

