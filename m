Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F7742227C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhJEJkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbhJEJkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:40:15 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64752C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:38:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s15so8023751wrv.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 02:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vt9oy+0kcElMx6lSJpjsV9uP82l0Z+RoA+ivzl5gLLQ=;
        b=py36VqET7Mcd78BQTYkjhaGkz6+fhMmSLSICQIezDBrLNYaQ4htKIDZqTdBgNycNpV
         UEnXtku01BKhzZo4K59hnJSf0mXC2DtG4d+7g1s8SmFcXtk0LpDf/brT7GQYRQsCvhFn
         9emCFWPLaQM0DvrHvq2Ivibwx5F3AXpzgn6eczf6Xttaj1l1bm7zjj0MecyyLdgTaGtp
         2lOV1VlUCvV93Y/NZInzWI1c1xTpCXrd/kX/tw3syYeRfPeW+5VcbbVODEq4lIS7z6qn
         vq6XgzTvW5DDe8xp/NJj25+D8dqytOVAcE/xzOVKFELPxrBmGnJRwzZ7AjRDojsgLCg/
         N3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vt9oy+0kcElMx6lSJpjsV9uP82l0Z+RoA+ivzl5gLLQ=;
        b=xVERoFJdt/IYLJ+kVZe1VRbZvxVUBcY4z54GrgOK53wzfB44Qy1kEsVBROEgNxQYW6
         //tzbbIyYU0/d9h6AVSfrCwvCRGS8X4HhfIzg5Ao29Vul+vGqIOpGX9nrl5+kqaZox6d
         o+axDoaVA/zzhiJkqVX8Mkr1kvDh5jkMMIQ5IS/41Wh/OpC0I7d7yoW33Kn8I+4V3fbo
         n5CfMOadiw8lWdgPZtBbXG4/I82VMpINrdgJOZSSsZQyKAhLRieTX0fOszmd/07ucdFN
         xYl7eeGEgx8CGncacDXMO1u8y9IhrxrPaT5grT9plD76qRASNhgwh3MMZ+MaZ0moFB+g
         ZGWA==
X-Gm-Message-State: AOAM532UBaCS2UaQKUAOM1og9ZIUzsHziV5+p81CtiAYmRyxdU+lmfy+
        1P0Ge2rzx25wUKujxPKfGJbv2Q==
X-Google-Smtp-Source: ABdhPJy2Cv4VLFXCmn/y9qaTgx5H3ZhL33c2RWwwNK7Ws33XZqkeaVtFR0N8phhQcgpM8qjPLyvO8A==
X-Received: by 2002:adf:97cd:: with SMTP id t13mr20122276wrb.312.1633426703978;
        Tue, 05 Oct 2021 02:38:23 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id c185sm1321846wma.8.2021.10.05.02.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 02:38:23 -0700 (PDT)
Date:   Tue, 5 Oct 2021 10:38:21 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] backlight: qcom-wled: Override num-strings when
 enabled-strings is set
Message-ID: <20211005093821.6kj6wuoszz2ruodl@maple.lan>
References: <20211004192741.621870-1-marijn.suijten@somainline.org>
 <20211004192741.621870-4-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004192741.621870-4-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 09:27:34PM +0200, Marijn Suijten wrote:
> DT-bindings do not specify num-strings as mandatory property, yet it is
> required to be specified even if enabled-strings is used.  The length of
> that property-array should already be enough to determine exactly which
> and how many strings to enable.
> 
> Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
