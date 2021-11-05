Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABA7446587
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhKEPRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbhKEPRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:17:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C04C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 08:14:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h24so2215490pjq.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nnHVWr/JLQ/giaq/yHDXfmSji6/e+JJxcUykqE8B89M=;
        b=oHdbuefenRoP6A2SUrVt0mVVYw0O0CW6sQv8g9B6tJUKTDX0hFwFdWaLcbQrNWbEza
         oIorq9MPBFM0ZA2sIYw6r3ZDRej20wciO/bDi6vFl0Lm8QvdjI+3a+wvMn+m1PuiOO4M
         DONChc/dMn6Ck84Y/i5s3lf4NuVZB81l6BgHoA63Ky4hduAbohAkNeAORgfKH3bAzaUG
         zAAyszjg7VwhJUfCCNSgtM0v4YBFrX4vTaKOJXAcfQKNU1AtMUYK3hYDb6mZibxxOdtA
         LSpdxes6f6cC7Lae6S4OqqIvpH1g2EkUAu1SQ4aWnzu5hsVp5uMG3u5+S/0GPC+BvvMK
         VBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nnHVWr/JLQ/giaq/yHDXfmSji6/e+JJxcUykqE8B89M=;
        b=RZsp9xwZMMEyO0EWHxEt9rBK53mOJ8T9/IslzDkkcTG9uiZ1M2YbIKf5GonT9jpqFv
         S25Lml97RnxxRcQIOl4lDRLPLVrrtEtxs5DHbCTsXtJ7MqT1zkeiAlJSo+UqNNyHVrzz
         5tEvetMMvcMbxPk2hNJxmqhnxIt+X6IBGF7gW0H/JQyXWpsQsLQ4xDt0bk2O56pWzM15
         hgQ94uz+EKa8ia+KrhLXIQG90ZKzH6yW238C7b1aW0156cP4s3hRjjUHSTn815aOY9Ow
         RScFYrSZ5Io8rPNSqUDXtGtfkgqO40Ftjsm1Q3QCsploTGo1CGVse2FHZ/TFR8axpPvB
         z3Lg==
X-Gm-Message-State: AOAM530+4uviYtrBo7nQElzaSM50nCNzbfc2M60UVNKIUTW/LkIa54N4
        0M0ShtO8RP2SFq/zf4DUlka9Yw==
X-Google-Smtp-Source: ABdhPJy85qpd8h14Lrp5hGuSpR6/fN9CbJmNDaHHOjCwIDzB5ivhXD7IjpIlSiJLeDcBbRej731vNw==
X-Received: by 2002:a17:902:e8c9:b0:141:6eaa:2137 with SMTP id v9-20020a170902e8c900b001416eaa2137mr51571039plg.22.1636125273019;
        Fri, 05 Nov 2021 08:14:33 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x1sm7678485pfr.148.2021.11.05.08.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:14:29 -0700 (PDT)
Date:   Fri, 5 Nov 2021 09:14:25 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Jinlong <quic_jinlmao@quicinc.com>
Cc:     Tao Zhang <quic_taozha@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Subject: Re: [PATCH 04/10] Coresight: Enable BC and GPR for TPDM driver
Message-ID: <20211105151425.GA827656@p14s>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
 <1634801936-15080-5-git-send-email-quic_taozha@quicinc.com>
 <20211103194300.GA383984@p14s>
 <20211104111323.GA14135@jinlmao-gv.ap.qualcomm.com>
 <20211104170224.GC491267@p14s>
 <20211105081750.GD25738@jinlmao-gv.ap.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105081750.GD25738@jinlmao-gv.ap.qualcomm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 04:17:54PM +0800, Jinlong wrote:
> On Thu, Nov 04, 2021 at 11:02:24AM -0600, Mathieu Poirier wrote:
> > [...]
> > 
> > > > > +
> > > > > +static ssize_t reset_store(struct device *dev,
> > > > > +					  struct device_attribute *attr,
> > > > > +					  const char *buf,
> > > > > +					  size_t size)
> > > > > +{
> > > > > +	int ret = 0;
> > > > > +	unsigned long val;
> > > > > +	struct mcmb_dataset *mcmb_temp = NULL;
> > > > > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > > > > +
> > > > > +	ret = kstrtoul(buf, 10, &val);
> > > > 
> > > > The coresight subsystem normally uses the hexadecimal base.
> > > > 
> > > 
> > > We will address you comments.
> > > 
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > 
> > > > Shouldn't this be "if (!ret)" ? 
> > > >
> > > 
> > > When ret is not 0, it need to return.
> > 
> > I would expect something like this:
> > 
> > $ echo 1 > /sys/path/to/tpdm/device/reset
> > 
> > and not
> > 
> > $ echo 0 > /sys/path/to/tpdm/device/reset
> > 
> > The latter is what the code does.
> > 
> > Thanks,
> > Mathieu
> > 
> 
> Hi Mathieu,
> 
> The ret is the result of kstrtoul not the val.
>

Ah yes, you are correct.

