Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BCC35F085
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbhDNJOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbhDNJOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:14:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B42AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 02:14:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u21so30288896ejo.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 02:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=S7Nl/dzV+akrNQvsnMiiu0kWOdSscSjYzYhuC8wPGSo=;
        b=sOAHL2mWZY+78lOShlM9reMPKSryH3wmn68iz72GGBR1FFS00omlpI2mEX6ZHMHWuO
         PFa9A3s0l68RfmQ6P2iJHwiPR5uKMwwckKQy8LFghkatWq7I4vOKmQrGzMvuLWJwvfxW
         QQ1DBDxGclm6Daz4v6CWoFD5FD1eMFPoXLxufRwW3lG2QSjUR310mYetX2rlBxQqFxVd
         hCO2lJoj0NF5IVSPn8NPgRuHMDId8LLuYvruI764bZ9e3TA1Ua6XPeqhiDCPg2i12HHz
         p25zrILMduceN4Xvs6hNFQvU0O5oYaup/EaEfxG/OiCpqU3UkOW22cgAzr72xfrqB26v
         y9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=S7Nl/dzV+akrNQvsnMiiu0kWOdSscSjYzYhuC8wPGSo=;
        b=luRy9glSE1bmOkTJFOrX1kFawPg79jFW1IH6VlJ4giI5ZkhNAI9foiTsF7yMZ+Fusv
         E5vouHOzAhrxY5F82eCviGHgHJdOr40AwFUy7BnLU4ug8d3vNPHuO4JL3Ctq+9QIp+GK
         GD7NBx34WwDb8Ay7SX7yyyyt36c1KXMRCulKllJOO+tBYVVdnVZn0dV2q146FowLTQxP
         IvCaWOG3ct/p+CNb/YjR1DBOUn01ygShm60/VO7v3YssmLHkg/R+ZpZRsltFaP3cZ2xt
         16JfaJRKoi3a+sibtb387NDfGelY3kZkHqC2fWUOEBoDs8/oe30C8qnPi360RxXEF7mT
         xvJQ==
X-Gm-Message-State: AOAM5311vLNVmUpXiHPh1DIWBVpADtfls4wjEk8WTlpG2UOmHPWZGlNP
        HA5Q/x6vp+d+WD8Guqj8PzhvE9OULHZwuQ==
X-Google-Smtp-Source: ABdhPJzSE77OdgvHeXMjrSPwShkQBqyaUfMKBJdNP8DC+Pd1oVy/CV7nZi+AtvWVQKlFbJ++gZa5DA==
X-Received: by 2002:a17:906:bc41:: with SMTP id s1mr10635848ejv.527.1618391655173;
        Wed, 14 Apr 2021 02:14:15 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id i2sm11453134edy.72.2021.04.14.02.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 02:14:14 -0700 (PDT)
Date:   Wed, 14 Apr 2021 10:14:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mfd: max8997: Add of_compatible to Extcon and
 Charger mfd_cell"
Message-ID: <20210414091413.GK4869@dell>
References: <20210405071344.1215429-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210405071344.1215429-1-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Apr 2021, Timon Baetz wrote:

> This reverts commit 9c03008da125c1007919a9186628af3cc105f526.
> 
> commit 41a8a027f4d3 ("regulator: dt-bindings: Document charger-supply
> for max8997") introduced a binding which uses a property of the max8997
> pmic node to configure charger supply, making subnodes for MFD cells
> obsolete.
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
>  drivers/mfd/max8997.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
