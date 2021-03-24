Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D47A347953
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhCXNQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbhCXNPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:15:32 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D821EC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:15:31 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id n198so21430170iod.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oPFA6rVxHKxBQf4a3Xn6w1bxyecBN3XKdCmIzpzW6iI=;
        b=YUN+OMrgxvni1bhoTXWvikyICShXhRAcIYY65R2qWT8dKQ9C2LhB7m2uAovivNnWTS
         mE6S/u3FzHduklf/WYV8yE9Y/OWri7YCehdUpiPcAPyyzropeRmcqJ8YSUwJ5A3p6sXB
         Q3yXE+rQk05eziqAc5ysqpvmusGf0p9cEYQaSBeEWysugZ5t4b79osPH3aPebGwEGZO/
         1rvnGlMV8vo+fCBl3E4ZZFWRw+nmC7nyy6kR1nehlMIunL2E9QA2f9QLnXmA/l7BgmiU
         A3BrrqR9xxW05Sgq8JzuW/JyOF4JL+Wa37BpALJ0IMp7sr8odq2BEtDeHcFUQAODZ0Np
         B/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oPFA6rVxHKxBQf4a3Xn6w1bxyecBN3XKdCmIzpzW6iI=;
        b=dyg5uO3LOI2MnBUhcGrU7tJOFgBNaM5uxPRDNe4M16tlNHSAnGGeDXEEqMFm+Rhw+1
         Oj1s1CJF9G0+rc0UQn1g6jFKgCa8eZU4JABZ06JlHir87npwup15MewKe3BO3WyNNpXA
         pSIQ349lpNKyyKDTUR83LTICJwccMmahut/pM78vnzEm4oLBPdw5tWnTWZJOCc9blADm
         /wvPU2f4b2JTEa5+cSu4GGCNLzsJRnh34m5ozyV1abLh3hsxGLJKtRkCjGavl/w4ReiJ
         ns7xvHhUwYVtWK6ibqQd48VPiRQSdtazQrl6XdynLDYeiuQwSiHrD676EcAdMM4oNUUD
         eglQ==
X-Gm-Message-State: AOAM533ayRnOkvmED3R6nIaw4hew67aNqztpUoFjepXPJjUbaQCZOgGK
        wvnbqeB4ZYG7QhtvBeRcJlnkdVui7qhI9Uxo
X-Google-Smtp-Source: ABdhPJw5nl75LHisWPGEDM7ykRNxz1p6iL7XlaPCh2TtwZVdsbyrweDkGyv7pUd9gGuTMW/4xNo7Eg==
X-Received: by 2002:a02:ab94:: with SMTP id t20mr2883601jan.49.1616591731092;
        Wed, 24 Mar 2021 06:15:31 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id n7sm1160486ile.12.2021.03.24.06.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 06:15:30 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/6] net: ipa: versions and registers
Date:   Wed, 24 Mar 2021 08:15:22 -0500
Message-Id: <20210324131528.2369348-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2 of this series adds kernel-doc descriptions for all
members of the ipa_version enumerated type in patch 2.

The original description of the series is below.

					-Alex

This series is sort of a mix of things, generally related to
updating IPA versions and register definitions.

The first patch fixes some version-related tests throughout the code
so the conditions are valid for IPA versions other than the two that
are currently supported.  Support for additional versions is
forthcoming, and this is a preparatory step.

The second patch adds to the set of defined IPA versions, to include
all versions between 3.0 and 4.11.

The next defines an endpoint initialization register that was
previously not being configured.  We now initialize that register
(so that NAT is explicitly disabled) on all AP endpoints.

The fourth adds support for an extra bit in a field in a register,
which is present starting at IPA v4.5.

The last two are sort of standalone.  One just moves a function
definition and makes it private.  The other increases the number of
GSI channels and events supported by the driver, sufficient for IPA
v4.5.

					-Alex


Alex Elder (6):
  net: ipa: reduce IPA version assumptions
  net: ipa: update version definitions
  net: ipa: define the ENDP_INIT_NAT register
  net: ipa: limit local processing context address
  net: ipa: move ipa_aggr_granularity_val()
  net: ipa: increase channels and events

 drivers/net/ipa/gsi.c          |  8 +++----
 drivers/net/ipa/gsi.h          |  4 ++--
 drivers/net/ipa/ipa_cmd.c      | 26 ++++++++++++---------
 drivers/net/ipa/ipa_endpoint.c | 42 ++++++++++++++++++++++++----------
 drivers/net/ipa/ipa_main.c     | 21 ++++++++++++++---
 drivers/net/ipa/ipa_mem.c      |  6 +++--
 drivers/net/ipa/ipa_qmi.c      |  2 +-
 drivers/net/ipa/ipa_reg.h      | 40 ++++++++++++++++++++------------
 drivers/net/ipa/ipa_version.h  | 29 +++++++++++++++++------
 9 files changed, 121 insertions(+), 57 deletions(-)

-- 
2.27.0

