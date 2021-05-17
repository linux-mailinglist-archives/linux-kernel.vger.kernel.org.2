Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107BD38319B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 16:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbhEQOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 10:38:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42296 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240204AbhEQOcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:32:08 -0400
Received: from mail-vs1-f71.google.com ([209.85.217.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lieGX-0007Ao-Pw
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 14:30:41 +0000
Received: by mail-vs1-f71.google.com with SMTP id a11-20020a67d30b0000b02902363051a2cbso356694vsj.18
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b8fOlxYIjxroeXZaPApUy+9pShAujZ8BOr3a1vv0QfM=;
        b=kPSUfIiKYnDPLFL+cIjFMGc7bMWGDY79HU6nA93XYM27Oqea678M8fX2fL3MSGoLgG
         Nb3JxB2avObe28kPLIg6vvwPO9bcBdXxjzVxLb0fpmuariAZZOcUht/xL7Nq9QB3t7mU
         eNbyZd80RqwwJbtCdcm/staQYCx/El5RURcfWoQ3skDviysC8XRsCpKwD3MwuIFgk2gV
         Rj/AQMj6XnHp4exq5RSHPk8pS9xZ0Co0YreVAJvGwl1/KiDMWfBpQ6qxJNi1zd6acdna
         eDq8MlKRlPmISJNdcCIPQQATFu7Ra+v6gnQa/jVe9pY/R5J3oeXM5gl8IcDcojEHdnTa
         2+EA==
X-Gm-Message-State: AOAM532nptYxyxjAPJWzf6vJJidvJar5TzSVp1G2JRRW2EwJP0jXAQTJ
        Mxbh57ldqhAwoOvRCMxnx758NRqEhA5ZtAu9ZEf/pBe/mL4U64NOrOLAhwKcIV6lwQvkYdclVDW
        ZC6Xht16AZjU9vbD8PGfSP+Jz7NXxVwOzCpfCg9GS/g==
X-Received: by 2002:a0c:d80b:: with SMTP id h11mr211350qvj.10.1621261460010;
        Mon, 17 May 2021 07:24:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFThVtFmA2e59WhPfODKDeGjLXwwKQduT0MHPDWTRVXP0ipfgDODV9fTCnG5Tk19ONs5RSmg==
X-Received: by 2002:a0c:d80b:: with SMTP id h11mr211331qvj.10.1621261459879;
        Mon, 17 May 2021 07:24:19 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.1])
        by smtp.gmail.com with ESMTPSA id u27sm10534108qku.33.2021.05.17.07.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 07:24:19 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] memory: tegra124-emc: Fix compilation warnings on
 64bit platforms
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20210516161214.4693-1-digetx@gmail.com>
 <20210516161214.4693-4-digetx@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ae6dfddd-0e08-bb40-fd4f-36276be30cef@canonical.com>
Date:   Mon, 17 May 2021 10:24:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210516161214.4693-4-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2021 12:12, Dmitry Osipenko wrote:
> Fix compilation warning on 64bit platforms caused by implicit promotion
> of 32bit signed integer to a 64bit unsigned value which happens after
> enabling compile-testing of the driver.
> 
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
The patch was not suggested by Nathan but it was:
Reported-by: kernel test robot <lkp@intel.com>

Nathan however provided analysis and proper solution, so co-developed or
his SoB fits better. This is not that important as comment above -
including robot's credits.

Best regards,
Krzysztof
