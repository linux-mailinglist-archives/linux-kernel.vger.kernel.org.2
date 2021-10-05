Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5E7421DA7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 06:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhJEEsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 00:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhJEEsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 00:48:20 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B992BC061753
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 21:46:30 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 133so18658858pgb.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 21:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oU0y/L1Kv7h8rjDf7ezD8KvTWO00EJ3BiI+ZclBMT+w=;
        b=pRO4hYs7dy8DnFLkzsum1hayDKhtSmwJ0KwVN49yNiKOTVcDCqgL6Nym+QWQ6KKGIk
         u0Qm1EhsfiI10jUTsTm//HiUtUjPTywNgnnbPFQ1tbXidYSXeuIaOliknF/ksiDu0YM9
         8hfwIKq2Y86O0Tr5RccWvDaM8rfVK6wD0Q2ZlPbxBbkPG+pW3FL7cN4+JdFH1E5l2e50
         uqVTAMlaZWEUHkLtsAnYLgXsXA44W3xV7UdHN+cmH0chEH3MPPuQ2IfIGy/Z3vyOslPu
         SspaBL6ccG4F+0nd7B8TJIVKrkF0cXXN/WCgqLdQwJU9x9QyuqYadxUYh2Qu8Nu7y1yP
         eONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oU0y/L1Kv7h8rjDf7ezD8KvTWO00EJ3BiI+ZclBMT+w=;
        b=ZHJ965TNOi4abclLzquhJbzXU8FNYg+xEhvvIABKMV/pIiTJrSvKy6IrYN906mqSiE
         dhAnRCVdVw1KgxtL/6Vsyqmm4jSJAImefhOFWwzGgFwDpda8hDqZOrvqC4vjlXD4n1Ys
         wmKDH7XQ4MQGxFeaiL2eGgfowLJvRrORk1e+Btyv2vq/yNVecotV+0idYEUU/4Q4RUiN
         CEMZgkMWfN4uorWUfykbQXjFtuR1zzizj1YKguIEr3F3/p+z6qySQIduLKUyygrMCF7t
         lJ2eG1R1TchDCHdy+vl2D3xR2euvDZSJq97nLUO7CPXwDmmGMlTVO7Q3EhT962I/g8ej
         fnyw==
X-Gm-Message-State: AOAM5313HoI17IQEzXAQbHCfLp6YuX7Tiytv1aAJIrehvNrut08stmxz
        l7m8aL07m6ZLyYZCH4DViScE0eb/PJgY
X-Google-Smtp-Source: ABdhPJxhXUmFhJYMG650PXT4U5Cg8sHpINcD7y5trS4JlMzsEZwxtjoLOtzNO02sROfoinqm3g6TTA==
X-Received: by 2002:a63:b707:: with SMTP id t7mr13893203pgf.55.1633409190133;
        Mon, 04 Oct 2021 21:46:30 -0700 (PDT)
Received: from workstation ([120.138.13.79])
        by smtp.gmail.com with ESMTPSA id z33sm15305980pga.20.2021.10.04.21.46.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Oct 2021 21:46:28 -0700 (PDT)
Date:   Tue, 5 Oct 2021 10:16:23 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rafael@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML
 bindings
Message-ID: <20211005044623.GA4195@workstation>
References: <20211004044317.34809-1-manivannan.sadhasivam@linaro.org>
 <20211005042300.ix46h3ceu7aiwrg7@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005042300.ix46h3ceu7aiwrg7@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 09:53:00AM +0530, Viresh Kumar wrote:
> On 04-10-21, 10:13, Manivannan Sadhasivam wrote:
> > Convert Qualcomm cpufreq devicetree binding to YAML.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> I hope you will be resending this after fixing the DT warnings ?

Yes, but I'm not sure why I can't reproduce the warnings locally. I did
upgrade dtschema package and installed yamllint.

Anyway, will remove "maxItems" property as reported by the bot.

Thanks,
Mani

> 
> -- 
> viresh
