Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4022E3385CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhCLGYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhCLGYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:24:50 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B06EC061574;
        Thu, 11 Mar 2021 22:24:50 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 18so1162048pfo.6;
        Thu, 11 Mar 2021 22:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ipbs0vmn31jwBnMAmrQqwbFSeorIpjiivuriOSD9mTw=;
        b=hnoMeyqTgxI+BsZIA6OCmL9vC+/PsLv3BD3jq2ESlv91TV6fYJog8hU4qpKi1t5vcQ
         85hBlAaY6s1lUSYwzGwctHqHjdS8dOj6wcdTZid5H8EJLCrz/uEzoVD6/40u4s0dXbRa
         Ae4ieoCRhuy85VEyI4PVuQvStN2RbIxIAmPmKRlDW8nMU63kvXaOhDt7ORUM5eTFqVKU
         EuGmNo4WdPkDBcrFYigyjf2w1UPjD1Jx0GCVj2F42CIa1rrGM033zeTAsksCjHvD2N7/
         QJ+SviwGfqjrs50xAnx/agmkapFvP8IZxMdQo9H0TjfZpYG5vba0eWotEajm9YPkWmD/
         z1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ipbs0vmn31jwBnMAmrQqwbFSeorIpjiivuriOSD9mTw=;
        b=Mk8QwObaCtXFd7Ddc+ZAoZcc12S97vB39xlsS+HTrSNFjnMoXODSzzQ/+n0cbFS8QQ
         yyYz70OYfVhOVgEXGu3FGK/dxNNMKXkXw5OjgyX9pdQiHa+wIqb8gkV7bFSIeSZycVqd
         ECUiFCkGMJwhvsj4vjQiGcmSnh5kq+snQNzyuV6wnEL8FYCp+5JSFTj6HIyxoo/WEG+d
         Sybvp7s8pW+iTIzkJTswUGwHupqk1dYPjnvmDOqBlvLZMp3CtYHpp4O7U4XVGbE+u4qQ
         NZ/sIECwMKMlO+87Q8LCP2vh+q+ph8ot6rlpUu3NzkhthbFDVRrheY1HVyJJV7i7TYi7
         hYww==
X-Gm-Message-State: AOAM531XIAnmHelXGGFUIjhvaXdJa/Q9dFgK4GhWpm1dzMPP8grApmM4
        3WtzX2H56saknLFYdIJskfvyM8p+EbhL6Q==
X-Google-Smtp-Source: ABdhPJwbLrv2qnek5I0Nbk7xSDiIXg00FGvxUPIXtST4dXlIDQEHa/YC5+OrmArbUrCTwPr3JMAStw==
X-Received: by 2002:a65:5a4a:: with SMTP id z10mr10103297pgs.240.1615530289738;
        Thu, 11 Mar 2021 22:24:49 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id h6sm4048406pfb.157.2021.03.11.22.24.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 22:24:49 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, alexandre.torgue@foss.st.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v2 3/8] dt-bindings: pinctrl: stm32: Add stm32h750 pinctrl
Date:   Fri, 12 Mar 2021 14:24:29 +0800
Message-Id: <1615530274-31422-4-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
References: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch intend to add pinctrl configuration support for
stm32h750 value line

The datasheet of stm32h750 value line can be found at:
https://www.st.com/resource/en/datasheet/stm32h750ib.pdf

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
v2: just add more commit message description

 Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
index 72877544ca78..59f33cbe8f48 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
@@ -24,6 +24,7 @@ properties:
       - st,stm32f746-pinctrl
       - st,stm32f769-pinctrl
       - st,stm32h743-pinctrl
+      - st,stm32h750-pinctrl
       - st,stm32mp157-pinctrl
       - st,stm32mp157-z-pinctrl
 
-- 
2.7.4

