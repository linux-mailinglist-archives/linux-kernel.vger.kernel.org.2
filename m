Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EA03D551B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhGZHcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbhGZHcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:32:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2665DC0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:12:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g15so10006387wrd.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4tEJ1EXV/Vdj/aCsuc1acozXg5J8k5N2sXI1v0Cr20c=;
        b=e25I2djGYRs0cUrhNFDYhZ1z1GVsJrH7VpwqSAfKS5YX5c6CASIGCQRY7f3oCDup4u
         aosNR86/MvXBkx7k6ytr8EkWxebxzvsst3gIfun3OLhfxfQybtKbAl0XDl8DpKubZLT1
         f/vaaLEyxSO4AJQu3KRivSOvoYM1ya7oManS63VlsB7T1Z2pOu4NskQwsieRdZ2zJK+5
         QPEblBLEwzzO3KutnQyXSf95omkxXwXUXgfBht6JZL5GnnQlezINWI3byjl+6fGvExWW
         zaN2B6oXU2GxTTUJBx8SVAPwcbBkWySM3YDaZudUoXKOzDh8oXVEyLfSI2J6zZiBV5Gg
         zhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4tEJ1EXV/Vdj/aCsuc1acozXg5J8k5N2sXI1v0Cr20c=;
        b=Z7BytdGqBnf1gF2XF5nJ97qNokB4AjNMV24s9fXCYmE9KHH9/LTE5oRoBIVXbO0Q5M
         vFT7xKY7CdQolHsb4Tau/0H8Lg+14b1MwJHQfIPHHLs8pbqCXcGIqYlkH8RxG4m0Juge
         CPyGAJc45z74pvmDtpyn1/fTmiwvEaPYMmrlE/t4Rgk4XfpsReRKSr6NFRmT+TkyOgko
         GioSLuRoN1Oz2VVw9VxPPmTyTl3ITvAbIdFyZNInpsMVncrkI+b+yvd5OeBLTB03yb6G
         BVcyVuRPNKwMCaSMiynZqBjXkn1bAaprf3vVsVLRfBo8Btxy/Zs4TsntIZEw0pdeLUxo
         MNPg==
X-Gm-Message-State: AOAM533r+Sa0amC0aB59y49vUFQG+W1vXhaVjLhb0mKQRQpeTdTW5K1r
        Z0NkEheVKRIbzS5NSqQW4PrbkQ==
X-Google-Smtp-Source: ABdhPJz0jNUYacAEh7/L0p/4gEnTv2gAafJV6dTmoqoRNJUxeAdokinO6yIuuxegyZMMW1jIsORE+A==
X-Received: by 2002:a05:6000:10c3:: with SMTP id b3mr17868370wrx.271.1627287169725;
        Mon, 26 Jul 2021 01:12:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:32b6:aa71:d2df:4f1d])
        by smtp.gmail.com with ESMTPSA id c15sm646762wrx.70.2021.07.26.01.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:12:49 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Anand Moon <linux.amoon@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCHv2] ARM: multi_v7_defconfig: Enable CONFIG_MMC_MESON_MX_SDHC
Date:   Mon, 26 Jul 2021 10:12:38 +0200
Message-Id: <162728713307.14205.5671227677376567217.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715092233.1084-1-linux.amoon@gmail.com>
References: <20210715092233.1084-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Jul 2021 09:22:25 +0000, Anand Moon wrote:
> Enable CONFIG_MMC_MESON_MX_SDHC so that SDHC host controller
> on Amlogic SoCs boards enable support for eMMC and MMC drivers.

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (for-next)

[1/1] ARM: multi_v7_defconfig: Enable CONFIG_MMC_MESON_MX_SDHC
      https://git.kernel.org/amlogic/c/c8cec81305463d042d51af946b6b273d8367626e

-- 
Neil
