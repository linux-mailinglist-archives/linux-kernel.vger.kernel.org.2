Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EE540C0A1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbhIOHix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:38:53 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50748
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236514AbhIOHiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:38:52 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8C2D340260
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631691453;
        bh=9Jsg/Zb9vOxmr47H6Dck9hmK7mt/XUSoX3CVPDrTxZw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=m6YsJANSRk0dr2my2IPIyexXMfu4iOEjS4AI0vbzeyugKwlCRtssnfvR/VOUejA7d
         NtznAp0yg99gWqUJG9Zg/VCpYGa49eNhmEm4+2QQflzyPDRlpP6QRb6xOO4ieaHgIG
         abZ7TmV7HsEB9U5XZr2Cz/JTrg2A57YcRgR+lliyJ9DwjB2Q+SNe7sKucrbcWLxbsB
         a22NFdHtVIJDw3ANzkx4hALiyI2UbpLr7vFc06ZhF8CIsVNnjqVFYOx9GG/JFN/vin
         xh4kPTL+DScCFsekr57InpDuYGGHBS8lHB36fWdSg1M/TBpJE80kUvXHKau818Q57l
         o6MdP/2EDnvRQ==
Received: by mail-ed1-f71.google.com with SMTP id b7-20020a50e787000000b003d59cb1a923so212997edn.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 00:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Jsg/Zb9vOxmr47H6Dck9hmK7mt/XUSoX3CVPDrTxZw=;
        b=R8v+Z27rh1Ie9Pu/USFB76RJ2eugZjc7aZqtEhzOVMFFG7aDZNmb86cH8Z5gWN2Sc/
         vLqE/jp2Lsc85QQA/ezZN9RR/q02Qmv5g7A7fGlgF/7RIg4xJC679ljWg0fKSjtmUFrJ
         YiD4dFPOKrVrtkp6F2elMUS/ERuxM/QylLWICkkLTcdIE4F75A3SabuOnegNolacWJYJ
         0mOft17W9cRejSpYax+ESfzvtMyzBdcXru4DZdLlL8B8VAutxA8yIbSWACK1KPbC078T
         F4Rx2LabgYzsJJG+lvMeAR7Txm19fgQAKhWyXuM9xLM/c9uJgAQeCqzl0YFNtFc+eG2w
         V5JA==
X-Gm-Message-State: AOAM530MiTA1NHAfhApSuc+JzHRYcaqlS9pbcZD6H6+pLjkUBPnp1UQ4
        bauT7qCk7qk4bXDFnqHItdwpuMsW1cypwkb6NnzjstFmgeC5WKNYk37p7cb6/0BywIUjEbjWKqE
        va9HLTqOZN5a5qP/O4opuZOHH2iOdhZykv0ryk7TDqQ==
X-Received: by 2002:a05:6402:2da:: with SMTP id b26mr23729098edx.160.1631691453111;
        Wed, 15 Sep 2021 00:37:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9KNnHVSLzmWN5khTacRj2yNehERLh21SPyQ+lDhUrMrfW6xrVidKaH9YbxB7KxkhxkN1q5Q==
X-Received: by 2002:a05:6402:2da:: with SMTP id b26mr23729082edx.160.1631691452928;
        Wed, 15 Sep 2021 00:37:32 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id d22sm5871832ejk.5.2021.09.15.00.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 00:37:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     CGEL <cgel.zte@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] memory:tegra210-emc-core: replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
Date:   Wed, 15 Sep 2021 09:37:24 +0200
Message-Id: <163169144170.13297.3862081658679258253.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825063739.70260-1-deng.changcheng@zte.com.cn>
References: <20210825063739.70260-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 23:37:39 -0700, CGEL wrote:
> From: Jing Yangyang <jing.yangyang@zte.com.cn>
> 
> Fix the following coccicheck warning:
> ./drivers/memory/tegra/tegra210-emc-core.c:1665:0-23:WARNING
> tegra210_emc_debug_min_rate_fops should be defined
>  with DEFINE_DEBUGFS_ATTRIBUTE
> ./drivers/memory/tegra/tegra210-emc-core.c:1726:0-23:WARNING
> tegra210_emc_debug_temperature_fops should be defined
>  with DEFINE_DEBUGFS_ATTRIBUTE
> 
> [...]

Applied, thanks!

[1/1] memory:tegra210-emc-core: replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
      commit: 6fc5f1adf5a11422d748aa71e43e7c979208b8f2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
