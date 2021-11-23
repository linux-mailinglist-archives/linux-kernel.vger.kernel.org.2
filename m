Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00E645990D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 01:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhKWATI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 19:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhKWATH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 19:19:07 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14104C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 16:16:00 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id w4so8748507ilv.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 16:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/CwY4GIFCqOSMR52qLYzEMnUpqMj/zngqQh5/Mk2h1I=;
        b=Adeu9/L+o9xyBIZ47WdHTdGd/70zl6lH7UF8N6C1pEjTFRtG5nGR/stEQdLDakLupb
         lBTHZkwDHh2idJ6Qwxn5ckm55uIsV/wWMIIbd/Q3cs0+HwkXy6rV18P0mrZc+OA65w+M
         XMXIPW6IOH7zLWqOO4dMfRNzwk+3oUGOb1+cbr7Pj2XUXlkojbFV+ZPCw2ZqBt6ddC3Q
         iTIIpQpj9Moa9Blc7XTfe5bUllGT9gwHY+DU5lOUk38Rtouu3IXXuyNzPaV5nnmxeySp
         RP+WE5p6InNNTaXjpLcv0eSl3h/HWtILLgOK43rJBlhvwcfYIZp6M/J9CzQlxLIGQ0zE
         tfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/CwY4GIFCqOSMR52qLYzEMnUpqMj/zngqQh5/Mk2h1I=;
        b=3To06QRwSw7pA5bxLI+p+sBZsk9hiput1mn7IzMAaUt//DUlw8LTzr338IPjw3Vlob
         KsAKuUdqdNPsw+SNFxt2YOuZmrcYifFHBMOV8HqDRORSGUkNwqY0+Ix0VY+MwhG1Hsfh
         gXJWABKn89EH826+gdkPZOO8m0WtB43dd8BlaLW3P/5PTCvCb4Q9GTUE/cEw1IiVI2yN
         q8SXjiJWYIu+K1hwzWqGxucMk05LNa4R0KzMvA454ZbYnhJQyLwljFHUi3cxOzqipj97
         A0U/XCQQ9XGuS88p1lwrshsxZ3npVIDPQNHPI5hwu68GclGwzkq2wdgwaLkagAMl0BTo
         PqjQ==
X-Gm-Message-State: AOAM531zLKUo9qcSO1B56n332kXMMToOLZJVd7oiyvtlRrfk3rPiVRJ8
        NuPhCEfNqezxyGGt6VzVguES2w==
X-Google-Smtp-Source: ABdhPJz+6F7oEjBA7N4CeOYUwNCuBtj5Z1j0ATuzYZTpImPL+EXZxBcJocH2zF0gk9hFFss8fW4byQ==
X-Received: by 2002:a92:d106:: with SMTP id a6mr1353221ilb.234.1637626559468;
        Mon, 22 Nov 2021 16:15:59 -0800 (PST)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id u4sm7040094ilv.81.2021.11.22.16.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 16:15:58 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     pkurapat@codeaurora.org, avuyyuru@codeaurora.org,
        bjorn.andersson@linaro.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, evgreen@chromium.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: ipa: prevent shutdown during setup
Date:   Mon, 22 Nov 2021 18:15:53 -0600
Message-Id: <20211123001555.505546-1-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setup phase of the IPA driver occurs in one of two ways.
Normally, it is done directly by the main driver probe function.
But some systems (those having a "modem-init" DTS property) don't
start setup until an SMP2P interrupt (sent by the modem) arrives.

Because it isn't performed by the probe function, setup on
"modem-init" systems could be underway at the time a driver
remove (or shutdown) request arrives (or vice-versa).  This
situation can lead to hardware state not being cleaned up
properly.

This series addresses this problem by having the driver remove
function disable the setup interrupt.  A consequence of this is
that setup will complete if it is underway when the remove function
is called.

So now, when removing the driver, setup:
  - will have already completed;
  - is underway, and will complete before proceeding; or
  - will not have begun (and will not occur).

					-Alex

PS  These patches might not back-port cleanly; I'll gladly provide
    equivalent code for older kernel releases if needed.

Alex Elder (2):
  net: ipa: directly disable ipa-setup-ready interrupt
  net: ipa: separate disabling setup from modem stop

 drivers/net/ipa/ipa_main.c  |  6 ++++++
 drivers/net/ipa/ipa_modem.c |  6 +++---
 drivers/net/ipa/ipa_smp2p.c | 21 ++++++++++-----------
 drivers/net/ipa/ipa_smp2p.h |  7 +++----
 4 files changed, 22 insertions(+), 18 deletions(-)

-- 
2.32.0

