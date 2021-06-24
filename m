Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4F03B3939
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 00:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhFXWdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 18:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXWdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 18:33:08 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4CAC061574;
        Thu, 24 Jun 2021 15:30:47 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id t32so6447302pfg.2;
        Thu, 24 Jun 2021 15:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t1WDXuUmSX0SVrD252BOWsAIUItp3RFhB8/dNy2hUvM=;
        b=EEklot8MDUnEqSxvwxtaJrp+Vjeq/D890xz93XYPwMjM0wGE5lt2cK3lqigu7VO0T6
         X/uRoGtgDvswkZqYMTTlne2AXLsSHpUcE7hlyx3ApW/cJUuQP30fUU/kPw2PZ4T5J0OR
         daE3pHf9zMFIK9WGL4lAHxIDId+mqLwPRz/b0aZpuxYE6RZzoEdcBYprdsFRdumfp+6A
         DCIA0alNM5RGRg6FRqvTKcHTJ4gq20xf1SNe8tY1mio+ek0xToKiHjEZQtWcBE9zK+qy
         qJ0Uts1Dkkpl3WibMGmT0MZWATDAiSqlNpSn6HsSQCf2hFtQ0glB6SUAsziIGFnw6sx0
         Oszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1WDXuUmSX0SVrD252BOWsAIUItp3RFhB8/dNy2hUvM=;
        b=gLFhnSYbfqLDDujzxxGlaCgY6hWl9Ab/Iu+eUe+YZOxPg+Ch9RSTLMdi0UosIw0r7u
         Ci3PNYgvesRNs1JidX81XWvZkgLiKT2FKCJGI+a+OUgNmNU6lBEpL/1zGD2MNrvc111z
         Zy7FnVv1vFfyBFbHNXIiJxszMEUIFvyAT9ZUhMWG73TTLcNcMnytQH51RQKxipHUTtSd
         19kYvdivePf2x6BbHssHxJkDHee/V+dVKcN088YkyHlXayUyetBXjB+OyA8YOGLSYYKz
         iy7rT1VcmRGn+QNX9iLUBB4tUMKT7A3BoGATdkqOdwm7zPN5whsoQCICbRWa/9kJmV8m
         Wuig==
X-Gm-Message-State: AOAM5321inGvknFba8YltlwIbDrUTUV41KttBv32ac5V3BjpXWhZSCfY
        lp8jgUwUsr6h/FV4LoVHzHQ=
X-Google-Smtp-Source: ABdhPJz5BWnu5UQQQJfNxAzQHlvBctgUg7O6eEBQ5Gmuu4uyYdUz+eOEdWvjiYuV7pUPNUO4yrio2w==
X-Received: by 2002:a62:581:0:b029:301:9082:7283 with SMTP id 123-20020a6205810000b029030190827283mr7224799pff.37.1624573847407;
        Thu, 24 Jun 2021 15:30:47 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s4sm3438798pju.17.2021.06.24.15.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 15:30:46 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] dt-bindings: arm: bcm: add NSP devices to SoCs
Date:   Thu, 24 Jun 2021 15:30:37 -0700
Message-Id: <20210624223037.1314943-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610203524.2215918-2-mnhagan88@gmail.com>
References: <20210610203524.2215918-1-mnhagan88@gmail.com> <20210610203524.2215918-2-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 21:35:11 +0100, Matthew Hagan <mnhagan88@gmail.com> wrote:
> Currently only the SoC names are added. This patch expands these to add
> the devices.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
