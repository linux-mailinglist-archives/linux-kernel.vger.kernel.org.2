Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A136D38AF71
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243262AbhETNA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243510AbhETM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:59:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007F2C07E5EE
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:25:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y14so15384540wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2vuP9pLH1GNFHwKBRVQ+EoRKak5xCUlItci//u09Xk8=;
        b=ocxpZ7zRPzo57+6/Fsnho3JT0+eWzP76JoZoItEJXbQN+knRsvJgsRlPLzIMVzKtaa
         mkheSRD0qP0DLda1T1rXusSQCoPYP8M5aNmTiRQMHQ4bvkSWJqajm0Wo9Mq9avvYByY0
         pfMmfLkfglzkiLD2yuSuP3tqmsfmcFXLSqb9q3pFM2viEl78Njitqsbe3L+uqg8CF8kz
         A6jrnT0ujJJyMh170OjAOnC/H1asTVk0+xAaV385iPV0oy3VU0zgwIK0s/rh/k4hRkph
         bOKqOE/0Nj3AY+1IzD57qVzTJp8Ubxolr0TBfVh4ascNCAup6BfE7YD17swcAfLWx4ZI
         5yOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2vuP9pLH1GNFHwKBRVQ+EoRKak5xCUlItci//u09Xk8=;
        b=qbwHXW/veT2Rh1DEEb/sQq9X9k6dKB2UpGWZspe9FtgKVjSPUaqONHGc7Ioska9QTn
         q8Heuwc9FeKKsosyhu2uhrwapz+evBKi0lY8cBXtXkwmX1J9L64YmFZM3nm9Oo9X4LFZ
         jpN1iRqOVPXVFyyN80SK9/Hrxxgf//cB+FgLAOJN8yVtc2Er1rOKgMFmRmNQytmlFEGN
         S7wGvHnFr+xudW1vphuTtmO7nCANAb9+dGCzjCO+gCVRzOUdjYiZZOAKAkdmOOyKUVfA
         4u4ysElpdlDv/7Xvf4TXg8NJrdvMEEaLrpSkMIkzxYnUoepNQV/H2W3SUA2FojT7Tzvm
         jCqQ==
X-Gm-Message-State: AOAM531Y9pcMYJzrLwiQT2Q8wvsKa4kpEMeAr1OHNaoJ6D4Fe9XR1x9u
        g8Wk8KD36fNcMVX1p0c2KLnUgA==
X-Google-Smtp-Source: ABdhPJx/TXikSkc7C/v1F9MZEU3YeLs4Ntw7IApwlyf3djEsw/U9yhQEwRad6QvbBU8Hm6OLrw1XNQ==
X-Received: by 2002:a5d:4b87:: with SMTP id b7mr3889282wrt.129.1621513546632;
        Thu, 20 May 2021 05:25:46 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id i11sm3205643wrq.26.2021.05.20.05.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:25:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Anders Blomdell <anders.blomdell@control.lth.se>,
        Comedi <comedi@comedi.org>, "David A. Schleef" <ds@schleef.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herman.Bruyninckx@mech.kuleuven.ac.be,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        "J.P. Mellor" <jpmellor@rose-hulman.edu>,
        Klaas.Gadeyne@mech.kuleuven.ac.be, linux-pwm@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Mori Hess <fmhess@users.sourceforge.net>,
        "Spencer E. Olson" <olsonse@umich.edu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Truxton Fulton <trux@truxton.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Wim.Meeussen@mech.kuleuven.ac.be
Subject: [PATCH 0/6] Rid W=1 warnings from Comedi
Date:   Thu, 20 May 2021 13:25:32 +0100
Message-Id: <20210520122538.3470259-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (6):
  comedi: comedi_8254: Fix descriptions for 'i8254' and 'iobase'
  comedi: drivers: jr3_pci: Remove set but unused variable
    'min_full_scale'
  comedi: drivers: ni_tio: Fix slightly broken kernel-doc and demote
    others
  comedi: drivers: ni_routes: Demote non-conforming kernel-doc headers
  comedi: drivers: ni_mio_common: Move 'range_ni_E_ao_ext' to where it
    is used
  comedi: drivers: comedi_isadma: Fix misspelling of 'dma_chan1'

 drivers/comedi/drivers/comedi_8254.c   |  3 ++-
 drivers/comedi/drivers/comedi_isadma.c |  2 +-
 drivers/comedi/drivers/jr3_pci.c       |  3 +--
 drivers/comedi/drivers/ni_mio_common.c |  9 ---------
 drivers/comedi/drivers/ni_routes.c     |  6 +++---
 drivers/comedi/drivers/ni_stc.h        |  9 ++++++++-
 drivers/comedi/drivers/ni_tio.c        | 12 ++++++------
 7 files changed, 21 insertions(+), 23 deletions(-)

Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: Comedi <comedi@comedi.org>
Cc: "David A. Schleef" <ds@schleef.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Herman.Bruyninckx@mech.kuleuven.ac.be
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: "J.P. Mellor" <jpmellor@rose-hulman.edu>
Cc: Klaas.Gadeyne@mech.kuleuven.ac.be
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-pwm@vger.kernel.org
Cc: linux-staging@lists.linux.dev
Cc: Mori Hess <fmhess@users.sourceforge.net>
Cc: "Spencer E. Olson" <olsonse@umich.edu>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Truxton Fulton <trux@truxton.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Wim.Meeussen@mech.kuleuven.ac.be
-- 
2.31.1

