Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E0C3D7EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 21:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhG0Tqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 15:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhG0Tqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 15:46:36 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2343C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:46:32 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id a13so122738iol.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H4OUebZ7xitrsOEWvGlbAq60KdqQlbMc/4TH+h2BBVw=;
        b=dUDbHhGhsRAve6ItU2zgUbk46iQhfwU+vtplrbsG4NlNTq75r8BghZ8oV2DmpXrjD9
         jjqVmoPUVOTXZGANfcSDwjejio+kiXzPHJHeo0uFAG7AOAy0QZhmju5qQkgOLJjjZ99X
         lvjZbfrC3faSU2VRavDIMzQTFCo5VOj3yc7TKN71G7pFuCvZv2mtcg7ELus4RNNqP9k1
         q0SKJ2bAWadNDkjFYpb9BNDx2teOr7WmPc5gZfuAL2JYy1wsut5byKLEPDFNbPDag9oK
         Mr1IJmlK1uRrgwNUmdo072d4ZGfoar7EgnNmKU5yn+5L1K5x8w1kAk3voj0JzWjyhNef
         AsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H4OUebZ7xitrsOEWvGlbAq60KdqQlbMc/4TH+h2BBVw=;
        b=aZ/RSCHQWHT0Q+N6CsIMvvLz/+fPL/PYIuin9tuuS/0f5p/bRtfZ9wlhe6WRWvrqt0
         U2l/dOx27P4Qj8cP0pgJTcEx3tuk/Qf6c7LHgbltPgGU4iiQ+ZXAlu5WKWTLagh1E1gK
         UeXaEREGx7gYKtGOTzfp6T11By0y7PfsL3UUzxJaxGLYurIxxwrpq5DIiESpZ+AeCx9B
         Zwkgwi0DWg/TZYqS2p1exgQSAONnGpLZvq5QOE53110BaTyXswoFipT/S+wtJRuDLOxO
         dRpMGF0rmwe/7dOJ0IHZzK1j0XU2OMb8vtIjCN+C5DaciO3udmEekKD423Fhungy1+Ur
         EjKQ==
X-Gm-Message-State: AOAM531FDgIEOAmXBlxzl244i8v7PasiPLVT67x5YRfcrjc5XAZ1khfN
        8TvIhLZyTO2kdgvGfZXdAy2XXg==
X-Google-Smtp-Source: ABdhPJzK4J5zLorijuI14ZaGYRNIrelsae+mhmJKow9OD7css3/0rfdUHtJa2DgF6rtcFoWQeY51Dw==
X-Received: by 2002:a6b:7905:: with SMTP id i5mr20670143iop.175.1627415192317;
        Tue, 27 Jul 2021 12:46:32 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c1sm2443014ils.21.2021.07.27.12.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:46:31 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] net: ipa: IPA interrupt cleanup
Date:   Tue, 27 Jul 2021 14:46:25 -0500
Message-Id: <20210727194629.841131-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch in this series makes all IPA interrupt handling be
done in a threaded context.  The remaining ones refactor some code
to simplify that threaded handler function.

					-Alex

Alex Elder (4):
  net: ipa: make IPA interrupt handler threaded only
  net: ipa: clear disabled IPA interrupt conditions
  net: ipa: get rid of some unneeded IPA interrupt code
  net: ipa: kill ipa_interrupt_process_all()

 drivers/net/ipa/ipa_interrupt.c | 57 +++++++++++----------------------
 1 file changed, 19 insertions(+), 38 deletions(-)

-- 
2.27.0

