Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D23B3937
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 00:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhFXWcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 18:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXWcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 18:32:18 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8075BC061574;
        Thu, 24 Jun 2021 15:29:58 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f10so3730738plg.0;
        Thu, 24 Jun 2021 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yV5sTO+k9dFc7PYqougBrTow2ms5XdzCfkDTsdpD4ww=;
        b=djGPQ1nwYVviho4zQKz7VjbJdDaC5VlZ6KXQ8BbSYU+jqXn53ghA1rQD0QBIKGbzwh
         fpNitHa1sMGVOhIGNFuzRlWba16EWCRHrGDjDOTv6nErZA6mqDiOdLgczLU+RWE4qx38
         NjVWgLXvdIImgUKxS0tu9y+CRyU8apVT3gtDw5zN989i9QvWUiG5ZmauvSA/y9WqRS/H
         Ps8NVqkk/f579WXjkqHF0LZ3OHDSgjJ5ckntouZIaFVPRCBHpOSAkTSVU2JgQaOUVIO7
         Oa5itJnOM/vCk7dRLBDSTlRed9W9rECzLBkKlG5l0bmzE40bH5R5sXZLRBlEN8pMYcGe
         dPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yV5sTO+k9dFc7PYqougBrTow2ms5XdzCfkDTsdpD4ww=;
        b=sFPNijrnEroG+vwX79RxteNamgXzLkv6wSen8xybRqld3PHK3FXcKZzU0c5IPMqSZI
         +BMlVVHr1ALer+sNHHxZMcMTL9URlDRayzcEOC0yw7CRMFKf63cZDwPWZIOY3uo6PT0o
         kygdOa/KbwXdW/Y6F17uOFoTRBhurmH9tYk5z0Ie44J8H+bzTPyfU8i24rtIBCLTg8oI
         +iNtZowU2Q1PpVImyd7nO9XZZci6tKp8Ablu24IBMYmyDUdk8kNNzZbTXEkfUSdkA6li
         dInRhxpLCS8ZHnc4JugJHUx4Qa3Twq5fod+ZDfm+8vRONMgGq7Qxt9OKO2KiUbHVyYmL
         +z2Q==
X-Gm-Message-State: AOAM5318Djzf2rytB4NYPryC9P1oRSRv59oNejUrL4HExzRX5a1ozO5w
        UrSIZq1RG2o7W4knxFr/qaY=
X-Google-Smtp-Source: ABdhPJy23p6zwBAUWWzNRNX0fhblbN4ab2PUwBdIE7rAw2+HwHK0NXdsqTvz5o1nq3jXQHrFpX7ReA==
X-Received: by 2002:a17:90b:a4e:: with SMTP id gw14mr15075632pjb.223.1624573798019;
        Thu, 24 Jun 2021 15:29:58 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 76sm3653548pfu.131.2021.06.24.15.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 15:29:56 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] ARM: dts: NSP: add device names to compatible
Date:   Thu, 24 Jun 2021 15:29:47 -0700
Message-Id: <20210624222947.1314735-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610203524.2215918-1-mnhagan88@gmail.com>
References: <20210610203524.2215918-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 21:35:10 +0100, Matthew Hagan <mnhagan88@gmail.com> wrote:
> Currently only the SoC type and platform are specified for all NSP
> devices. This patch adds the device names.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
