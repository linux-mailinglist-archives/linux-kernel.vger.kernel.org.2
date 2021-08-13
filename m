Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E383EB6FA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbhHMOry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240854AbhHMOrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:47:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E197C061756;
        Fri, 13 Aug 2021 07:47:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c17so6971630plz.2;
        Fri, 13 Aug 2021 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h0fwzAM2xa3IuzI5XH7EKcb4uriWshT0e5PMSEAhE6o=;
        b=SFsaZR8H6/iCATb9npLqQav3v7+Hx9pEBpXMvZkAbLWlGdP4tJPkFnhWjYYVBA+gr7
         enDVqHRI+sUTfO+QD+xUb/kiaHjki5TDX7LDRXRbnAAGdzglfYmAIeEv3NaLOs3WZFI6
         QpwVTXaqKuk2LqUcHXMYCJShgxETjKgSFjd+w519tN8vJ1PIS4ggPI/hdyDemG/O9yG0
         d+nJvNvFi1CNxm3imEFAafWG8G3cd55gKw6pOrOqUc8/nnasymxbpZawN1H+CcZsRXPW
         sAIiYwwES150T0ZoQ+2eHkBM4cXeXgB/0HvLF2TLeor+lXfzkRiUTK8l2xe65SzwmVk3
         WOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h0fwzAM2xa3IuzI5XH7EKcb4uriWshT0e5PMSEAhE6o=;
        b=Tctp9o2oyj5MSf+2cnRcBsQNDDlDwC4PGxq3PTyXHd1G8JeF9WMU5hiRC1uIngDJ6q
         7W2kqatD4rzC39VKmreYzSdXIJFxj258d9scA855EUjIiwbM/z0NpoJ1sJjYuKpgjp/B
         lUo1za7D6Nnqe1+dW4wG7n8u+a0QxtQmJu0bW2m6cJA4IDR4VjTy6ddivK8C30izeLbt
         /kFC2w1toIt/8Z3lwFABoiE6I0cXdcKB/cCKFcEbNrsz9pZVAsrJM8bwn+a46tV7D8Yr
         4HAH2eAxmUYqJK0aZMcWV+6o61DRlldX3zPCWfnqufpct0CpGmmWLl0BEulFHLaGpT6l
         FXhg==
X-Gm-Message-State: AOAM5330EcvSNSNwGbDIB75eXDfPolpEnQKBMUbC8+SWJw58N/7+bynx
        g+sJYfb1JGKx5PAfxXo2a/s=
X-Google-Smtp-Source: ABdhPJwW7TruVJob38A8ZwZijeyYKk6sy+4zU/ElfEn3Dos9dmdvRF3erNjV7wBXCJz+RKJwCFAOrw==
X-Received: by 2002:a62:7f09:0:b029:3c8:584:72d with SMTP id a9-20020a627f090000b02903c80584072dmr2813006pfd.80.1628866045025;
        Fri, 13 Aug 2021 07:47:25 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id pc6sm1799926pjb.29.2021.08.13.07.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 07:47:24 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] Documentation: in_irq() cleanup
Date:   Fri, 13 Aug 2021 22:47:13 +0800
Message-Id: <20210813144713.85598-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the obsolete and ambiguos macro in_irq() with new
macro in_hardirq().

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/kernel-hacking/hacking.rst                    | 2 +-
 Documentation/kernel-hacking/locking.rst                    | 4 ++--
 Documentation/translations/it_IT/kernel-hacking/hacking.rst | 2 +-
 Documentation/translations/it_IT/kernel-hacking/locking.rst | 4 ++--
 Documentation/translations/zh_CN/kernel-hacking/hacking.rst | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
index df65c19aa7df..f514cec8e16b 100644
--- a/Documentation/kernel-hacking/hacking.rst
+++ b/Documentation/kernel-hacking/hacking.rst
@@ -77,7 +77,7 @@ fast: frequently it simply acknowledges the interrupt, marks a 'software
 interrupt' for execution and exits.
 
 You can tell you are in a hardware interrupt, because
-:c:func:`in_irq()` returns true.
+:c:func:`in_hardirq()` returns true.
 
 .. warning::
 
diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index ed1284c6f078..94232ed1d592 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1406,7 +1406,7 @@ bh
   half will be running at any time.
 
 Hardware Interrupt / Hardware IRQ
-  Hardware interrupt request. in_irq() returns true in a
+  Hardware interrupt request. in_hardirq() returns true in a
   hardware interrupt handler.
 
 Interrupt Context
@@ -1418,7 +1418,7 @@ SMP
   (``CONFIG_SMP=y``).
 
 Software Interrupt / softirq
-  Software interrupt handler. in_irq() returns false;
+  Software interrupt handler. in_hardirq() returns false;
   in_softirq() returns true. Tasklets and softirqs both
   fall into the category of 'software interrupts'.
 
diff --git a/Documentation/translations/it_IT/kernel-hacking/hacking.rst b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
index f6beb385b4ac..a2474e1f235e 100644
--- a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
@@ -90,7 +90,7 @@ i gestori d'interruzioni devono essere veloci: spesso si limitano
 esclusivamente a notificare la presa in carico dell'interruzione,
 programmare una 'interruzione software' per l'esecuzione e quindi terminare.
 
-Potete dire d'essere in una interruzione hardware perché :c:func:`in_irq()`
+Potete dire d'essere in una interruzione hardware perché :c:func:`in_hardirq()`
 ritorna vero.
 
 .. warning::
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
index 1e7c84def369..1efb8293bf1f 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -1459,11 +1459,11 @@ contesto utente
   che hardware.
 
 interruzione hardware
-  Richiesta di interruzione hardware. in_irq() ritorna vero in un
+  Richiesta di interruzione hardware. in_hardirq() ritorna vero in un
   gestore d'interruzioni hardware.
 
 interruzione software / softirq
-  Gestore di interruzioni software: in_irq() ritorna falso;
+  Gestore di interruzioni software: in_hardirq() ritorna falso;
   in_softirq() ritorna vero. I tasklet e le softirq sono entrambi
   considerati 'interruzioni software'.
 
diff --git a/Documentation/translations/zh_CN/kernel-hacking/hacking.rst b/Documentation/translations/zh_CN/kernel-hacking/hacking.rst
index ab974faddecf..877921adb5bb 100644
--- a/Documentation/translations/zh_CN/kernel-hacking/hacking.rst
+++ b/Documentation/translations/zh_CN/kernel-hacking/hacking.rst
@@ -68,7 +68,7 @@
 它将被排队（或丢弃）。因为它会关闭中断，所以处理程序必须很快：通常它只是
 确认中断，标记一个“软件中断”以执行并退出。
 
-您可以通过 :c:func:`in_irq()` 返回真来判断您处于硬件中断状态。
+您可以通过 :c:func:`in_hardirq()` 返回真来判断您处于硬件中断状态。
 
 .. warning::
 
-- 
2.30.2

