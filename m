Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE733EDA83
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhHPQG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHPQGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:06:54 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21368C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 09:06:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bt14so16928499ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 09:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dsy2FFIBDpdnQxdOvpG9locBJTuLRwcWpIcYnX7FKsU=;
        b=qfFjXJilL0XaJ2SeS8oxPfhd5ufAEH/X7lue4BRTV8JzCIwd2D7kvAxp/XL4+S2R0V
         DHUeY75bNZ0Mv50Gkn9d9G3EcXCbTXSoSTgeuOZslu+Pki+M+g8wxxG0eoXLqE5VZQxF
         Eg8BIsGj5f1U7OunLzT3HfqTa4JRp76htrt0PrJRjW8WnetQUzrdfPoSUszbqvS23Q3P
         wbIcNlk5wP+ua7s5yFugD3Ke66T8dcgfCZNXC0BDbAz+vb9LvGHIvOIdLfG2XzvtdMSZ
         qbmIE9kxFDu3AeqCQMkmJrXWCPtH0Ur2wIWmBsO5FGM2+t5zBz86E7L9xseoyNZoGc0V
         9qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dsy2FFIBDpdnQxdOvpG9locBJTuLRwcWpIcYnX7FKsU=;
        b=Rr/W2AM1RxWCoHepHw3nSbYCKg/BAwhPc7Y3XSXM+pFBQmaeJfiLDAQ2NneOlxvMI2
         27SmbDqyoMZpk/J2kWaWvHOo+hNoUMjg3M8nKJEl+eMgwFwHnBYWcDOiQwofRPUyGrPg
         wucY54xWdj7SuV2eQnw+0suW9iEHwuuYfldKsKH4OtSrj7w4zwgJo9ExtRY1bsQjzw06
         7TGVwMUWBg4W842hrW8WUC09S4jQQrpUT8pAK4JV4nju0iJgbUlmwHG+9hiXRLrIBcFV
         fs+aXs2iPeDaU/SESIzcMNBQMr0Cv2XsqnC8DJjne3wfEzZlpvw2A6dmzAkIFLbwiiQr
         pPLg==
X-Gm-Message-State: AOAM530DxLPR/s+2QsLvPAb7ZXITYrHKVjHTS1cjkbKc7IbUKjE6rsPf
        O30PpZxynDbMhiDDego20Vw=
X-Google-Smtp-Source: ABdhPJzT87VMKMpXyWRXG5sJlR82C6kk8DrLKbkY1qZXSY3uI4KGtX9OtGZwJPaZWdCH5Rpf6Jb2jQ==
X-Received: by 2002:a17:906:e0c:: with SMTP id l12mr16806531eji.301.1629129981737;
        Mon, 16 Aug 2021 09:06:21 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id s18sm3906239ejh.12.2021.08.16.09.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 09:06:21 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: Remove unused code 
Date:   Mon, 16 Aug 2021 18:06:14 +0200
Message-Id: <20210816160617.11949-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused code from the r8188eu driver.

Fabio M. De Francesco (3):
  staging: r8188eu: Remove unused nat25_handle_frame()
  staging: r8188eu: Remove all code depending on the NAT25_LOOKUP method
  staging: r8188eu: Remove no more used variable and function

 drivers/staging/r8188eu/core/rtw_br_ext.c    | 263 +------------------
 drivers/staging/r8188eu/include/recv_osdep.h |   1 -
 drivers/staging/r8188eu/include/rtw_br_ext.h |   1 -
 3 files changed, 1 insertion(+), 264 deletions(-)

-- 
2.32.0

