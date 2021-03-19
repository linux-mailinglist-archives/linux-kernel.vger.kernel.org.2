Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B30334261F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhCSTYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhCSTX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:23:29 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CF4C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 12:23:28 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 7so4110879qka.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 12:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W9pVcYH8HQZntZJQ72OreOwxRsD8poTVxL/2gBrG+FA=;
        b=EPoQevvACFQt7DrVhqSHepEMMBKoPpmNYo3M3BLOQfRDdoeHgj6AjVngjRrYhbrhb3
         QJ6E/4xd5RUoYoZIyvKVrt2gQKvIH+20okCGFZvi/3zIOFTVeNgrZYqcfd69By7AjvYZ
         2h3JiCXumMFYe+AhIOCQJu8nir1Xmejbl+nZKNWJyGXV/huIHtv2VUfm2ULuF91htSzO
         m/r60E9bO0cwSdW7mrkjS0TIvMs6di1T471unJe/6Qx/DpIttpfS5FyCvvX1mvlSPRL4
         aniXGGdoxVUFm4EAwDsCaf+beQo9bhqu27uDr0lNn68YMQCvyMPrzYSimCEqWVIMShtn
         FilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W9pVcYH8HQZntZJQ72OreOwxRsD8poTVxL/2gBrG+FA=;
        b=lfEJBvhrDA89dUxrZcgyekSJ6W3AUGan1dhtVBtfJCLkGA86jSo14y/qeg4Kh/23dV
         jCU2By/pHuMucWTmSIlkRaCI9yShdZ9i/r20SW1rcwdhe+HdUh7CxAE1QFZu15IZiwVb
         1ardDbBj9vSlti9KjMGxm+LsN5yYjRdHVWWH1jTU64L6z1oLjJfpJYWSHK0tQLZADO8h
         KDi9tu90/Af+KnGccMLRzU4A8Lk/7B3PlTb1aNMMKonBCqv3aIjW8w+u2wxEUcC2iGXi
         GxJKiVlEdvuRBgsWZYi04evPnBN6i8GCzop8OKKXej6y9zKeMyI53K1bT11KoaY6Pj9/
         EhIg==
X-Gm-Message-State: AOAM530KvhQ5edp6iT0eY/JSrwlbbc4B53VQfMuH48kukJ29MAV4juLU
        utlMb8Gi3wMlhjey4OH9xoh3Jw==
X-Google-Smtp-Source: ABdhPJzJ4mVtiGFVVjHB8MhDrBJjsJCUVAs4MhM0/Xh0tTVrhQCl/zxhmmu87my8U0VXhMlJOwA0Vw==
X-Received: by 2002:a37:bc43:: with SMTP id m64mr175903qkf.186.1616181808112;
        Fri, 19 Mar 2021 12:23:28 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id h16sm4362835qto.45.2021.03.19.12.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 12:23:27 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        tyhicks@linux.microsoft.com, pmladek@suse.com,
        ebiederm@xmission.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH v3 0/1] dump kmessage before machine_kexec
Date:   Fri, 19 Mar 2021 15:23:25 -0400
Message-Id: <20210319192326.146000-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
v3
	- Re-sending because it still has not landed in mainline.
	- Sync with mainline
	- Added Acked-by: Baoquan He
v2
	- Added review-by's
	- Sync with mainline

Allow to study performance shutdown via kexec reboot calls by having kmsg
log saved via pstore.

Previous submissions
v1 https://lore.kernel.org/lkml/20200605194642.62278-1-pasha.tatashin@soleen.com
v2 https://lore.kernel.org/lkml/20210126204125.313820-1-pasha.tatashin@soleen.com

Pavel Tatashin (1):
  kexec: dump kmessage before machine_kexec

 kernel/kexec_core.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.25.1

