Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3F2368DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbhDWHKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:10:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36383 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhDWHKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:10:00 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lZpwJ-0003Qf-Rb
        for linux-kernel@vger.kernel.org; Fri, 23 Apr 2021 07:09:23 +0000
Received: by mail-wr1-f70.google.com with SMTP id f15-20020adffccf0000b02901028c7339ccso14746224wrs.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 00:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=16r9DssXKUC9HdkrZg3Sm4SlbqGPCpv9BtQcvqu4Nqs=;
        b=B2+ZVljCeXb91NPEdpX83K9Yi/Hy0TI9az9L7Nh62W50doV7wq9do1uJTBhGGa+x1x
         2j3UyiusQWi3hRovEpUTazbpOlEs32a3llCHqNsnT+Dfstmg2rC5Lm4eJZN5KumqDDIL
         zest9ntjQ0wtZHOF3lQ1MNzH8JKGl2hsE6/9h3V2FbxeZ1t0DI78e6RF5WNkjC21BCk1
         leJtExR8qpN5Eh0rJ9SqVxsGK0AXMvVxpul99bSiaMNjlobHtK75sI7WXb8kP4/5Y5sI
         lvPG0bchGKN7eBezIBusiNhJ+XT5lqDWfjJPiIK/XbNpvWojXcbS/DurQQe/tLhyIJTR
         eEJg==
X-Gm-Message-State: AOAM532PvTymL6fQ/aAOBIH2L8Xe2hBp9CYpXWKSng51093K/FmVTeYs
        UXcfmnAd67SBD98NJH7YjcrDBPu36agzvtJfa0oZ7qWA+J9JDEF6T4yx8YmpxdF0iTyu0YtThaK
        SM0z0efUrgYa53AHSdHQULOZmrDauLctXfgGMNl2cpA==
X-Received: by 2002:adf:d1c9:: with SMTP id b9mr2830891wrd.352.1619161763187;
        Fri, 23 Apr 2021 00:09:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7iVYsXTmbfyE3WjIA68KJwkWL2BOCwMNDEHHo8nMg4UhT+jmgh4htXnxkoNXG2W6OYDtUTA==
X-Received: by 2002:adf:d1c9:: with SMTP id b9mr2830875wrd.352.1619161763000;
        Fri, 23 Apr 2021 00:09:23 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id h9sm6756062wmb.35.2021.04.23.00.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 00:09:22 -0700 (PDT)
Subject: Re: [PATCH 054/190] Revert "clk: samsung: Remove redundant check in
 samsung_cmu_register_one"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-55-gregkh@linuxfoundation.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <05bd90cf-e761-9ade-388c-7b78a0ed716a@canonical.com>
Date:   Fri, 23 Apr 2021 09:09:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-55-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2021 14:58, Greg Kroah-Hartman wrote:
> This reverts commit 8d7a577d04e8ce24b1b81ee44ec8cd1dda2a9cd9.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: https
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/clk/samsung/clk.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
> index 1949ae7851b2..dad31308c071 100644
> --- a/drivers/clk/samsung/clk.c
> +++ b/drivers/clk/samsung/clk.c
> @@ -356,6 +356,10 @@ struct samsung_clk_provider * __init samsung_cmu_register_one(
>  	}
>  
>  	ctx = samsung_clk_init(np, reg_base, cmu->nr_clk_ids);
> +	if (!ctx) {
> +		panic("%s: unable to allocate ctx\n", __func__);
> +		return ctx;
> +	}

Hi Greg,

The commit was fine here, so please keep it. NAK for the revert.

Best regards,
Krzysztof
