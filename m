Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E743447369
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 16:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbhKGPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 10:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhKGPFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 10:05:49 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC775C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 07:03:06 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id i13so10423388qvm.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 07:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3dZaLu1jOb5L+/xiFfhpx0W3PDKJc2vbOhEH6/IHwEQ=;
        b=DbEOLd2AbOUtpMSe3L+qBgWZXqu4VLKk7jVrqMvqMuWsXOoU5M7RgRsFhcIUM3APcj
         Pj2ZdA1ugDd+5iQ70kiWnrZm01q+xSG8k5lcaGtmkTijIxBK/NCNFOZZLF5+BlDfVQBx
         q88Djrow2mv/hxuAS52EVF8Wkx1PxJ9hL8vR/+mNTSTYjjB4uIAV0J6KtfQl4T/oUWVu
         Y+E2IKO2EJyLobPlrvZ2cnVcv86GYJlGrlAOQpiykr+dUzOv1BDjZbJbARq4DLw+AXgR
         QwmVbPoK+ESrDwiNNW297EzNfjG2SR+Ap2hK5z4XXPa8BMiT+g/05/6GYKIBz5xPJ48K
         +Fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3dZaLu1jOb5L+/xiFfhpx0W3PDKJc2vbOhEH6/IHwEQ=;
        b=zSyqS40j391iez4IwzhaRa9KyGQ3etrb4qx8xXc6L6lOHjGooIwrgSwOgxE4dwOK1V
         d0/SuAbvwCnN+4SEIZSyS2qQFSxK4qQFPKDLfImHucAR3gM5nT/JqKy8TzV8kREfJw+0
         mhNwnjMtW26aVY0QSzFzi5yedZB7obqrER8GpqBvQ+5hzX9/oPd2Mr80GRnbWviWZKOD
         sTtl3NpHIBTZyU+aI2fI1bMvL3Vkfe3qg3pv02Bb53VfRvZtEdD+FYlXKlb7mQvOGoH9
         j+y9H6gnWr2vWh9DTooWSuwzp2SquqM5O6ebpZogDV9oja1Mxc0H5sLuCjs8QBSZ0fcq
         8RWw==
X-Gm-Message-State: AOAM531QA1EOy7fAHrub3i4HsPVIO7qiq4bT7p9pCI/GS99plO6B0aP4
        u4+bPn3sIiVc8DatCct18Pc=
X-Google-Smtp-Source: ABdhPJxXqU2vyUfYsyB6Z/mUYYuepK01dRPr3AKXljyIsOFjbNWUqw+nhkRvdcaGwOPGD5yvV7BXuw==
X-Received: by 2002:a05:6214:1453:: with SMTP id b19mr12218204qvy.20.1636297385976;
        Sun, 07 Nov 2021 07:03:05 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5c21:92d0:fc01:11b0:47fa:d730])
        by smtp.gmail.com with ESMTPSA id x11sm9554883qta.90.2021.11.07.07.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 07:03:05 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     ojeda@kernel.org
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH 0/2] Fixing bug that would segmentation fault
Date:   Sun,  7 Nov 2021 12:03:02 -0300
Message-Id: <20211107150304.3253-1-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches consists of one patch fixing a simple coding style
issue and one patch fixing a bug that would cause segmentation fault.
Basically, there was a pointer that was being dereferenced without testing
if the pointer exists. This patch adds a protection, returning EFAULT in
case the pointer is NULL.

Luiz Sampaio (2):
  auxdisplay: charlcd: fixing coding style issue
  auxdisplay: charlcd: checking for pointer reference before
    dereferencing

 drivers/auxdisplay/charlcd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.33.1

