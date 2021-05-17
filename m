Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C2E382B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbhEQLeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:34:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37272 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbhEQLeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:34:21 -0400
Received: from mail-vs1-f71.google.com ([209.85.217.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1libUe-0001SR-4z
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 11:33:04 +0000
Received: by mail-vs1-f71.google.com with SMTP id f26-20020a67e09a0000b0290235a378d2f1so331487vsl.17
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 04:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kQXbZ0GBpMeIdKKjZ5TbypurkKvU8BrE/KZM5yWXMaQ=;
        b=Ixnu0zbet4o8B8Pbn8YRVL9pv0eYw8EsXYzFBGAcrOA2XeFC6f3lQ8Scq4G11XWP2n
         Ibw7YOBQGhpCjld+LrJnIAy5GWnv0Dt9gelqMALQ7/z7rErMaD2QNG+fPVgG1vFuV2zf
         fDkFiAs6ncl9/o3KQvbQDWvvwnBvEtR1DkTWUofENDBhViW/CVCvqwzvRQtISzEYkiiB
         t5NpgCtrDInyc0DqRH7pd3QYhDK/a0rEZI8zX1d/Jq/P9S5RwpE7MZoUTsHTS/ls4Uvj
         jPEt5Iy52sjp+If6mODe524gnPgwnqYV8hWJMoa5Xo2b765N6IbjK19eHFWtTVxcYIhC
         LsVw==
X-Gm-Message-State: AOAM532zYlMQakZKpR4hQLho+hjHTeLz/uLbF+jW0DTfQAuZQjqq4+gH
        GZ3VHbBWUVjHkQ+JjOfsFT0mNreHx/RO6WclsHI8pkZ3etIYUQzbLnTgTIHbEB6gTmB9blhMB3E
        z2TkgtJ/FhGpu9raXmeFs3Hn+/bPFwU5iLUAHRpMrIQ==
X-Received: by 2002:a05:6102:e08:: with SMTP id o8mr3024462vst.29.1621251183277;
        Mon, 17 May 2021 04:33:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBtUWKgqJWY8Y6YoYB0wyLexLSheMP3/JgQhAaRd52J6CsNhUccW8OwoEq2IRhuYNn6TOfjg==
X-Received: by 2002:a05:6102:e08:: with SMTP id o8mr3024443vst.29.1621251183070;
        Mon, 17 May 2021 04:33:03 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.2])
        by smtp.gmail.com with ESMTPSA id b197sm2233859vke.24.2021.05.17.04.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 04:33:02 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] memory: tegra: Enable compile testing for all
 drivers
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20210516161214.4693-1-digetx@gmail.com>
 <20210516161214.4693-5-digetx@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <acafe8b2-e6c1-7864-5efc-cebaa2342856@canonical.com>
Date:   Mon, 17 May 2021 07:33:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210516161214.4693-5-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2021 12:12, Dmitry Osipenko wrote:
> Enable compile testing for all Tegra memory drivers.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/Kconfig | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
This depends on clk/soc changes, so I am fine to take it via other tree:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
