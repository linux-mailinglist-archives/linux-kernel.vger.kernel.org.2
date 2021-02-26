Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442A73263E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBZOPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhBZOO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:14:57 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60829C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 06:14:16 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id l12so11132330edt.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 06:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KoK826DVw45RSIr335dfSy5TyJSQwwkfzzkU1fu3OEk=;
        b=cZkTHSJQ1r4p4PitkU+/vlDTzmJg/V9nX2WMHhQJxJoERKL9NFhitjzsc5EiUnHIup
         oRr/wP47bDW4/E6DZ3P0aRDX2piGYfFtiIlzynodqk/4dzzLitA4hawc6gMGVrWWf6So
         4foAsZlCzcrFpybhzSxYqAYHtxVK9TO0y+LTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KoK826DVw45RSIr335dfSy5TyJSQwwkfzzkU1fu3OEk=;
        b=h0eIZxlcvre0mdYNDg4jL9ukzIqUBYev9+2wGFV3gONkzMM+gfnQ1h7zKZGSNbJxEp
         XtteU6joiilYS0luHnbWZel+vMiG+r9r30o2djumXyDMRNQSWKtGqthTkOowoJlpeZIZ
         mmEzOfr4KXeWpastVIipnjGloTv5GQwct2H5SSiwaSW9E9cveQOGsputtaR1JGfQgP+l
         B7mWBB62S/eyqg6n/9SrvGrBDWXphH12HiqqP8tq+kgu4ZPAihriCCPuJdDxa8LeBK3P
         ZzoOVfVmFXpMxSkuWG9rlWuTh7DdxWNUXFmq5s0uHDH7VNWZkaKM/8YmYPcdp8Sy0v06
         RPQg==
X-Gm-Message-State: AOAM5314r47MFN8gEhupZKrhph+BjhhzUzsXpwe1miW4eeY314RSzHJI
        y6/yu/o0Y+LO4dY52Q4ORPSC+nvGY4PZ6A==
X-Google-Smtp-Source: ABdhPJyQT4fNHYcSdyEohDne+SLW167qPUaA5ARIIc3MduU1I9qui5Ic3KhEBXHGpsBnUBhz2mxR9g==
X-Received: by 2002:a05:6402:2054:: with SMTP id bc20mr3575708edb.190.1614348855092;
        Fri, 26 Feb 2021 06:14:15 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id g3sm5316838ejz.91.2021.02.26.06.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 06:14:14 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/2] add ripple counter dt binding and driver
Date:   Fri, 26 Feb 2021 15:14:09 +0100
Message-Id: <20210226141411.2517368-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What I'm trying to do:

We have a board with an external watchdog circuit (the kind that is
petted by flipping a gpio). The reset output of that is split in two:
One gives an immediate interrupt, so software knows that a hard reset
is imminent. The other half removes the "reset input" from a ripple
counter, causing that to start counting at 32kHz, and after 64ms, the
SOC's reset pin then gets pulled.

Unfortunately, the board designer overlooked that the 32kHz output
from the RTC can be disabled, which (since no other component uses
it), is just what happens when clk_disable_unused() gets called. When
the watchdog fires, we do get the interrupt, but the board does not
get reset as it should, since the counter doesn't count.

So I'm thinking that the proper way to handle this is to be able to
represent that ripple counter as a clock consumer in DT and have a
driver do the clk_prepare_enable(), even if that driver doesn't and
can't do anything else. But I'm certainly open to other suggestions.

The "clk_ignore_unused" kernel parameter is fine for debugging, but
too big a hammer (since it applies to all "unused" clocks).


Rasmus Villemoes (2):
  dt-bindings: misc: add binding for generic ripple counter
  drivers: misc: add ripple counter driver

 .../devicetree/bindings/misc/ripple-ctr.txt   |  8 +++++
 drivers/misc/Kconfig                          |  7 +++++
 drivers/misc/Makefile                         |  1 +
 drivers/misc/ripple-ctr.c                     | 31 +++++++++++++++++++
 4 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/ripple-ctr.txt
 create mode 100644 drivers/misc/ripple-ctr.c

-- 
2.29.2

