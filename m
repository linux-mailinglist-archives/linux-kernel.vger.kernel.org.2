Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634C630EA05
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 03:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhBDCOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 21:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhBDCOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 21:14:45 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F334C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 18:14:05 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id nm1so808920pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 18:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mckQoiGoE74PnmANLRsJaJ/stHIJIIS3Nq4uDiC55dk=;
        b=VpULEK+L9QfUEm1PUXo1hWoJoxZiTILtxebAy86nFTCOP6xrijMM6Eh+lx310P0rtT
         Ypi8CWv8faqXx3l1D9+KnWLn7nnDKC/9+Fxv9LraR7YWZFBkrAzpf8uVbXR71MyKS0h7
         qXd1uea6xUjuvn/BM5u+v2air58URZqQEGMRs7+3+AAqiaqT+6tU2+blBwZ6JAxttf8Y
         JqvjN6M63p1ZkA/RKQYro0E0BLedYAQcxg49T/vqBXYOE3mvLf8CFuHKL+iHewgWAWWR
         D6ceYh7Zxhkd/PLLn/xn251iKRZ+90CoE5rmKlb8tEQ1FzaOYtjGvFhn/+dBwHpGktg4
         HISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mckQoiGoE74PnmANLRsJaJ/stHIJIIS3Nq4uDiC55dk=;
        b=FF0APN3RV1YnNKv05+rOo4WaeRFznFcIxGDvkaeb81bO5Q7BeV/HD5bj5qougegb4x
         0LhQ4/e8Fyqcfte6MfXehYmnxCfcTzKFLq5aOitTp4VUopw3XEFTTWNGICGtfeGG9mvU
         0d9XfZ3iGl3m8+YSIehxmOoTavYeYDM5N7rzAdnhnGpCQ/9CKUUDu8GmMoOG8vqIKLJn
         bl3jgjgP6QHnzlNznuPPEuwstquR5XiCx7i3euZXuzELZxtOOi5ncwYG4HGy68d2pPFv
         dISQiFJniwJ77WIeqSFGaGCH8lQyHoylp1UibSkArG3OsYElZdrh5V5OPnohi57YXL9G
         Dnfw==
X-Gm-Message-State: AOAM532i1Sj/76M3/9sWGuzxasGdDBlazONZlCrrQRHdwRuTmM/u9b1M
        xvNUC7hTulK0Kc+8XrF1yqnLUQ==
X-Google-Smtp-Source: ABdhPJzyzFx1igsthqZq+BEt2F9YVfuSdRdm3nMIIFHeDK5xZiynFQeSRIk6dsPzrWZPSif58dMoDw==
X-Received: by 2002:a17:90a:de8c:: with SMTP id n12mr5745235pjv.131.1612404844575;
        Wed, 03 Feb 2021 18:14:04 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id l14sm3320072pjq.27.2021.02.03.18.14.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 18:14:03 -0800 (PST)
Date:   Thu, 4 Feb 2021 07:44:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v6 13/37] cpufreq: scmi: port driver to the new
 scmi_perf_proto_ops interface
Message-ID: <20210204021401.ivlvi4bqwnznuhro@vireshk-i7>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
 <20210202221555.41167-14-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202221555.41167-14-cristian.marussi@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-02-21, 22:15, Cristian Marussi wrote:
> Port driver to the new SCMI Perf interface based on protocol handles
> and common devm_get_ops().
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v4 --> v5
> - using renamed devm_get/put_protocol
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 37 ++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
