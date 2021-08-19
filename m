Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17E93F18C1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 14:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbhHSMHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 08:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238105AbhHSMHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 08:07:16 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372EBC061575;
        Thu, 19 Aug 2021 05:06:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w68so5268574pfd.0;
        Thu, 19 Aug 2021 05:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/owt6hoNTtsQ/QXnLoTF97Mvv/lqQX+CifZi81HKaY=;
        b=PwdWiFnCd8wYI312sJ6r26K55pTqgxZl4txuUejdFuo5texYq0N5FWBqK7WJeO97VU
         7Oo/cLx+01LgiVeG9D3aGoVJEka4XtmyZDQJtWa06hjEzUPDNj3HqsD0/AHSHap2TJqe
         KS7fyIVpVAdi4T4Q4D9aThZp2n7FdvarLaqt6FuWnu8y0N5iGJRkSHEJAzyw+8eUNjdt
         wFgQaiM8BM+qwUM6HUOXXgefMTxH/RlzqBcqYunueJAFvrki8dnqdkavLvldrIdWGJyL
         COdI035mB6hf3N8aSGn5mNGvotpczLjQT/Dw58FwZjdeEcJNucrpAkWNcEGt6FvblVzg
         jpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/owt6hoNTtsQ/QXnLoTF97Mvv/lqQX+CifZi81HKaY=;
        b=JgOTc95cFQzSvcJRxY/gHyhvbP/usK/UtwqSAd3U+SRjEK3KWABDOesHphF1TkefZL
         dnjyvm5ctMcG+KdjOyGm28g+z3SVStOza1g8D6sU8/uZ57UofRMMW9MdasCRgZKO4S8y
         VloYWdJVY2KJjWtYFq+jZCQSLR11hA34Uic1N9s5QiJFwMWPIlCK2NcEflHMD4AVc7jP
         FVxyAVAOQoBFujCDOi6uD4rX+fB4THI/Dr4ZlosrlRbVPssO91ueHwBfiLS9SCrk3UXt
         Nj0HSa/YelEdIdaOHfCbJhXqEuB0+GtyoEZgPMHs92R/CdDsl3s4nqjgYFx7Lrl3g0i5
         pvUg==
X-Gm-Message-State: AOAM53365aNUKK9XfzE6+P5dJ4HqtmxAbtz3JLV5bLYGpiu/TziFII05
        XbOqM4geeHJQoFiMusbOhjXk/jrxK0vXbrZjqSI=
X-Google-Smtp-Source: ABdhPJyFvwCm11gUzXWLrChXtuULcoSIURh4Rz1eMv+B4wTFouPBrU83bmAjt9MJxxx2N9f7hhKUMPgvCgLKNYZjPco=
X-Received: by 2002:a65:45c3:: with SMTP id m3mr13809086pgr.203.1629374796666;
 Thu, 19 Aug 2021 05:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210819033001.20136-1-hpa@redhat.com> <20210819033001.20136-6-hpa@redhat.com>
In-Reply-To: <20210819033001.20136-6-hpa@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Aug 2021 15:05:57 +0300
Message-ID: <CAHp75Vd8tG+_FVapEMjj7_QMBjAzf2r-W95Am=sOPh5DG+V7Tg@mail.gmail.com>
Subject: Re: [PATCH v3 05/20] platform/x86: intel_pmc_core: Move to intel sub-directory
To:     Kate Hsuan <hpa@redhat.com>
Cc:     Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dell.Client.Kernel@dell.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 6:32 AM Kate Hsuan <hpa@redhat.com> wrote:
>
> Move intel_pmc_core to intel sub-directory
> to improve readability.

>  .../pmc/pmc_core.c}                           |  0
>  .../pmc/pmc_core_pltdrv.c}                    |  0

As per SCU patch this can be done as

pmc_core -> core
pmc_core_pltdrv -> pltdrv

-- 
With Best Regards,
Andy Shevchenko
