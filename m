Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0389393EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhE1IZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbhE1IZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:25:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4BDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:23:42 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m18so2425189wrv.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eyBJIBJKczJ4RCczHpoNmMeimwDIieha7dBuOVSfeVY=;
        b=paNmSYPQSTAA07IrL4Z6qqnDX1AMgX6uUlbirHht/gRhjhp5y3jgEdM+zePbTS4wRO
         ASvVKsROxD40q08GHdOCt9/BTkDYX4+zyYkhR7IAMpyksRbEPm7sxOCpCI2CtbU+xbh/
         swMrHA0taOpk6ZSfznnAb7N9N++FMc6czgcXJA2XXRz/2FFhHi+JbI1eHpfQDNob72iv
         fn8UH5YVCEzg7Q7Zhqpl/br7NU/bqVMpyAaf2gzulPr7Sp5PwGmEwpFTCYUHBEOjC935
         XERXEhKHpOPhMfrN5ZAYIsMLTzwQnDEjmv2138H8Zx0Z00rl/z7I3DJql93HKWq2yqVz
         OUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eyBJIBJKczJ4RCczHpoNmMeimwDIieha7dBuOVSfeVY=;
        b=NNNBOM+k9nV3xupl1zGRbKWOKip6RsnxSXV3/iFA5QJKvrrMX8wCw0YSY/tGNk+bfN
         NvlipYO0M9g7XxUkPln0fbj2oelCVyDPPlXZGj1MEK8IBKItTmU6Eimtc2qivll5kZPs
         9RluCCvn41bWy9NECav0H25t9/uhuQTK+YYnF3LHHcqduDh2BaKHy3El2QHZCW2cgC68
         owlQiJwOu/injwgLF6cdchD1EQaOEKis67Lg9exC372yA6rssuS+OOtXqjkxsg0mhwgk
         O8xqCtuYj9TFWXaILVu7bRnl5hNNxhl33fK93Hao1xcMWhcMTt7KZ2yOCMiEy/t+ElzD
         6xsA==
X-Gm-Message-State: AOAM532rCsF/czeeEmcZdXWFhA+jT0M3ntjP32GTWHT42IrcgOzvqA8n
        Wd4hEYhkX98TErsjrL309mjd7Q==
X-Google-Smtp-Source: ABdhPJyREmn3HIj0733EmrukvEHehxAlOFXkOCYHOIioGLDLIR0MJuUSRMrnOK/iMw+/Nqsvtv+Opg==
X-Received: by 2002:a5d:64a5:: with SMTP id m5mr7474092wrp.182.1622190220775;
        Fri, 28 May 2021 01:23:40 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:668d:49f3:7f84:14a7])
        by smtp.gmail.com with ESMTPSA id e26sm5490248wmh.39.2021.05.28.01.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 01:23:39 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: amlogic: meson-ee-pwrc: Rename "get_power" to "is_powered_off"
Date:   Fri, 28 May 2021 10:23:37 +0200
Message-Id: <162219020184.199045.11093167625598495051.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517202115.1004065-1-martin.blumenstingl@googlemail.com>
References: <20210517202115.1004065-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 22:21:15 +0200, Martin Blumenstingl wrote:
> The name "get_power" is used within the Meson EE power controller driver
> to indicate whether a power domain is turned on or off. With the
> original "get_power" naming the result was:
> - true = powered off
> - false = powered on
> 
> Rename "get_power" to "is_powered_off" to make the naming consistent
> with the third argument to pm_genpd_init. Also this naming is easier to
> understand when reading the code without looking at the implementation
> of "get_power".

Applied, thanks!

[1/1] soc: amlogic: meson-ee-pwrc: Rename "get_power" to "is_powered_off"
      commit: e93e6bef7930cc23b878b6768f617c479f1a5c50

Best regards,
-- 
Neil Armstrong <narmstrong@baylibre.com>
