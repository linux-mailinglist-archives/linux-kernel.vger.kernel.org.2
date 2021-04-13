Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B19035E247
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346503AbhDMPHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:07:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58804 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346482AbhDMPHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:07:43 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWKdO-0005qS-Fk
        for linux-kernel@vger.kernel.org; Tue, 13 Apr 2021 15:07:22 +0000
Received: by mail-ed1-f71.google.com with SMTP id f26-20020a056402069ab02903788b40ed89so1427376edy.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BbLS8YFFiy7aQZZ6pW2QChOM2i4McA8DXTegdPkwtbw=;
        b=G2E1Rc6/cqTehfLGXCEvlcs1DZy2BokgKsctirGRiW2JsIJuRDL3kIDcMAdLnfEnVe
         UxDNl+eU7NKQLyA3O9bnG1zRP0v8e9hSs2C5pNj0OWEXDGUBV6xwdShT05JMyTBG6l+A
         slXUPfwhq6FX8lSCoRZy9NMopT+vVNA3IjFLp2ang8ldxnQl6uBNJdNf6FO0BLIiAnSe
         fIBiB0A1dWCYNamYknl0b6wOlFzYWJNEd8B5ixZGqfeHgJxsRuMMTGswRAwHpdkWTEw+
         66Qw7u7Vc15hDWX4t70++zE7lxUt0R5ZWNnmbNhUuxFyiTxcbYpytOHRZCzn48B00903
         1TfQ==
X-Gm-Message-State: AOAM532ijsZlPpOgPUpnDZPPiyO8eoUolbcTlXtvKofSmQ+BVquzJyH1
        HdRw+pxbVFQXSODI6FlV70s4uHFOvOFyrldUQ6aDzEzz2rwu3EippTdITlUSkNzCSaHdAq21hXU
        7PnzZHgDxamGFdMigKP7s+s6kpJ82YPl/QSnCA1hwVA==
X-Received: by 2002:a05:6402:c:: with SMTP id d12mr34967848edu.100.1618326442229;
        Tue, 13 Apr 2021 08:07:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWppPmHJVhEQzMw3NoPRy3HSvan9DczQR6zow4e4/MKICDqAiBqgdCGfAG5MyEeiRhZhMW/w==
X-Received: by 2002:a05:6402:c:: with SMTP id d12mr34967816edu.100.1618326441990;
        Tue, 13 Apr 2021 08:07:21 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id r25sm9717507edv.78.2021.04.13.08.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 08:07:21 -0700 (PDT)
Subject: Re: [PATCH] arm: mach-s3c: Remove unnecessary break
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
References: <20210409064920.1096367-1-wanjiabing@vivo.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <1c1e4839-fbc7-b50c-dc25-983edf018e7b@canonical.com>
Date:   Tue, 13 Apr 2021 17:07:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210409064920.1096367-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2021 08:49, Wan Jiabing wrote:
> There is a return above the break.
> The break here is unnecessary. Remove it.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  arch/arm/mach-s3c/mach-rx1950.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks, looks good but I do not plan another pull request in current
cycle, so I will take it after the merge window.


Best regards,
Krzysztof
