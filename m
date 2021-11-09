Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C925544B522
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244955AbhKIWKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 17:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbhKIWKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 17:10:19 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EFAC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 14:07:32 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v20so1123070plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 14:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SEW61RMqEuc7jtNZFEtpAj87vz2BI1gvYwTO3mPCgJU=;
        b=S8AMqrmKFNv0gFAihdzlw9jupFiimC8CVrQaM1XmxgOq+AS0Mda5vVHm8hCMMmUHk5
         Pro7U5SdSavvYmNlFV4y42kzBfkvpqB9ZiJoKFrxnrLpGAjopnh0Tky6PE9UQFEtdoSl
         YO1M1RO3aK+gTNAtSS/qgOLhH1VAiOeTrB8izOeYhRLW7Eo5iwEvWWfYMbknl4b5GWgL
         kCPecaBaenk9Nm9/WVDW6RH5Qgam7mA3infVoGPe31yAI8NLQoLO4DkRjAoB/xYyw6qt
         JzHAQ7yh4uP0AlC2QbnP3g0iyqAtlOvKtDsKjZ1iPIRVHHaKIxkOldHVcwiD4/R9DDer
         F0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SEW61RMqEuc7jtNZFEtpAj87vz2BI1gvYwTO3mPCgJU=;
        b=RcvliDtPNz/PuZosNFd6GyxgAGdcUKIwarBZdUY1/arHNnVlFOrmPKsYCCx2DXm3+l
         OqHA6dgyjuRlE/nAgbhInNSCWIcMCreXGnMqQSaLeQCJ3XbSF7qmj+9vKohVdFyK2d/2
         rdCjOOhisAmIkEk3paStsejjVZ8A9FXNjTGlSzbVU0eOJZ6MyuuukrzM8ps79hfYP7ig
         HgICAjqoCEYXGFW+TuFioTWVhOwtqdu975OlQyuyR3L3ySblc+cjZ43MthlKLEJ6yEhi
         6ia2spAQhP46g+4AW6pAgADKVN9Ye4hjuC/j3bpy7a6UGAzrLyLKSghP6VLeTBLbtJGQ
         FZWA==
X-Gm-Message-State: AOAM533JG0Ify+XQTzqaUjsS0wcNe5PT2SmmFpV3F+3sCw0rsnYbpyWY
        5ZD3uRMy3nzjzS0enObCSvk=
X-Google-Smtp-Source: ABdhPJxRKDthI/Jr2d2dcLEivS+Vz5KSyF62eRKrC+uUg+QOTgysRSI9Of9nPiXhFk6Wiv/ad36gMQ==
X-Received: by 2002:a17:90a:134f:: with SMTP id y15mr11037244pjf.158.1636495652422;
        Tue, 09 Nov 2021 14:07:32 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5c21:92d0:458e:ac7b:f0d6:7ef4])
        by smtp.gmail.com with ESMTPSA id y130sm14494685pfg.202.2021.11.09.14.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 14:07:32 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     ojeda@kernel.org
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v2 0/2] Fixing bug that would segmentation fault
Date:   Tue,  9 Nov 2021 19:07:30 -0300
Message-Id: <20211109220732.7973-1-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <CANiq72kgm-5CidoN8VRLnWokiDSWsQcMFbaUd4WKOnbPsON9RQ@mail.gmail.com>
References: <CANiq72kgm-5CidoN8VRLnWokiDSWsQcMFbaUd4WKOnbPsON9RQ@mail.gmail.com>
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

Changes in v2:
- Changed return to -EINVAL and using WARN_ON as suggested 
- Note in response for Miguel's comment: for the first patch, I ran the
  script './scripts/checkpatch.pl --file --terse' to see with the file
had any coding style issue. That was when I was suggested to remove
'int' from 'unsigned long' declaration

Luiz Sampaio (2):
  auxdisplay: charlcd: fixing coding style issue
  auxdisplay: charlcd: checking for pointer reference before
    dereferencing

 drivers/auxdisplay/charlcd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.33.1

