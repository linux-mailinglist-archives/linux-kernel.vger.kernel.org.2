Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE937354CFB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 08:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbhDFGet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 02:34:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48800 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238603AbhDFGer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 02:34:47 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lTfIL-0000Oz-Sv
        for linux-kernel@vger.kernel.org; Tue, 06 Apr 2021 06:34:37 +0000
Received: by mail-wr1-f72.google.com with SMTP id l3so4618601wrp.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 23:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BMxd/x1G6zBfvDxJ8kpKT8eMUVA7SyyKTi5pE6J4kM8=;
        b=Kgm/669L/9AYewtKnrjgeyuNqVK5agirNS40Gl6jBRRO5J0JLKW7NYVJuRMuMDaCu/
         vJu8aXoPavXwyy35DSMlesmjwEAd0wJXLiDzYtQLbO5RdBhx7fia3cQzYh3hdoSAdFM0
         mojwnbBLA2ghLH/xys3ybm9P4LRKFu71MoOCxdpzdrZCCHP6Oeh+J4FSzoc+UUiQso1i
         pzwz93A+M7kM5IkMRAdqss/Ndze0Y906xiIdY5gsTOw/UTxlHaHWOz74ZkmtFtV4TUjb
         iSwsSqEhAlt2DQOxXZ9qDwXjC5nYNjlxy5rRanymm7EgIYvEKliN4PG656ykGrzIdBce
         BDmg==
X-Gm-Message-State: AOAM531z9QuT/6K8JhL4hqDgjXrxxAZtLcvONSncEfeJ5D1iLhj0HNVw
        ilYm14tIs9yqwPb3ux4Qnk/1cKVyuELDHsUJyUT8zR3w5f6DBJUM2z+zeXjAFPLDgeATk5ZCtJP
        yXy0GJeZE+Y5OPCWdynsZtekekOb6Q6qELW11VbCIOg==
X-Received: by 2002:a05:600c:4782:: with SMTP id k2mr2508259wmo.75.1617690877633;
        Mon, 05 Apr 2021 23:34:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySVVC3XjNtljd/JCBUFCPPytV1h0dvBECpyVFRPioGRuvmHhYJ/HGe+ofT+CvyjfE1K8eHuw==
X-Received: by 2002:a05:600c:4782:: with SMTP id k2mr2508244wmo.75.1617690877522;
        Mon, 05 Apr 2021 23:34:37 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id l1sm32036825wrv.87.2021.04.05.23.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 23:34:37 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210406104511.2535b830@canb.auug.org.au>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <190b8e95-2a96-142e-7b98-34318eea6804@canonical.com>
Date:   Tue, 6 Apr 2021 08:34:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210406104511.2535b830@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/04/2021 02:45, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the arm-soc tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/clk/socfpga/clk-gate.c: In function 'socfpga_clk_recalc_rate':
> drivers/clk/socfpga/clk-gate.c:102:7: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>   102 |   if ((int) socfpgaclk->div_reg & SOCFPGA_GPIO_DB_CLK_OFFSET)
>       |       ^
> 
> Exposed by commit
> 
>   cdb1e8b4f4c2 ("clk: socfpga: allow compile testing of Stratix 10 / Agilex clocks")
>   552418658acd ("clk: socfpga: use ARCH_INTEL_SOCFPGA also for 32-bit ARM SoCs (and compile test)")
> 

Thanks Stephen. This is a result of compile testing and was already
fixed via clk tree. You should not have the warning after all the merges.

https://lore.kernel.org/lkml/20210314110709.32599-1-krzysztof.kozlowski@canonical.com/

Best regards,
Krzysztof
