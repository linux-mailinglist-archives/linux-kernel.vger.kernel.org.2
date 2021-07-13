Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA59C3C6C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbhGMIfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 04:35:38 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:33850
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234648AbhGMIfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:35:36 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 33C984060E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626165166;
        bh=0KaW9YQiAdzUibYXtbruuTwQaZ3izlaXwF5Lzq2Zgfk=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
        b=oR5cWie7ihrMRweegICXeTh4uH4GRgc+v3GO284lFaO553pvIhfSA+mwYwVQ81oPq
         a3EatjFauHcFMtROXWMjDZPsTY+ZmtswK6FvOjW9a+reqoKXDYL+7DohZLr40hw+lo
         vdlm6duuwsNqH3kXzB/fqCMjzoU2qBc+nq57K9rqP7Odx92SCJHXykVvYiWgbdRQw1
         7a0wQ4Ucinqjihu8t8+MuS12Tbc/dUQ8/a3OUmlW2AvJZXQVSXq2TUrF3fyFPMBL7j
         cyHM3Hnx5yZLinHS8nrj8tLJIqoQuYgx+XAZDItnQ6c46AGOcmGHamUYCrmPneTsNH
         VMmbrC/vJMw+A==
Received: by mail-wm1-f69.google.com with SMTP id d16-20020a1c73100000b02901f2d21e46efso1106113wmb.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0KaW9YQiAdzUibYXtbruuTwQaZ3izlaXwF5Lzq2Zgfk=;
        b=XBlWiETuCTQo/lDnie3VSp/PtZ7HDloDaQBoqFZhtYnEClGzEPby9nEXZKpciyOEgY
         0ZW2NaDFy8ANebEYoTH7xEk29eP61l2xNako/0ueLZPdsrMHZbgt2eeD3MhWCXZnqOfi
         6BOmSgt5oFYovUU6A6vQmb8mUSxyepf4496bA/kBqXfVMjwRrhzTu8EUTDgjUEg77xKw
         bnPHnnLB1KL/60kbj5fM+OKI0ZO1lGdaP9NwUtOfProIjQycsx3sz6pbBXfNO5TjMQpc
         079vatFted515Ag/OpBu7efhQF5pebz3103tkx4JSsJuH9WWWUxcedmGqIUJ3FX5seCZ
         ru6g==
X-Gm-Message-State: AOAM532Vj2ZclBLM3GFdMo27xg1tND19JzziRXHf/kOpqKTsfAMTyIiW
        sYo2Wt2/hTSr/WPCNGwKaZz/ezMruzZejgD4eDSOylV4xhIS6vXSA/1YIH2M9HbeD0epYAcGodt
        SsXWyXTUKUKkLGEpHq3wNJpvO+/vzJoPA37Q1pp6KoA==
X-Received: by 2002:a05:600c:350e:: with SMTP id h14mr3818078wmq.68.1626165165916;
        Tue, 13 Jul 2021 01:32:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5hHALFc7JZnBqydG7y891ITJRbPCdZ1Vqr9qjNSdHxv4eNj/B5+KBgzOnXyo7WtqEcxWrzg==
X-Received: by 2002:a05:600c:350e:: with SMTP id h14mr3818056wmq.68.1626165165717;
        Tue, 13 Jul 2021 01:32:45 -0700 (PDT)
Received: from [192.168.3.211] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id d29sm6508845wrb.63.2021.07.13.01.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 01:32:45 -0700 (PDT)
Subject: Re: [GIT PULL] memory: tegra for v5.14, late fixes
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20210625073604.13562-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <cdce189d-9f98-dfee-e8a4-b35aef346c0b@canonical.com>
Date:   Tue, 13 Jul 2021 10:32:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625073604.13562-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2021 09:36, Krzysztof Kozlowski wrote:
> Hi,
> 
> Late fixes for Tegra memory controllers drivers for issues introduced in this
> branch in previous tags.
> 
> On top of previous pull (memory-controller-drv-tegra-5.14-2).
> 
> If it is too late, I can send as fixes after merge window, but maybe better to
> get these into merge windows earlier.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 2c1bc371268862a991a6498e1dddc8971b9076b8:
> 
>   iommu/arm-smmu: Use Tegra implementation on Tegra186 (2021-06-11 08:44:53 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-tegra-5.14-3
> 
> for you to fetch changes up to bf3ec9deaa33889630722c47f7bb86ba58872ea7:
> 
>   dt-bindings: arm-smmu: Fix json-schema syntax (2021-06-23 07:55:10 +0200)
> 
> ----------------------------------------------------------------
> Memory controller drivers for v5.14 - Tegra SoC, late fixes
> 
> Two fixes for recent series of changfesi n Tegra SoC memory controller
> drivers:
> 1. Add a stub for tegra_mc_probe_device() to fix compile testing of
>    arm-smmu without TEGRA_MC.
> 2. Fix arm-smmu dtschema syntax.
> 

Hi Arnd and Olof,

Let me remind about this pull request with fixes for current merge
window. Without it, certain configurations (build/dt_binding) are broken.

Best regards,
Krzysztof
