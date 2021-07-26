Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3FE3D551C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhGZHcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbhGZHcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:32:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B248C061765
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:12:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so5655236wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yq3/Usg23HBuIMfDTsX3A2d2AdqpGJKmC06vUXWwG8E=;
        b=CzQF+6G19IDqt6+jnnEAWeFDqZiAtBSDlznMfDlFQyG/wd74/mcrVc9W/M883ZGDMs
         lqjUfRd+4wGHVSK7AujVAoZtIosvU1cjF02YuvMeVEzUzuw095/q8Xplw37MXi8EooCl
         R+f9dCokfwFQgLOONjvZ8X6+ykLNn27j4hQlPrzfB0DpL/4GMWGocAzrBfwMYmMWg/RF
         uOeOlA8NKWYqneKCf1LkDkVu9REtd0Letq/7/LSe1oRALiuz71D4n6iQEbknMp5EWyBN
         A555b/ogGegRzFxzW/cciWWFdxh5ue30qlVgvvNxKHpPk89xmIy2D/R5Jh4hym7QChAp
         6Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yq3/Usg23HBuIMfDTsX3A2d2AdqpGJKmC06vUXWwG8E=;
        b=qGQQshlhoUuBnXzVfTCatEIF96MzSHsF8dM3WKGQ9jOySUg387u2ssRfnskYRLtY4h
         URDYuE3xmV4UzSymPsXArFiMeh5ZF8238x7fDFw7ecHCVDAmVEUPBE+VcAEfkh8x3j76
         +8FJMRLQm2UyUIwj8e3wXcZ5vL6qw0lyNQxXxZxiugVy5JDE+fewVti8nK9irVLL2675
         0dNfkDO9YiY/52KyKkr4AeIkNfabocdTF4+QBCw9eaKPoaH70Zd1SqlNgekNir6ni+Ib
         qNyj2M6nzw6XYa0nHq+CQh8H5Xp7ex6pZmmOGAT8U4hWVA/1R8WQUsKwdSG246JsAOZ2
         aEWQ==
X-Gm-Message-State: AOAM531aLYDxX7r0B8Hzij7TEPS0IPyj+E3yZZQAKR6jwaqMdBQONwQW
        8PJ8jjId63sT+lPweTdI0d09tg==
X-Google-Smtp-Source: ABdhPJxx3eMucSN49AJxrsYAM/bzg6uYgeTTFscxgW1oSmdLnxJP1ucK7mNwiZf31V86inX3IcD/RA==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr1209192wmj.63.1627287168602;
        Mon, 26 Jul 2021 01:12:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:32b6:aa71:d2df:4f1d])
        by smtp.gmail.com with ESMTPSA id c15sm646762wrx.70.2021.07.26.01.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:12:48 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Anand Moon <linux.amoon@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCHv2 0/3] Fix the pwm regulator supply properties
Date:   Mon, 26 Jul 2021 10:12:37 +0200
Message-Id: <162728713307.14205.16664284438953464220.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210705112358.3554-1-linux.amoon@gmail.com>
References: <20210705112358.3554-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 5 Jul 2021 11:23:52 +0000, Anand Moon wrote:
> Changes PWM supply properties help fix internal link of PWM to
> main 5V supply as per the shematics.
> 
> PATCHv1 below
> [0] https://lore.kernel.org/linux-amlogic/CANAwSgRD9_B7f5UjPrxeL+x-eMMc2MAG3tXLQw36x0ho+ba_Uw@mail.gmail.com/T/#t
> 
> Thanks
> -Anand
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (for-next)

[1/3] ARM: dts: meson8b: odroidc1: Fix the pwm regulator supply properties
      https://git.kernel.org/amlogic/c/876228e9f935f19c7afc7ba394d17e2ec9143b65
[2/3] ARM: dts: meson8b: mxq: Fix the pwm regulator supply properties
      https://git.kernel.org/amlogic/c/632062e540becbbcb067523ec8bcadb1239d9578
[3/3] ARM: dts: meson8b: ec100: Fix the pwm regulator supply properties
      https://git.kernel.org/amlogic/c/72ccc373b064ae3ac0c5b5f2306069b60ca118df

-- 
Neil
