Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAF133A1E7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 00:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhCMXVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 18:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhCMXVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 18:21:10 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148C1C061574;
        Sat, 13 Mar 2021 15:21:10 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id g24so6706512qts.6;
        Sat, 13 Mar 2021 15:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sPD2bSnWvbDrgLc8T8FiNAXhzdKx85WK2z6G0UHNxJo=;
        b=V1flZnjJUOSV40TEOU1wTcP4ynJNP+VBRjXEAMhy7slACxk6YKpxL7XjL+XUZoi8le
         o9p4l07PiyZ0k1EFXDDNS6fsX/wwqWTLAdcWzfavQ9yWgH9wSC/M9ME3J3skL9l2qHX6
         IRf5inhpiutM3WenpV6QLcRI5ZUOEnX/1NETriYNwGxmjqUh5hg2+qq8iAhf58FaprEr
         sLQjLzbvpgahSBeuUp8xfTyNhdZFwFlUMyCR8NjYdUHkhqwOgXwam7RcesDbiuSosQ3m
         l4DQld+5ZE8w+EwvhwAe8uj97M23tiigV3YoOhgY8bbH+Xs8UJR3SjsVD8ovJw2HNkpc
         30uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sPD2bSnWvbDrgLc8T8FiNAXhzdKx85WK2z6G0UHNxJo=;
        b=Yt0pJiBlb8byOL1rgnY4QZ7vXZ3tmYtiO1DZccVvsmLj7XDmm8QYjRbOL/fgfEsq/r
         sARB5hSWcmPNu1KgTaItv0+fGjv4mfYOoxl7t77XIDEDdR9rFM/vC/ZrjDKGzNWjXwbE
         n4D9dcy0oV3zG7J9mx5pJJ44fjsNYdG7BWkZdnb3CScRfDEjqhdm8vC99l0QrSR0jWix
         anMICHrdzcJDvtyOAOg32CSJdTy1HALzgWuGikqsnsmXN46P/Dq5ZyY8RatvKTH1eAW9
         mClvntcFOWyIxwOWdOn5I2FB5C7cqxbK3Rit29Y+oLKvF3Sd7CpEUjGcM0zf6EL97UOj
         42mA==
X-Gm-Message-State: AOAM53324WdJAlQU54ApVfeeZeStPgQLUBpzZK3pysEMyPhDLn/pQPPl
        fCPH/spaqt17ThPlaqXQpLI7DunWhZMLG53Y
X-Google-Smtp-Source: ABdhPJwNJB4MD1+fjjAgaeEZaXl0M+JmZ/u/trmLws+AkEeeKGkrESMrdqOuefSpQKnEj/K/un7YSQ==
X-Received: by 2002:aed:306c:: with SMTP id 99mr17329762qte.352.1615677668706;
        Sat, 13 Mar 2021 15:21:08 -0800 (PST)
Received: from localhost.localdomain ([37.19.198.114])
        by smtp.gmail.com with ESMTPSA id r17sm6630360qtx.62.2021.03.13.15.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 15:21:08 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] docs: devicetree: bindings: sound:  Fix a typo in the file rt5682.txt
Date:   Sun, 14 Mar 2021 04:48:50 +0530
Message-Id: <20210313231850.17278-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/drving/driving/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/devicetree/bindings/sound/rt5682.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5682.txt b/Documentation/devicetree/bindings/sound/rt5682.txt
index 9c5fadb6ac82..cd8c53d8497e 100644
--- a/Documentation/devicetree/bindings/sound/rt5682.txt
+++ b/Documentation/devicetree/bindings/sound/rt5682.txt
@@ -44,7 +44,7 @@ Optional properties:
 - realtek,dmic-delay-ms : Set the delay time (ms) for the requirement of
   the particular DMIC.

-- realtek,dmic-clk-driving-high : Set the high drving of the DMIC clock out.
+- realtek,dmic-clk-driving-high : Set the high driving of the DMIC clock out.

 Pins on the device (for linking into audio routes) for RT5682:

--
2.26.2

