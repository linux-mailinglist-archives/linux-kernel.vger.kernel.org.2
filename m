Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B62135C44B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239621AbhDLKo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239615AbhDLKo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:44:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9CBC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:44:37 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b26so3800072pfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X5Zkx3/PmOz226VDaHPUOrqvW4IVZLwxtVFG37YmhL8=;
        b=n6rRbm0yTIltvNi1N0xtCXbdwwR4pWththrksGAIk8cNX8Y47peQO7IWknYwiDXZLU
         4qagSnIRiu6be8BYQaH3u98xi+zt77IdpQGsF4q163GJ7NMjl/vx6DA7WLnz+87i57vl
         BINM9ezkVYDbmNHfowukC/fiFpqhO9TL+svXSDT3vQ55qerPKK1r70UnPFtRDKQfE78J
         LlpMfn2xqkoffESWahFHngiyHnpiLauczeXgGHB9Uqs+KhcAOMxlLoPkipFuSLHPSdh8
         R28cFkm6+EYRTBMO0VR5C6VQb0tDI77EbK7J+0Zoej8QlmrQejj1kwi12m/rqgolflA/
         o+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X5Zkx3/PmOz226VDaHPUOrqvW4IVZLwxtVFG37YmhL8=;
        b=jF7HpZbamLOB4SxFdABlxVczW2lElJvIFrpXqFABPKh5iryAFlQOtyi+Y8tQy16FBO
         RhFuxACtvcMCR/f5Rhnc8wjceOXQCcKgPZFzp1akaRUFKYYabgIOeNwofefZ2SBvp2FT
         i25ocwfmMBQpPQROJfl1uOTZfJRMtzxSqKQit7ENd/++27Somf7Wvzw/5nJpWf/hdXkY
         QerIcZK4CwDVFnmcpXQZdMm/VVDWcHIe76kDpnnTNPxHZ+JwIZJmo0jnUJD0hAt5DCik
         BpCXphWiFSrjCq8CU8sNqyzFuUpurmUcExgpKYum3b17atH1HUO0aHUDHzVTbFV9pcZC
         QRSg==
X-Gm-Message-State: AOAM531XyKPX9kjNz0ScIyXQ7n9alljaMP3oc+YSXoYvqR/GGpGr96r4
        qbiSA+UWGvtWc1Iw7+3vahk=
X-Google-Smtp-Source: ABdhPJyBR5T/xmD4u4Gku3ZO/f4l7wjZcN1OtuDNGziMjhhgAqzGRwmQwp0GF3XZcv/CwZWVyMCUrA==
X-Received: by 2002:aa7:943b:0:b029:23f:8fa1:5f11 with SMTP id y27-20020aa7943b0000b029023f8fa15f11mr23557569pfo.67.1618224276587;
        Mon, 12 Apr 2021 03:44:36 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id q19sm11005093pgv.38.2021.04.12.03.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 03:44:36 -0700 (PDT)
Date:   Mon, 12 Apr 2021 16:14:27 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     nsaenzjulienne@susu.de, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v2 2/2] staging: vc04_services: rectify spelling mistake
Message-ID: <967c328610909bc010b0bb82a1f89b71a57fa7a3.1618223171.git.mitaliborkar810@gmail.com>
References: <cover.1618223171.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618223171.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected the misspelled word.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 
Changes from v1:- No changes.

 drivers/staging/vc04_services/interface/TODO | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/TODO b/drivers/staging/vc04_services/interface/TODO
index adb28f46ba67..39810ce017cd 100644
--- a/drivers/staging/vc04_services/interface/TODO
+++ b/drivers/staging/vc04_services/interface/TODO
@@ -37,7 +37,7 @@ This should be fixed.
 
 Even the VPU firmware doesn't support a VCHI re-connect, the driver
 should properly handle a module unload. This also includes that all
-resouces must be freed (kthreads, debugfs entries, ...) and global
+resources must be freed (kthreads, debugfs entries, ...) and global
 variables avoided.
 
 5) Cleanup logging mechanism
-- 
2.30.2

