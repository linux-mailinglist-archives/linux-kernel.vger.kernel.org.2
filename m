Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3F633A1ED
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 00:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhCMXYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 18:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbhCMXYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 18:24:05 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D443AC061574;
        Sat, 13 Mar 2021 15:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=bjTkDYY2S47W+dOwH7RhQ+iYh/NtHasQ+4FwEjODBck=; b=TlzMrUWL1xPkqHMoahUKjApRlE
        EBdmu/rXygCPYBfAHTuPJWjO1wvTnNj3hCZ7kqm4VosmLUOa5phIbrrjn77xe//uQDRPEtvPxDe8m
        MmuwooLijFxhaG4JI1oudU4bC6Od9fgSUeutUtW44PxwVWA8u9dh/OSn44jYQQ4J875Ua5F7HycaG
        6qUjXZ4epTwK4RuLZ5RcRcOnjoZkGojimzW0xyANw1WqfWNVHPSkHh832NnoeHARTyWMfgoPoOYsB
        gWLyLiE1iE9MBbShGTyVDhKZkZgcAJlxr71pawmXDy5ZG8yJyjFTZ74z0qtBhGzjxvQxE2VviQKzl
        MHxishjA==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLDc2-001A31-0P; Sat, 13 Mar 2021 23:24:02 +0000
Subject: Re: [PATCH] docs: devicetree: bindings: sound: Fix a typo in the file
 rt5682.txt
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, dt@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210313231850.17278-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <08789a65-5159-8658-5fc8-6f6e6efe3e27@infradead.org>
Date:   Sat, 13 Mar 2021 15:23:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210313231850.17278-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/21 3:18 PM, Bhaskar Chowdhury wrote:
> 
> s/drving/driving/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/devicetree/bindings/sound/rt5682.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rt5682.txt b/Documentation/devicetree/bindings/sound/rt5682.txt
> index 9c5fadb6ac82..cd8c53d8497e 100644
> --- a/Documentation/devicetree/bindings/sound/rt5682.txt
> +++ b/Documentation/devicetree/bindings/sound/rt5682.txt
> @@ -44,7 +44,7 @@ Optional properties:
>  - realtek,dmic-delay-ms : Set the delay time (ms) for the requirement of
>    the particular DMIC.
> 
> -- realtek,dmic-clk-driving-high : Set the high drving of the DMIC clock out.
> +- realtek,dmic-clk-driving-high : Set the high driving of the DMIC clock out.
> 
>  Pins on the device (for linking into audio routes) for RT5682:
> 
> --


-- 
~Randy

