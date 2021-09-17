Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AB340F352
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbhIQHdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbhIQHdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:33:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B28C061764
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:32:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 70so3630977wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2THikK+ZWL+RF3hVyz41egxjiPVtWjXYvxUpPXvBXFY=;
        b=5jTefkWXREWF2cGsPQ1xqboI1NOUcMMKqOp5GGGKX00o++JvixQQFdZgiGhbfPztZW
         AWuZRDnm+43FAef/op1HcpXS5j5SaqtpytYaUTTWGt26kR8idjX3hjDIm4xd77FB0yOf
         Zg2uVfTXBQwBb+UVwlX7pkgaC7U3ixigzPp+XHaoyGFnz3Z+NiQe/JeGlrbFf2WhUO1x
         HwGLMSBt8273hll9oKHJOn9F29xiTgehodeF6NF6jCzz46EEzqGDdxK1KrLSAcsB1RXW
         T5PZBO1tvfEfNlGA1jrDFfX5T9SLQsmJ71rhoG0BZFNYdTStf0bJbkfrrKLlEc7BfmlT
         jVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2THikK+ZWL+RF3hVyz41egxjiPVtWjXYvxUpPXvBXFY=;
        b=KGHPti/cs7TY6/cNqv5khCjb1PegBuyhU05nD4DMOFWJ8ETORIqjqhTlqIltVJlpcN
         vUnyN6U8UtRcLRf2DxdKLwHI9Pkubyd1qp4lwbWsMzfnlV1VYAJfQkNXQvgJFW24J9ds
         NEVAJEimwF2eTmU2zM3RCKAnJFNBCeByAkY1OWxfEmEmHCWPE504JiJ72bz7AbLoXVzD
         qbAr8CT7jWdmKzjoVgmJQphOaRjeFIIr4a8F5Zjrh0/C2ykPYxxRaBliqyEzTDr3p/nH
         A50IRGR+2vdFfim1k24AKxUB0WYPG6Aj/+yx0xd7wwPkqrxuXptup28pdxeMyxkPGasa
         MlXA==
X-Gm-Message-State: AOAM530DuAiJYzCsR79uO3Ni6Lm/3hYkvkZ733QQCVQnfn5ZEVS44+JM
        BZW9w9np6etJHTnelYe3VVLvFw==
X-Google-Smtp-Source: ABdhPJwRGFW/dlw8u8+sISzcx3AX9UykA/D7q41zATuitAWDOLHohqdL50iGXLQcC6es+k30msM6wg==
X-Received: by 2002:a7b:cc0b:: with SMTP id f11mr12363412wmh.2.1631863937090;
        Fri, 17 Sep 2021 00:32:17 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:7c8c:5a9b:1b6e:1623])
        by smtp.gmail.com with ESMTPSA id d8sm6148326wrv.20.2021.09.17.00.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:32:16 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson: add audio playback to rbox-pro
Date:   Fri, 17 Sep 2021 09:32:12 +0200
Message-Id: <163186392856.1051643.15826774789936581584.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914151631.2841-1-christianshewitt@gmail.com>
References: <20210914151631.2841-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 14 Sep 2021 15:16:31 +0000, Christian Hewitt wrote:
> Add initial support limited to HDMI i2s and SPDIF (LPCM).

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.16/dt64)

[1/1] arm64: dts: meson: add audio playback to rbox-pro
      https://git.kernel.org/amlogic/c/9450f63ba4d1915d8d605bad6454fc82522d95d7

-- 
Neil
