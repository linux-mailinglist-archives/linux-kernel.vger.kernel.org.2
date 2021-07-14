Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679923C9354
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 23:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbhGNVtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 17:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhGNVtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 17:49:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEA1C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 14:46:24 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b26so6151371lfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 14:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FR/btbe504ikCrRzJGo5ktlDT0Nj2F4KipBhyP56FHQ=;
        b=052d8aolVEbgWlAhUTObQeSSSsc/5cyQRm4SrN6i3GbJklAnbh2nHkQX/SHxYOxxEZ
         lRTpL2lUyo+HvDqFCK9mMrheoMSkaT3Gd9zzB4HT0+0VOJrIVtSSJbLMbVrdpgP22GZH
         3FAYw4PVzXhVbRgprQhdyapFqXkJRQcVicAQ3bO+/um4TjUjB1EaXT9FkLLQL9rxpbcx
         LAyJ4yvOBhbqtWqkz7tMudXCDMXKoYCH6nI5ZwvAGhrJTZlYOuMExSzZsOa2NkkeCXXc
         ktJ/rFBabqFc7a5syDapOtp3GrcvkX2MQhccw6qAQXC7gD2/MgwL8OJVanG/XAf/5J6z
         59WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FR/btbe504ikCrRzJGo5ktlDT0Nj2F4KipBhyP56FHQ=;
        b=cn4B0w6g023YNVWiiiW1e7RqaBMv1oaoKmmZNa2/6RGS0WBi2fW9AviGzu8mFZbCrA
         gG8623joS98yGTH/uQYNuGwidi0bf+42WBkMMgLVeWD78cUgQziU7dUL+NjQunwALyKw
         HoqVhCPlT8npLe15Lw1610iDgjBJCSo2ueY8zBR5z7EPcepglYshPhOG+R1pLzvU3fS/
         KBsfJTkpXLyUOL3xrIhwMafeXbVWYTIweOBGxBR0QH2/BE5mo44dPdKGWL96gAbq9zJr
         BeMZdD2vTYxsNHhsHNMJ/i3ogJhCuFgsuHp6L5iFrwfzYviVUmDZ0XMMtJ8OgnC7MCDg
         lgRw==
X-Gm-Message-State: AOAM533PjjU5uHsPUuj587QJlsy583YsvX17z8yuAziD0lFNPmWtMNRE
        dXoUfKYM9E141XsLp4DXErz41NnKHYt6sRJU
X-Google-Smtp-Source: ABdhPJyrOWKbrcjB8a2SKmUBymUcYuceia/qvuLTjwUKPG8fXMmdLl3la6ni1sVQKMB4Y1uvp2FV6w==
X-Received: by 2002:a05:6512:158b:: with SMTP id bp11mr204118lfb.172.1626299183183;
        Wed, 14 Jul 2021 14:46:23 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id s21sm370837lji.57.2021.07.14.14.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 14:46:22 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
Cc:     jaz@semihalf.com, gjb@semihalf.com, upstream@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, jon@solid-run.com, tn@semihalf.com,
        rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH 0/2] ACPI: Update DBG2 Serial Port Subtypes list
Date:   Wed, 14 Jul 2021 23:43:44 +0200
Message-Id: <20210714214346.1397942-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This short patchset adds support for the new 16550-compatible
serial port subtype in the spcr.c driver, using the definition from
updated ACPICA header.

I'm looking forward to the comments or remarks.

Best regards,
Marcin

Marcin Wojtas (2):
  ACPICA: Add new DBG2 Serial Port Subtypes
  ACPI: SPCR: Add support for the new 16550-compatible Serial Port
    Subtype

 include/acpi/actbl1.h | 15 ++++++++++++++-
 drivers/acpi/spcr.c   |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.29.0

