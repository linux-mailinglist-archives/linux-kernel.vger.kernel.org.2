Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A2A39B128
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 05:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhFDD6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 23:58:23 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:47055 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFDD6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 23:58:22 -0400
Received: by mail-pj1-f45.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso5086290pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 20:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eMMwY8qQNkTVoHZiZIl5tn9ghZC2j5sUCYWs3fjlNkc=;
        b=WQYEOJQWgXV4Z7RlPLlCH0GI+8Mhykds+lFNzn0YEf1jC3NHqQDlnuj1KwVBv/ZBQX
         pZNuy4boZd2b5p9mFrU+nNwNa8pExofWPH8fWCT2NkP+ZEEdC26KFyH0eXB1nm+bz/2Z
         HSFTbe3cq9V7LGWs2wNjTxwxjbSAjqCKZw8zKzq3/mJe4N/JoD6Kqcb0lislhEzPbWAF
         dQcDE12nrPhNyxzg6hjcYpp7wXdFO59UM1Dd0LuPnJ7XZFdv01gp1F1pRwEZLc8t/Xe4
         xMi+71z90CBtnKV8nH+H+8qVxwYvONklR91BD3XYmLThGLSZMOFLzuA4QefdfVyrqcH+
         TNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eMMwY8qQNkTVoHZiZIl5tn9ghZC2j5sUCYWs3fjlNkc=;
        b=WpSAnkfqYawiw5kdCUxkzXD8pKWX1rfi5c7+EgWUq1+SoHkW3WPWX+9hA11CV3OC1M
         rzyU9zpi4NdwVwk5mKKvW2ngKFtfj9zq+XI5bpcOI5CAcYSvMx/90AyPyZw6AiZztXv8
         A2AHag9WpVWljP6oR8NLznIPlcRFod2W31AoZPSSUzyZRk49O34bPKv4aclCjLGmsLhr
         t7YhuS1EEdBkToUIeSq2Ss5BxFerF4c87cNGitPE5yXjF4ZjD0NNqTOG8xFI35w7+kLB
         KvDPjtqXC9uXxk5Vc/Kw2+bRyxixMhEjqLmpJhw7ubxhJfdhFzWdXDIo7ByvahxbfmKT
         5O4A==
X-Gm-Message-State: AOAM531PcKR5NRrF0XJCEvzAksPQWOV96dJvw5QsixXycW5tYLX2Th0q
        eG2npNfi5c86a8HtaT6O7ydK7g==
X-Google-Smtp-Source: ABdhPJw31ObwYL3vjh7VCbQTqwewCpEgPzasyY0q9PhumD4gKAiT8PNeki4nnCaX5rvxG2YlnrciEQ==
X-Received: by 2002:a17:902:548:b029:10f:30af:7d5f with SMTP id 66-20020a1709020548b029010f30af7d5fmr1584319plf.22.1622778925580;
        Thu, 03 Jun 2021 20:55:25 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id s22sm475766pfd.94.2021.06.03.20.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 20:55:25 -0700 (PDT)
Date:   Fri, 4 Jun 2021 09:25:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Seiya Wang <seiya.wang@mediatek.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
Subject: Re: [RESEND 1/2] clk: mediatek: remove deprecated CLK_INFRA_CA57SEL
 for MT8173 SoC
Message-ID: <20210604035521.ly6unoj5537xy27h@vireshk-i7>
References: <20210601071042.31349-1-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601071042.31349-1-seiya.wang@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-06-21, 15:10, Seiya Wang wrote:
> Remove CLK_INFRA_CA57SEL for MT8173 since it's no longer used.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> ---
>  include/dt-bindings/clock/mt8173-clk.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/mt8173-clk.h b/include/dt-bindings/clock/mt8173-clk.h
> index 3acebe937bfc..3d00c98b9654 100644
> --- a/include/dt-bindings/clock/mt8173-clk.h
> +++ b/include/dt-bindings/clock/mt8173-clk.h
> @@ -186,7 +186,6 @@
>  #define CLK_INFRA_PMICWRAP		11
>  #define CLK_INFRA_CLK_13M		12
>  #define CLK_INFRA_CA53SEL               13
> -#define CLK_INFRA_CA57SEL               14 /* Deprecated. Don't use it. */
>  #define CLK_INFRA_CA72SEL               14
>  #define CLK_INFRA_NR_CLK                15

Applied both. Thanks.

-- 
viresh
