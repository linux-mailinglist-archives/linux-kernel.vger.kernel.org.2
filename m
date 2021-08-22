Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A323F410B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 21:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhHVTHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 15:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhHVTHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 15:07:41 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5580DC061575;
        Sun, 22 Aug 2021 12:07:00 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id n18so14561741pgm.12;
        Sun, 22 Aug 2021 12:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QChRC5bsvV5GsGHtGsawsuaXm1RQ/2QbEQSA8oSl42s=;
        b=X7x1jGQ6jvPK5Ng6oNKbipRs+whc4v/ZBhTbx/hriXIHDKB+xOQ4xbLPAgFiFFp4q+
         5C6MUCmF/Ncg2S5j3TqDLO5Fa932Tx7097vE5q7QVAY8F4JHbFpItZzFFrsLdngit0gi
         oUIM/ZnA2J+AQhY85BjOofHjqLq4i9wJnvJxduNGNE+G7LNIZGiUywrT14V0cF9Juk6x
         keXb1B3FOnx1H3VAU0aq5EccZAkkebLqC+1uEZlDWTiy3w7bOxAH+heZrnzGQyWH2p3g
         2ZQzZpuYzVSRZzE0D2HExmpMvR9PxpFmuJErLapOShFXakB9Yh3L17wNIn1RGlRQR2vO
         w4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QChRC5bsvV5GsGHtGsawsuaXm1RQ/2QbEQSA8oSl42s=;
        b=DylbwKWXFEF0KKA7flrn7vVvLco7UdIm8WOTmSRkyC0cN0NpblEAgd6n4bEHGrAH6n
         y1lKRBhTgWFEkL3W66aXrZQmsbmzY3iW59Oq/0baMqt0XL72ri+qaltReVI4GDQ1Tflk
         DT+wvH0GbfXp1fzstkAy2FDPH0k+bIo7DgN5qVZaoeJU5d5+2v7Jac/v8q9uHoELrUlj
         +SJJBoq/gYUFz6DWVhYKrLD23/c4oMsvVmtCABoyg6uMt8zScQ0cXOgr9i4bBd0jdn47
         uU9cX8IPStDCZPmpAqJZawR3/PfsLsiOiw2nnz3fs0J8qZfWCc3WirrF2D4pAJhxR2hf
         m1mQ==
X-Gm-Message-State: AOAM532EDFiDBcUlPbEnhF+OlNtpYZe8jaLrB/Hn73fFCd8D4nMVv+/5
        eKMOesZ6x8oHWL+Rbf/8lFc=
X-Google-Smtp-Source: ABdhPJyYv9kHBYTe3Pqh1Lt1N0bT8OWr/15WQznm6TVO/nUMDch7ktyIiIRuPMQHNk4Ghq7FqLWqEQ==
X-Received: by 2002:aa7:888b:0:b0:3e1:6855:a01f with SMTP id z11-20020aa7888b000000b003e16855a01fmr30210507pfe.75.1629659219785;
        Sun, 22 Aug 2021 12:06:59 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l8sm16915842pjy.42.2021.08.22.12.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 12:06:59 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/5] ARM: dts: NSP: Add common bindings for MX64/MX65
Date:   Sun, 22 Aug 2021 12:06:49 -0700
Message-Id: <20210822190649.3713909-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806204446.2981299-2-mnhagan88@gmail.com>
References: <20210806204446.2981299-1-mnhagan88@gmail.com> <20210806204446.2981299-2-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Aug 2021 21:44:32 +0100, Matthew Hagan <mnhagan88@gmail.com> wrote:
> These bindings are required for all Meraki MX64/MX65 devices. These
> common bindings include memory (2GB), PWM LEDs, AMAC, I2C (AT24), NAND
> partitions, EHCI, OHCI and pinctrl.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/master, thanks!
--
Florian
