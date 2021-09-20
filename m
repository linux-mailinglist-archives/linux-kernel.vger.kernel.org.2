Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5701641110C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 10:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbhITIgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 04:36:02 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51680
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235893AbhITIf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 04:35:58 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 153383F4B9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632126871;
        bh=QOuDhjEYBpbLsCkja2E5kIg84mTo7Mp3bww45iwZuuc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=g6JzfbbWEYxZz5ei2fucQV+VI0c0khFzhk07yLSYQtm8jvpeLkcnqhpOd1nahbCBz
         c/gOVi6jRd3aDRVkdbJIPOcgs5rLbl/9jgTyMwD0+sgvwlTKpMvpbPSpWuaCHlvUoR
         lsvy5EttoMxjdNiGKHjoJVnKdxSE8pkgQVvXVwI/fLhf1B+QwoiYU0Mzqw9sNp/17Z
         VaKKApmuLrO54yen2Uu5aW+hpwxdc/EXRP3LR569TozsIPKFMxlUv6qrG4qajLZJyj
         nTIxn0fA9z03PY0QfRC9J3zBl2nkF7ulK4wNkjdTgzzXQ67p3zF7Zwwgqt7n4g2boG
         gk4Dui88ZIcFg==
Received: by mail-wm1-f70.google.com with SMTP id c2-20020a7bc8420000b0290238db573ab7so5466714wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 01:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QOuDhjEYBpbLsCkja2E5kIg84mTo7Mp3bww45iwZuuc=;
        b=j/hFE368BGtzSUgPHiLpqLpVMSkYbjufuLHF8dHRKcbeevipQIsmO+ERr3Eg+jxj4z
         0lVDhJWiVYvah5d3L5HhisLXPbVakUt8YDnu8gO2qM4WJriI1Z1ZbedC/KxcEFmUpgdz
         M9NZLCF3wsBeywLlPMIWLuiZaEm3AcUrNmT98zBIu61wL2cvL4RXi3wHQtWA6CGJykHd
         d5b9Ups9nOLyYrjPc3AMr8XvR8xnH0zxw4ful2ijX1TwNjmP19B5EhqHVKEL0zURwIRS
         l0RStgmLapymfT86G3sTuVpPA7b4fbp9EfB/TIpvH4cts2PTLDIAxujkknRSvRgYGt3d
         rybA==
X-Gm-Message-State: AOAM530MDiqPN4sMLZ6wI40Fgdu3Is7YTBmQhxV9F4oLxYauCn9tk7qX
        C7jbid3sIVaNfWmzqUs0+/ZsojzVh5VEqLPKLpviuaxAbSAAqgIut5cYCeDov1kYbax3SY0W0yv
        mXuApKSM36Fdx+KtEju9TU9acjfI7CZnBZgmDuWzPbg==
X-Received: by 2002:a7b:c0d1:: with SMTP id s17mr28624755wmh.139.1632126870599;
        Mon, 20 Sep 2021 01:34:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/Z8xXI2Qq35LGBSF3xaoKtEJihngmysxU/0sHU8yCajr8fdzEoTawRUZVVBarprNDrWcgkA==
X-Received: by 2002:a7b:c0d1:: with SMTP id s17mr28624744wmh.139.1632126870473;
        Mon, 20 Sep 2021 01:34:30 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id v188sm4658891wme.38.2021.09.20.01.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 01:34:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] memory: tegra: Remove interconnect state syncing hack
Date:   Mon, 20 Sep 2021 10:34:26 +0200
Message-Id: <163212685894.112070.3043725946674605837.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210912183009.6400-1-digetx@gmail.com>
References: <20210912183009.6400-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2021 21:30:09 +0300, Dmitry Osipenko wrote:
> State syncing works properly now, previously the sync callback was never
> invoked. Apparently it was fixed in drivers core, so let's remove the
> hack. The state won't be synced until all consumer drivers of devices
> that reference memory controller in a device-tree are probed, i.e. keeping
> bandwidth at maximum until both display and devfreq drivers are probed.
> 
> 
> [...]

Applied, thanks!

[1/1] memory: tegra: Remove interconnect state syncing hack
      commit: 77b14c9d05bd72d6a3f11b4982591d6cb0090ffe

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
