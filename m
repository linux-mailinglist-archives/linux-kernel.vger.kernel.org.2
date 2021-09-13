Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E00B409CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbhIMTW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239568AbhIMTW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:22:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5D6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:21:10 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g128so2987237wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZTkljj3h+rTe2KBAyAOXxGYvTDb2Jx0UPe/y0mO6974=;
        b=N2B7edFOIXkqBqcVeWdUIQZvOJfOCKOgJUqeh9qq2rmA9HKal3oX5Ovr7KdLLJL0YA
         Z0GDZ9O1HAnhFoA/ad0DV8Ic9aKC67REhGWQKhQ/wRl/W7v4cuQWroFe/Dnz3kSbRbZ1
         7hPy8ZjQITnINBJhUxw4HaHoodg/KG+PCoonE0iar/U9bwteoluTofcWoO39u54zjUQj
         KUrLdz/1oM88H2Veg0j1Bt87o94zp0CDum6gmRUJTe6ELqsDr0CHb2UhXYkemHFDrIif
         4pJ/WvJWYfWbRLP1PQgu7/now5QfbRWS/9rvJo9rYZ81i391AbwSogiRFAO8U5qEhHqL
         HFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZTkljj3h+rTe2KBAyAOXxGYvTDb2Jx0UPe/y0mO6974=;
        b=d5FGvkV3EuX17R3LSXMDMi5IiisXj1sCLiAWEKhNiFIHxZvY4c22UypqVl3wyHTSNM
         qOKkSRnRxKKfNZI04qcpBRp3rlxfbvzhgqIT7/ykBiLQLEysxTGyEqDYAlRtv8xG9T0C
         VlSdzwDiLDQy9xzb7HAZlCbb83bRck6NxMqW8DePLcHyqgy0RwKoJfnKNU2Od87uPGCv
         j0iwYXzl+AZC8MrbUpbGElOPdEXHKM77SajvtjIUnUg0b9Udz2abp0I/OPRIEpJVPVtJ
         Dzs3AIQb8wBG/VVnwkXuLVcQlTShl3epP8WfpAQn2Mrb190oMG51F892eGkiSBx287Jc
         dKqA==
X-Gm-Message-State: AOAM532jCgy2reFVrTXGKmGntsB9ZngLVKjxNjNgarW5fTxl1qI/QSbH
        Teg+RQusknwSvhzdJyj9j4U=
X-Google-Smtp-Source: ABdhPJymv5uEomJRaSyutIHUUpPODIWhCGF1NIQLM1vmoUj526ylZ2yn6O3R9AiUD5dtxCa4XbgIxg==
X-Received: by 2002:a1c:acc2:: with SMTP id v185mr12840636wme.71.1631560869581;
        Mon, 13 Sep 2021 12:21:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::1db2])
        by smtp.gmail.com with ESMTPSA id m2sm475021wmm.3.2021.09.13.12.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 12:21:09 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: clean up odm_types.h
Date:   Mon, 13 Sep 2021 21:20:40 +0200
Message-Id: <20210913192043.26527-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes unused defines, an unused enum and an unnecessary
include from the header file odm_types.h.

Michael Straube (3):
  staging: r8188eu: remove unused enum RT_SPINLOCK_TYPE
  staging: r8188eu: remove unused defines from odm_types.h
  staging: r8188eu: remove unnecessary include from odm_types.h

 drivers/staging/r8188eu/include/odm_types.h | 18 ------------------
 1 file changed, 18 deletions(-)

-- 
2.33.0

