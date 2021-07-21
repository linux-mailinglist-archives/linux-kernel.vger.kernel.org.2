Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF863D1735
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 21:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbhGUSyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 14:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240307AbhGUSyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 14:54:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04486C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 12:34:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id l26so3813080eda.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 12:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p3h3q8SHUgg6wfPU9uDK9V1IUiRt6H/fJS2Uqk4LTjo=;
        b=jxVE536lO6V1V6YbIJNIe/q7qyRQ+FUijbpRPDb3t5x+boUjuTnlRZjfJf3x7SbmTS
         jGaiFq2muBjo9FV+NcDXqRh+AhriqXZoCmpC61kt2cOseFPSNTjiI2a2UBYokmz3JHS8
         Vvm+diE5hXoCulTMdQ6pvYpG1DaQarXcsiqUM26vkBdJEEjbZqPRKC2nFLk/iecr9HRK
         4Ih8EjfJVtGQ+eS2kDQMmDSeyJLmpbRCO/4IJWHPKH4mKz+d4sXubn/KgfyAB0sI73cZ
         /y5JzfFp8OH76znFvfxty1mIDyYmXJCa+6j2A+83rY2XBe/gX7OVks1SW5CF1cf67SrF
         6BGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3h3q8SHUgg6wfPU9uDK9V1IUiRt6H/fJS2Uqk4LTjo=;
        b=lFrPFTr+Op7bNgiV6CeLEXL7deKzhL1zza3gqb8S86xwkAbqjop1QglwBEzdKB6FYp
         tfQen8K3494O3X4en4JWooiTHalZWOP20oCrchJvUnbl++gGe1ws8lZQ5mvABqE8x5w8
         mPgoNDGPlHpUg9/6nJMxqNumcvebnyUNtgAqiSt+1IXNyZo38MJk8WFPGXyUsK6CSudL
         lw/5OYeE9WhNB8wjX+FawZv6FlP5wCZncmdXn3rCxGFB/wgKK4+2kvNqWKMbAsnQp3LF
         CqLefXQRUAamt51c7JpmGSiC0s2qMlcOs4gUwcUtzr8BPzHC3u99fsoleEEclwB3mO0l
         C/pA==
X-Gm-Message-State: AOAM530HHylVLq7oTzH/Zw7wYdut4Anb/xsDCQPZ+vDbtA0FhvJiLMgQ
        5bqh0ahx/D5FI0uIOdqZ1hA=
X-Google-Smtp-Source: ABdhPJxRFnLhSyJCqIqRpa3F1lM5FPtP4S7QyYZtcJL110++SL15glECjzfv8GkcBbm2vMgSE4YpJw==
X-Received: by 2002:aa7:d3da:: with SMTP id o26mr50201686edr.304.1626896082588;
        Wed, 21 Jul 2021 12:34:42 -0700 (PDT)
Received: from localhost.localdomain ([176.30.239.20])
        by smtp.gmail.com with ESMTPSA id u26sm8611841ejj.4.2021.07.21.12.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 12:34:42 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, zhansayabagdaulet@gmail.com,
        straube.linux@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH 1/2] staging: rtl8712: get rid of flush_scheduled_work
Date:   Wed, 21 Jul 2021 22:34:36 +0300
Message-Id: <6e028b4c457eeb7156c76c6ea3cdb3cb0207c7e1.1626895918.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1626895918.git.paskripkin@gmail.com>
References: <cover.1626895918.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is preparation for following patch for error handling
refactoring.

flush_scheduled_work() takes (wq_completion)events lock and
it can lead to deadlock when r871xu_dev_remove() is called from workqueue.
To avoid deadlock sutiation we can change flush_scheduled_work() call to
flush_work() call for all possibly scheduled works in this driver,
since next patch adds device_release_driver() in case of fw load failure.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_led.c     | 8 ++++++++
 drivers/staging/rtl8712/rtl871x_led.h     | 1 +
 drivers/staging/rtl8712/rtl871x_pwrctrl.c | 8 ++++++++
 drivers/staging/rtl8712/rtl871x_pwrctrl.h | 1 +
 drivers/staging/rtl8712/usb_intf.c        | 3 ++-
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_led.c b/drivers/staging/rtl8712/rtl8712_led.c
index 5901026949f2..d5fc9026b036 100644
--- a/drivers/staging/rtl8712/rtl8712_led.c
+++ b/drivers/staging/rtl8712/rtl8712_led.c
@@ -1820,3 +1820,11 @@ void LedControl871x(struct _adapter *padapter, enum LED_CTL_MODE LedAction)
 		break;
 	}
 }
+
+void r8712_flush_led_works(struct _adapter *padapter)
+{
+	struct led_priv *pledpriv = &padapter->ledpriv;
+
+	flush_work(&pledpriv->SwLed0.BlinkWorkItem);
+	flush_work(&pledpriv->SwLed1.BlinkWorkItem);
+}
diff --git a/drivers/staging/rtl8712/rtl871x_led.h b/drivers/staging/rtl8712/rtl871x_led.h
index ee19c873cf01..2f0768132ad8 100644
--- a/drivers/staging/rtl8712/rtl871x_led.h
+++ b/drivers/staging/rtl8712/rtl871x_led.h
@@ -112,6 +112,7 @@ struct led_priv {
 void r8712_InitSwLeds(struct _adapter *padapter);
 void r8712_DeInitSwLeds(struct _adapter *padapter);
 void LedControl871x(struct _adapter *padapter, enum LED_CTL_MODE LedAction);
+void r8712_flush_led_works(struct _adapter *padapter);
 
 #endif
 
diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.c b/drivers/staging/rtl8712/rtl871x_pwrctrl.c
index 23cff43437e2..cd6d9ff0bebc 100644
--- a/drivers/staging/rtl8712/rtl871x_pwrctrl.c
+++ b/drivers/staging/rtl8712/rtl871x_pwrctrl.c
@@ -224,3 +224,11 @@ void r8712_unregister_cmd_alive(struct _adapter *padapter)
 	}
 	mutex_unlock(&pwrctrl->mutex_lock);
 }
+
+void r8712_flush_rwctrl_works(struct _adapter *padapter)
+{
+	struct pwrctrl_priv *pwrctrl = &padapter->pwrctrlpriv;
+
+	flush_work(&pwrctrl->SetPSModeWorkItem);
+	flush_work(&pwrctrl->rpwm_workitem);
+}
diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.h b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
index bf6623cfaf27..b35b9c7920eb 100644
--- a/drivers/staging/rtl8712/rtl871x_pwrctrl.h
+++ b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
@@ -108,5 +108,6 @@ void r8712_cpwm_int_hdl(struct _adapter *padapter,
 void r8712_set_ps_mode(struct _adapter *padapter, uint ps_mode,
 			uint smart_ps);
 void r8712_set_rpwm(struct _adapter *padapter, u8 val8);
+void r8712_flush_rwctrl_works(struct _adapter *padapter);
 
 #endif  /* __RTL871X_PWRCTRL_H_ */
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index 2434b13c8b12..643f21eb1128 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -606,7 +606,8 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
 			padapter->surprise_removed = true;
 		if (pnetdev->reg_state != NETREG_UNINITIALIZED)
 			unregister_netdev(pnetdev); /* will call netdev_close() */
-		flush_scheduled_work();
+		r8712_flush_rwctrl_works(padapter);
+		r8712_flush_led_works(padapter);
 		udelay(1);
 		/* Stop driver mlme relation timer */
 		r8712_stop_drv_timers(padapter);
-- 
2.32.0

