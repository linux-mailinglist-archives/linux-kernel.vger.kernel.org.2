Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A148F3EBF6C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 03:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbhHNBtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 21:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbhHNBtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 21:49:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41922C061756;
        Fri, 13 Aug 2021 18:48:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id e19so14268089pla.10;
        Fri, 13 Aug 2021 18:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kJmxB482cA5ul6CcBMvGgK4Q0eveD39EM9aKbFMmIvk=;
        b=G5xqlDDp9hTT/j5oSHlmY9k2va0fbUGTVHgrmtVhbNjwOHy3v254hy1hu3uV7+kSDE
         7/O88F7KhY7805LE2JAs6Wqx/lQk6Zo6CR49YHaQ2/Bs7PTj5W3FfeRx3Vp5Hqja+01w
         ouDaiOSXHU/KRp+QUu9xpoJo0VVdFmPBQdN3731y4rpnzIsM43TlFH3bThLwjJI39zSb
         Lp/iq32M5RvcAvFX+UP3jrYaxw3HZcmD6/YqO1F05CEDLio2ffkCcv2h5olol8ylOo4e
         zBM3uGkv5CNKCO4c3tjGKZbouJqJLJynOoGWTI5y7HbW5A+6pYNEpKXBRNv6kEJDB+EJ
         uUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kJmxB482cA5ul6CcBMvGgK4Q0eveD39EM9aKbFMmIvk=;
        b=be7Kyzddle5E7slH9uarj/8YkUt99iqLqj0jbvmm1eE2YQ27jK8g2rDa1u5vSRQ9hb
         2si4n8kZStzq/xqbe9uwCGHIW83H9ze6db4J0dQrFG8RCKyxJoJcHWU8v8nJU6rqyHz8
         T55dvkI8/psxWKbL0gJ7xqU2Oe3S/yTkwsW+ciDopYnpqbWgSMl6m0DiRi+ss6bn8+vX
         43TpPEG43r7olGnu8IClCC+b3o8bzUdxf2UWiTOvgjxBKWo3TpoGSAK7tyA7qAjE7ZjY
         PGwwiN5Op/Ef3+e1nHu9mUROPXCt+rjkX/Xg4t5strT0+XMUQ4EdMK8IzY99QBR1K7Xn
         SekA==
X-Gm-Message-State: AOAM530OXTLK75EiWSgiF4yu9YbEP2PfC/whaBc9wceRcXaffOr310C5
        PFPA4AuQtNDcDcWhJmeYVAw=
X-Google-Smtp-Source: ABdhPJyfYUdvCFUD02cuaIXOo88Ssmg1Z5SFo8Jaw9p35r27avMEnNx1R4ei11f0mh6povpJOQlgxw==
X-Received: by 2002:aa7:880f:0:b029:3e0:6f99:1f88 with SMTP id c15-20020aa7880f0000b02903e06f991f88mr5109976pfo.38.1628905723711;
        Fri, 13 Aug 2021 18:48:43 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id k25sm3549031pfa.213.2021.08.13.18.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 18:48:43 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2] Documentation: in_irq() cleanup
Date:   Sat, 14 Aug 2021 09:48:31 +0800
Message-Id: <20210814014831.53083-1-changbin.du@gmail.com>
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
v2: remove unnecessary ':c:func:'.
---
 Documentation/kernel-hacking/hacking.rst                    | 4 ++--
 Documentation/kernel-hacking/locking.rst                    | 4 ++--
 Documentation/translations/it_IT/kernel-hacking/hacking.rst | 2 +-
 Documentation/translations/it_IT/kernel-hacking/locking.rst | 4 ++--
 Documentation/translations/zh_CN/kernel-hacking/hacking.rst | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
index df65c19aa7df..55bd37a2efb0 100644
--- a/Documentation/kernel-hacking/hacking.rst
+++ b/Documentation/kernel-hacking/hacking.rst
@@ -76,8 +76,8 @@ handler is never re-entered: if the same interrupt arrives, it is queued
 fast: frequently it simply acknowledges the interrupt, marks a 'software
 interrupt' for execution and exits.
 
-You can tell you are in a hardware interrupt, because
-:c:func:`in_irq()` returns true.
+You can tell you are in a hardware interrupt, because in_hardirq() returns
+true.
 
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
index f6beb385b4ac..487c8732dfe8 100644
--- a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
@@ -90,7 +90,7 @@ i gestori d'interruzioni devono essere veloci: spesso si limitano
 esclusivamente a notificare la presa in carico dell'interruzione,
 programmare una 'interruzione software' per l'esecuzione e quindi terminare.
 
-Potete dire d'essere in una interruzione hardware perché :c:func:`in_irq()`
+Potete dire d'essere in una interruzione hardware perché in_hardirq()
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
index ab974faddecf..f2bc154c5bcc 100644
--- a/Documentation/translations/zh_CN/kernel-hacking/hacking.rst
+++ b/Documentation/translations/zh_CN/kernel-hacking/hacking.rst
@@ -68,7 +68,7 @@
 它将被排队（或丢弃）。因为它会关闭中断，所以处理程序必须很快：通常它只是
 确认中断，标记一个“软件中断”以执行并退出。
 
-您可以通过 :c:func:`in_irq()` 返回真来判断您处于硬件中断状态。
+您可以通过 in_hardirq() 返回真来判断您处于硬件中断状态。
 
 .. warning::
 
-- 
2.30.2

