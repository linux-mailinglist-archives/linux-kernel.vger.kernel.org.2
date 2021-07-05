Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D163BBC23
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhGEL1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhGEL1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:27:52 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E531C061574;
        Mon,  5 Jul 2021 04:25:14 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id y17so17978442pgf.12;
        Mon, 05 Jul 2021 04:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5O0fSJhaUzvQBS/JvZu/NJClK6d4varvuShuvbKWaFk=;
        b=kFqMmoZoh8a0/xcYGHZ+zRDysUQBRHcs5T0gDEqAA+al4IGat9cHr1XU1S5XVwXzLA
         uo5MiUMGtf4TQBD5prNba4pon/uJHm25f6+YhwYftINCPjPB6oHsgE5T/68gsDOiuKNo
         2mMqxc966jXfKamCK/ssEvEpKy0PJlpt/yQ5hVNyga/DViPeehIIwUaSZ4Aju0P4Kpw1
         GEW/ICOJhPR6VXDDKfqMZt8c9gTqfOdoM2q6ex1Yyaggpc31HHkqrz5+t83eqmyVdgB8
         OZwF+wBqZR2coEez3wH4uF0iW4or0LfvsHX58sKqi5A7z52WWWshhJDHz1+byd9Us+VC
         ZeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5O0fSJhaUzvQBS/JvZu/NJClK6d4varvuShuvbKWaFk=;
        b=g84AnVARyLsn57xDLR8XMcmgixHQEmbjKZYS7QJVaMR+YlASfBbBlaOqWxDkgTBVKA
         SWRpKEtBkRhs8t5MSDbwyGkSt6oq09hyeSD/N3yaJGl0Khyosnri1EsM1gkyoPjELPdf
         +sPIDQ1dyOpjP/hF/DC0SdrBwE9CHBGXzx5exLivON9uwzIhIC7ZAI3vBI4Rpg8VWEUR
         d77flL7AMm97ojm5eCdEr06jdx6MhEGZ17am5CrUFBKffh/eaiohWz21yptdfWry8ekC
         oGZdKIW5cIi+dy0byrbmTljooUdAP5Ywb7lYWO0151iir6ABG1AXRYkgs+kXYLvcyxlz
         zQew==
X-Gm-Message-State: AOAM530dW2is1JuHPu+7dZ9ruBIeGaEivsrw6TeYFSSF3KOr1xQwPfo/
        1TNhgnlK4yIFlfbIv94ZyIs=
X-Google-Smtp-Source: ABdhPJxnlaG524ObSrCFPEQsAQnTM1rthDLu6NOwfUx5Q9n7OL6ckReIPpid0igp+v8DCbTY7ebrcA==
X-Received: by 2002:aa7:968e:0:b029:319:886f:fc2e with SMTP id f14-20020aa7968e0000b0290319886ffc2emr12728779pfk.49.1625484313903;
        Mon, 05 Jul 2021 04:25:13 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.31])
        by smtp.gmail.com with ESMTPSA id gi20sm20976959pjb.20.2021.07.05.04.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 04:25:12 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org
Subject: [PATCHv2 0/3] Fix the pwm regulator supply properties
Date:   Mon,  5 Jul 2021 11:23:52 +0000
Message-Id: <20210705112358.3554-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes PWM supply properties help fix internal link of PWM to
main 5V supply as per the shematics.

PATCHv1 below
[0] https://lore.kernel.org/linux-amlogic/CANAwSgRD9_B7f5UjPrxeL+x-eMMc2MAG3tXLQw36x0ho+ba_Uw@mail.gmail.com/T/#t

Thanks
-Anand

Anand Moon (3):
  ARM: dts: meson8b: odroidc1: Fix the pwm regulator supply properties
  ARM: dts: meson8b: mxq: Fix the pwm regulator supply properties
  ARM: dts: meson8b: ec100: Fix the pwm regulator supply properties

 arch/arm/boot/dts/meson8b-ec100.dts    | 4 ++--
 arch/arm/boot/dts/meson8b-mxq.dts      | 4 +++-
 arch/arm/boot/dts/meson8b-odroidc1.dts | 4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.32.0

