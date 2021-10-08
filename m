Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF70426C62
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhJHOJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhJHOJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:09:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BA9C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 07:07:59 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j5so39893841lfg.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 07:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LM8exXLD+iGuyAMHH60gDe9grHMgI1JcUjlMPF2x57k=;
        b=wAIKT/OncDDU+q8mVwqj4X35J7BFH8ELaEOdEzvEv3W0NbgxVugDsVUMEqKlohkPKh
         RHzCsflFbWooMg9e6f282ohA9VC2MXriO+a79584q6Y+Hsbg+LwkLCo583NxX2I+xrGF
         f52GTnVmhZW4vTU61p8cgoQfZN/fyyVHMOb7kLd8v0EnUNlIsDpSCvd7/rFWH/yW96hF
         1VRWSKb3GnOblia+mjfXcQea+CozHQWm09MW7oL71UIZfXFmbbK5iSl5sbJswwZjl5bX
         BJq8loVlSMGzLdsuPaOm6QbCrRBSfWeQl47EjIQv2cOimOxP3jocea3XP5BS/icLE6oy
         kLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LM8exXLD+iGuyAMHH60gDe9grHMgI1JcUjlMPF2x57k=;
        b=sSEEISdI4dfnnNA7JpiWE7PD20/lTxA0Nfw1M8zuRP1NidvGoxetEoKnH0arCDM2GA
         HF/UvMfo51mNXHEy6PYeSxBCZYDWaYLoOgbreBU9PWLlp0WXZGiWQz4w1r6VpnB1njzl
         bvNTmOawm6euuzqt3mAi+DxdeP59tjn85yYpEgda8vVDXFxuYKE05Zhc9kwstQsSHzux
         IEtkymZf1+kx/D1mvs1aLxc/EcOZ6YsdmPIIOd1BfWtmRFaj5zoqgQ7wxWzFHlN/NbS0
         CgmDOoVElfCXuFjXJVfhL0zDCYaJa1opMsX1KsCAUs5s21WanVwwZq/clWRa9dSj1A0y
         7Gew==
X-Gm-Message-State: AOAM531zIKISxfl2fYgpkVyUvwP9+Sd1+911ZlD2HLfkxtuHCcveNoKX
        bLnZU3NX+l95ZGwZ4j9TukUnkQ==
X-Google-Smtp-Source: ABdhPJwqlRgCQh8TR4LXiGYJmEDK2IdsjYET0MnbpUDaPuZrXzxm09QRxDQ4ZXpaCtyZC1PRrAa1yw==
X-Received: by 2002:a05:6512:23a9:: with SMTP id c41mr7918952lfv.298.1633702077040;
        Fri, 08 Oct 2021 07:07:57 -0700 (PDT)
Received: from grasshopper.googchameleon.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id j23sm252667lfm.139.2021.10.08.07.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 07:07:56 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        dinguyen@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, upstream@semihalf.com,
        mw@semihalf.com, ka@semihalf.com, tn@semihalf.com,
        jam@semihalf.com, amstan@google.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v3 0/1] Add support for the Mercury+ AA1 module
Date:   Fri,  8 Oct 2021 16:07:34 +0200
Message-Id: <20211008140735.3290892-1-pan@semihalf.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add support for the Mercury+ AA1 with an
Arria 10 SoCFPGA.

The reset controller patch was added into Philipp Zabel's tree:
https://git.pengutronix.de/cgit/pza/linux/commit/?h=reset/fixes

The i2c bus numbering property was replaced by aliases in the
devicetree.

Paweł Anikiel (1):
  dts: socfpga: Add Mercury+ AA1 devicetree

 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/socfpga_arria10_mercury_aa1.dts  | 112 ++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts

-- 
2.25.1

