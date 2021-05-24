Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED77D38F414
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhEXUJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhEXUJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:09:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9875DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:08:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso12064957wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=UJAT12VUa4aYtE2wZCxflRrYqiTwHKqIc1L2n78vuL0=;
        b=tMI8wilCW+zwGJobpXovpS965RsQkQSiLuwQjl7lsN0bx6GLNmqtAZ12Bt5+wdM89S
         vR8G5JyOcJpYEW+NQunDKk2rwSjMABswgPm2RpSWL7v7XAC7EFvRN91gsBcpyGWP9mrG
         a/r4Am9yvYWB308IKoHiFllRbJ6c7oLDajOOQw73bsk6yPOBMoneDAL2EjfH1It249wi
         NNisuQYAMyqeb9IffAEdM4IgkII3rRPNTn6MPzr9G3meCvvfkeiLxg3UD5FQKIrL0NfI
         NsJ0/tiFCJiNswIhpc2gr4DPn5kgdJAl3BEz88OqnaspNkf6vC7CwOJ3f9xWCGBbkEn2
         TiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UJAT12VUa4aYtE2wZCxflRrYqiTwHKqIc1L2n78vuL0=;
        b=YroQO1G7NXWBvqq+KY6kpTPevtih0OYDBNTdjAgw56ecBB+SKVNndabZdzAuVj93gE
         O1xU1p1geM2mK02DO1K/Bv8JXdzVBAKnTgcCheVIjS9Gir2YfKO/AQL3m2hoJ3eIKuYp
         Eh/YePQALlJf060F/HsNxWmjzA8ca9cmyKT/cr0lmOuizPrLGxGB3fzHElrmDdI7YF2R
         Myl+ygX6L7gsiXKjAH1TNEqC34LihPJTJFUP+RkdQ4ts9wZfhkioSaPvcBS0gh/I09vU
         Y0Wrm5AXUovOb3auLv9lR5/AtzwhzKUY6KrC55nLARkau8rKANMJoVW5jEMAz9MYXVxM
         bQgg==
X-Gm-Message-State: AOAM533YODyIWI+REJxG23+SrrgtkBwxQ76CV37dTLGi41RYgf5sfs/F
        eN5Ob+5K1DQncd9dYzsGIWdkGOD2LFo=
X-Google-Smtp-Source: ABdhPJwkXhlHFkw5QhDrHUygXoKnX8H/nZAPnfZvX6W73Qat5KUvYMxD9Exl1TMi/lOjAg81fbPNAg==
X-Received: by 2002:a1c:2cc3:: with SMTP id s186mr634315wms.150.1621886890787;
        Mon, 24 May 2021 13:08:10 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:8954:39a5:6045:cd0c? (p200300ea8f384600895439a56045cd0c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:8954:39a5:6045:cd0c])
        by smtp.googlemail.com with ESMTPSA id c206sm460263wmf.12.2021.05.24.13.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:08:10 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/13] eeprom: ee1004: improvements
Message-ID: <bd8439bc-3a6f-fd52-5fd1-bf9782061612@gmail.com>
Date:   Mon, 24 May 2021 22:08:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes a number of improvements to the ee1004 driver.

Heiner Kallweit (13):
  eeprom: ee1004: Use kobj_to_i2c_client to simplify the code
  eeprom: ee1004: Remove not needed check in ee1004_read
  eeprom: ee1004: Remove not needed check in ee1004_eeprom_read
  eeprom: ee1004: Remove usage of i2c_adapter_id in adapter comparison
  eeprom: ee1004: Improve check for SMBUS features
  eeprom: ee1004: Improve creating dummy devices
  eeprom: ee1004: Switch to i2c probe_new callback
  eeprom: ee1004: Cache current page at initialization of first device
    only
  eeprom: ee1004: Factor out setting page to ee1004_set_current_page
  eeprom: ee1004: Improve error handling in ee1004_read
  eeprom: ee1004: Move call to ee1004_set_current_page to
    ee1004_eeprom_read
  eeprom: ee1004: Add constant EE1004_NUM_PAGES
  eeprom: ee1004: Add helper ee1004_cleanup

 drivers/misc/eeprom/ee1004.c | 191 +++++++++++++++--------------------
 1 file changed, 80 insertions(+), 111 deletions(-)

-- 
2.31.1

