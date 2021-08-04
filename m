Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AB33E013B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbhHDMev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbhHDMes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:34:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02769C0613D5;
        Wed,  4 Aug 2021 05:34:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so1356388wmb.5;
        Wed, 04 Aug 2021 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T7y3XoKx560IIuodiyJF+1EGhUXPpmwekuXB+OdFOz4=;
        b=n9pC7MBO5MmUgT0EmL1pM3aubyN710oo5qB+xQyN4X08wASge/2ZfbZxlzjE44VIGo
         T67r9ZIvHM/DUgjzYRS7FrTsh/SckcDlVpBERW1U1c6Vm2Z1EitptWOettxtzrHA2PCK
         Oo/EZUN9+1hpVsezW80/mGWzlhD+26IqCvDDute+uNiW9l75iO2gPdB4uQWUArAIT7Ht
         /Afs+yrXrAG4Uvg1O5QNNKIs/855OJynS3H3M9luymfLoR9h96ep/n47F+bjyxYmj5m7
         a+RsMM+h3kEeEmq+aUomXofG3ZBsZWmHctO2CZV8BmC//Bhi/1EFoaY9V97eXiorZz7S
         yXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T7y3XoKx560IIuodiyJF+1EGhUXPpmwekuXB+OdFOz4=;
        b=GuOy/OX1PiTcgQ7R1hMb38/SoS35YPKrOJMxO3+MkDxTEG5mdOCoxDUxSfnksOCFY8
         rLMlRG9KSn8Yum/XT1bb7U70NuTJfbwqKVsWgaDiNiI/cSVHITsnpw9hkETx8YuAwLQg
         NF0M5T5xvOgTa98kzhWoi0hnmfVjVdJ9Lk4nla1aZhHQnWgULgxwwmo+c782JlckqAg2
         X7BOoIV10U3B7GD5+AoRTZoJqtZaOKsHi3cer+C0NaNr8GwdFau48xyqBeQBp5V/l2b7
         PICdNRFlzzVO+HxUf/ucVklYXiTsyr+hTVYC3cOQ2N5b18NAm8of6leSzjciIsu01OJw
         aHrg==
X-Gm-Message-State: AOAM532UfpjE//h71SMJhKmsUEwEj49wRmXn8q0IeaYvRYjISwxi7Nic
        V8Wzgxd6IB8GdWHRzxX5xpaLEKeKkSk=
X-Google-Smtp-Source: ABdhPJzgnQ6FVcLyLBH3abz/FShyYq886TUhMfAGMuepHLepG5xOg2dUzT24+pNWvIbWkUyMRkbFTQ==
X-Received: by 2002:a05:600c:259:: with SMTP id 25mr23867004wmj.57.1628080473469;
        Wed, 04 Aug 2021 05:34:33 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d4a:5b00:f5aa:e9bf:ac96:6276])
        by smtp.gmail.com with ESMTPSA id g138sm2620158wmg.32.2021.08.04.05.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 05:34:33 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Randy Dunlap <rdunlap@infradead.org>, Pavel Machek <pavel@ucw.cz>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/2] More (hopefully final) Kconfig clean-up after IDE removal 
Date:   Wed,  4 Aug 2021 14:34:24 +0200
Message-Id: <20210804123426.16947-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Christoph, dear Jens,

here is a follow-up to the issue of Kconfig references to obsolete IDE configs,
which I first identified and addressed in commit 094121ef815f ("arch: Kconfig:
clean up obsolete use of HAVE_IDE").

Following checkkconfigsymbols.py indications, this patch series cleans up all
references to removed IDE Kconfig symbol throughout the current kernel tree.

Pavel, Sekhar, Bartosz, you are CCed, just to let know about minor follow-up
cleanup in your files.

Christoph, please review and ack.

Jens, please pick these two further clean-up patches.


Best regards,

Lukas

Lukas Bulwahn (2):
  leds: trigger: remove reference to obsolete CONFIG_IDE_GD_ATA
  arm: davinci: remove reference to obsolete BLK_DEV_PALMCHIP_BK3710

 arch/arm/mach-davinci/board-dm644x-evm.c  | 3 +--
 arch/arm/mach-davinci/board-dm646x-evm.c  | 3 +--
 arch/arm/mach-davinci/board-neuros-osd2.c | 3 +--
 drivers/leds/trigger/Kconfig              | 2 +-
 4 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.17.1

