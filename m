Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDE534C2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhC2FQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhC2FP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:15:56 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFC6C061574;
        Sun, 28 Mar 2021 22:15:55 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id g8so5916712qvx.1;
        Sun, 28 Mar 2021 22:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTjK2aoLd0nTWDBfHhu3i7BhdlafX4joW0t8yphONzo=;
        b=mow1/W82Nuq5Qsqz/CHqZ+1XWWSyRX2OFdTvOqRA6KTrw/Tj4DUlnaj0lIevx9t4jy
         XiN0SYx5VHuDKuNW88KSGV4ZAfpvxqAYGI89sKW3Pe4PEyL+flMqPaL+2P4rsXJPgCFS
         7XYwf+0Xsr7W5ape0lZttx1kJ7K2cFj5/FAOl2ImeyCvV932qFMYvUyCs7TRLnxWQfrj
         IpzpENUJTtuM34CxKIdMZThtkzvYx96Rs5XF3ahTRnVTTUNyiVvsu+o+ZSZtIA8dCYV0
         jpxLkZM8cdGpIQMQf5GWIt/xziai6JR+R1OYx83py/AiyBgSKDEEH6gTWR99yGA4cQCR
         L4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTjK2aoLd0nTWDBfHhu3i7BhdlafX4joW0t8yphONzo=;
        b=jmZZScxIcW5/Kr8Sdj2xjpOftqQaC21wF89A0CAYrtYWb44yYPUfzGubyccRb1o0eM
         +N7pg26jkbLv2hslH2i6XsWFJvwaK1zw3Hhq7X9twR+pdH6XF5fzRpXzR6uzYqisEfCG
         iDBoHM038Tjglr5nvPYAeXZgoEVq5sEIGzgZLdXyoq43Qg7GPDG9pIlmDmbGy/YvVnl3
         RLOgBK6rttStG6hyslqDey2eAQl+zXBTYgFm50jsGGcNcZ3yWsCKg8q3Kp8Qv3C9Cr+c
         l7+Oufbc2agNggHCkARdVDzCjcdQklxKO9k+jAx4X3pm9zCXFfromtd+hBbdIKJSM2cB
         GfqQ==
X-Gm-Message-State: AOAM530kJAKqk4FaEi8ZcHALzJkdvb/uP4cDkkcLdeWRJdc72wtUFZLm
        oQOFZooTCivEjyjcPoHlJkafCKwOjRaoFg==
X-Google-Smtp-Source: ABdhPJx+Y5TnxxQppstcJgcpqpYiPL6xHbxs6efb3NWFRgoMLXvWEdL6yf9paIkElondY/+GCbmQsQ==
X-Received: by 2002:a05:6214:d65:: with SMTP id 5mr23734563qvs.56.1616994954815;
        Sun, 28 Mar 2021 22:15:54 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:15:54 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/23] virt: kvm: /mmu.rst: Fix a typo
Date:   Mon, 29 Mar 2021 10:42:45 +0530
Message-Id: <878044f88da7746495235549030cb95f821c8789.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/unsychronized/unsynchronized/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/virt/kvm/mmu.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/mmu.rst b/Documentation/virt/kvm/mmu.rst
index 5bfe28b0728e..e6c525280813 100644
--- a/Documentation/virt/kvm/mmu.rst
+++ b/Documentation/virt/kvm/mmu.rst
@@ -244,7 +244,7 @@ Shadow pages contain the following information:
     unsynchronized children).
   unsync_child_bitmap:
     A bitmap indicating which sptes in spt point (directly or indirectly) at
-    pages that may be unsynchronized.  Used to quickly locate all unsychronized
+    pages that may be unsynchronized.  Used to quickly locate all unsynchronized
     pages reachable from a given page.
   clear_spte_count:
     Only present on 32-bit hosts, where a 64-bit spte cannot be written
--
2.26.3

