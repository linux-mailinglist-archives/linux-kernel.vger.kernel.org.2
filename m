Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489A1330373
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 18:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhCGRvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 12:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhCGRuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 12:50:55 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D6DC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 09:50:55 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id j22so1155908otp.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 09:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GQHl+zpu/inrbV1rjy5hkiRCDTdKkqauCTFc+qd6ozw=;
        b=XfhCIlUGeIh2UiwoJofuby65T2uX6tubjWDh5JGpp8ThmUn367aptsnQPPgHueQxdn
         TdhAA0aKTAoGkItigqy8f36XISKW9iIc0m93Ir2A3Cvd8KnhTZ8kel5i6p3GDCNvyc95
         UUT32CisSqE3bJl62Yla5a0JkYDI5IxDvCwebT4xtyxvCnn2C7TpiLGzN8BF73azGKQj
         lJTLsMfBj/jTlvu5+ObilpdclM/opJPElB69N039ZbOa5sBFTDQAMiTV/tafzHYnUml+
         c70g974fWgqR2nM3v9bpXDYH1v3KdbmH+evk6jTfX0dakFdq9xsLI5Hv6pjT6UXhjwfF
         QKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GQHl+zpu/inrbV1rjy5hkiRCDTdKkqauCTFc+qd6ozw=;
        b=NNQs1jpOnkQRg1l1v3u0QX5H8Gby/NCa+8sY5tDRD+Nha7IYMY7ROYnfUI2ThpbFMt
         Ow9fu3fYBF9pPmTUvDOeJbOv9fyw71XBgPnM4K6cni8JHeOgIzqVXcGjUwxLFaisC4dI
         /WMukWjz2ilqsOB1v9E4ujEPPfcLOjFJug326tB5+edQKuSAh6GkNXpppS5lrT+ijojK
         zSfvEDu37e6SOuy8l/xSF5d5i9ALTq3yTWQ0L4JVLd5womPnnLNJBygipbgArLv5pkzW
         IvkWVs+ml4RbckVhKGwWwnk9Zfn0dyozMot3ZHJOL8kmXFIXw5viUqQXgtEY+IhTWj7D
         wjtw==
X-Gm-Message-State: AOAM533mutEDWp7cRmtHiQNIHD972LrYp7YBqT9Xulh/ZGmcXacLLwz2
        gsebGIbiXCFHWfM2ebFSCqNVdOyU2O5dyQ==
X-Google-Smtp-Source: ABdhPJzLW/jntSpl9Yc+jhz/WZpZWEPpi5ZIs3PuynSoz26s8wddXpfzhThT+O/v/9H8kNSSrSyu7A==
X-Received: by 2002:a9d:5cc8:: with SMTP id r8mr10536306oti.215.1615138967469;
        Sun, 07 Mar 2021 09:42:47 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r43sm1814602ooi.30.2021.03.07.09.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 09:42:47 -0800 (PST)
Date:   Sun, 7 Mar 2021 11:42:45 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Elliot Berman <eberman@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 6/6] firmware: qcom_scm: Only compile legacy calls on ARM
Message-ID: <YEUQlY4X1e2PO8tl@builder.lan>
References: <20210223214539.1336155-1-swboyd@chromium.org>
 <20210223214539.1336155-7-swboyd@chromium.org>
 <b9174acc-9826-eb82-b399-ed95f7e83085@codeaurora.org>
 <161483844056.1478170.8701629037531614722@swboyd.mtv.corp.google.com>
 <5ac262bf-a70a-4ca3-01a8-d1432732d26f@codeaurora.org>
 <161501150705.1478170.3739297122787060750@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161501150705.1478170.3739297122787060750@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 06 Mar 00:18 CST 2021, Stephen Boyd wrote:

