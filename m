Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F2C3B0997
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhFVP4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhFVP4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:56:14 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1148C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:53:57 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id v3so14833818ioq.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Umc4sWsDnV3E9dkp2D6Lf7jpm4wZpHbawbe0BbsfyjQ=;
        b=a9yJqt2BZ2t2MDO4kGRIpXsAEVZWE7vIE7Nt2dJ/XNwLsYRGxh5Nh4LT4oHH3mWMIE
         SU71pitQAq11v0g54LT52FbEu4dg3VU6asksFLM4KWS1WV5VaTzcv0zuhBaoXWSiwFU4
         GSJ8j3RTvTN554gm0k21flTX6WubLgTYDwB2hDFVXRILHCZsWTaIpgk+HFeuhLuDsBrm
         3zdH71YWvJRudeZ4PUUkvFnilzObWTaB2qUjWs464a2qJny09dM1mTTLOeHKGbaM7MLQ
         hudnPSND/ilGhN/jiHUgRtintah/IIfY2RQxxQ4c++Aw4KcwuG6s4DXroUqjr98iJ1Mh
         8pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Umc4sWsDnV3E9dkp2D6Lf7jpm4wZpHbawbe0BbsfyjQ=;
        b=Ei+r8DdOQZDJ2g0NJa0VYXJGdI82M2V8P0vEkUL/lRPeZDZbFr7osJ7eIG0sl7+EVI
         U8+ZxAQl+ZTX5NHVx01qH3S836Q2DNaAVxaE1RbVxZtVXS7y0bdR0ek54vQnH0aFINNZ
         L6a639QJmIZCpGvMs5XWv1zPfGbr++WRZ9EoWhOMrbdS46AfH+LKv1r2yaqJy0RyJLI9
         7mXmWKt5GOZYz5rmoZZmACZahMPIlBPAdt1LepKdOnpEaYDlOfxbviTmf+l7WY3xpQbv
         kHUg2ARfymfM6tZTW+BI4aKEAgsNkRxXy9PwyHjkNBmi2ERNhzm4tg3JiypkAY0Q65vM
         ciDw==
X-Gm-Message-State: AOAM531ByCmTSHCyItAGIVeF9xANV0DTD+R4b8EExNsgR9e6zZDWIPOW
        1cglmd24k3XBX+PWIEBVl24=
X-Google-Smtp-Source: ABdhPJybhZcceVuAq9l1pSv+bPD7hz6H8VrIXkAsBL245tiYdEFH3+R8PbBr7b1X8eiwT1bH/so0Qg==
X-Received: by 2002:a5d:9414:: with SMTP id v20mr3477008ion.66.1624377237182;
        Tue, 22 Jun 2021 08:53:57 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id z3sm11951776ior.14.2021.06.22.08.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:53:56 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6A5A427C0054;
        Tue, 22 Jun 2021 11:53:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 22 Jun 2021 11:53:55 -0400
X-ME-Sender: <xms:kgfSYEr4XTEPkXkwA6CZSmohE8D_D4VZddbn2visH4FlMb6sdLJ1tA>
    <xme:kgfSYKpPQ8o1l1P8fRe9TdZOGGVLWn91ZPrCU1onqbiks_G5_fnki3zqW5puk8Iv9
    go5ylaGwK2haDFPCg>
X-ME-Received: <xmr:kgfSYJP_U2wo0jULlPTGWOhZ6RJEF4sRr5bc6T3EGFfehVqXOAshAmhgWOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeguddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepieejhfelvddtgeduhfffueegteevleeugfekvefhueduuedugfevvefhtedvuedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgv
X-ME-Proxy: <xmx:kgfSYL5PyfEEELNivW3CESoLVDia1sQRM8j7gDij7T1Iio-TvkIGAQ>
    <xmx:kgfSYD5sx1NsYzQbZ8f2PKElAeK10emQKao_jh-CMVvQC72O32GqWA>
    <xmx:kgfSYLhmN-XK4rG0IrbGMvz19Pzcw_9frilKF2LeT47j7ciMqm-_EA>
    <xmx:kwfSYGYYKK0Rl-1BuvQxzePIs66bpydLP7wPyLNktiYScICmmsc5oA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jun 2021 11:53:53 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 0/2] irqchip/gic-v3-its: Introduce virtual ITS
Date:   Tue, 22 Jun 2021 23:53:11 +0800
Message-Id: <20210622155313.3819952-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Here is an RFC for supporting platforms having LPI supported but without
ITS. And this is for the virtual PCI support for ARM64 Hyper-V guests.
We currently choose this approach (LPI w/o ITS) because a) it's allowed
for GICv3 and b) ITS may not be a more efficient way to configure LPIs
compared to hypercalls, but we'd like to get feedbacks from the
community.

Besides, patch #1 fixes a bug which I found while I was at it.

Looking forwards to any comment and suggestion!

Regards,
Boqun

Boqun Feng (2):
  irqchip/gic-v3-its: Free collections if its domain initialization
    fails
  irqchip/gic-v3-its: Introduce virtual ITS

 drivers/irqchip/irq-gic-v3-its.c | 124 ++++++++++++++++++++++++++++---
 1 file changed, 115 insertions(+), 9 deletions(-)

-- 
2.30.2

