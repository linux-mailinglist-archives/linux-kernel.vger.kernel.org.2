Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAA84531D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhKPMMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbhKPMKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:10:44 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A44C0432D5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 04:02:17 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id z1-20020a05600c220100b00337f97d2464so1646732wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 04:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lDB8txmndiyc2KBELD6n3DhmgYu8EUzPVuapNCQo1zs=;
        b=mldJEOu5NnmqmiMKzPY9mz4IDbBaAR8ZcKLbG0mHBR1p/bymyHk4A4WmkcwvmMlC49
         QXby76RujpVem0BcrrnMrZl6V/5ovityJgIR9R7IPEF0w0lN9nfNaFvG0ZcaH+odLMrV
         BLXG0Gj43otjSUslxvnTqFnMIdf5lgrLEgxMaJF7BAnLMjfYaLV9ccYKHnkaHna67Tc3
         f+NUSLHyELqD+EhXH//cGilrC5xyNQn+yfKIGQYlMBCY4T69ZIUyZOXC7PX9sLQuUUkd
         3TE726MkaJFV+JTdlj8n3RWk/IG/usYTIma6oaI5FhMfjDY0uR1acYx+8yBvUL03L8zj
         xviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lDB8txmndiyc2KBELD6n3DhmgYu8EUzPVuapNCQo1zs=;
        b=XN4HqVGH4yq2WP7qsHbYawA/kcLgry/XBPWaMuaTzHi+o38/UzFm/quU0Psr90sCwq
         jqfE5QJTyHKDA/XqNZ8mZFw2Rb7Iq3VECGeWpGpADnIaVHSdDnTLvVB8tHt6Z++WEVu1
         jKqw5TN6JKvyVJQzaZGz8SD4xpIQLav6g0fSyM3PQQWnjQJc6BpNI831HkLmjuX3PibZ
         jWu0Bi/NLN4FNtEiWdkjuBds32giTVOL6h0FFLq93bUL+junWCVynVDFbGcvk/D0FGu0
         rjQepD1oYJsknwLojmdQDoJpCahrWbXn2ZUZjXOiypZWQxtoAUri4b11gQuh7bc1tBbV
         XTvw==
X-Gm-Message-State: AOAM531GONUfIK2KikUOa33SZxYHpxI89lbNXTZuH0DEuCaw5icQCL9D
        8uaqQY+Vulx7juNeilFCLPiNuA==
X-Google-Smtp-Source: ABdhPJy0s8g4BijfftlxD/F7elVGNq4pmmk3Cu5+zRpMwyxjgqhMYGMoZqI1RiG+YUAJq6W28VKZIg==
X-Received: by 2002:a05:600c:a0b:: with SMTP id z11mr70111480wmp.147.1637064136454;
        Tue, 16 Nov 2021 04:02:16 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id l124sm2298443wml.8.2021.11.16.04.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:02:15 -0800 (PST)
Date:   Tue, 16 Nov 2021 12:02:13 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 0/9] backlight: qcom-wled: fix and solidify handling
 of enabled-strings
Message-ID: <20211116120213.n7qxqfi62lrxhyl7@maple.lan>
References: <20211115203459.1634079-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115203459.1634079-1-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee

On Mon, Nov 15, 2021 at 09:34:50PM +0100, Marijn Suijten wrote:
> This patchset fixes WLED's handling of enabled-strings: besides some
> cleanup it is now actually possible to specify a non-contiguous array of
> enabled strings (not necessarily starting at zero) and the values from
> DT are now validated to prevent possible unexpected out-of-bounds
> register and array element accesses.
> Off-by-one mistakes in the maximum number of strings, also causing
> out-of-bounds access, have been addressed as well.

They have arrived piecemeal (during v1, v2 and v3) but all patches on
the set should now have my R-b: attached to them.


Daniel.
