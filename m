Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232253FA797
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhH1VZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 17:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhH1VZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 17:25:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F1C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 14:24:56 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so11872325wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 14:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZNxHbwj3FFw1s7r8fmJNCVirp0vGHYDh5NCdNZ/bMJw=;
        b=I0bu/IWSCaVI4Q5GDkcJ1MryLO1CNVwZqWRFlYMCUC+/Q8NyU7VcLgE1kFKXw3Y1Rh
         WUyGB8IhIeYZX3GyXGkvDWqYgRnMuyR0D+Cc8moTPwYMtPOrC7YoPu+4kskJTO580d23
         MQVEEAmtoFmJuFwjBPuHJVmk9syB2JAscAL+f5qE2TdufGatKlOFxelLIWqoj0DzETHj
         SaGzuxcsrCNp+6cAIV5CAOB7XBOtR/6tq5inED+SlSEukjPIeZHIZ/TQA9nnXtHiU407
         Lrx4AI18q1Sj9C1FAXUtcU/JwwvFgC9yTkA2vbZXjpIu2F0S7exr82QT52TWWubH2emE
         X05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZNxHbwj3FFw1s7r8fmJNCVirp0vGHYDh5NCdNZ/bMJw=;
        b=MyPmjlMtmERECPeNxe+WgomUFWd1RwbMDiEh2nSVT6N0eTqlI+mpXrjFy0W2HoRYp4
         pWkR2CYI3R3IzPVh3lYDnZ6t9yT5qgdGGj85H+7xtcysVx+dFD6kcAs68QzkezY69FOC
         FhvmHex/RTaYQJBxr5DkqMDq01JzJ2wcDFAMJ70vCC6v9m7rMCFrP7NpUsve3xhc9it7
         rczOR8ab+95ha92HeEQVmHqKL4c29hJ9P/E9oQXBMN0yGqG8FjTLmYFfSNiLf4zIuRZH
         o2io+jxRA7tKs25DiAdVlFd9GIbPLYzlmmskdzVa25r/VAVVDffvXsxc3kuI1VVzA6Mf
         oYAg==
X-Gm-Message-State: AOAM530XBdwY1Qf1hhPYAVNEuhrhyokf5MSj7PmyvANHbvE4ZeU1kY9o
        CAvGI9znBYEErWnVKdXrqJ/q3XhKd6dW58gU
X-Google-Smtp-Source: ABdhPJzP10UNmHbvkAL2JL9uNMbsGcbTdDnWUhz2cnmq0lRK6kSteom8KLe2geWLREhbwQyz/G0PGA==
X-Received: by 2002:a1c:9a91:: with SMTP id c139mr15158828wme.106.1630185894927;
        Sat, 28 Aug 2021 14:24:54 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id u26sm8645847wrd.32.2021.08.28.14.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 14:24:54 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     straube.linux@gmail.com, fmdefrancesco@gmail.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: r8188eu: cleanup c2h_handler code
Date:   Sat, 28 Aug 2021 22:24:50 +0100
Message-Id: <20210828212453.898-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch set cleans up the c2h_handler code in the HAL layer
of the driver. In r8188eu, this field of struct hal_ops, is not even
used, so dependent code has always returned _FAIL. For this reason, we
should remove this function pointer field, and the wrapper function
which checks it. This is done in stages by this set, and helps get
the driver closer to the pointer where the HAL layer is
deleted/integrated as necessary and no longer a separate entity.

Phillip Potter (3):
  staging: r8188eu: remove c2h_handler field from struct hal_ops
  staging: r8188eu: simplify c2h_evt_hdl function
  staging: r8188eu: remove rtw_hal_c2h_handler function

 drivers/staging/r8188eu/core/rtw_cmd.c     | 23 +++-------------------
 drivers/staging/r8188eu/hal/hal_intf.c     |  9 ---------
 drivers/staging/r8188eu/include/hal_intf.h |  4 ----
 3 files changed, 3 insertions(+), 33 deletions(-)

-- 
2.31.1

