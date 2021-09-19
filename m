Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF692410C2D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 17:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbhISPjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 11:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbhISPjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 11:39:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEDEC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 08:37:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z2so2123689wmc.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nXMUgHcMZfyY9k+4nDgErnfgloDRhYJnVFo3LMXQlrM=;
        b=X0qu+bb+AZ63iT5aKeHoGKv9NcF7QkVA6HARCKvSiIcbEP7f+aJ4QNBZTArGpvAeBE
         Udabe07k6pdbiHsYnFgrzBGBlZE8kk0bzfHrrhiWSPitsDxQCid0Pj5048fJZXL9oimH
         iW9Oydyt6Il2XuXoFphwpHZs9jTVdNS6t5TdKO1jH9VuLJKpcnFBRp6xW1XjlDD7nX8X
         UDgDbUuT8vJSOoXHFypB6kWNhSdGTM+n4jEQldhFk1isgTigxEb+0U9OfrNMiOvf+aNo
         RON+dhY2LnKDSc7jXv19m2rkQfCL6HtOO9HJA0aSm/B+y+KrL75aDJ7yIj8UoiJUJINf
         l0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nXMUgHcMZfyY9k+4nDgErnfgloDRhYJnVFo3LMXQlrM=;
        b=mxO53/7bUQeHBK43D+HgfYLTngLb9yxs8ulSL/QGZxfRK2UPXkUK2YM07ZTjnSulTh
         u99tSaF4M6OsFa4Xl/pJEYXuksvmPaT0q+nVKM8Dd7MbQ0FONa2Dg5PohOKKRpeHFh4O
         uAM5eF9qWH4IdPXWrqVRjN+85xb/CugWs0CFSQMx7TyjazLjbJSul6AGE83W614uzP3s
         kJ5pJNHxdsDcj04c335KdkDfm28K7eYXNv40/AZOEazJnrfN+fPacvzCVERzFrjeau8x
         a+ezuVCRlfuJcAle7nYRxwTxyyGXqoVddZ1MZ8lRHNeNL4roTfmDD3gOQ3OWxm1QtT1B
         YmvQ==
X-Gm-Message-State: AOAM530q9qirclYlX0N8obN8GLLW8wIs/QlJxWaMUSMJlTYLw2pUr2r7
        vApPQwhgNeoOeoJL/6pD9n4=
X-Google-Smtp-Source: ABdhPJxqdVAhv/j7paPSrXLqdSreKB07b7r9FWwvjzP4T6P6QsHdVl59G5171uG7gLycOYMM4b/68A==
X-Received: by 2002:a7b:c384:: with SMTP id s4mr20547419wmj.108.1632065857610;
        Sun, 19 Sep 2021 08:37:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id l15sm16614501wme.42.2021.09.19.08.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 08:37:37 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/6] staging: r8188eu: remove unused functions from rtw_ap.c
Date:   Sun, 19 Sep 2021 17:36:53 +0200
Message-Id: <20210919153659.20826-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes all unused functions from rtw_ap.c.

Michael Straube (6):
  staging: r8188eu: remove ap_sta_info_defer_update()
  staging: r8188eu: remove rtw_acl_add_sta()
  staging: r8188eu: remove rtw_acl_remove_sta()
  staging: r8188eu: remove rtw_ap_inform_ch_switch()
  staging: r8188eu: remove rtw_check_beacon_data()
  staging: r8188eu: remove rtw_set_macaddr_acl()

 drivers/staging/r8188eu/core/rtw_ap.c    | 584 -----------------------
 drivers/staging/r8188eu/include/rtw_ap.h |   6 -
 2 files changed, 590 deletions(-)

-- 
2.33.0

