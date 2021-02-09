Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A292C314C4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhBIJ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhBIJy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:54:26 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD838C06121F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 01:53:26 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p20so30269500ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 01:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pqbb2hbiFk/I6vb7TmhkdeW2Dsvn3o0tV40ygJzupJY=;
        b=b9Yr/WFLNTMKwRU/2j24yNwf+F6THMtjELrnzsywsXAvhuvqobOJXsTvc+lpvKP3TV
         JjyxjnXcK6zymN3TICdIcYxmJPe59Buw647pX/xX1GwjeksqDvnR1xClt3jNL9cruFPT
         k1RBj5wUH74f0g5nDeoMk/IqVDQCAhH6uMFIjZeTxzg2VE8FYH74AN+Lmk3AC8+F1tR8
         wbdLI8NTK+qLD5yeAJxvhqx5NUL70wwjvLH5qYX1e1lrfYQqjLOLmMF8f6ccCcSBIR6h
         0I35KsZlmdqauVSYeSmPW+hz/Smm1QWs2ndz0HZdUJ8n78SOkSI9E+davlobcA2tDpWP
         QqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Pqbb2hbiFk/I6vb7TmhkdeW2Dsvn3o0tV40ygJzupJY=;
        b=MLjmjVlF2EpZa4g0XYOMh26fvJDf8RT8JeCNeHrWIx7QW2zrmsfeinQIwdEXsNT45m
         kdhZG5kxPEEj0lajgJ812Xmbm+wT7/H01+XzXXebJXHO7SjzfDkxIIwFHbEkG1uIu27l
         ADYskChkDLTXqpb1pOQK6ehYlnl5UQK75dnji9jUZVrzDNQKy8UH7i2bk5xiXvbt7hp9
         FDTP3LPA1Je0uhyRuZoJShJcIy1iLpQ2WPvfzPbaD7ud/PExdHa1TeCRJmwWruIiwGIu
         petPuwxa+I2q8aszbvndaV7+YHBZ08tMGoFCoV4AWT+q47NFrov4R42FopPd96C13JsP
         Z2UQ==
X-Gm-Message-State: AOAM532mhPyOcPebwj3c6S2sv71wKJ7lOw51FBbyxqDgyscXnBfM1JCJ
        O/t6rxpQ4dkNz3F5AzDaLP2MIRkHbG583Q==
X-Google-Smtp-Source: ABdhPJxTHff2sFseU/wwogexEzr83TWbeERuCDSraUtmSFT/XUiOPJ0B8MHbnrKRymb0cLjUniSZRw==
X-Received: by 2002:a17:906:880f:: with SMTP id zh15mr8838974ejb.268.1612864405279;
        Tue, 09 Feb 2021 01:53:25 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id i13sm10249734ejj.2.2021.02.09.01.53.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Feb 2021 01:53:24 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Bastien Nocera <hadess@hadess.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH 0/2] usb: misc: Add support for Microchip USB5744
Date:   Tue,  9 Feb 2021 10:53:18 +0100
Message-Id: <cover.1612864393.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the series is adding basic support for this USB hub. The key part is
running reset over GPIO line and when i2c is connected it is necessary to
send command to boot the hub. This chip is available on Xilinx
zcu100/Ultra96 v1 board.

Thanks,
Michal


Piyush Mehta (2):
  dt-bindings: usb: misc: Add binding for Microchip usb5744 hub
  usb: misc: usb5744: Add support for USB hub controller

 .../bindings/usb/microchip,usb5744.yaml       |  56 +++++++++
 MAINTAINERS                                   |   2 +
 drivers/usb/misc/Kconfig                      |   9 ++
 drivers/usb/misc/Makefile                     |   1 +
 drivers/usb/misc/usb5744.c                    | 115 ++++++++++++++++++
 5 files changed, 183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
 create mode 100644 drivers/usb/misc/usb5744.c

-- 
2.30.0

