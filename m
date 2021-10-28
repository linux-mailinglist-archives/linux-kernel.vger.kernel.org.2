Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B05E43E821
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 20:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhJ1ST3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 14:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhJ1ST1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:19:27 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27259C061243
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:16:59 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id m37-20020a4a9528000000b002b83955f771so2408359ooi.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wusxu4vVS094WYADHFLACryqXCZAQomcEnv/oqtQUp8=;
        b=cIHck4f7AU6fCfChVEV2LovuiRMjA9npqq575g7mD6uUXAWIZK7H/dd0FYbkYWvcLw
         THcW+crPTr8lmtELnV92shgpOg7arjpaszvQRz613ZU/fICX96ZR7nz0A+Zs5ZWX2Kzu
         3Fxyh0V1kgUIi49NKrpybu+L1b2eGf9O4QvZQI8qc2ZWwFFux0z41haIX4Vcc6wgljWR
         MDV+4WCiRPJBUi+UaFPrdiEtNHYRNGNAC/yesi/c2odE1ZPoTN4ofOemZsJA0bfvkzro
         RVFdWyPcFsTjJWMnxm3mzqX74df7+nxkEJqS8WqXZ6DsJcMWEMdTR/QCI0bM6LMkj2JB
         0REg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wusxu4vVS094WYADHFLACryqXCZAQomcEnv/oqtQUp8=;
        b=M1Ypp0cxpINudUQcYSYJcUkf31xNkVTeNB9IpGTwXiaCpD3UB9b2TnK78EnMHuBrsw
         AIdxA7XGMSgElYJil2vSEK1K3qnF4BwhmikZMocasloW+xx57Hy3STHWcY9l2TJShs1k
         kNkh2tJRbm1b59v39Y53xQm/wldUjQtgWcPQPSFSD2f9Zm8CuQVvQTvQ6ltCqS7Nsfua
         +Q8HkiMnfvkyB9hdk7vXwwO+3nQ2m8clUDyZOP8wVY3iYRFnvekq0k2t0GDmvBTF5JFa
         rZmp7+kmGfnSYfbLBocS+X3XO9KT+giJVu78/hwf3NDUilGUwNJQOoDl1YXuVp4nJ7CF
         De+w==
X-Gm-Message-State: AOAM5325xstWZpq1LmRhYv2+EteL+vBUI+XxXtlF9n1NGwCziYVbrLrd
        j6cVfcMhXDWEgFSIlQucXUkGUA==
X-Google-Smtp-Source: ABdhPJy7YMoWnmrHfImanNmbs6Unt0iAC5Q17Vv8gEqfdVoObsC06l/dfy2j5VCFf7uWMyZht8j/MQ==
X-Received: by 2002:a4a:e218:: with SMTP id b24mr4268610oot.36.1635445018092;
        Thu, 28 Oct 2021 11:16:58 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id bq10sm1288528oib.25.2021.10.28.11.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:16:57 -0700 (PDT)
Date:   Thu, 28 Oct 2021 11:18:45 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 4/8] cpufreq: qcom_cpufreq_nvmem: Simplify reading kryo
 speedbin
Message-ID: <YXrphSSG9+zsZbJ9@ripper>
References: <20211014083016.137441-1-y.oudjana@protonmail.com>
 <20211014083016.137441-5-y.oudjana@protonmail.com>
 <f4af0e40-9e93-dba9-7401-cdfc76ba667e@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4af0e40-9e93-dba9-7401-cdfc76ba667e@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15 Oct 11:58 PDT 2021, Konrad Dybcio wrote:

> 
> On 14.10.2021 10:32, Yassine Oudjana wrote:
> > In preparation for adding a separate device tree for MSM8996 Pro, skip reading
> > msm-id from smem and just read the speedbin efuse.
> >
> While I'd really like for this to be merged, it's gonna totally wreck backwards
> 
> compatibility.. But then, since APCC was not defined properly before commit
> 
> 0a275a35ceab07 arm64: dts: qcom: msm8996: Make CPUCC actually probe (and work)
> 
> there's only 5.14/5.15 (both of which were non-LTS) which would *actually* break given
> 
> somebody decided that "ah yes, pulling in DTs from these specific mainline kernel releases
> 
> is a good idea"...
> 
> 
> If I were to judge, it would probably be fine to rid the old mechanism..
> 

Given that various people have reported instabilities on db820c in its
current form - and prior to that it was too slow - I think it's fine to
favour getting this sorted out properly over backwards compatibility.

Regards,
Bjorn
