Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204C53A7D93
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFOLxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFOLxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:53:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DF8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:50:58 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n7so11820582wri.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PdU2bY/SN4I7cszjYcsRntJqyJLTQNOvxI394iFHwtE=;
        b=QIttTeGnDuX3ukvTrSjLCivonyCbj6AL0CPj/APsfWHkMs5IOEpbDzAvkqp/vgkIfk
         DydEDrTplN7ddjZAlYn7pRuky18FqitJTnZviJL7TCgYtBgOA6tuvr3wceee0Qco2hJj
         bBXLpbBmCA58tbTxRDJE59RoGE46KkGa+QU4Nf0BQDo522GubsqeakiEs0su/qYZ9M2t
         5WK73HyHETlTPLlJoV00CPBduIQHMILcJgTGCSr6W/AzmvVzRJgjrB1C7MVS0Lhm/S2z
         IrILT/yC4LpO2IeBP7qFfsmz7v2xjjbhfnl3vj0GfNY05j44c2bjDz/Fs1WLrUc9pia0
         cOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PdU2bY/SN4I7cszjYcsRntJqyJLTQNOvxI394iFHwtE=;
        b=hWfj6hIS5XjAhvXmxFhoOUO2LiieRc/GxbSyV6xYQtfXiW9vm8W1QMFleumSLEl5f0
         SE8uVfmEsbEzSJBUjlobK3cu56AgpYd27yHRykRj4ZB5sNOJb7vaCaT7LSusSMholif1
         7lZPJ2H6ZpBTLGUsQbcQNZLPBTFRVM8UKPgsKGG/aZkiSdGgNfGglWcs3mjHhmun/KoM
         bWJ9rXM2pmxmjyh1wqbrzcv37ToMtF9iH88HAmoKtqYiv/QhrXxn6kLV60ta4f822wvZ
         56c/IwLqK5Je/FffGlTVZ+8p1kB6HjB71ock2PmV7J5v5TNh+PgOG1RHHqK+t1yq4c1w
         D4Aw==
X-Gm-Message-State: AOAM530tvxXEqEVvFjY5vVobRpvRLjha7AnPjNCebDoTrg8dwKxLsavs
        44Ulvnuoyh+/LUxRBMqSNlWFrg==
X-Google-Smtp-Source: ABdhPJwaMMKE8BX4TagB/Ws3iE1zriPycEW5yWNt/esE6SHmboWKy4ydFtjGBROjsSM1J2SOF1Efaw==
X-Received: by 2002:a5d:4089:: with SMTP id o9mr24747413wrp.195.1623757856801;
        Tue, 15 Jun 2021 04:50:56 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id h46sm20344662wrh.44.2021.06.15.04.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 04:50:56 -0700 (PDT)
Date:   Tue, 15 Jun 2021 12:50:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     patches <patches@opensource.cirrus.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] mfd: wm831x: use DEVICE_ATTR_RO macro
Message-ID: <YMiUHodC+0KAXPwD@dell>
References: <20210602114339.11223-1-thunder.leizhen@huawei.com>
 <20210602114339.11223-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602114339.11223-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021, Zhen Lei wrote:

> Use DEVICE_ATTR_RO macro helper instead of plain DEVICE_ATTR, which makes
> the code a bit shorter and easier to read.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/mfd/wm831x-otp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
