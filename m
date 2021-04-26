Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5690636B044
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhDZJKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 05:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbhDZJJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 05:09:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49850C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 02:08:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so1178056pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 02:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TUB8ZW50W1LH/QwrQax9EjDH6gcEGV3rni30bl3X4NY=;
        b=nMLVxO6CIiy/xoC7MTIJbp07rnSHaLHlZQaXqT9LsKQyH9vwAf5oAote5EctuSpRnV
         ZNk0sQSWlXUvYSx+7YcGU6axtY+S79n1oE2UhCNrFJOcSEL4YsgyWEJGtbdGKLJkLgkI
         QennNi2LcO+vB/r1UTYKCXEQNpal4XjwjKvKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TUB8ZW50W1LH/QwrQax9EjDH6gcEGV3rni30bl3X4NY=;
        b=Zab5o9sht8Ah+PmYPFAUmxfdjxWRwF3xmpCaVITv4AMkSrL/wE+2m2rjIuzSTcGjgQ
         AbVOoR5jHb3/tScTQwZxjGnBcKmryV3teVRGu29EWFTQQZIIUYhIe9LopOTWkA0UdOqE
         rMv6L8VsalcZf0KpfHzR36IjCKc/EN4dIorECbc/Ee49fsL8KopfzTgUQQ3GCYUFfTNh
         EeCI9d9KFJ4fmwwC/GN12ldNHtpBJsIhCf55a8OcBPbcI1ld2JxmqS+xZIPPWjPgxNG+
         xtbMpSLwq9n5LNg9lpOBnCwrMarVxC4o5n1lzT/HRGSkVYxd9g6JyJJLbLFoWrYcHIgJ
         cmOg==
X-Gm-Message-State: AOAM533BKsNee03Cj9AfiniDtKtN6Ow6Klh+AMRyQpoQxGzrWhjvgA9a
        D6hmil8o4ndZJwm0uJiYZ6c/Rg==
X-Google-Smtp-Source: ABdhPJxz8tmuXwED9CTvIhb+i/UFSl3au8tJ/pNDTPQq4thJ6fB38kVQUMNqaZ8W+CGIK8/FjIcZJA==
X-Received: by 2002:a17:90a:c8:: with SMTP id v8mr21678604pjd.18.1619428121944;
        Mon, 26 Apr 2021 02:08:41 -0700 (PDT)
Received: from localhost (160.131.236.35.bc.googleusercontent.com. [35.236.131.160])
        by smtp.gmail.com with UTF8SMTPSA id j29sm10602171pgl.30.2021.04.26.02.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 02:08:41 -0700 (PDT)
From:   Hikaru Nishida <hikalium@chromium.org>
To:     kvm@vger.kernel.org
Cc:     suleiman@google.com, Hikaru Nishida <hikalium@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [RFC PATCH 5/6] x86/kvm: Add CONFIG_KVM_VIRT_SUSPEND_TIMING_GUEST
Date:   Mon, 26 Apr 2021 18:06:44 +0900
Message-Id: <20210426090644.2218834-6-hikalium@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210426090644.2218834-1-hikalium@chromium.org>
References: <20210426090644.2218834-1-hikalium@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config option can be used to enable virtual suspend time injection
support on kvm guests.

Signed-off-by: Hikaru Nishida <hikalium@chromium.org>
---

 arch/x86/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..fac06534c30a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -825,6 +825,19 @@ config KVM_GUEST
 	  underlying device model, the host provides the guest with
 	  timing infrastructure such as time of day, and system time
 
+config KVM_VIRT_SUSPEND_TIMING_GUEST
+	bool "Virtual suspend time injection (guest side)"
+	depends on KVM_GUEST
+	default n
+	help
+	 This option makes the host's suspension reflected on the guest's clocks.
+	 In other words, guest's CLOCK_MONOTONIC will stop and
+	 CLOCK_BOOTTIME keeps running during the host's suspension.
+	 This feature will only be effective when both guest and host enable
+	 this option.
+
+	 If unsure, say N.
+
 config ARCH_CPUIDLE_HALTPOLL
 	def_bool n
 	prompt "Disable host haltpoll when loading haltpoll driver"
-- 
2.31.1.498.g6c1eba8ee3d-goog

