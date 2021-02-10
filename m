Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55464317477
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhBJXdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbhBJXd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:33:27 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0524EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:32:44 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id e12so2127113pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r6Hapq7kV6otgap3ZUZZOvoWqJOVNtXPwECnVrn/R6Q=;
        b=E0I618eOwSh2E9sEk4bQ+xWTfD/jnEyjDdwdHOAQY98D1LEy9wP6SLM0zodlwTmOBt
         CEgN3j5YqZbmP2aUaBFZGwugtaxnatHxyQ2qAHoXfIyLA2ZauGdjzJriKdSvqLlSCd9o
         +mpfGe27deB+++jUveUkNipaBdnMMiBwGyS2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r6Hapq7kV6otgap3ZUZZOvoWqJOVNtXPwECnVrn/R6Q=;
        b=WsuDUA7FeD9ewypMEgJokjXWwxeFfl/hOFJA59InOf44vd0I2Ya6N3EgyFBJJyfs7l
         Pnj1bm+8y9+966B/fVIfk54Vx4q3iYituXedS0us+Wk8Iih1YpU2ICtVpqcOJId0XG9G
         KlwEjgcSe8FcgZmjijLdvDUXb9YOLmZHhDQTgAQz3Fbhj9+avk/FbQSx/1jwsSzOHXDr
         UsbSTL85i/N3glGFPUurG1PpBmi2hbQhAcZNgpt2e4LOnPE0EgmhxXkOSv1CZ5hKJAhi
         gO1JNwOTIXPOMVzuvTmZ92qsub5fbIheBLskSr8jT8VBBoVnP4HESxvIydH5czwHTIly
         ltVw==
X-Gm-Message-State: AOAM533Xzd0wnhiDYJg4NCEUBwzR7MgQ7zvWks+aI3YhSFAA6et8TEwZ
        tGhOVq/66vvNvuqrMdIejAOi8w==
X-Google-Smtp-Source: ABdhPJy7IG3V/4uloAYtfCimRtA7hHKAQm5abaGJXwFI7t7V/lLqamZWQ2rtJJkgCU3Mko/yzUMN1Q==
X-Received: by 2002:a17:902:ee04:b029:e1:7256:fa18 with SMTP id z4-20020a170902ee04b02900e17256fa18mr5077020plb.58.1612999963525;
        Wed, 10 Feb 2021 15:32:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a78sm3616860pfa.10.2021.02.10.15.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:32:42 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH] staging: Replace lkml.org links with lore
Date:   Wed, 10 Feb 2021 15:32:31 -0800
Message-Id: <20210210233231.1664896-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=065284c84f9e8b8ad601127d816f48422b69d224; i=yZn1Heji1RqzdfQZvZRGy8J3YtNiRGNoH2Q1+UpL15s=; m=kc8NgBcNkR1FdAUFoBcecPqIFWVDlhJwDI99K+gzg58=; p=M2dbRkIQhjx5vyRdtSmtEnm1MqNsT/Do2zO1kJyvvww=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmAkbQ4ACgkQiXL039xtwCZ8xQ//RYM D0pHhPqXiKFuSeoueESy8Zf2Z6gecGK3FXbnljybKtpy5xPO5J8yyP5lprlTU864EuHaixajPGKX/ D0vgrNshSKFzMRdn+vsx3bRuWdhYrFJ9PryXtJNkiZ/4feGHBjiRfyR9PaiVCIGVHFzFb79Ch420c S9wvLh1nQAs80KDNhpx99KvdL8XWL9MrtRMFNboydFIIJn/O52w++xabAULYAvbCEEka7EJdFwbE7 jOTWJacCpGbyjQZnV/RHds8HmwQPruqHsopOOUJ6ffBBGVR+UWQm9GAsM3wk2/p3fWlQR5OYjpJlL Rx1kWrkkUcm2JwbJbc3FXQhxevhHNZQLHIdxMVEuXwO5+PMHycruQPa84jUnU9Pv86WSaAQrsGa/t EubrI2K5uoHjwi//9Zsl5VHr96kb9GFyhmB3bjKA/sqtYALP6pvTOEvnQBaj75UsMXyhpZz8th0Ba Kk7IaSFl81FPB4Qm0A5fhqDlT9T2h6MHdWKCJMQeY9zaD14Uv+djiKFQyrokWbASOCUX51QqLTbYI 4xZf2ip5MUpC4hP+yGbqOAiqL7Ox0euE1hA+gKfj6ftofIGEUugdxGuTgAaJyJ4siAspXTEXpafG8 W6Z/TQbMuWRIvjgHzPsR9vEZF1z3BYabso1Wo2xr65/VOCSRM9FnEZLb8/17SwO0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
links with lore"), replace lkml.org links with lore to better use a
single source that's more likely to stay available long-term.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/staging/clocking-wizard/TODO             | 3 ++-
 drivers/staging/vc04_services/bcm2835-audio/TODO | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/clocking-wizard/TODO b/drivers/staging/clocking-wizard/TODO
index ebe99db7d153..c7e1dc58dfba 100644
--- a/drivers/staging/clocking-wizard/TODO
+++ b/drivers/staging/clocking-wizard/TODO
@@ -2,7 +2,8 @@ TODO:
 	- support for fractional multiplier
 	- support for fractional divider (output 0 only)
 	- support for set_rate() operations (may benefit from Stephen Boyd's
-	  refactoring of the clk primitives: https://lkml.org/lkml/2014/9/5/766)
+	  refactoring of the clk primitives:
+	  https://lore.kernel.org/lkml/1409957256-23729-1-git-send-email-sboyd@codeaurora.org)
 	- review arithmetic
 	  - overflow after multiplication?
 	  - maximize accuracy before divisions
diff --git a/drivers/staging/vc04_services/bcm2835-audio/TODO b/drivers/staging/vc04_services/bcm2835-audio/TODO
index cb8ead3e9108..b85451255db0 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/TODO
+++ b/drivers/staging/vc04_services/bcm2835-audio/TODO
@@ -5,6 +5,6 @@
 *****************************************************************************
 
 1) Revisit multi-cards options and PCM route mixer control (as per comment
-https://lkml.org/lkml/2018/9/8/200)
+https://lore.kernel.org/lkml/s5hd0to5598.wl-tiwai@suse.de)
 
 2) Fix the remaining checkpatch.pl errors and warnings.
-- 
2.25.1

