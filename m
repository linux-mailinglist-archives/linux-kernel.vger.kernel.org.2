Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835333F18D9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 14:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbhHSMM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 08:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239151AbhHSMM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 08:12:56 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A68C061575;
        Thu, 19 Aug 2021 05:12:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so11139857pjb.3;
        Thu, 19 Aug 2021 05:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lz6ZTqf/54ImmUiBimm1pwt9LHrmxlW/CupKtaG8WMU=;
        b=DvHNmuWoca5xtE44zYFkU6FUrmF0RF9uNLhEFuOfPTUPwjWbB7HLcph9WHGDZNOGTe
         4ZUI6sHJd9eZ4pDRdTjN6d1skApcCcCSLVcxhQyHKLSc6usovllUhyDffeMRzq8IjvdA
         i1E/VTHch9g8G531OYEYPoGxFl6zkyLqZjHcmkL9ayVldikVAQmYo3ZnAeSrEbfZ0Pil
         tu7RfogFcbmEDc1pqGJUcKogx82oJMillIrWVekIG54AKaibvRGFBRqcP3m5ELSHbdgU
         aXO0V5PX8TU9bR5Qg+gNNzO0o7QD0eYgdvr1KQUMj2Q7BTl+XVA2WuglCXRkBfyIxoWM
         VhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lz6ZTqf/54ImmUiBimm1pwt9LHrmxlW/CupKtaG8WMU=;
        b=otCyQ26mS3vn5nnlHmX9gJ6NGqq34TPzWhsjpJrYCz/trzfQAR5mFIoyqRRU1+fKiu
         b3QLAT3nQCLmMx8b8kiDBP5O8g+5IrLdD0sIi/MN1ZI4n6S6rAlzUvFtn9zzxCr6f4ME
         RPHA6o2Wql7F5s7ddb/3ErW9L89+tBzE3yUWMjLooL9S29NexvRJuhPirYz+j2nATWw+
         VB8jAPnoIP4kCN15Kmo25eYojvcvLbQ8Jegsfe7egOw7DbXo6myWa9/xJAzp4Q1fqjWl
         8eNAEmyIjhQdbCfDDMGflX9lJFHcnsmqm22kke8JxigeWwxgtJDkgbiuH0AkXl+ATi/j
         uQPw==
X-Gm-Message-State: AOAM532AP2HDOQwqkG1rx9WOTUoSYxZGbbN4+0osMmyAY4/PNUS9yoo2
        iVV6W9ajvz/sXG38fSD0l/LHj4l9y1t88SeKGUM=
X-Google-Smtp-Source: ABdhPJzfFKIuAeULsnK7FfOivilpl+NjZolryfU0dT2q/X3HSPKvmsqES7gsNfCMyXS9HaXueda/c4XqU7xnbyNu3hE=
X-Received: by 2002:a17:90a:6502:: with SMTP id i2mr8917123pjj.129.1629375140432;
 Thu, 19 Aug 2021 05:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210819033001.20136-1-hpa@redhat.com> <20210819033001.20136-8-hpa@redhat.com>
In-Reply-To: <20210819033001.20136-8-hpa@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Aug 2021 15:11:41 +0300
Message-ID: <CAHp75VcNDrMEMGkMsLZ6xPkDY_DTOiXVrM4OAXeNEGqGbQBzjg@mail.gmail.com>
Subject: Re: [PATCH v3 07/20] platform/x86: intel_telemetry: Move to intel sub-directory
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
> Move intel_telemetry to intel sub-directory to improve readability.


> +intel_telemetry_core-y                 := core.o
> +intel_telemetry_pltdrv-y               := pltdrv.o
> +intel_telemetry_debugfs-y              := debugfs.o

> +obj-$(CONFIG_INTEL_TELEMETRY)          += intel_telemetry_core.o \
> +                                       intel_telemetry_pltdrv.o \
> +                                       intel_telemetry_debugfs.o

I know it is in the original, but we make take a chance to split this
per three separate lines

intel_telemetry_core-y                 := core.o
obj-$(CONFIG_INTEL_TELEMETRY)          += intel_telemetry_core.o
intel_telemetry_pltdrv-y               := pltdrv.o
obj-$(CONFIG_INTEL_TELEMETRY)          += intel_telemetry_pltdrv.o
intel_telemetry_debugfs-y              := debugfs.o
obj-$(CONFIG_INTEL_TELEMETRY)          += intel_telemetry_debugfs.o

-- 
With Best Regards,
Andy Shevchenko
