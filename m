Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAEF3995A6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 23:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhFBVzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 17:55:44 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:45569 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFBVzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 17:55:43 -0400
Received: by mail-pf1-f181.google.com with SMTP id d16so3252911pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 14:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ntQT2pZR3LJHS6LUFfJ+Qm+vXWzrrp5nCQGAwU1JB0=;
        b=hcmQBsf5LoocnIf8a/0Ca0mlBQCzY7GjMf15ueTI3PEpj3E/TBi5Q4d6mn33d2MJoP
         o9USDMmnfkAKRC+HQmjPpNpm9ItolNHZ1gLqyQzuO6A7JT97S8N4Sxu9N2mExjgaVVfG
         /6iv9Wdl/GeNVu3eeoA7T88o2yYmvWwncmi+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ntQT2pZR3LJHS6LUFfJ+Qm+vXWzrrp5nCQGAwU1JB0=;
        b=U1UVdTIx38mGBTMfijx4SsNW01b/TktsNFTcn6940ERlx9196dvvwS7TxdNIQlokqa
         LfyJH/KPgTAP4ZEsJWyjnqav+Oz2/nGwVCp89XBdsG8eBcPwAiChJ2WWt3Q+p7QALd0d
         ocQiPCFxarGXSDDhF7r/5SifQeoC8HLuWVr5LjgDJE8cB68XgKNyEZ9n17ajFHZzP1A1
         oJIMLBxiqBnePdIXGOlbWbWQVzLFAUgloioCtpvkQgV8oNUmfCidOl/H+1DpaQkdoDiC
         2100o4w6hzC3NOVKr6jBRjs29Wrq9QtrSsRuCbWUHaDqvJHD8rq4kR353pwo+/yNDyxx
         qKCw==
X-Gm-Message-State: AOAM533HOUqLZPXUEQ2iUfRYvm9VWhLc7s8UsERDz9wlCHMrgXLSGYqX
        kZYz/rd023Yr/fp2NECBUGKBIw==
X-Google-Smtp-Source: ABdhPJzeQ5qvww5ymAg1YzwWIo2ptK3WZmfCNVj/MFd8/a2Itlvi0o2veU1w5SbMD5HCoN+TggIUFg==
X-Received: by 2002:a63:1b52:: with SMTP id b18mr8618637pgm.263.1622670780419;
        Wed, 02 Jun 2021 14:53:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 60sm338761pjz.42.2021.06.02.14.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 14:52:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Dave Airlie <airlied@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Emma Anholt <emma@anholt.net>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 0/3] drm: Fix randconfig link failures
Date:   Wed,  2 Jun 2021 14:52:49 -0700
Message-Id: <20210602215252.695994-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While tracking down spurious "orphan section" warnings on arm and arm64,
I needed to fix several other issues that it seems other folks have
tripped over before.

Here's the series that fixed everything for me...

-Kees


Arnd Bergmann (1):
  drm/msm/a6xx: add CONFIG_QCOM_LLCC dependency

Kees Cook (2):
  drm: Avoid circular dependencies for CONFIG_FB
  drm/pl111: depend on CONFIG_VEXPRESS_CONFIG

 drivers/gpu/drm/Kconfig       | 2 +-
 drivers/gpu/drm/msm/Kconfig   | 3 ++-
 drivers/gpu/drm/pl111/Kconfig | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.25.1

