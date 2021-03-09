Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5682F332DEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 19:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhCISMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 13:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhCISMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 13:12:10 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D04AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 10:12:10 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so7491795wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 10:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zzBPtS1xdLZ/zOCVXNiYwDt4gKEIaEhuN64+KPrjbH8=;
        b=dRd+yptFvhY0fjHhzAmaNrZzZn25ELYdv7FJUCVlpt7EuGr82COj0XrKfSQlM7SQON
         QMDMGyi2L6yK3X23fvM8SZw7bzuBZzWQ0+uxBO1Qk1cqQ3uT/pZFXVANlQmnvMNP1faJ
         LeXPmcaa6ow7f4IJEBRn8SNku2f+lbPtN+l2W1JBwdPtHA1RpmiQG1tlYxoeyAeOI7lq
         hc7ToO2G3UgclpjqWjqnlFDnVI/e5dS0ekZ1T/WTefuQ+YNC7V1GoWHT+Us8ZuQUqb47
         jmAjBuwPNXWKjcfnkh/54Nj+ASEKZ3DDSPZedVfdPcfa8nwVPGv2qxYQuxVIZ/CrR49M
         jzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zzBPtS1xdLZ/zOCVXNiYwDt4gKEIaEhuN64+KPrjbH8=;
        b=qKBH0ddnTA2TyAkotSY0fvzIhXlLBuU1oq1HPpmPMtyyQvStsm18UfWOlG6/outX6l
         hpoD6/zkzqXPUWjAXepLLilJwUeizwELT0J5sgqtaPnN8T6f7eHW82RvLozvx9bkKM41
         N4vl1C2wIWa7HWZeqiOil1eshA5oLaOW1IemiIjtl0a6dv0B8T/xjUud44MnUISbVnnn
         hntmk2jmWeJsy6lf6/nyrT4zvvBOJ2G3sy8awxeGiB1neRbeQ9Vt8Z+1SSIgBxUtf+um
         mR/bhc2OwyT948GsVwcpouoBBlOqOhhOTQmWlQnh+3hpy2KjXE08EjO435F8JJrniZZz
         kCBw==
X-Gm-Message-State: AOAM531O4xacdDrUbJNmgZ99qKt7valgirLmHGwmoz2LNiiYePEJWzSZ
        EKQbf+MxN5FVJ8Rztal6M6cABg==
X-Google-Smtp-Source: ABdhPJxL6sx99Qcv1Al5yQZTtdyL9YKsqMgoemCYmt6nyqO+AhBmIGs20BPkL5cbEajrgWKQEJwWpw==
X-Received: by 2002:a1c:a985:: with SMTP id s127mr5375278wme.158.1615313528945;
        Tue, 09 Mar 2021 10:12:08 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id n66sm5078959wmn.25.2021.03.09.10.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 10:12:08 -0800 (PST)
Date:   Tue, 9 Mar 2021 18:12:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD and Platform/X86 due for the
 v5.13 merge window
Message-ID: <20210309181206.GT4931@dell>
References: <20210128172846.99352-1-david.e.box@linux.intel.com>
 <20210224201005.1034005-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210224201005.1034005-1-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:

  Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-platform-x86-v5.13

for you to fetch changes up to ccafe3126ad3f48ea1cd9ae460c69d1ba879fb65:

  mfd: intel_pmt: Add support for DG1 (2021-03-09 17:05:25 +0000)

----------------------------------------------------------------
Immutable branch between MFD and Platform/X86 due for the v5.13 merge window

----------------------------------------------------------------
David E. Box (2):
      mfd: intel_pmt: Fix nuisance messages and handling of disabled capabilities
      mfd: intel_pmt: Add support for DG1

 drivers/mfd/intel_pmt.c                    | 112 +++++++++++++++++++----------
 drivers/platform/x86/intel_pmt_class.c     |  46 ++++++++++++
 drivers/platform/x86/intel_pmt_class.h     |   1 +
 drivers/platform/x86/intel_pmt_telemetry.c |  20 ------
 4 files changed, 122 insertions(+), 57 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
