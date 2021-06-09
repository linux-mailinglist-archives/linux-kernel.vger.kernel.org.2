Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924E33A2030
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhFIWhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhFIWhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:37:18 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8B1C0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 15:35:07 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id q3so1326318iop.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 15:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ui1h2/lSGVRiQONBoWaBIz37PCDVCaei4l7Zfbmyt1o=;
        b=yAmrt0d9LAu3cHvGNP7zACcD3e9r64TysgH7QY3IrtmWGZDBKY09Es05iiGj5+dLoy
         QJ7xlRn+/AczqW2l+K+Y53ybJ6gq0pSlRBPGmpDHTeZIFxQP0sQdyI+OvHnTFdfunBkK
         FQgqy4K10ls8tebZfEcpMz1s10oq5vD+oMpE1D44lo36oYTuOnGkMIM97Tc7t92lO6h9
         aUgmtZiHW7EgwgfZjz/7X+e9rrDeUmqqgr6toToiaqHlXBoTzrwwAxV0EtAlVOcjskLx
         EnA/Nl6GcVYBS6DT7oPLDIta1Xh64BZbq9xl/dbZ0svj9JMBmRa/rZ77Cob0GYtB+XMw
         tZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ui1h2/lSGVRiQONBoWaBIz37PCDVCaei4l7Zfbmyt1o=;
        b=Acb7nBcsyvbLIjyJxqlirGk2kA+p8gauqgTN5h/iMV5Gd8fy/gWo+M/CcO9sAeV/MZ
         BYm6QSJzgZ1s5XpLYcw3K8G/wjTrwr9gKOtRXDcfMikZuMs0Qy+mbqLlUBruFGrUSHwh
         ugO5VlL/+XcptggzohDFCv63MnKKqbX9uEcHTsIUCHSfFaFhpcN2bUS44Qtmo4Kg/1a1
         KUixyDmnKr3psUSu32NXTWU7RA+Cx/wsBxlO3TO/Xesp7/SvzoVg08V8DIcx95Ho8USp
         D6OyBRbcAAvAfCJ01nnPKtdtPeV6FB8N/H3OUj6wds1Poqvvc2wW1NGnNf5lOpemtUtV
         o7HQ==
X-Gm-Message-State: AOAM531G8hutx4zFFMDqr+xqpBO5kvcVFnbC7Glu9RdlKTbL6l/zvI2q
        zoWwcbnZ+4+7XwC9SUurfayZbrUfb+WCxRZC
X-Google-Smtp-Source: ABdhPJykbFctufQfaPqz9EI9sNhxYW5geFhf20IIojB7NpG3KhV7jvhnobjONjbEuzEhJ7sAgGY0MQ==
X-Received: by 2002:a6b:7948:: with SMTP id j8mr1294767iop.32.1623278106398;
        Wed, 09 Jun 2021 15:35:06 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c19sm750165ili.62.2021.06.09.15.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 15:35:05 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 00/11] net: ipa: memory region rework, part 1
Date:   Wed,  9 Jun 2021 17:34:52 -0500
Message-Id: <20210609223503.2649114-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first portion of a very long series of patches that has
been split in two.  Once these patches are accepted, I'll post the
remaining patches.

The combined series reworks the way memory regions are defined in
the configuration data, and in the process solidifies code that
ensures configurations are valid.

In this portion (part 1), most of the focus is on improving
validation of code.  This validation is now done unconditionally
(something I promised Leon Romanovsky I would work on).  Validation
will occur earlier than before, catching configuration problems as
early as possible and permitting the rest of the driver to avoid
needing to do some error checking.  There will now be checks to
ensure all defined regions are supported by the hardware, that
required regions are all defined, and that there are no duplicate
regions.

The second portion (part 2) is mainly a set of small but pervasive
changes whose result is to have the memory region array not be
indexed by region ID.  I'll provide further explanation when I post
that series.

					-Alex

Alex Elder (11):
  net: ipa: define IPA_MEM_END_MARKER
  net: ipa: store memory region id in descriptor
  net: ipa: validate memory regions unconditionally
  net: ipa: separate memory validation from initialization
  net: ipa: separate region range check from other validation
  net: ipa: validate memory regions at init time
  net: ipa: pass memory configuration data to ipa_mem_valid()
  net: ipa: introduce ipa_mem_id_optional()
  net: ipa: validate memory regions based on version
  net: ipa: flag duplicate memory regions
  net: ipa: use bitmap to check for missing regions

 drivers/net/ipa/ipa_data-v3.5.1.c |  15 +++
 drivers/net/ipa/ipa_data-v4.11.c  |  24 +++-
 drivers/net/ipa/ipa_data-v4.2.c   |  20 ++-
 drivers/net/ipa/ipa_data-v4.5.c   |  23 ++++
 drivers/net/ipa/ipa_data-v4.9.c   |  26 +++-
 drivers/net/ipa/ipa_mem.c         | 196 ++++++++++++++++++++++++++----
 drivers/net/ipa/ipa_mem.h         |  25 ++--
 7 files changed, 291 insertions(+), 38 deletions(-)

-- 
2.27.0

