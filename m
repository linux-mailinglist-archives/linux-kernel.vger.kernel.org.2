Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D429316B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhBJQYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:24:33 -0500
Received: from smtpcmd0642.aruba.it ([62.149.156.42]:33879 "EHLO
        smtpcmd0642.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbhBJQYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:24:00 -0500
Received: from [192.168.1.184] ([79.10.42.7])
        by Aruba Outgoing Smtp  with ESMTPA
        id 9sGEl0x2gl6ts9sGElboW6; Wed, 10 Feb 2021 17:22:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1612974160; bh=+zT/ViXdsyEqsM0XxHGfPKmXnHFZ85zQgkpYMgBh4Oo=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=KZRe+R9tdGmlGRClWHts7qbM0AWGy6q8nqNyi04jXGTU8LIdASdhyQ7BH+gCswyha
         kzN4Ke8kQ2Cy6eyOZI5MTXLqzpf4XW49Cic0UNmD5KyChQzHoSgOCk1krEtxJ9K4/c
         WBNiWfoTdcpwDI/kSTmjTVSDLv7s0UdXpp5iDzV/DPmigVnHDOzMoiQaORVFFTgpOz
         UUnyr2bf3j/0N0BXfwZdCRU1+On7qJguMG53FMBaGgZZNBN5bCZBSQF6/93Nlm0O3D
         7q1CsUjb/FAiDXdCOCsZ7aU5By1owYruUoJemu7wLTcT5SUbG/H1MN4wzwh5tJxOhB
         KvChlSqrzX+Yg==
Subject: [PATCH] pinctrl/sunxi: adding input-debounce-ns property
To:     Maxime Ripard <maxime@cerno.tech>, wens@csie.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <d244aa6b-00b7-d768-83cb-e5a228b7ee08@trexom.it>
 <20210114081732.9386-1-giulio.benetti@benettiengineering.com>
 <20210114114219.faulkwww3dhdqwmc@gilmour>
From:   Marjan Pascolo <marjan.pascolo@trexom.it>
Message-ID: <c3bc06e3-4193-dc0b-b2b3-d54636481e28@trexom.it>
Date:   Wed, 10 Feb 2021 17:22:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210114114219.faulkwww3dhdqwmc@gilmour>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: it
X-CMAE-Envelope: MS4wfH6oTAFv1UAc1UHjeT7fAUES0ERDDBsJcmnoqFOgFC4ptHAeVTLQat5FeTa3CPXA5acPN5BTNTXELXNkmdiwK4JcdZovN+luGUaxplPcy95PLoftAoUr
 M5mpLLDSjADTP7z+8Ou0rzlTA6ofdIK6AiHqwlfsmOEPQTGD1feR+1zp6kUEs0dQHr2AL3VLgpUIt+qQ3qqNqRGPF41/LkEK0HuBtmvn4CvQ875aG7XWb59t
 uneMi4ET4xtInHSFyOf7NCULykYkLkFIP+EqY+ygFeWFqUada0m8ywN0eWwtru5r261rWaqYkbSJX4sxRnxsXxD0yJb/FalRjeGQ8RHOhJlYTdMjMcaEPKtK
 R/CH/zYX3rdF0oGLCcE1ErnL8nsZBA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Allwinner SoC interrupt debounce can be controlled by two oscillator
(32KHz and 24MHz) and a prescale divider.
Oscillator and prescale divider are set through
device tree property "input-debounce" which have 1uS accuracy.
For acheive nS precision a new device tree poperty is made
named "input-debounce-ns".
"input-debounce-ns" is checked only if "input-debounce"
property is not defined.


Suggested-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Marjan Pascolo <marjan.pascolo@trexom.it>
---
---
  .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |  9 +++++++
  drivers/pinctrl/sunxi/pinctrl-sunxi.c         | 25 ++++++++++++++++---
  2 files changed, 30 insertions(+), 4 deletions(-)

diff --git 
a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml 
b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
index 5240487dfe50..346776de3a44 100644
--- 
a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
+++ 
b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
@@ -93,6 +93,15 @@ properties:
      minItems: 1
      maxItems: 5

+  input-debounce-ns:
+    description:
+      Debouncing periods in nanoseconds, one period per interrupt
+      bank found in the controller.
+      Only checked if input-debounce is not present
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 5
+
  patternProperties:
    # It's pretty scary, but the basic idea is that:
    #   - One node name can start with either s- or r- for PRCM nodes,
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c 
b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index dc8d39ae045b..869b6d5743ba 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1335,14 +1335,31 @@ static int sunxi_pinctrl_setup_debounce(struct 
sunxi_pinctrl *pctl,
      struct clk *hosc, *losc;
      u8 div, src;
      int i, ret;
+    /* Keeping for loop below clean */
+    const char* debounce_prop_name;
+    unsigned long debounce_dividend;

      /* Deal with old DTs that didn't have the oscillators */
      if (of_clk_get_parent_count(node) != 3)
          return 0;

+    /*
+     * Distinguish between simple input-debounce
+     * and new input-debounce-ns
+     */
+
      /* If we don't have any setup, bail out */
-    if (!of_find_property(node, "input-debounce", NULL))
-        return 0;
+    if (!of_find_property(node, "input-debounce", NULL)) {
+        if(!of_find_property(node, "input-debounce-ns", NULL)) {
+            return 0;
+        } else {
+            debounce_prop_name="input-debounce-ns";
+            debounce_dividend=NSEC_PER_SEC;
+        }
+    } else {
+        debounce_prop_name="input-debounce";
+        debounce_dividend=USEC_PER_SEC;
+    }

      losc = devm_clk_get(pctl->dev, "losc");
      if (IS_ERR(losc))
@@ -1356,7 +1373,7 @@ static int sunxi_pinctrl_setup_debounce(struct 
sunxi_pinctrl *pctl,
          unsigned long debounce_freq;
          u32 debounce;

-        ret = of_property_read_u32_index(node, "input-debounce",
+        ret = of_property_read_u32_index(node, debounce_prop_name,
                           i, &debounce);
          if (ret)
              return ret;
@@ -1364,7 +1381,7 @@ static int sunxi_pinctrl_setup_debounce(struct 
sunxi_pinctrl *pctl,
          if (!debounce)
              continue;

-        debounce_freq = DIV_ROUND_CLOSEST(USEC_PER_SEC, debounce);
+        debounce_freq = DIV_ROUND_CLOSEST(debounce_dividend, debounce);
          losc_div = sunxi_pinctrl_get_debounce_div(losc,
                                debounce_freq,
                                &losc_diff);
-- 
2.22.0.windows.1


