Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371443F079F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbhHRPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbhHRPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:14:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE8C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 08:13:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q6so4087314wrv.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qoZ5/2UWBHWiefaepOTj74QF+R/T3B3ep4P+G4GpmBk=;
        b=ysQzummWZFRxjHAe7mXB3AHPWLwPUtmjc0LuCo4tsGWjD8BK3nI23I0aPbHxcfWwrR
         p/QhgIb0gnva9hU7RUPeBtLSw8BlPKv2r0yUh7sB08OHEZCl0v718i5EuaPnYfy4oQPB
         u9lcoG3GGKvEecvMu8wDx76Zb95XHqILqOUF8uGxfgGvIlcFnyyKN0QbzliUXqklpVnI
         xaP2Cbu5UFhZwD0tfcZD7UmwUOonanb8Zu60T1x1ILMj8yg6ykHXaWPHWTwgR5RkPE3H
         6w+nAOk9d13UVxTtnG6DwFw0p4NOb47S0JtGo1r90p63X0cObJ8Il1aMIpVaSoGrlVmI
         ZaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qoZ5/2UWBHWiefaepOTj74QF+R/T3B3ep4P+G4GpmBk=;
        b=kjPI66AY4odFlhBxjZMqUS5ktNOvuIze5Z4HeNgrlcC5FBbYpfB3DTH5veU6hyYGkO
         Mtmnc/FDbMHq310u6V1nLDqzgYZCNT7Tk6XA0p1wppQfsX62k7QuLuHvWtaAs5I4qwYp
         B+CfpjxgjMZ2PNA4Jes9QXs8csPmXRg+rwtNAWWH0rNnLWtj6uyV4E/7ON81lRJn8ds0
         JviUwGebwcAhofGauZ9/rHWiyp3zTd4gJqx7D4HFt4SL0meAXicMkHP90mt7L8u3QYxT
         o7dIFBxJTPHWVe6pI2nWfpyLAILfp7nbcsf7PfoxSTxhE1gOWWGTTC1YsedjlHkPjVmk
         ++yA==
X-Gm-Message-State: AOAM533IfCsH+bPiwQWIsM6YUL5IHhK8jiqVkMuDOqF2GGlmu0TsfAg7
        cJxxB+DkqoFzOiGMx1IjQRhsQg3ayu4h9/5C
X-Google-Smtp-Source: ABdhPJyhbAySDzbEYd9YP+taXFk34acrm5nzmziQoBK+X7ZLqDuRGhC7C//Qyf5SMo+wHxmRvOkcMA==
X-Received: by 2002:adf:f20d:: with SMTP id p13mr11240480wro.95.1629299628146;
        Wed, 18 Aug 2021 08:13:48 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id l21sm101829wmh.31.2021.08.18.08.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 08:13:47 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@linaro.org
Subject: [PATCH 0/2] Documentation: dmaengine: Tweak dmatest docs
Date:   Wed, 18 Aug 2021 16:13:13 +0100
Message-Id: <20210818151315.9505-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of small improvements to the dmatest documentation.

The first provides a description of what the test actually does.  The
second corrects the description of how the test behaves if the channel
parameter is not configured.

Daniel Thompson (2):
  Documentation: dmaengine: Add a description of what dmatest does
  Documentation: dmaengine: Correctly describe dmatest with channel
    unset

 Documentation/driver-api/dmaengine/dmatest.rst | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)


base-commit: 7c60610d476766e128cc4284bb6349732cbd6606
--
2.30.2

