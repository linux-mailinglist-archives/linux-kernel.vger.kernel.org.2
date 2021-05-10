Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34CF378D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349289AbhEJMs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240482AbhEJLap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:30:45 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E100BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 04:29:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 10so13532396pfl.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 04:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=u7kwQuQc09sCEmYFDSsBxiPEjHb+SjER7KEW/q9aBeM=;
        b=GhTXHV3iRipnohnB8mk6igF7KQTfIbrkHT/UGk0AxMDSzi3+AIE69eG7YapDlaMrPQ
         Ymds8zb+g87yG2HZ4Z0JAUW7lhZxhTfQp7/tVVBfrwmMMAugSa8hYsFVlpXhrCZe7cM/
         BfQniveZhHEqJ3cXTOb26Qp1Ph8+/Brpiu+RAj3AFMchXt3QzY13KGqIzF9UhaJez9Dz
         Vh0bh2kHAJ3JsXDVWK86ZPjALg3H08Y3uiENwDXvgc3KBBRyV1QSjFqHOeuZQvg87ANM
         voVHaNaad02zRKv3TKjrWNuSw7cMShlfNs+d4Mvt9NqFkXaZoRMfi+/PaZnio/x2avUy
         dMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=u7kwQuQc09sCEmYFDSsBxiPEjHb+SjER7KEW/q9aBeM=;
        b=HLTF6/OIUVEk3eN470naR5ROs+ItAKMveyVct4FKXytdHFvGP7WVA+9YfgdZ9F2Rdd
         Bfm5D06r/iRi+GksJZyfBV3pShGD5sgothgd07uxpuKeIgMcf+Dx87taXeiS4g+rtUiH
         1HR/LX2X05zGOfjDdaKKFsl7UwwFoQu7OF2G9ftrwE3CXIw9apvNv4CuD0wecIzua+Se
         sijvcXHWf2KS1++vuQZiwGq0JI21YyyKqG8R0kpR7KKc6tbKwJZuwD/MVGrsQSy/1LiS
         Kln/m197ZafTSxCyPwDMASkAoxRHeNhEBZORBdryhVdbV4G760mJbQjj39o+8fPGKgVV
         /T7g==
X-Gm-Message-State: AOAM530BOvhroWvDrHnZaySzCZ1aMaw7/TfznP2Rlw28TDGsVTiLh8Mm
        uTdot9EO/UOJmPWGa9WI2Bo=
X-Google-Smtp-Source: ABdhPJyhPFULlPmf5JjZr5dSB1k+4B3e8GDiWgBUAhShAddRlC/o676Oj9y+zzSMAWWAjxU07k9t4w==
X-Received: by 2002:a65:618c:: with SMTP id c12mr24754664pgv.296.1620646177767;
        Mon, 10 May 2021 04:29:37 -0700 (PDT)
Received: from ojas ([122.177.206.92])
        by smtp.gmail.com with ESMTPSA id js6sm46169607pjb.0.2021.05.10.04.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 04:29:37 -0700 (PDT)
Date:   Mon, 10 May 2021 16:59:27 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, ojaswin98@gmail.com,
        gregkh@linuxfoundation.org, atulgopinathan@gmail.com,
        yashsri421@gmail.com
Subject: [PATCH 0/3] staging: rtl8192e: Fix style warnings in rtl8192e driver
Message-ID: <cover.1620642396.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes several style warnings as reported by the
checkpatch.pl script, in the rtl8192e staging driver. 

In patch 1/3, the changes have improved readability at the cost of 
crossing the 80 character limit, by a few characters. I believe the
trade off is worth it however would love to hear your thoughts on
it.

Ojaswin Mujoo (3):
  staging: rtl8192e: Avoid multiple line dereference
  staging: rtl8192e: Add identifier name to function definition
  staging: rtl8192e: Fix whitespace around conditional statement

 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c  | 12 ++++--------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c         |  3 +--
 4 files changed, 8 insertions(+), 13 deletions(-)

-- 
2.25.1
