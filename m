Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38D93946E0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhE1SP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhE1SPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:15:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C106FC061760
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 11:13:42 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x18so3835169pfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 11:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LhCOa1GkQ+RkJ6+ROCyG5Y6gGwAVgI1Bik3Ds034L48=;
        b=JW2PU4A6nuh+DvIHLIFnraf8gdYYaWUVRnlVUAKY+7hnV9yXkWRYjD/U+ktMQcHjpd
         vOY8Yw7T+EBNq4mgCKqPutAFoyDT6oO8/YSDwz9YvW9iwG/YepPU6OwrZwQv4sfwLf9d
         lxF9Gjuu7HqH6SuNnrvFp2UybC+8VERl8IRf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LhCOa1GkQ+RkJ6+ROCyG5Y6gGwAVgI1Bik3Ds034L48=;
        b=D30I1MRJf485tKpgSo81ET1CtejZYs4e687pEAXpXRiH0mnqApLwKlQKq3n+XAsyE6
         pGZUOKEgh2775C4a5OqJ6d6s1mtspp2I2e+E/O63kdnb7fsX5BwevGwi6wLyJjN/KsnX
         YGRpi3U/HOZVWtzSSR8Wub0Jze1DXCu/p0foXjh7Cv/Y4gSr/Pbfu0dODxOR0zK5fQwF
         0mn3h9JxmX2+3v9bVmmJPDLe6OzCDfWjlNhkCgea7nnaqu745sk7hD4mqGpsvOJZPn+w
         a20hIh7BMcwEqaggeErXp8fyuPnPnS/0yK180aR4sTN1JmQWpELKs/qK107aANAtTBOR
         dfYA==
X-Gm-Message-State: AOAM531JVaRnTuKLzKDsTDd6O5U0MRw8xOBuRu6i+F2RSOmCwH6T1Tc3
        Lk3M+lqmNc8KzzYCFXxExqWhMg==
X-Google-Smtp-Source: ABdhPJyT8dhG0KylcaBFSiur++TUJ1qmtq/5M9hRb9MA9KxTEj0O/X7td0RTRvYZTbk0I5Xxuji+Ng==
X-Received: by 2002:a05:6a00:1a4f:b029:2e0:754b:88c2 with SMTP id h15-20020a056a001a4fb02902e0754b88c2mr5111414pfv.65.1622225622395;
        Fri, 28 May 2021 11:13:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d12sm4590562pfv.190.2021.05.28.11.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 11:13:40 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>, Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bradley Grove <linuxdrivers@attotech.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/3] scsi: Fix a handful of memcpy() field overflows
Date:   Fri, 28 May 2021 11:13:34 -0700
Message-Id: <20210528181337.792268-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on improving FORTIFY_SOURCE's memcpy() coverage, there are
a few fixes that don't require any helper changes, etc.

-Kees

Kees Cook (3):
  scsi: fcoe: Statically initialize flogi_maddr
  scsi: esas2r: Switch to flexible array member
  scsi: isci: Use correctly sized target buffer for memcpy()

 drivers/scsi/esas2r/atioctl.h | 2 +-
 drivers/scsi/fcoe/fcoe.c      | 6 ++----
 drivers/scsi/isci/task.c      | 4 ++--
 3 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.25.1

