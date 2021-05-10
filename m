Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3645378E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhEJNDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349676AbhEJMtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 08:49:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53488C06125C
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:46:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h4so16468521wrt.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MZpUv7tgjGxsXDRQniIs0eZxYD9bjY5jkBU/UVJQVj8=;
        b=KbG8JXbT2noHOgmMd8wJRapH4yPW5nZH1EiRztpC69MkRLgon2bZfP/aSKBEBilS41
         K5v1HIQei9NxtxbWzIEX8ZRTOY8s/ISaEWwh9uCZE2jmOyKCYaSpJvQXq37QbZEgKMse
         0YmMVjQutEteHLbaUmy75ccRGeePdej01d3FuuEIzovSmFL7TeaBQzdsAUiujBTjRnkS
         dUfyLcYVT1KmgGgus4jBLDamMM3JGBJk4r2rlcIDk/vrE9fCVBJQD7dilyT41EBHH6Un
         PkOXv4vYvzh1OeXj2uQRdLLQ5YD/+5kRE4otP4Mv9nIG1i73zeIEL9OyWP52jVDaFW+d
         FR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MZpUv7tgjGxsXDRQniIs0eZxYD9bjY5jkBU/UVJQVj8=;
        b=Ef8sOaKN+KPF21pIrUdL3m2RFfunqRAm1QpdW5AgNhQ+OVoRhlijaYmOzZqp5/fEMa
         nyHhqq4wuHmpJ8T4wdq+D6g/b4TM/C5v+dkOSKOoejnF9FE1kDanYhrcOxKibULwHsP5
         vXlLqXPhVckPFjuQZBDW3I87Rf337dwo9cwB9v57Sg4mSA55JxYDhlGMbZ2ZuotSKx7D
         LMpyUOIbr3Z2cYqSaLIp3x5D1NJFnBMaQy3+pdh5wViWJlcY+502xF0fyJo7/q5p8xoo
         4lbpSDwy/JXRyQ/qT+8P8XPkT/F4EMNNh1CNNjCAcWqlxaKyHBR8rx7q6j0Cj/nj08DL
         NJRg==
X-Gm-Message-State: AOAM533h008sptWh256Khmx9geCyZxUQou8z6TploVCSC4k2rRDDzkCb
        kA4ucQGSKJrC1Bu6zBOHmEP8Ut8RHYTPOw==
X-Google-Smtp-Source: ABdhPJwHJ0YxxrB1WrnxtlN4cFr+nvxmbre1h5q2AO1M+TCVJHiwm+S+EaVBDIvEkjDcFLF/bUWTXw==
X-Received: by 2002:adf:ef45:: with SMTP id c5mr29775237wrp.78.1620650780962;
        Mon, 10 May 2021 05:46:20 -0700 (PDT)
Received: from agape ([5.171.73.3])
        by smtp.gmail.com with ESMTPSA id a9sm22109481wrw.26.2021.05.10.05.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:46:20 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: rtl8723bs: use of generic CRC-32
Date:   Mon, 10 May 2021 14:46:17 +0200
Message-Id: <cover.1620650484.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset replaces all private CRC-32 routines with
generic ones.

Fabio Aiuto (2):
  staging: rtl8723bs: replace private CRC-32 routines with in-kernel ones
  staging: rtl8723bs: move comments to silence 'line too long' warning

 drivers/staging/rtl8723bs/core/rtw_security.c | 69 +++----------------
 1 file changed, 10 insertions(+), 59 deletions(-)

-- 
2.20.1

