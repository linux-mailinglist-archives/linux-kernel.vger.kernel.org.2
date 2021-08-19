Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28513F22ED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 00:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbhHSWUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 18:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbhHSWUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:20:07 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879DFC061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 15:19:30 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id y3so7513699ilm.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 15:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vPUru/TYDi5YjR/bbAhvMjF9OzpGGdZFmOl2rbUnBB4=;
        b=S7vi+fiVH/33qj0cnmQ8BsS//9/RbmQkZAE9NIfUZaQamE0mxS8rlq4pBey3Zg0dXk
         pujrPK9G3j11L02JpYV8TnSbqs3bBljFpwrM7yL96+2cngVEMIA1qYZOJM05SuaDV1Rj
         2ExUNLcA665tlRfnIcJ0NEzD4xPE4RXUMBV//wp3XSBpooHTvvMXtIN9Tisdtkamnfye
         9Q2okibI5n1e1Dgb4ZgBG5q5qsDFPOApxogYjMgzPL+Il4vfTT2+HFUyRdGkiBV7OatM
         0EpWHps/ujczw+cztWpk9fccvhqU7a6RBh1s8k1YhpshhQT8b9i6M5po6B64JoqmZPTf
         ZZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vPUru/TYDi5YjR/bbAhvMjF9OzpGGdZFmOl2rbUnBB4=;
        b=rNNkL+tHmgCrUiyWvSEYDP3E22BV7MU1t84pdZ0AIMrqdLXHZdnt3RRLHQFXyCFgpI
         6mpGDzAFZxog7wvhbGC4CbE+RRVHtkJj9JDD+q9p3RPuoJM/tSOkAe37K7faanXz3WDy
         z3Fx5VSGeOb/6eq9tzuq+P4pwUSOQLdX15Cgda9mnrIy9VFmfrrzgpJO7D3ADMBPIMRs
         PTgL59inGlkeGIrazd16rRlPnQ64KEMaQlLSchs7u+6RdF9AIq/VOtluw7BqEcfN1JSy
         V5R+IRhS/0LqSQLD5FbqQCfEejeTgYt/dzj2U04WS7nWW8Py2DE2VaLIkaBoy9Z4kDu8
         g3+A==
X-Gm-Message-State: AOAM530F4jHtO+/ixUU7A2mvjPN5M95jzUliNQAuvnr4AYgU3cWr+Gqb
        vSoBzrBDS4lDfE1yUCWinwytmw==
X-Google-Smtp-Source: ABdhPJxDB9EdhwwGVYmZKbE4M6XSdELpdA4qZ1QD+Y/0MjpEsXVuIjVbxFsjKMN29zkfqGLPLEet3Q==
X-Received: by 2002:a92:c601:: with SMTP id p1mr11250320ilm.284.1629411569899;
        Thu, 19 Aug 2021 15:19:29 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o15sm2245188ilo.73.2021.08.19.15.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 15:19:29 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] net: ipa: kill off ipa_clock_get()
Date:   Thu, 19 Aug 2021 17:19:22 -0500
Message-Id: <20210819221927.3286267-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series replaces the remaining uses of ipa_clock_get() with
calls to pm_runtime_get_sync() instead.  It replaces all calls to
ipa_clock_put() with calls to pm_runtime_put().

This completes the preparation for enabling automated suspend under
the control of the power management core code.  The next patch (in
an upcoming series) enables that.  Then the "ipa_clock" files and
symbols will switch to using an "ipa_power" naming convention instead.

Additional info

It is possible for pm_runtime_get_sync() to return an error.  There
are really three cases, identified by return value:
  - 1, meaning power was already active
  - 0, meaning power was not previously active, but is now
  - EACCES, meaning runtime PM is disabled
One additional case is EINVAL, meaning a previous suspend or resume
(or idle) call returned an error.  But we have always assumed this
won't happen (we previously didn't even check for an error).

But because we use pm_runtime_force_suspend() to implement system
suspend, there's a chance we'd get an EACCES error (the first thing
that function does is disable runtime suspend).  Individual patches
explain what happens in that case, but generally we just accept that
it could be an unlikely problem (occurring only at startup time).

Similarly, pm_runtime_put() could return an error.  There too, we
ignore EINVAL, assuming the IPA suspend and resume operations won't
produce an error.  EBUSY and EPERM are not applicable, EAGAIN is not
expected (and harmless).  We should never get EACCES (runtime
suspend disabled), because pm_runtime_put() calls match prior
pm_runtime_get_sync() calls, and a system suspend will not be
started while a runtime suspend or resume is underway.  In summary,
the value returned from pm_runtime_put() is not meaningful, so we
explicitly ignore it.

					-Alex

Alex Elder (5):
  net: ipa: don't use ipa_clock_get() in "ipa_main.c"
  net: ipa: don't use ipa_clock_get() in "ipa_smp2p.c"
  net: ipa: don't use ipa_clock_get() in "ipa_uc.c"
  net: ipa: don't use ipa_clock_get() in "ipa_modem.c"
  net: ipa: kill ipa_clock_get()

 drivers/net/ipa/ipa_clock.c     | 17 --------------
 drivers/net/ipa/ipa_clock.h     | 24 --------------------
 drivers/net/ipa/ipa_interrupt.c | 14 ++++++------
 drivers/net/ipa/ipa_main.c      | 21 ++++++++---------
 drivers/net/ipa/ipa_modem.c     | 40 +++++++++++++++++++--------------
 drivers/net/ipa/ipa_smp2p.c     | 19 +++++++++-------
 drivers/net/ipa/ipa_uc.c        | 22 ++++++++++--------
 7 files changed, 65 insertions(+), 92 deletions(-)

-- 
2.27.0

