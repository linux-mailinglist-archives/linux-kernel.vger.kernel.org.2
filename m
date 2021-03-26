Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5220D34AB8F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCZPch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhCZPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:32:16 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A380C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:32:16 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bt4so2718682pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=shWDx59AesrkQIBJ0HQxol61//HEQgZeaaeeBvaZnTE=;
        b=gjCulAkx+OFFY8XziBxbHNaxjP+zhQ/bgUHtot1Zr5EkwMNOvp6Hz1hbOIgofLFPSv
         PvTBe/lVtA6NWhZ/NkKuzV1RmjCSCn6KcN40BBOCIQDhd7QKUsgC/wec3BivUYjFHngs
         WAG49BZMiZN5gLWNArhJWh7dAGCPQl7nebuxthTIQm2SVf744jeavxG9R0yW9tywKokM
         6ZjofnhusqWsDmg1Rtdj+2WJRHTJ0+AZqOpzLwKwBATBToQONUfGVCUP//CF9Bex+FxC
         0h478E5dqjRJuIfZA3xjhF/CVaIaKcABNZNTcB/adGbIKXhCDxt5j+FtA+QgZtheTUtP
         zBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=shWDx59AesrkQIBJ0HQxol61//HEQgZeaaeeBvaZnTE=;
        b=HcE0GaYpHHNQGht39O5AQYxa7/0flATknv/HrPy7SfcfggruUiX4lEJ2ykw+vNdyMW
         zwM4JMRofvXIZ7EiGK99SJKtKmSXhiXhmsUNMZ1VxjlKiMp2ZVZyzbR7fjdk6CI6FW0L
         r7+id7MOuo9rfphmtBk61BjJ0KJGOwPQA0P/B3STZjQK4V7syHg1ST/VhY1hQzxgkEDV
         COJkbTeqS8ws4p/jYFjICnN6vHYL2tHZQ25rd1+tp4e5RoRapmDDWHGl9nqw3ZP10e2f
         itGiEIZmr+G9LdixsKikF9bL2x08P9StOfIzNvAwD4bikFuCB6Cw7G2tB8xUYREFLozM
         icDg==
X-Gm-Message-State: AOAM533SYij3sXF/1poys8mjzkxEoL5Rl6Jn5uQKGuGLTENtMtqOikNR
        LN3PgjMoHRO3MT7ZNWgg2fYI9g==
X-Google-Smtp-Source: ABdhPJzpajusYAJ3lV53LraA4ksa7e4AnMF5tcbCrqc4k84bZJvb5YlBVgWv3Ecw7tHHP1DBxfbH6g==
X-Received: by 2002:a17:902:7b84:b029:e6:ec5a:3097 with SMTP id w4-20020a1709027b84b02900e6ec5a3097mr15352269pll.58.1616772735660;
        Fri, 26 Mar 2021 08:32:15 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id gm10sm9117873pjb.4.2021.03.26.08.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:32:15 -0700 (PDT)
Date:   Fri, 26 Mar 2021 09:32:13 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] coresight-pmu.h: Fix a typo
Message-ID: <20210326153213.GA2009902@xps15>
References: <20210326142244.17504-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326142244.17504-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhaskar,

On Fri, Mar 26, 2021 at 07:52:44PM +0530, Bhaskar Chowdhury wrote:
> 
> s/orignally/originally/

Even if the change is trivial this changelog is insufficient.  Moreover, if you
found the problem with an automated tool, please add the name of the tool to the
changelog.

Thanks,
Mathieu

> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  include/linux/coresight-pmu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> index 4ac5c081af93..2d5c29e3cb8a 100644
> --- a/include/linux/coresight-pmu.h
> +++ b/include/linux/coresight-pmu.h
> @@ -14,7 +14,7 @@
>   * Below are the definition of bit offsets for perf option, and works as
>   * arbitrary values for all ETM versions.
>   *
> - * Most of them are orignally from ETMv3.5/PTM's ETMCR config, therefore,
> + * Most of them are originally from ETMv3.5/PTM's ETMCR config, therefore,
>   * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
>   * directly use below macros as config bits.
>   */
> --
> 2.26.2
> 
