Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1D03424A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhCSS2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhCSS2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:28:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1EDC06174A;
        Fri, 19 Mar 2021 11:28:05 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e7so11845760edu.10;
        Fri, 19 Mar 2021 11:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W6jXeRNDOcegTzfjmtjhnShpH4QsKc8qKRMmcEjm3N8=;
        b=hvq5QBPnPF1k3QdamFVPBw5XsC3MJAkglNpleZbNU95fXD5xnaE1YynFB0FbtycKJP
         rBUrq8eSrQaXZrMh8S8aFN6NR5AI68livmOpCsjlTzlbEwH9pCTcksJx18qoBM3d5Hyl
         edMfzCJ66QLKMUp0xbLHZG3xsWoZcYhKzkvPMzATwEuRQbGIbaCx+q7LdxdBCM+/1234
         eWIVC5hqgQwXsJFNL6GKv9GfPnPpMdGsDChS3j1F9AMJ2Ui8ZIJt79KJnQ6jSQbTIYQJ
         PU1o6IvHcv3FBNLFIBRIGH0umyrFNy17TEpP2jXBh6iJaGpOF6FeT9993FXIC1wl+Ri3
         KowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W6jXeRNDOcegTzfjmtjhnShpH4QsKc8qKRMmcEjm3N8=;
        b=eBIU+z5J+t0TYaKFcdy0iisW5k74huEV2pHIhtSwK0bclhO61YUjlAyrC8ZyGFP9Kn
         ISUIUKSF5MS22opLTxnoT+rDoXvoaxSUlRBIQu3xyfSMOFglrLjd+YWQNxqNkSAkkAsb
         Csud3sQHesJwp4VvW61g45nrCNpIVJzaStIifyeFUHpFcIJnWWr9o+zVHrnqq340X1i8
         l8b4WZGFjS1rQlPAynN+l0d0uEyHQXoxtkS1/vfU2DQwFZ0ve3aoksT7sJmOuO3LGdp4
         CygdwbXGA+SglCb6M6JYaCr8Zd4+JHFIyxpd7LOAHLBT5WUFcBv92TD6AT5fTBfQTNHA
         g/4A==
X-Gm-Message-State: AOAM5315F29ymwUtjhPHI4dF/Ba9okmh4asv2dHBwZdnavpkd4hm9iK2
        f7dCAZn53Wyi3NbjlscW6Zs=
X-Google-Smtp-Source: ABdhPJyMLN32+Z2D+l+3U+KFdeiR26k3dajXDSBJk6CeH85m6WS0WaZTxr6qBzhEvzrK4RRp9LvVHQ==
X-Received: by 2002:a05:6402:270e:: with SMTP id y14mr11140411edd.283.1616178484430;
        Fri, 19 Mar 2021 11:28:04 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id gb22sm3951070ejc.78.2021.03.19.11.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:28:03 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add support for Actions Semi Owl soc info
Date:   Fri, 19 Mar 2021 20:27:58 +0200
Message-Id: <cover.1616178258.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a socinfo driver which provides information about
Actions Semi Owl SoCs to user space via sysfs: machine, family, soc_id,
serial_number.

Please note the serial number is currently available only for the S500
SoC variant.

This has been tested on the S500 SoC based RoseapplePi SBC.

Thanks,
Cristi

Cristian Ciocaltea (4):
  dt-bindings: soc: actions: Add Actions Semi Owl socinfo binding
  soc: actions: Add Actions Semi Owl socinfo driver
  arm: dts: owl-s500: Add socinfo support
  MAINTAINERS: Add entry for Actions Semi Owl socinfo binding

 .../bindings/soc/actions/owl-socinfo.yaml     |  71 ++++++++++
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/owl-s500.dtsi               |   4 +-
 drivers/soc/actions/Kconfig                   |   8 ++
 drivers/soc/actions/Makefile                  |   1 +
 drivers/soc/actions/owl-socinfo.c             | 133 ++++++++++++++++++
 6 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
 create mode 100644 drivers/soc/actions/owl-socinfo.c

-- 
2.31.0

