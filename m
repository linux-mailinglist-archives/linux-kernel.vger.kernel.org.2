Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFDC3BA3B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 19:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhGBRnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 13:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGBRnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 13:43:24 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911F2C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 10:40:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n11so6784871pjo.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 10:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ycjp7IAqDr2sOnAy7FcDwlQNyrrs73BvoaVb1DqiHGQ=;
        b=hXCal/zMzcHOOkI6LKY9PJwrhZjek3Uq1Q8hFYTilZlPb1rFzm6fbNxp1zfgInmKlm
         LibPHj/kHN2YrKH/wvbI5ghwA2Nee0C7MlDjM0ZQLL76sU463eEtLN0ru0/XvM77sP5C
         llg11fZ9NUv+f6B/uoZtFg/6bcaIPI5zRSonE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ycjp7IAqDr2sOnAy7FcDwlQNyrrs73BvoaVb1DqiHGQ=;
        b=gpc0IshPoR8PYszkqqmfHLQpE0Jn86NIdShYMpseui6ibgKMpkMPS7nQminmw8WMm3
         R8Q8NXJK7v0DtPibuU+Zmdpu+wdy4osCsZlQ0fWxany+HAyKGAyFrOzAQ0GVg+nLhJVD
         06Vj2Nv88YAGMMt43OvyGB4m7aMiVPpuAbrf4q7gjNp/fh7nbnfMcMWvpw9wCeth0Rtq
         cLAJLRHxSX7tF8YvlN355uZ0yTlqOuMhZm3aJLrvLSAJqFWK//2OqrnTjvheqGEwzNZY
         +RmTQgMZEKX66ErdID6ZtW+r6XKLh4FRLpIRseVwcAol1uXGiPToxyA0rsB+YxMhF9DE
         BnWA==
X-Gm-Message-State: AOAM530liDtmsEdrTx10AXJ2J7bFkLvl/gStOKlpS/JcWRRpUUoR0Bq5
        L6RsSodmmXYZAKoMUXklA74U2Q==
X-Google-Smtp-Source: ABdhPJwMSoOsTEABHtrW7HqLlaxkNVRoZIIw7kxoTj6Qn0w7ATi2x4YP5nEMFYDBI56IJyRFWz68UQ==
X-Received: by 2002:a17:90a:a48b:: with SMTP id z11mr840698pjp.24.1625247650754;
        Fri, 02 Jul 2021 10:40:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e29sm4400649pfm.0.2021.07.02.10.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 10:40:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Rodrigo Campos <rodrigo@kinvolk.io>, linux-kernel@vger.kernel.org,
        containers@lists.linux.dev, Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Alban Crequy <alban@kinvolk.io>
Subject: Re: [PATCH] Documentation: seccomp: Fix typo in user notification
Date:   Fri,  2 Jul 2021 10:40:42 -0700
Message-Id: <162524764023.3795686.15431640935196466896.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210702151927.263402-1-rodrigo@kinvolk.io>
References: <20210702151927.263402-1-rodrigo@kinvolk.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2021 17:19:27 +0200, Rodrigo Campos wrote:
> The close on exec flag is O_CLOEXEC, not O_EXEC. This patch just fixes
> the typo.

Applied to for-next/seccomp, thanks!

[1/1] Documentation: seccomp: Fix typo in user notification
      https://git.kernel.org/kees/c/19d67694745c

-- 
Kees Cook

