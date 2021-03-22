Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0F9343D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCVJvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCVJvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:51:21 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FD1C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:51:21 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id l22so7112386vsr.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5tfs4RKe7DyMwZ1/CPo5NhF9TOT1gu2YypsLp/MLgM=;
        b=jZZakAEjYi6mGXYPe0pKVcHGkM6m9obfR4McVCvd1b8MDvhbComsZMn2j9W3A1uPUB
         xbFxhnWbBDtCIMzbFR9DylYiJoQhglwob5eYglSrvATADskf/+PtWLTuFiGDbnWbCWhz
         gfvbZD33GhPFnR3OVw1Ane+UhOnOpQ2dkt2yMtrbDRz8SIpDYOFM+G9YUaIsv6KmSY8m
         ep3coz3/NEt+bwNT+kM8Otxf+IVjVirPfiTuz2K0hy0PX+Y2gwSkNUdarA+Y/cUULyHd
         MmMStPABEqN40vuNsLCSmxb38hr86z8n06ROg8K4AV2WEG0wg4ANLGuzDpnsrhJAe1kb
         m24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5tfs4RKe7DyMwZ1/CPo5NhF9TOT1gu2YypsLp/MLgM=;
        b=VTcW7ngZkcXKemMm+4O/S4z9VFykizrS4t3KSa2e//sCko1PvfJT0MIBVhK9ctn6Bd
         G+mlBe22E1mrPS4AQy+7v0VXwNftyexJOwSdNsIwAmhiyvdbERthhFFAzU9o38Rh1sA3
         cINWE1B0lvHw2cdtzUth6GiYTBKWxKEo9CUMWIqHvtBpdqPL2JI85QI8EsIitOK2Clvl
         sbzwBwEg5F+RqGSiKwXVPLBTAkoxM3hM96Eeuo2Y/34wiHyh1IxEt+ddbd+Uo6bR5Xkp
         GKHZZF4RzmPVQbhrIpHpiLVef9fI/+8TiyKSCSgezqu2j7r/3TgYfXZKfgEtWbwPeumh
         mwOg==
X-Gm-Message-State: AOAM530+uBQx//0RVn2Hk+gFRBKv8+wGBg6lsarFwaFxPcyhluwPFFq5
        C/SaNV0d3EHkBL4q5baRRMUceaUrSnY2JMSpJBNDScX47GxDNcql
X-Google-Smtp-Source: ABdhPJxSmVWQ+VNhvjr6kPnEiAv0MfbblHS8tcCuFWZqQUooRb9bxb7ZDa9Mq0coPqO9X5cqHB3AsAG3JqeXC5dQPns=
X-Received: by 2002:a67:77c1:: with SMTP id s184mr8018900vsc.55.1616406680551;
 Mon, 22 Mar 2021 02:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <b62a68d1f8488e7f95befc6723ba5c20d6781628.1615487235.git.limings@nvidia.com>
 <1615936797-245197-1-git-send-email-limings@nvidia.com> <CAPDyKFpvuKU50T1UXfo-H5=gesOwqH4rW4sok4sYOZBgFijt2g@mail.gmail.com>
 <BN8PR12MB3556CA0C1635FFFD50390CDED3689@BN8PR12MB3556.namprd12.prod.outlook.com>
In-Reply-To: <BN8PR12MB3556CA0C1635FFFD50390CDED3689@BN8PR12MB3556.namprd12.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Mar 2021 10:50:44 +0100
Message-ID: <CAPDyKFqnUDCOmJe0aH7USXrAwktB1-GYz-MAr04dHF7iEG10DA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: add ACPI support for
 BlueField-3 SoC
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 at 21:23, Liming Sun <limings@nvidia.com> wrote:
>
> Uffe,
>
> Can I confirm whether you meant the 'master' branch or some other branch?
> I did a rebase of master and didn't see Shawn Lin's changes in the sdhci-of-dwcmshc.c

git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next

[...]

Kind regards
Uffe
