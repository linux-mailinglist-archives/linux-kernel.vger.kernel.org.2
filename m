Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1953A2FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhFJPxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:53:34 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:43600 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhFJPx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:53:27 -0400
Received: by mail-lj1-f180.google.com with SMTP id r14so5543033ljd.10;
        Thu, 10 Jun 2021 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dJEQ05qdu+8nKCCgzfIKNvAnjM3rPput3SGOoOdwVG4=;
        b=QXXfyC+CNRLr82a3T4zoVNqWsc6aHIooixWlBRMAvV8jgeq1VtCOLKgW9CnDdxXEMp
         bBSvfsLmLqGnvOfzibxr3DiX1hOtLD9chD2ojf8BYLPUkp6i8Z9AmDB2pv+a1emtFdh7
         Es7D6Suy14DUN8O+jGAFcmXnGMIOSByWfW8ldXV8TLSLPxQffIyMQ+fnndbC7n27v4ze
         mmTuvG2gf/1dDU1KJgGpR8+vFs2nrjnaxtcvcfZ3VRfn1gUlEam3kl4AkxQhwynzRVCk
         G0yizUAc2LPeITpnC/C9x/6fZ5t8nPD+mtqluShpZqg8JGhG3G/FrZukLWvxjJAzjIrz
         3jFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dJEQ05qdu+8nKCCgzfIKNvAnjM3rPput3SGOoOdwVG4=;
        b=TjjUKj+lYHFdek+ESe5L60iINFIoaqKlJkzX/foTOFLMZB5creRPgQ0IS8Jyzn04A7
         J7yt9u3xZx6xOPrzYW8dX08hGct/Gx/qk9F4d3nAHqDSALMfiY+2uMw9FXUwMW6kytrV
         ROSjUSjFNIB/bOUbW2oXowDrrt3e3ZtIQHA8HeRCEg4mEOhLd0egsN8dk4A4rc3DQgKG
         E79WSjO9GOooIP2toAXXd84VqMhgaZ8bySZTwcRjXxqeBPcGP1/wKN7/TYRWcsmFQm11
         7Uk/WvGf4zwz0PejBhuqo1h3OarAOGPwj42MZ0hLUVWGjzvC5l2uRb7XC4yKkOYxLJXd
         dd7w==
X-Gm-Message-State: AOAM532qK3VfmN7sTBfqixqX6ssVX1FHfzB81/xYXWBeuhnC4do/v1Xj
        TTZ0OCK7rwg0bCRRgIKXrdbrG9wI1Ww=
X-Google-Smtp-Source: ABdhPJwac9R6lTcA7YMbwSgbmVO2TftWIG8X61GWwb+P+TB9zUhcJYF8mm9KjWnbyK3VOGP+fv2uig==
X-Received: by 2002:a2e:b4c9:: with SMTP id r9mr2805279ljm.306.1623340217082;
        Thu, 10 Jun 2021 08:50:17 -0700 (PDT)
Received: from [192.168.2.145] (94-29-21-60.dynamic.spd-mgts.ru. [94.29.21.60])
        by smtp.googlemail.com with ESMTPSA id z14sm380368ljc.51.2021.06.10.08.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 08:50:16 -0700 (PDT)
Subject: Re: [PATCH 1/2] memory: tegra: Add missing dependencies
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210609112806.3565057-1-thierry.reding@gmail.com>
 <20210609112806.3565057-2-thierry.reding@gmail.com>
 <0c762772-929e-2eb8-6568-4aa82ea2f9ad@gmail.com>
 <ee2846c0-9274-0888-90ac-dac72d2ab5fd@canonical.com>
 <a3110fbd-c4af-0317-5a6d-1f780f1dac91@gmail.com>
 <1400979c-c7a7-9618-1168-70185ed10546@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8d8d019a-34c1-50bd-5eba-ce361c263d35@gmail.com>
Date:   Thu, 10 Jun 2021 18:50:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1400979c-c7a7-9618-1168-70185ed10546@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.06.2021 09:43, Krzysztof Kozlowski пишет:
> The stubs might be good idea anyway, but the driver explicitly needs for
> runtime working reservedmem, so it should select it.

The OF and reservedmem are both selected by the ARCH for the runtime
use. They may not be selected in the case of compile-testing.

Both OF core and reservedmem provide stubs needed for compile-testing,
it's only the RESERVEDMEM_OF_DECLARE() that is missing the stub. Adding
the missing stub should be a more appropriate solution than adding extra
Kconfig dependencies, IMO.
