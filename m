Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C750B342D3A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 15:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhCTOR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 10:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhCTORe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 10:17:34 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F77C061762
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 07:17:33 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n198so9185489iod.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieGGL6rIftmGUrUPP8WBA7EIeMeymcZEigdcphOIazQ=;
        b=AyIlZKGPBW3eGyJxO0O0uPvBmrF4lKvqtgqSZQeDuly+wQsd8oojNcLxw1XvQfTcLG
         wJPiqhwweEVI3hl1BiTUfI7j+tmO5V9VXtG1N8JecVkXNifS7knjSX5lL88UKd86VRAQ
         aPQAEQ2ZNuACW0x4WZQNLQZTPL+p2x14plohxHe6gyDZVkRwofwCR1rJ4u4bM/iiSl8n
         /4AWuB4o8tyB4im3N1RQ+B6wZcV+KsoIg1eqrIPq65sksKLqs6dH/4gSFn0fhNQHiMFx
         xcSjmeDGrSepdnWGDDVwBkAoXx2fKMzdzRY5QOQpsLu+WTCJvHvopE7+rj3z1bV52+R5
         EwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieGGL6rIftmGUrUPP8WBA7EIeMeymcZEigdcphOIazQ=;
        b=A1+vsFU0otKSkamh0Bq0260WqBKL3oiWb1j3W3pbK8cqKgLGfEGOcpCaR6VLWLqd9x
         xgMY265qqBmQZBRPtKgM/hZOjbNYNthGwIjVHpyoN0Yp9H5qjvUX+VpWUWIIJ7w001J/
         CSniF9KZsM6pq4aeIMKktzMYAhIY0WS18rTqrxowHs3kYROfyPmoupF+y2Y8T9KGQmx9
         RIHTIRkJLRoRqbCtWp8NaIgvHkFxKE7ZdoE9c2d16/m+nEusywnA18rNSfmk2+8yA5Rr
         WD3N1z2XITN7oX8AR2vOcSdsF38r4xJaUXNz1kBAJJuFr/r8sp5qZ1k0YvYYQcF1hUqP
         +h6w==
X-Gm-Message-State: AOAM531UF9HAfsSJeNSDaHvbeD4ZyZ2HM+rxwQZDflCjnZclWs07anO7
        8JN/4W5BCKyiCoHc0I2Z5zL4HA==
X-Google-Smtp-Source: ABdhPJysHApS2IUHUucTm8+Tzo0kQeaczIijUCeFjBK4YCihzwJ3FY8DWqaTzGm9Hxg9cvYwQi3bQQ==
X-Received: by 2002:a5e:d61a:: with SMTP id w26mr6065331iom.40.1616249853034;
        Sat, 20 Mar 2021 07:17:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id s16sm4273221ioe.44.2021.03.20.07.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 07:17:32 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     leon@kernel.org, andrew@lunn.ch, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: ipa: fix validation
Date:   Sat, 20 Mar 2021 09:17:27 -0500
Message-Id: <20210320141729.1956732-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is sanity checking code in the IPA driver that's meant to be
enabled only during development.  This allows the driver to make
certain assumptions, but not have to verify those assumptions are
true at (operational) runtime.  This code is built conditional on
IPA_VALIDATION, set (if desired) inside the IPA makefile.

Unfortunately, this validation code has some errors.  First, there
are some mismatched arguments supplied to some dev_err() calls in
ipa_cmd_table_valid() and ipa_cmd_header_valid(), and these are
exposed if validation is enabled.  Second, the tag that enables
this conditional code isn't used consistently (it's IPA_VALIDATE
in some spots and IPA_VALIDATION in others).

This series fixes those two problems with the conditional validation
code.

Version 2 removes the two patches that introduced ipa_assert().  It
also modifies the description in the first patch so that it mentions
the changes made to ipa_cmd_table_valid().

					-Alex

Alex Elder (2):
  net: ipa: fix init header command validation
  net: ipa: fix IPA validation

 drivers/net/ipa/Makefile       |  2 +-
 drivers/net/ipa/gsi_trans.c    |  8 ++---
 drivers/net/ipa/ipa_cmd.c      | 54 ++++++++++++++++++++++------------
 drivers/net/ipa/ipa_cmd.h      |  6 ++--
 drivers/net/ipa/ipa_endpoint.c |  6 ++--
 drivers/net/ipa/ipa_main.c     |  6 ++--
 drivers/net/ipa/ipa_mem.c      |  6 ++--
 drivers/net/ipa/ipa_table.c    |  6 ++--
 drivers/net/ipa/ipa_table.h    |  6 ++--
 9 files changed, 58 insertions(+), 42 deletions(-)

-- 
2.27.0

