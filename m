Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDF84412E3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 06:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhKAFRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 01:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhKAFRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 01:17:52 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C3EC061714;
        Sun, 31 Oct 2021 22:15:19 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 127so15322145pfu.1;
        Sun, 31 Oct 2021 22:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=eQTrCdhBkLh9tGcXymY0XdSTKIwy9zPdWafZdXWaJ+s=;
        b=lqZW5ygwNT0Tfw1gNHM+EvMONbwVs+LB8oWzVnBN1Je/sCzCWm2ehkDUTYiOa2el3O
         Z9HjiFjj7z6NnePLxcn7oDhuoAmJQdAhSF6/X8VXEwGkoU8C64Zzm81BjnOwtFJ8DBMR
         +cHPjXBznBIS/LPYEw++PDz9G/4pjDTdeIXkqL7yJfA38CrtIZ7d7h95EQcSoJVu4A1g
         5HVFgcKrZdVDts3Z5khUNu1jR7Ycq2m7jABDy6uhSY0JrOwO6EkBJnuz3AQwItXHP1cD
         KkuT9W1u1oAlYJu0s7biPDu881JSr1K6IFPZ1CE6DEl+6wGkcSMcRK9b4pV5njSK4kKV
         YwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eQTrCdhBkLh9tGcXymY0XdSTKIwy9zPdWafZdXWaJ+s=;
        b=J4Q6cyE6yPp35MnmCt0UuiTj8k/mndvbMCm0EYsNkLGv663M3lD2ykfu9roPfxrA+M
         QF4XjUGUskD75HIrHF4ytIdIm1AMRRWUvzRy3XaXEA5FgUHZMN0IdQ6C8AQlUhDcncd6
         I8nZSA9ZCjlC+kTwDRrKfKPrO/HQPXpMzwjNoTmtc1O40THQUIxQZzm5GOwHzWtMhf23
         Lu8exJZPDovzhOKV5TMuxfNZoG9B+3Vpomkzr0pOpfYdlHsi0+s/5Ikb+LoE3SIhpb6S
         DK+HBuCN3TEb1h+CMrITRVEIRzXi6nkTdFJyxzPWtm/Uvth5/jdrTXM6YFhjU7CamAzA
         dPxQ==
X-Gm-Message-State: AOAM532ORtN4LMXmy3QqT5EoQ51we9udHzpE3Z9/mxv4Z2T3dS+2fDnv
        A/h6pQGN82tnbLErLSilokY=
X-Google-Smtp-Source: ABdhPJzRPetkNTU4yZ7X8fXHTkgQpJ/jgZp9+aijq0Nvexp757HBns3yhJICsisVzb5cUyvJMIOcEQ==
X-Received: by 2002:aa7:858d:0:b0:481:12de:ce17 with SMTP id w13-20020aa7858d000000b0048112dece17mr1837190pfn.59.1635743718945;
        Sun, 31 Oct 2021 22:15:18 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id k7sm3182090pgn.47.2021.10.31.22.15.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Oct 2021 22:15:18 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
X-Google-Original-From: Vincent Shih <vincent.shih@sunplus.com>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     Vincent Shih <vincent.shih@sunplus.com>
Subject: [PATCH 0/2] Add OTP driver for Sunplus SP7021 SoC
Date:   Mon,  1 Nov 2021 13:15:10 +0800
Message-Id: <1635743712-25358-1-git-send-email-vincent.shih@sunplus.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for otp driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Coretex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD Card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Vincent Shih (2):
  nvmem: Add driver for Sunplus SP7021
  dt-bindings: nvmem: Convert Sunplus OCOTP to json-schema

 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml       | 116 ++++++++++++
 MAINTAINERS                                        |   8 +
 drivers/nvmem/Kconfig                              |   9 +
 drivers/nvmem/Makefile                             |   1 +
 drivers/nvmem/sunplus-ocotp.c                      | 207 +++++++++++++++++++++
 drivers/nvmem/sunplus-ocotp.h                      | 136 ++++++++++++++
 drivers/nvmem/sunplus-ocotp0.c                     |  54 ++++++
 7 files changed, 531 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
 create mode 100644 drivers/nvmem/sunplus-ocotp.c
 create mode 100644 drivers/nvmem/sunplus-ocotp.h
 create mode 100644 drivers/nvmem/sunplus-ocotp0.c

-- 
2.7.4

