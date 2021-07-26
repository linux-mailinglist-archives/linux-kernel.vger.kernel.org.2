Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A1A3D551D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhGZHcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhGZHcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:32:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD695C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:12:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n11so4748428wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pd0dKlBYHvLkVO2Zdl3GYa2e5hb4Ag5G614F6Ir3KS8=;
        b=yRKxCHGvx04XZB93foYYNe7JeZLlBdRECKOes+D8QtCHsA134aDyTRzbN1XAZtIzID
         R3QBhFan8+KewLzZuxRtKqyGPc//XpBp/ewU36YARCDqB7LzwZvvTaSbe+l61ZyuYn98
         UbVJBxtDro/ah6eSdIo8+qm+lLohQ96wxvvGQQ+viz+/CUEJe6yY29h7bWl0Jt9dqKoe
         ZqK0ovrSPFFcwORGo8JoXz2r2NNVE/6+uDq74iaK68uaPp38IOsqUP4l5Nz/urHUByyG
         vdIf/viF01NyhPEmdSL1Uh/+yQep83P5nXPLqx9atgkkA4fV/BAntDxJr7h2m9DPomjD
         x4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pd0dKlBYHvLkVO2Zdl3GYa2e5hb4Ag5G614F6Ir3KS8=;
        b=j94RtCkuaFG5574z+bbNprkoTXeTsSlYDruaLn3DLC0K/gS7zHDCTXONEbO4DCPbEz
         L6EKsT+wtRYJUs/Qp1Kz2DSZP2NWy7+YzV+h+6Sjjg2uBsrNan7Jj2SEtiW4KIu+rn8v
         7YGrBtOrQe0wPTahINriom1aAl883kTpdhdYIDGI9aXxkX0mSxmFUlzrvoheMyw/7THa
         TVJw5DnJAlGQnz3tMFNHlUyRGIC3bFCf5YVdA9iK6i665NDgVwUdYFGRNe9sIZ/WcyGP
         ummk0BIK3SxpPpmXn0Zf4aJhUM/lPcfma+0hP5T/+qlzqVpwVyuTy+63WEJBpIXOH0rp
         5TmA==
X-Gm-Message-State: AOAM532iUs2oGhvhhdApzhOMxjEvpLHwUfYKDq8mBvi+/bkkQ0qCMYc/
        dFnrJJAtg46bQMgXCckxL1070g==
X-Google-Smtp-Source: ABdhPJwrfl6rlxSgTjm42EmSfB6Tqb/I8WZ2O7ybCej0rK6/08EAGSHsuYV5OevD9Ebn3d6AggvlwA==
X-Received: by 2002:a1c:7314:: with SMTP id d20mr25217721wmb.156.1627287171296;
        Mon, 26 Jul 2021 01:12:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:32b6:aa71:d2df:4f1d])
        by smtp.gmail.com with ESMTPSA id c15sm646762wrx.70.2021.07.26.01.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:12:50 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        khilman@baylibre.com,
        Demetris Ierokipides <ierokipides.dem@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: meson8: Use a higher default GPU clock frequency
Date:   Mon, 26 Jul 2021 10:12:39 +0200
Message-Id: <162728713307.14205.9620047585632922207.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711214023.2163565-1-martin.blumenstingl@googlemail.com>
References: <20210711214023.2163565-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 11 Jul 2021 23:40:23 +0200, Martin Blumenstingl wrote:
> We are seeing "imprecise external abort (0x1406)" errors during boot
> (which then cause the whole board to hang) on Meson8 (but not Meson8m2).
> These are observed while trying to access the GPU's registers when the
> MALI clock is running at it's default setting of 24MHz. The 3.10 vendor
> kernel uses 318.75MHz as "default" GPU frequency. Using that makes the
> "imprecise external aborts" go away.
> Add the assigned-clocks and assigned-clock-rates properties to also bump
> the MALI clock to 318.75MHz before accessing any of it's registers.

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (for-next)

[1/1] ARM: dts: meson8: Use a higher default GPU clock frequency
      https://git.kernel.org/amlogic/c/44cf630bcb8c5ec78125805c9447dd5766792224

-- 
Neil
