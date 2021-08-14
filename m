Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219C73EC4F9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 22:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhHNUUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 16:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhHNUUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 16:20:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0383EC061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 13:19:51 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so21098381pjl.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 13:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mAtgpgJZGh5qZDIf6I2YBn2p3wmsbATJ34UD7KVweM4=;
        b=bS0bw4Nb73a6l7jcuM2wSDV4P0TeaiKE/QC1+0xoOtIlTgDbjac5q6rtGwB8Euyw7j
         9TGQP0A3Ykl4gyK2Hy5wyX72Mzwl8zazjXZ6dgUU4Psy9B3RpjDOT5kl+kLV6ffVbX5C
         2CDUqQqXEXJhCapE+J4G2939goYOMgEtYgX2LgCysAELwLyqR0PYiy11PWVlmxvbtaKx
         RBiXADztgCXYZibRjY3NkraMFQxVhK0ncsWN47nuDpnSAv8RdIBZUONo/GSU34hKclSx
         JQfrCmli4QVEh7fKwXZmpCI/SzZ4k+jl/A7WrLy8mfOLF1joLAqYH5dMZrsBJjbc5xI8
         ty+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mAtgpgJZGh5qZDIf6I2YBn2p3wmsbATJ34UD7KVweM4=;
        b=VyC1fgJraGr+po0HYfJrk3kYXjhUdfM1S4wGYBe13JGyeOFFq8isTvpgvAg99fmvWi
         HldH9Nyf6c/TxyuDSbQze9H4sd7gf7ap2wXY7E+MOke09ZWx+Z2NaPzdtyVI9zBAVBYW
         W/f3Y0NQViCdeoXGHsVw6ghbRKm/DgK5kpxcs5CHk1J6cSKs08cLt6YBzphnmNLVERjy
         pxf1fj5DOehhpjtICIQxLHk4qUcY2JrHsEjUEc7+2dTUMefM5W+845x2CT1akKhBRHfz
         StcwwtoXG8CIaPdSu+U7qQCkanMTABH8bhimwKzueoALpBShMmD9WWdZqE1c2FyiaHm4
         nTfw==
X-Gm-Message-State: AOAM530Jh0pOBpERw3G1RUiXDVeAcqCp13l9/Z1NnE96on5iHEivk+VN
        R7TZAnREcRoUBtjnfFtC++Q=
X-Google-Smtp-Source: ABdhPJxhPvqKjOaL6Gm/B7DK5CcgcrHKajWNwm/TbgU99bhnT1KC0ts35LjRkITbB9hyun/unyGbeg==
X-Received: by 2002:a17:90a:2802:: with SMTP id e2mr8871836pjd.215.1628972390593;
        Sat, 14 Aug 2021 13:19:50 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id u13sm6413121pfi.51.2021.08.14.13.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 13:19:50 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Jawoslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>
Subject: [PATCH 0/3] ASoC: ti: Use of_device_get_match_data
Date:   Sun, 15 Aug 2021 01:49:38 +0530
Message-Id: <cover.1628972198.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	This patch series will apply cleanly on for-next
Prefer `of_device_get_match_data` over `of_match_device`.

Aakash Hemadri (3):
  ASoC: ti: davinci-mcasp: Use of_device_get_match_data
  ASoC: ti: omap-mcbsp: Use of_device_get_match_data
  ASoC: ti: davinci-evm: Use of_device_get_match_data

 sound/soc/ti/davinci-evm.c   | 2 +-
 sound/soc/ti/davinci-mcasp.c | 2 +-
 sound/soc/ti/omap-mcbsp.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.32.0

