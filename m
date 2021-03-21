Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B91234327A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 13:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhCUMdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 08:33:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42190 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhCUMcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 08:32:50 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lNxGC-0006Fh-Me
        for linux-kernel@vger.kernel.org; Sun, 21 Mar 2021 12:32:48 +0000
Received: by mail-ed1-f70.google.com with SMTP id a2so25731766edx.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 05:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DHDU1gpmqjBqzxNCjS84KWsrFmwDGuzbA71vwv0Ay9E=;
        b=UlyaFDyjZCr9TisRJKIVCYuLgqAC7AhtTEPkQbPTRnpjod1KYxMvwhOpL6y/xq3TSl
         Lqb5Vc+O/OjedwtnurNUmE66pqPws4LTXA5yN4iHTaQcKKRcUtGZHd6Xad/7tmJID63J
         snUIkh6G/oM1HinAag1B5r7GlY1kH1UwPs448TY/r5XrmP/HNufNTNv6BXF8/orQIVmU
         7E9K3WrAjlUFEOhrw6+SpDSgt/rpdJUmSix4P/cR1z6R9m2JVhLsmTAkc2PPTe0VRaqV
         icEY6SP8fgDbo+sWeFC/fPP0CgSNLh0FfHqxkX5W9Me4qDyHH0Eq2eUr5j61CTtbtnJV
         0SBw==
X-Gm-Message-State: AOAM533tQBUfIGSjK41vOTQuo1ZCaG7jg2ZmwhcCmPKkRLDEczEWuzAa
        5TI17zqQeYF4tHKD+mWyFSL6z45Y0RoivUtkYbPibhTH+hGOKuq5gbDH9WcjPLW0V6yn+ib8AcS
        uikZ30FrscK8qlpKgNjML2s/BxZOSOgKp2mgHRKdHYg==
X-Received: by 2002:a05:6402:c96:: with SMTP id cm22mr20348066edb.128.1616329968501;
        Sun, 21 Mar 2021 05:32:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxoIGalzy0JccsRimagJT0ACtL9Y8MX1mohERXbGYiACXa1JnGvXydxGnKMzL4DK1G1QP4Fw==
X-Received: by 2002:a05:6402:c96:: with SMTP id cm22mr20348048edb.128.1616329968354;
        Sun, 21 Mar 2021 05:32:48 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id p19sm8214849edr.57.2021.03.21.05.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:32:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] memory: tegra20: Add debug statistics
Date:   Sun, 21 Mar 2021 13:32:43 +0100
Message-Id: <161632995761.4145.7861266441612493358.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210319130933.23261-1-digetx@gmail.com>
References: <20210319130933.23261-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 16:09:33 +0300, Dmitry Osipenko wrote:
> Add debug statistics collection support. The statistics is available
> via debugfs in '/sys/kernel/debug/mc/stats', it shows percent of memory
> controller utilization for each memory client. This information is
> intended to help with debugging of memory performance issues, it already
> was proven to be useful by helping to improve memory bandwidth management
> of the display driver.

Applied, thanks!

[1/1] memory: tegra20: Add debug statistics
      commit: 1ca59ca0afde17b75adc519858ccc30375cfad1d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
