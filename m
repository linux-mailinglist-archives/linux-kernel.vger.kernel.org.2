Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEC5315110
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhBIN6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbhBIN4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:56:24 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFC0C06121C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 05:55:49 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id r77so17891702qka.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 05:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kaIS61TBx6qLqzkfsvdpmxzmfi3VUyt6rdm+SfNIPYs=;
        b=cmWk3vHe8VY8IcLSoPpM3NvxRaBd/m6v12KkYCUhq/zfh+oWivQ+McHfpPVbIB5xt0
         btJE9TZVI6evmzzGOSCfBumAs0UklZVE/5X6rlSBog943qrv9UdeS07gzhd6tkF5zgXJ
         7MIwpp6JMJnXi66028exshzJFpP6gpvAa2jz2eJCBicN5GII3/dShMlzNAgi0Vrhle4y
         lsukiyInaPh6GX3xC7abH9mRVzX33qO3wulo+RdRXBh+yFQWLT0umU66TSVf2ziGLlT1
         pYxz4anJOWQdffnPLddBGObDJz9jWspDeOvJ75YWzcpamNQtY9AZz/bZx4qCMxud4dPF
         5Z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kaIS61TBx6qLqzkfsvdpmxzmfi3VUyt6rdm+SfNIPYs=;
        b=ulKVGCaxVNL4CbxWShRbLxhPrLn4idYGayYVI2Ek80cVfD+Gd2oo7UIzAfo4MZHEkc
         k/ZXXiHIuossrCrmY0uSdaOTgKteRCmN8TmCv9x7IWY9EIIhYY4USivgv2JSbr5cdny3
         gGKlvH4StVlI7sYfCxeS6o1lshu5ateYcW0+HKeF+LBMqfH6iigBikAb3Y625lIXaONs
         6x/ncDxggAmYAEgpb/qpxK6ZSYDyuXM47j+q3AQy1nSjV9esxVhb4TIyuLc97r77H8Pp
         Qgxu7se21uuw+Qo1MBOdUxSiFqHKWLXgJ7NG0Oxws8WPWOfbw6lZx74cZt7CTTQfm5rl
         cYNQ==
X-Gm-Message-State: AOAM532efXyg43UH+pt88wbw2emN1taO8tKHEMb/Yel8Us/45brdBYxm
        6+AgmrgO1al0BY8tPTxTUPs=
X-Google-Smtp-Source: ABdhPJwGp54ylO6OW91pWwsUqYcviprAt7wIKLHR9QxtTKRmnU9xxpcj31wzQM/zI4fwVGcRwC/lZw==
X-Received: by 2002:a37:4b05:: with SMTP id y5mr22959981qka.348.1612878948479;
        Tue, 09 Feb 2021 05:55:48 -0800 (PST)
Received: from localhost.localdomain ([156.146.37.186])
        by smtp.gmail.com with ESMTPSA id i207sm18663026qke.131.2021.02.09.05.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 05:55:47 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dwmw@amazon.co.uk, maz@kernel.org, peterx@redhat.com,
        luto@kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] arch: x86: kernel: apic: Fix spelling theroretical to theoretical in the file vector.c
Date:   Tue,  9 Feb 2021 19:25:15 +0530
Message-Id: <20210209135515.3865988-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/theroretical/theoretical/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/x86/kernel/apic/vector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3c9c7492252f..aa9d3cf69580 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -1054,7 +1054,7 @@ void irq_force_complete_move(struct irq_desc *desc)
 		 * of the interrupt on the apic/system bus would be delayed
 		 * beyond the point where the target cpu disables interrupts
 		 * in stop machine. I doubt that it can happen, but at least
-		 * there is a theroretical chance. Virtualization might be
+		 * there is a theoretical chance. Virtualization might be
 		 * able to expose this, but AFAICT the IOAPIC emulation is not
 		 * as stupid as the real hardware.
 		 *
--
2.30.0

