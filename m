Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C313F3B5E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 18:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhHUQTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 12:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhHUQTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 12:19:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBD6C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 09:18:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so15897291pjr.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 09:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujqwGhoXkAIsKqOBu+5AHyJrM+q7QtaKNKGeGWtsMP4=;
        b=b1DgIoDWfW00uQUDRWRZKNU3L0Ror2LLbFSuinu622OLVn5J53SU6MpUwO6xr6Epk+
         1xWa2xFfRhSa0Zh59p39aSmQrV/vUXySzE9WcSfAivb8zly7QyTM5HPG8EIjtKJeh3nT
         5EBElk2nMFah2h6/LbadWTL0vRcve6Iq7U6RzgKQcUmivlmPuzcPTTTBoXwkl2JW9bwq
         vg9Iq95MgLe+JmN5KrkPGOJ6TWW5nfSphH5bj9g/wXbdV+i8KIZ8A1z6MmasDd0td96d
         wDnCfvm16BccBBkICqV+noCtr1mKupsC+wIN9sAdAIbRlHHAdYUKGz7iVGFvtI9U3d58
         BsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujqwGhoXkAIsKqOBu+5AHyJrM+q7QtaKNKGeGWtsMP4=;
        b=R9xg4lNpyGfIIxb3LBeK+1MJ8v0KvXKGTtV3wkK0KXoW3RVUl9DXB23DXXJ0XoveI2
         NEuut98f24VNULk9xbg0/xrns7Hy+FBlGpe6OpUsBjzQ6ka7it7z0lC8aECTzDalBxkp
         PDWLC/vhiFW8MTDA/94rXmlBJPUcXQUvCIA5Ykq2FP+dDwMez71qLudjWj7eLQa2/RqP
         DikgP0x4BsmrCjTb2W1zSeyfwhQ5zcu/N/4FIhEWQlsQruDOPD/1PRII1aQW9yMmZOnu
         RQZYM9wOerH/r456ehd2yS2yIMKEDR3e7KDjwILBn0eW2HX5rMW/V9GWWyETEIP/UamH
         TuKQ==
X-Gm-Message-State: AOAM5318s1GBmEq1jRyq+xJwiMmwk+e/DqlU0rHLs4e5ngF1hk1eyXhY
        92PYLwxp7ac4u5a1eYAxAm4=
X-Google-Smtp-Source: ABdhPJxRYFbfpkYRMA48a8AJFfKOOWjC/TSKs76S7gRP5rYRq6aWSOFSkL3TumD6KBYM51meilrFSg==
X-Received: by 2002:a17:90a:a791:: with SMTP id f17mr4188714pjq.225.1629562718477;
        Sat, 21 Aug 2021 09:18:38 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id y27sm4227011pfa.29.2021.08.21.09.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 09:18:38 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] staging: r8188eu: fix sparse warnings
Date:   Sat, 21 Aug 2021 21:48:27 +0530
Message-Id: <cover.1629562355.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	This patch series fixes some sparse warnings in rtw_br_ext.c

Thanks,
Aakash Hemadri

Aakash Hemadri (5):
  staging: r8188eu: restricted __be16 degrades to int
  staging: r8188eu: cast to restricted __be32
  staging: r8188eu: incorrect type in csum_ipv6_magic
  staging: r8188eu: restricted __be16 degrades to int
  staging: r8188eu: incorrect type in assignment

 drivers/staging/r8188eu/core/rtw_br_ext.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)


base-commit: 093991aaadf0fbb34184fa37a46e7a157da3f386
-- 
2.32.0

