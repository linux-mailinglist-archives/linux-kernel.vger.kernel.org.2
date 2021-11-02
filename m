Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8BD443969
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhKBXS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhKBXS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:18:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637CBC061714;
        Tue,  2 Nov 2021 16:16:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i5so860418wrb.2;
        Tue, 02 Nov 2021 16:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6rjzzyUGSlERAuwJSH0XEKW/VN+PnGvJFm5FyzCoaY=;
        b=SQhskytV8xOmkEZ4+m1uy2ll3kfcpHqeQ4A7fnLA24OIBAYNc2Kf+l6rdlTfJ2cUac
         5GVjMRMfuMXH3dY+DjEK5HkIBzQSDDZDdK+DV+Yis8BLyNO/eNEZNylRucwy7rSfTZWu
         7WaKLCFzm+6dfoTWY/2qStAKEnXVclHHHOgGcVceXj1sWGTO+qODkmLI5NwylK7T0ikD
         Yelof2Ej02qQPskEWJFLga8VYKOuDQkETpy3NXz6yFAfSa+OgA/Q0aZe/QXcB4TP1+B4
         NByYHUxKAW+bK8IbOMxrlF8ikmhu77eN+COBWE5Io2B0rU2e/x7muo3gdgfpP/HhpuSk
         t7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6rjzzyUGSlERAuwJSH0XEKW/VN+PnGvJFm5FyzCoaY=;
        b=ePENgu0OD+Qv3ML/Jh/hZQ3r85cce99tnSpHlksijT6IzLo8u33LaQ7vdOKNzetE6c
         hSC4OJP1udya1W0rSJY/In3STi53nbfKMffHI1bTQ5PG8JWDfjCd5wB0Z9VcJph2/yql
         9kNtICHUiW2ygSIvKhbNUfl2sP8QTfGR0encjAEjs7ksO+oqoPMwfBF7WTWml8k8qJr5
         zElv6901NS3a7AZQZrnQPz4GYhn2Rbm3JbVn7eeQncaWtYAgK1CiZQELdeQhi2qZeu+d
         6WmOn6d/0qnxNcwvEnWvBzxDC0/UB0fic57l34+JNNhg37jGjFwXyUmMtwc1iDUsCS6O
         ciZQ==
X-Gm-Message-State: AOAM530+M3tMOfuyR4wPgbtWAJ4XcBZqaXhdEReB6P8jh0jbhujLFDPr
        3QMGgqdOrMBFvA==
X-Google-Smtp-Source: ABdhPJwgWQ+0bukxu84IxX9ucHGOlez2D67MBHn0KTjY4ZaQQR4vrEXDJe+QaCI+iqBw+g0bCbxwVA==
X-Received: by 2002:a5d:508d:: with SMTP id a13mr7354426wrt.41.1635894980021;
        Tue, 02 Nov 2021 16:16:20 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r10sm323399wrl.92.2021.11.02.16.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 16:16:19 -0700 (PDT)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: update email address for Colin King
Date:   Tue,  2 Nov 2021 23:16:17 +0000
Message-Id: <20211102231617.78569-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King has moved to Intel to update gmail and Canonical
email addresses.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 9d4fc1fea665..14314e3c5d5e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -73,6 +73,8 @@ Chris Chiu <chris.chiu@canonical.com> <chiu@endlessm.com>
 Chris Chiu <chris.chiu@canonical.com> <chiu@endlessos.org>
 Christophe Ricard <christophe.ricard@gmail.com>
 Christoph Hellwig <hch@lst.de>
+Colin Ian King <colin.king@intel.com> <colin.king@canonical.com>
+Colin Ian King <colin.king@intel.com> <colin.i.king@gmail.com>
 Corey Minyard <minyard@acm.org>
 Damian Hobson-Garcia <dhobsong@igel.co.jp>
 Daniel Borkmann <daniel@iogearbox.net> <danborkmann@googlemail.com>
-- 
2.32.0

