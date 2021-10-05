Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858FF42221B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhJEJXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbhJEJXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:23:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD8FC061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:21:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t8so36233754wri.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 02:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YyFRyEHqynJbmWmKpAdZjz+T5rvFi/tpprXJLcyRG+c=;
        b=zU6qTFB44YrqG7QPOsXyenlqdjTTnsITuNv4caDgpwMUfUfDza4ur1dItnA+o5tCes
         BABj0CwihjxhMiEdeRqfM6eeHaNAJu/wLcb+30V83CgVz3MiPZNuT4JJKieDuqWj0iiX
         HPFdKAz3Vb0jzuzfvLnA9IhCPn5vBxXkprMTYCB/Fezv02qH9csTJlqzipGQsHtFckzV
         q3ek74KvDAO+ZHK5DEfC49BwDZDX6YF065rWYDXU9sR4UI5q33IMFUMLHdpZp84I8SUp
         fhYUq1lL0T01Y5DJl0yf2qDytTHBQMzDOhPTTBv6hbHbYoNemG+UzYKdAL3w8MvYjbfd
         ABzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YyFRyEHqynJbmWmKpAdZjz+T5rvFi/tpprXJLcyRG+c=;
        b=3BkOCDYYc1rDaPJDrzJ6XsMrE/vnQLK7j+z2j4PcHA5yeCEXD/TvNdEs2+yJX4mhKY
         4LFWbgD1qrcB1jtHipL/ixvl0J1BFO0MyY856PsI6XsJQVug/NL+cCF6lueQkAE+GjzC
         ATiEsI3lv1Vc4BSArffgE+Y6RncRAAjM0XKtTTo3j1gLcS44w64m9V/SpiXIQKen75Vr
         VswSgBuV5em5+tRH/5742BHJ8pqkE62Vk/Ry5XDLnMrfyf83hNJAjRWaxR6ad1Qn3L6g
         W2Gt5+MtgLr/nRpyo3gCMqLu56PKKZxmQFHxonVbP3zsFTQfXUR10JGWH+75IfeeFD4B
         Dy/Q==
X-Gm-Message-State: AOAM532NL8uHa1POjgNW/+sqeNtm7duUnQ0rcXx6qyDUHR3OABeH2qgJ
        P/LV0bdmuxVsqTPzT8LMrzePpw==
X-Google-Smtp-Source: ABdhPJxGEywgmrBoEZ6DWLGsjAD6iNKNcElVuvD49frLRb7/uaoZeADnEzDGMaHNCxL23n45nw/LPg==
X-Received: by 2002:a5d:55c3:: with SMTP id i3mr20343391wrw.87.1633425682881;
        Tue, 05 Oct 2021 02:21:22 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id n186sm1266882wme.31.2021.10.05.02.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 02:21:22 -0700 (PDT)
Date:   Tue, 5 Oct 2021 10:21:20 +0100
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
Subject: Re: [PATCH 07/10] backlight: qcom-wled: Provide enabled_strings
 default for wled 4 and 5
Message-ID: <20211005092120.pe3z6jzs4bzc2zrx@maple.lan>
References: <20211004192741.621870-1-marijn.suijten@somainline.org>
 <20211004192741.621870-8-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004192741.621870-8-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 09:27:38PM +0200, Marijn Suijten wrote:
> Only wled 3 sets a sensible default that allows operating this driver
> with just qcom,num-strings in the DT; wled 4 and 5 require
> qcom,enabled-strings to be provided otherwise enabled_strings remains
> zero-initialized, resuling in every string-specific register write
> (currently only the setup and config functions, brightness follows in a
> future patch) to only configure the zero'th string multiple times.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
