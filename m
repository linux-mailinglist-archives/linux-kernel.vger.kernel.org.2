Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006713DDE23
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 18:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhHBQ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 12:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229797AbhHBQ5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 12:57:05 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E69916112E;
        Mon,  2 Aug 2021 16:56:55 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mAamG-002WEi-NP; Mon, 02 Aug 2021 17:26:56 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel-team@android.com
Subject: [PATCH v2 14/14] Documentation: Update irq_domain.rst with new lookup APIs
Date:   Mon,  2 Aug 2021 17:26:30 +0100
Message-Id: <20210802162630.2219813-15-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210802162630.2219813-1-maz@kernel.org>
References: <20210802162630.2219813-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, ley.foon.tan@intel.com, chris@zankel.net, jcmvbkbc@gmail.com, vgupta@synopsys.com, tsbogend@alpha.franken.de, robert.jarzmik@free.fr, linux@armlinux.org.uk, krzysztof.kozlowski@canonical.com, ysato@users.sourceforge.jp, dalias@libc.org, geert@linux-m68k.org, alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch, robdclark@gmail.com, linus.walleij@linaro.org, lee.jones@linaro.org, lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com, bgolaszewski@baylibre.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Catch up with the recent irqdomain updates, and document
{generic_,}handle_domain_irq(), irq_resolve_mapping() as well
as the deprecation of some of the older APIs.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/core-api/irq/irq-domain.rst | 28 ++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index 53283b3729a1..6979b4af2c1f 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -55,8 +55,24 @@ exist then it will allocate a new Linux irq_desc, associate it with
 the hwirq, and call the .map() callback so the driver can perform any
 required hardware setup.
 
-When an interrupt is received, irq_find_mapping() function should
-be used to find the Linux IRQ number from the hwirq number.
+Once a mapping has been established, it can be retrieved or used via a
+variety of methods:
+
+- irq_resolve_mapping() returns a pointer to the irq_desc structure
+  for a given domain and hwirq number, and NULL if there was no
+  mapping.
+- irq_find_mapping() returns a Linux IRQ number for a given domain and
+  hwirq number, and 0 if there was no mapping
+- irq_linear_revmap() is now identical to irq_find_mapping(), and is
+  deprecated
+- generic_handle_domain_irq() handles an interrupt described by a
+  domain and a hwirq number
+- handle_domain_irq() does the same thing for root interrupt
+  controllers and deals with the set_irq_reg()/irq_enter() sequences
+  that most architecture requires
+
+Note that irq domain lookups must happen in contexts that are
+compatible with a RCU read-side critical section.
 
 The irq_create_mapping() function must be called *atleast once*
 before any call to irq_find_mapping(), lest the descriptor will not
@@ -137,7 +153,9 @@ required.  Calling irq_create_direct_mapping() will allocate a Linux
 IRQ number and call the .map() callback so that driver can program the
 Linux IRQ number into the hardware.
 
-Most drivers cannot use this mapping.
+Most drivers cannot use this mapping, and it is now gated on the
+CONFIG_IRQ_DOMAIN_NOMAP option. Please refrain from introducing new
+users of this API.
 
 Legacy
 ------
@@ -157,6 +175,10 @@ for IRQ numbers that are passed to struct device registrations.  In that
 case the Linux IRQ numbers cannot be dynamically assigned and the legacy
 mapping should be used.
 
+As the name implies, the *_legacy() functions are deprecated and only
+exist to ease the support of ancient platforms. No new users should be
+added.
+
 The legacy map assumes a contiguous range of IRQ numbers has already
 been allocated for the controller and that the IRQ number can be
 calculated by adding a fixed offset to the hwirq number, and
-- 
2.30.2

