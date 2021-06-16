Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714C63A9485
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhFPH7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhFPH7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:59:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C4CC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:57:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id y7so1521917wrh.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UoBXqRCq/GKgsCFtxdyNhYZEG1lerimUhIzJ75PhSo4=;
        b=smaBEytUl3RTdRWq0F12AJVds1NTfRBOHb8CiNEmJR7v15XgMvSNugt7DNhsEbWoOt
         j0ROx3xAjlTInIZUpb9qeZwolKDFKr+7LSkCx3P3QLXj+xuUNJ+30k6Ly5ZlZhWnV9Jf
         fzHI7vCz0fsAVrQmFm2e0NlnkStWTYpZ5CisBLTWysRHeEy1AadN2w43wJQt2PHWF9+k
         nyRlEU9ye0icIr85MLuKM0whPb1jKIHPRG3G/LQ9+tfXA1QdYtjE2GOkblw+493HsOFn
         My+hcs3NHgx48VBSAVedYG0TQxtufo5S79Qw6XaY42GRvH3w8r/nlmMMtd9fDtwvqvqi
         bfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UoBXqRCq/GKgsCFtxdyNhYZEG1lerimUhIzJ75PhSo4=;
        b=aWzln1odF1Ut+Q8VUmN86ZyhDVQSMm+sq9dSyJyNZa2OhtlbnxzZhQWeHvutwCGPoX
         4kE1YIZBII/cl7rqqY3f28EfQcggiR/aDhjf6cz8v44/rmXpQb7WWZ7H10YRIL6KCel8
         pbw3BoeyT1mQBYtOj4NFEZPzgesvuqYdO+13wdKqa02NmOw1zpcuPIkkNurohV0C0iRs
         tEEgVLe6BStbc9ru0AzRwh45N2EtXLonWcCC/u7OPgLzS0cDVSdiG6vvq7CqP801otO8
         ++k+kUIhFB85GUaGLY/LpnF2AmQGjdz+B9iwm58Hq5PXgf39LyCzF7S+zssco71vdtJu
         LBXg==
X-Gm-Message-State: AOAM533q7LckHs+cGBOlobmXQvs6tr3Yi4T1rznNqnSB9+vHH3iJKMx3
        PYu8K7ye31gA576f58An2+vKqQ==
X-Google-Smtp-Source: ABdhPJwU4zzHq9l0pi588q7eWbNRK1xnuo4+qoimGaym+ARH5syyKShORmgsaFCnqmmOUiztH/z4XA==
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr3649588wrv.280.1623830227199;
        Wed, 16 Jun 2021 00:57:07 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id 4sm1227268wry.74.2021.06.16.00.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 00:57:06 -0700 (PDT)
Date:   Wed, 16 Jun 2021 08:57:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH mfd v2] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <YMmuz0EVjfEi6MJj@dell>
References: <1622652224-19103-1-git-send-email-min.li.xe@renesas.com>
 <YMiwEYLkbKocs8ux@dell>
 <OS3PR01MB65939641C36B650A3B69DAADBA309@OS3PR01MB6593.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB65939641C36B650A3B69DAADBA309@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021, Min Li wrote:

> > 
> > > +static struct mfd_cell rsmu_cm_devs[] = {
> > > +	[RSMU_PHC] = {
> > > +		.name = "idtcm-phc",
> > 
> > Can't you have a nicer name?
> > 
> Hi Lee
> 
> I wonder which part of the name that you don't like? PHC stands from PTP Hardware Clock. 
> I was following the name convention like tps65912-regulator.
> Do you accept "8a3400-phc"?

I think you're trying to put too much information into the device
name.

Currently it's:

  idt <company name> cm <platform> - phc <exact device type>

Where usually we have, taking your example:

  tps65912 <chip> - regulator <subsystem>

So assuming the PTP HW Clock is just a clock it should be:

  8a3400 <chip> - clock <subsystem>

It's difficult to say without seeing the associated child device(s).
When do you propose to upstream those?  Maybe they should be part of
this initial set.  I think that would help a lot.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
