Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628603893D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347676AbhESQdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347548AbhESQdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:33:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703B7C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:32:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y14so12602164wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/kRF+2EHxjIXcYwxp+VA+flXrKrf+D+9tOODi/MubSI=;
        b=X/7NE43VESjEESZ6BRitT4Nf0btI2iu8vwilepLZIh6FMm0rNcbkg0XPZ9JRwIJEQz
         KN8Eue+MCa8L22RdPzYSjCoDN7qevxqICHe+azgWzfmhad/Twj4tJzqNbQaMj3xK6vQZ
         Noqk3zstNpqgSD0fkeLE9ulz962bermNreVbUk8ipQhyB2Eh04pK9p0ZzgpMsJJi/ZaX
         32QbrmZ9HEvLOc0NCr+5ssV88N2SxCrATNF+gdQlymYI+RuSBNcRAvejZ/KihcWy6DJO
         J83U6/KU+ZLBZrwzWHizQxc+3nGs1doPKSfJzad1bW8nZ33yjp46OjRSqgElwjDlzAhD
         yANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/kRF+2EHxjIXcYwxp+VA+flXrKrf+D+9tOODi/MubSI=;
        b=F9voq9c7746EyWMC+q0hVR7XtTYsPZkSBGlzcjOGu/aafJDXnQ+kmi5w3vi8AOjWJ+
         O1hLmn/Ybq+ITh8LqH15IZs/H3xy6787qmK9GJkNRs1TPRV9qoMQECS2ZHrwMNOJL83/
         HwVfj4moQ+8Aa3IerNsMnZOz3O1gBOJlZExmDzOMfxjJA+IiDk+tlgiJb3qoyaQ717Sm
         YqqC8BESBcf4DvdrsxP+r+0QvgdIn9bLhuZQRvTMFNZrMGP4tWEFc5FqIGz057A2T0GQ
         Lp/q1pO4yNphbVGcDJW/E5OP/2CnTw/8MBtTXxze/JueMhXcQP/rsqjZ71j3VLhcyW8u
         CFBA==
X-Gm-Message-State: AOAM531R9y2v4bLnDG6U9TErdR9e8LbI4A2vDbG0W9p3gqjZMvauDHx3
        NiGgVQixFGDz1LJbVYvXbBGjnnvdWCesKw==
X-Google-Smtp-Source: ABdhPJxJwZWSmYRSdlEVnbDJiu2TKcA8ouMxEaaJ1IojTrfCuEQC0EoeR7+XHv14wZ2UY94Zp5vmYg==
X-Received: by 2002:a05:6000:1147:: with SMTP id d7mr15924809wrx.302.1621441935847;
        Wed, 19 May 2021 09:32:15 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:e5dc:6577:6b94:e9e7? (p200300ea8f384600e5dc65776b94e9e7.dip0.t-ipconnect.de. [2003:ea:8f38:4600:e5dc:6577:6b94:e9e7])
        by smtp.googlemail.com with ESMTPSA id u8sm5926002wmq.29.2021.05.19.09.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 09:32:15 -0700 (PDT)
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/2] eeprom: ee1004: Let device core handle attribute eeprom
Message-ID: <66e9f6e5-fdee-6963-6131-228c69705350@gmail.com>
Date:   Wed, 19 May 2021 18:32:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of creating/removing the attribute ourselves, just declare the
attribute and let the device core handle it. This allows to simplify
the code.

Heiner Kallweit (2):
  sysfs: Add helper BIN_ATTRIBUTE_GROUPS
  eeprom: ee1004: Let device core handle attribute eeprom

 drivers/misc/eeprom/ee1004.c | 26 +++++++++-----------------
 include/linux/sysfs.h        |  6 ++++++
 2 files changed, 15 insertions(+), 17 deletions(-)

-- 
2.31.1

