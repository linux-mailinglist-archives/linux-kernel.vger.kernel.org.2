Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA32F3F0EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbhHRXtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbhHRXtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:49:36 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFB6C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:49:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x10so6049926wrt.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s0lQauJnwT0JHwXU++inhEOx2/Px1wNJxlMsWSCzhy8=;
        b=OMGkr5DgF/GGPCeDetn45yN7Me6xBUlENpOwjGk3HnZyPIfMdmPndPa99EcmPNccvO
         AcAOW/rnnxxG6DArxyz7NGgsXNDwBTnQ5I10ORKUxrQIPWnLilg87MHTk4ZMC/Nw4Hd4
         cV9jIpHlPVvZmkj0lPAtzeXnd0dR+izYzgvKFjDSpGZOz7gpz2OOEKyfR/I1JiOhJ9Cs
         FRcIj1NR1DfDkrJNaPqjYuKT/Reir9PBaZQ2EVWXtCvcTgTr/scB4DUBoBgwaDYYbAis
         /X2WhwbTSIC+A7NrcwekLnYnVyJtn5aN9d53qRWmIRjVSfx8HM1VyKOmn12yWwfabLZa
         Xizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s0lQauJnwT0JHwXU++inhEOx2/Px1wNJxlMsWSCzhy8=;
        b=k8Q1R079rKkyNtEpkZRRmOA4G7UtR2+gQlzaczQUH0WlconNfI7lzNJWKOec6GAHOx
         VCm31EKKlTPBKzFSGpKhUrUAH9LqbrqJve3REqTaEc4JyoPIwT/3KzUJA9QVgr67brWj
         j8jbVmT+TbVMZ2eqoNzJa3Ub5zz1iSSjR0HCHJ0u6DsgTFn4X1SEmi2tnF6zMhX1F5fS
         YALoCbbZlS08OK47PQsERlc7hHHT9LyZ9trr76BsHezQClKHk/0eb52DrFPQjncGSrK4
         N/YQ6aiefbxeeSeKkCiyWmZAFfkXRWFUTcg4aUFdqdSKtEXv2Z7zyqE4snjgREGOay7e
         b0sA==
X-Gm-Message-State: AOAM532WsBfNkwTkIbRS2VNsa+CSrBPd29rFw/RVixas90GANMmdNQtR
        lzOZlgJAoii3pyhTVPo7148IsA==
X-Google-Smtp-Source: ABdhPJyHx7P5hh/ySyRCY9xN7Ct1mapOcAW8sVeLF4E0bCRunjTCcAgjFJJ7H+j2FA/4quSuVrsnIw==
X-Received: by 2002:a5d:64ce:: with SMTP id f14mr72952wri.17.1629330539063;
        Wed, 18 Aug 2021 16:48:59 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id z8sm1205916wrt.77.2021.08.18.16.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:48:58 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: [PATCH 5/7] staging: r8188eu: remove rtw_zvmalloc preprocessor definition
Date:   Thu, 19 Aug 2021 00:48:51 +0100
Message-Id: <20210818234853.208448-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818234853.208448-1-phil@philpotter.co.uk>
References: <20210818234853.208448-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rtw_zvmalloc preprocessor definition from include/osdep_service.h
as it now has no callers.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/osdep_service.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 4c00adeb72ee..dba7a7bec9d1 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -172,7 +172,6 @@ extern unsigned char RSN_TKIP_CIPHER[4];
 
 #define rtw_update_mem_stat(flag, sz) do {} while (0)
 u8 *_rtw_zvmalloc(u32 sz);
-#define rtw_zvmalloc(sz)			_rtw_zvmalloc((sz))
 
 void *rtw_malloc2d(int h, int w, int size);
 
-- 
2.31.1

