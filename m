Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD6935B6CE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 21:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbhDKTqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 15:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236469AbhDKTqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 15:46:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAD3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 12:46:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id b26so2640975pfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 12:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y76UezwuzE5PH7sUsaJ2E75phUC3veEDBvOshQ8tLXg=;
        b=qf1AFR25jfZ/Nm4XPKUySYL+6Bsrfxo8ELzrMRjh8yblxSjozO8uyE3aJyYU+MreoQ
         Bova3vYiOcsN0/IHHsRIPdxbLE0HfWQ/7aZDRVNv8dWYOqoKGJ1/kuFnKAo5tVeIXBbT
         AMQ0MsFjhZQ/UGlOV8Lp70fp8K9Ju6vtSlP+5wPDRSf/kVpxubwSlJF9zf244wt0cUZ8
         hfyNb4jIQDylML2eURp1i636SUjtSfanDcmA6sbJztJDmTis6OXAfV+WU4qlN+QJHmkK
         A96gw/hZmEEpDB6+q0BJsUUwILahItxzcmNcXGVAl+dBC0cQOsYJyuI1RWuhq7ExHAzb
         F/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y76UezwuzE5PH7sUsaJ2E75phUC3veEDBvOshQ8tLXg=;
        b=uWtd7erK5lPmyn1CqVlBqC4ZI9Xh97JkkWp6dj38YPRlVlddH4khCKsWQLzqc/irLS
         jRewssUWUDMXzd8TWNm35vcCHlp4K6zKbFwfjqSBgZKoiqy495T3M7sL20AKWC29Vl8/
         FrMcuuR5zh/HWwPHvZ59YwirsrKmzGAY8cVrpwb4bEELhElT91sgILK0mWaqte3fRA4M
         oJ/HceyCTjueXZq/RNkb6mtpUwbZVgCka5GsgB2OIl5XtRYC3B2hWzMqXc64veOgnlol
         S8sS7BHviZzW3/I7/iMe3sftC9s5WZtjKzkfLFsPrlgX9ojSH8uTcuTlgVW8agxJJqKc
         eVTg==
X-Gm-Message-State: AOAM530Z/tqgNp8fQUQcZbLPkrCj9M0ho1sgKCbVXoulQKgmfq43oXw0
        7Kp33aIQDve45+HIs0EV2L4=
X-Google-Smtp-Source: ABdhPJxv8t1OA3KrR8wdMht4Up6vRlI0yU9XZZMVpKR/zVopFqJj4jm6eEKtxbejefsfU+yl+wC9bQ==
X-Received: by 2002:a62:1d4a:0:b029:24c:325a:1456 with SMTP id d71-20020a621d4a0000b029024c325a1456mr2867691pfd.45.1618170393090;
        Sun, 11 Apr 2021 12:46:33 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id a25sm3382444pfo.27.2021.04.11.12.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 12:46:32 -0700 (PDT)
Date:   Mon, 12 Apr 2021 01:16:25 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     nsaenzjulienne@suse.de, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH 2/2] staging: vc04_services: rectify spelling mistake
Message-ID: <967c328610909bc010b0bb82a1f89b71a57fa7a3.1618169920.git.mitaliborkar810@gmail.com>
References: <cover.1618169920.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618169920.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected the misspelled word.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
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