> Quoting Elliot Berman (2021-03-05 10:18:09)
> > On 3/3/2021 10:14 PM, Stephen Boyd wrote:
> > > Quoting Elliot Berman (2021-03-03 19:35:08)
> > >>
> > >> On 2/23/2021 1:45 PM, Stephen Boyd wrote:
> > >>> These scm calls are never used outside of legacy ARMv7 based platforms.
> > >>> That's because PSCI, mandated on arm64, implements them for modern SoCs
> > >>> via the PSCI spec. Let's move them to the legacy file and only compile
> > >>> the legacy file into the kernel when CONFIG_ARM=y. Otherwise provide
> > >>> stubs and fail the calls. This saves a little bit of space in an
> > >>> arm64 allmodconfig >
> > >>>    $ ./scripts/bloat-o-meter vmlinux.before vmlinux.after
> > >>>    add/remove: 0/8 grow/shrink: 5/7 up/down: 509/-4405 (-3896)
> > >>>    Function                                     old     new   delta
> > >>>    __qcom_scm_set_dload_mode.constprop          312     452    +140
> > >>>    qcom_scm_qsmmu500_wait_safe_toggle           288     416    +128
> > >>>    qcom_scm_io_writel                           288     408    +120
> > >>>    qcom_scm_io_readl                            376     492    +116
> > >>>    __param_str_download_mode                     23      28      +5
> > >>>    __warned                                    4327    4326      -1
> > >>>    qcom_iommu_init                              272     268      -4
> > >>>    e843419@0b3f_00010432_324                      8       -      -8
> > >>>    qcom_scm_call                                228     208     -20
> > >>>    CSWTCH                                      5925    5877     -48
> > >>>    _sub_I_65535_1                            163100  163040     -60
> > >>>    _sub_D_65535_0                            163100  163040     -60
> > >>>    qcom_scm_wb                                   64       -     -64
> > >>>    qcom_scm_lock                                320     160    -160
> > >>>    qcom_scm_call_atomic                         212       -    -212
> > >>>    qcom_scm_cpu_power_down                      308       -    -308
> > >>>    scm_legacy_call_atomic                       520       -    -520
> > >>>    qcom_scm_set_warm_boot_addr                  720       -    -720
> > >>>    qcom_scm_set_cold_boot_addr                  728       -    -728
> > >>>    scm_legacy_call                             1492       -   -1492
> > >>>    Total: Before=66737642, After=66733746, chg -0.01%
> > >>>
> > >>> Commit 9a434cee773a ("firmware: qcom_scm: Dynamically support SMCCC and
> > >>> legacy conventions") didn't mention any motivating factors for keeping
> > >>> the legacy code around on arm64 kernels, i.e. presumably that commit
> > >>> wasn't trying to support these legacy APIs on arm64 kernels.
> > >>
> > >> There are arm targets which support SMCCC convention and use some of
> > >> these removed functions. Can these functions be kept in qcom-scm.c and
> > >> wrapped with #if IS_ENABLED(CONFIG_ARM)?
> > >>
> > > 
> > > It can be wrapped in qcom-scm.c, but why? It's all the same object file
> > > so I'm lost why it matters. I suppose it would make it so the struct
> > > doesn't have to be moved around and declared in the header? Any other
> > > reason? I moved it to the legacy file so that it was very obvious that
> > > the API wasn't to be used except for "legacy" platforms that don't use
> > > PSCI.
> > > 
> > 
> > There are "legacy" arm platforms that use the SMCCC (scm_smc_call) and 
> > use the qcom_scm_set_{warm,cold}_boot_addr and qcom_scm_cpu_power_down 
> > functions.
> 
> Ah ok. Weird, but I get it. Amazing that SMCCC was adopted there but
> PSCI wasn't!
> 
> > 
> >  > +    desc.args[0] = flags;
> >  > +    desc.args[1] = virt_to_phys(entry);
> >  > +
> >  > +    return scm_legacy_call_atomic(NULL, &desc, NULL);
> >  > +}
> >  > +EXPORT_SYMBOL(qcom_scm_set_cold_boot_addr);
> > 
> > This should still be qcom_scm_call.
> 
> You mean s/scm_legacy_call_atomic/qcom_scm_call/ right?
> 
> I don't really want to resend the rest of the patches if this last one
> is the only one that needs an update. This was a semi-RFC anyway so
> maybe it's fine if the first 5 patches get merged and then I can resend
> this one? Otherwise I will resend this again next week or so with less
> diff for this patch.

I'm fine with merging the first 5, but was hoping that Elliot could
provide either a "Reviewed-by" or at least an "Acked-by" on these.

Regards,
Bjorn
