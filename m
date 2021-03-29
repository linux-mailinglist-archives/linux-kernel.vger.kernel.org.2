Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C44B34CD4B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhC2Jsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhC2Jsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:48:51 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783F4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 02:48:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so6338758wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 02:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OyMXSReW5FYxUKuG3bzOVzDvXsFOeos0aY2G6CR/ZWQ=;
        b=yXTW1lq7sr7MfPFMudBJJW3aAoI+xbdYXVRC+H2zJTTVYyqnWRW1i4AgBbvDiHvn3m
         Q2fkk7Z/ZZjQDzLQWLXrXlVaCEMJzSWm7uNCKveGUclEdfvbTXzrk4k0uwfQgtBlWa3v
         MdLcm75t0ppSj0/VGwe9qCuHR21X9x7FXZwHFMMWLLddMezUlkNe3+a8tkUsnOUfv+Ui
         MpNsBJ5MY5PZu46Cx84/pUCqyHCsjp28sjWaSv7e1zkVXPzuGFNxhlO2El3igaodaIPt
         QQXkqa9Vsy8q3Gb7GEj/sB8Sfd570q0aarzfcic0/kOvVNtnmyXCz2ycHLTsZJ9oGM5B
         0YAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OyMXSReW5FYxUKuG3bzOVzDvXsFOeos0aY2G6CR/ZWQ=;
        b=NYcKexHldLaaJI9/RKLO/rwrkMqbaKouzufcqkTxdyxfe8pfFPFv/e9ruwf4M9Qc2G
         YV+jdKD3WIi/3MF609oSJQ0Q15xhxILjvyzy0asO7TVDy2HZGSgxI2qSN4SXYwcvJUP1
         3ANCVnPWoBImXIAWnRRtTym3Qh2VAbpye9VHQ3+McDGjTYAm5BVKJNZyVhUcLB6Bk6dc
         CZKG3AD+4mT5fwDubj7qroFbafZT8nth2+XKwBIJipmfHrpW/Zo7GVg75J8/YefmH3tI
         J1+UP4sadcfQmNrQ+gK9IvtaG7qMLqcjjgKw9/58rF6iQ9vYlI4Nxafz/7nTGparglX2
         lZqg==
X-Gm-Message-State: AOAM533xM8q6RPOWpZccC/8WNlM114Ri0lqHYGDzXMWye/CHTBf3CkAh
        Zwfm3Ca90qky8k0G0m/wFKd/dw==
X-Google-Smtp-Source: ABdhPJxbgDYoFM6blksIzoZrNSp5FDcXl/dwr+Pc88v0S7ka0SMIJAUSfT5ORFZQaPH57iOUoe8tWg==
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr24024486wmd.78.1617011329805;
        Mon, 29 Mar 2021 02:48:49 -0700 (PDT)
Received: from dell ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id h20sm23342409wmp.38.2021.03.29.02.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 02:48:49 -0700 (PDT)
Date:   Mon, 29 Mar 2021 10:48:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rob Herring <robherring2@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the devicetree tree
Message-ID: <20210329094847.GD2916463@dell>
References: <20210329195351.3322aee1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210329195351.3322aee1@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021, Stephen Rothwell wrote:

> Hi all,
> 
> After merging the devicetree tree, today's linux-next build (htmldocs)
> produced these warnings:
> 
> drivers/of/base.c:1781: warning: Excess function parameter 'prob' description in '__of_add_property'
> drivers/of/base.c:1804: warning: Excess function parameter 'prob' description in 'of_add_property'
> drivers/of/base.c:1855: warning: Function parameter or member 'prop' not described in 'of_remove_property'
> drivers/of/base.c:1855: warning: Excess function parameter 'prob' description in 'of_remove_property'
> 
> Introduced by commit
> 
>   3637d49e1121 ("of: base: Fix some formatting issues and provide missing descriptions")

Ah, I see.  Will fix.  Please bear with me.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
