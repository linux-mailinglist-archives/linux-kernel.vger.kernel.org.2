Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0FE397818
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbhFAQck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhFAQcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:32:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C269C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 09:30:53 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q5so4364233wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yFoi4/Rm5d18YcpSapUrPhKaluOYCl+WuvN0Px67Aqw=;
        b=d7P2mzuKCNCw5zrU6F5OlkkytG2GBomDc+OaEF/eomBIMMccIjU6xmcWKdXn9bKeWQ
         gTp/5bSV4SOhSqShyOed/W/8H43T126FOhtwjF/plR8gpH8Wg8FETHDibTd/J3J2fruy
         JLip/n575npCDmISZT7vo7HrRLI/yTlKWpIif83Ua6g94eUUL1N2df23vvhix3179ffW
         GEmHJROs0GuD+T+iQF2CLbtNxMxJLn14UXLHsNMg71LeOfY3qDGcqHVlafy5ACjtXVLJ
         9jtadeElgD+ZtM386nmEf49FE/aWGoQEERgf6g91yzD4fK/1p9cGqb094mXHrsxTrqOg
         RzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yFoi4/Rm5d18YcpSapUrPhKaluOYCl+WuvN0Px67Aqw=;
        b=eYS+i4ktsSQS0hGeDnSSahBvdjabBm2mmyIwT1fgfMbeyM7I5W62n5TLSzZHcXo6L2
         TOrAQGYtZ0wf/dl+bX53iL61ozR0hKNAYGZ6Ee+1EEVGTCI2bS4boVBxE5Fla7Bum1pl
         ZIbO2a2Hcjj9pa1ha07RCyLSMM62PRFNneXIz4Y14JMFANapAXanmNPfVxYCVfntWueU
         8GG3oQb118jjWhc/pO0Y1VfxsXMjtZ9MdoZuR5csvVk0BthxBtPZqGxyQKVSNGMeDcCD
         Ydg7fJRF0UdUgc/p16hAjeXo8TDGY/2e1L+1qaXuTCjxesU+KzVXEeUHwqHE5Px0gsb1
         iylQ==
X-Gm-Message-State: AOAM532gPp1WifuR2aR+E2Yq7x1P2DXE/f7B46EZGeshsWAiWNUIlLE+
        z2MVM+71GOFaQNO+jF4TX6UR/A==
X-Google-Smtp-Source: ABdhPJw8E/nFadihmxuNToyBOWYPj0n2wyaPusY/GpN99flnk5204EKpcUCqjOYbkFZFJZ9YESR1iw==
X-Received: by 2002:a05:6000:50d:: with SMTP id a13mr27815239wrf.130.1622565051931;
        Tue, 01 Jun 2021 09:30:51 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id v8sm4271697wrc.29.2021.06.01.09.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 09:30:51 -0700 (PDT)
Date:   Tue, 1 Jun 2021 17:30:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     patches <patches@opensource.cirrus.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mfd: wm831x: Use DEFINE_RES_IRQ_NAMED() and
 DEFINE_RES_IRQ() to simplify code
Message-ID: <20210601163049.GG2165650@dell>
References: <20210601070009.10098-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210601070009.10098-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Jun 2021, Zhen Lei wrote:

> No functional change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/mfd/wm831x-core.c | 248 ++++++--------------------------------
>  1 file changed, 36 insertions(+), 212 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
