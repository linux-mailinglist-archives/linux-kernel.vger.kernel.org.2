Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A546E3F7EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhHYWd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhHYWdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:33:25 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E422EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:32:38 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id n15so1869368ybm.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=ptWadA4HCMeQHLRnXPnOPfNeTy4dya/p1yelvBBPdOw=;
        b=CJFSEB2aSJuS32LVbLByi6Oo/eFBtaHvVMXFh5j0ChqYy80SAIT2oyyP1jaUwAN9f3
         Cw4q4BHbGverTdpnlNggEdoVjDUEOI8o5ONUG+p+D6RNfcKlPP5Lq98MzZ8KvMH/GiEj
         SKK2LB3ICfN3vrhPPBfuLflyl1NTrpQcfYseF4cVKpEebLwZoczIhd14THjcWH/RgXA5
         n50Viu83Jx/ihfqpVdlfKnpDbpCkLAzEMVrDsn04XeJ4Gcuv9ndBK+g4XoyM9kHNlaOy
         vqjRqJxwnOWD8AMVhGSUj2X2CX8B8haOBDRg4ADJPqvBy7w0dOMA7ezF/isphgs4tdPh
         GJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=ptWadA4HCMeQHLRnXPnOPfNeTy4dya/p1yelvBBPdOw=;
        b=mGG8hj1HmtPMkRuZ1icLYtG5oHbc7Ic1BdjYfdg/vn3Y/gU68OrBxpmv2KI/CgJNgv
         UaFchwFQY8fbigTfRFVXqMLnF5+u66SKYcomCDLT1P0G1qgZp50b0Ulwhrlcum8PcnKn
         IPekhR089I1a+qwA6F/zfD2ee9HkL4VIpYVVGLDOLnvFHWK1qnxhfK5zuaQL2n5L+oMu
         fa9Fd13OwMYVaNrWlQfnphwVVOhVcQXJBHPhG81liyIx3AIFZNPqlcW2oJ2wUo+RExKu
         tCzsqYz3B4eWRw+xKWeWDlh8E+5zXsBgCFtnP2y8G2fu0XtKaPVo+IW/6VhZMDyJCUsb
         M88Q==
X-Gm-Message-State: AOAM530zL0V9W3hpnJGab8uoDDY42dmiWwkusSGDWw931Qg/FhwmDXjw
        QGlvTErg5fNsLqihVpXRVoRFYfDBD9CFcEExXinHnA==
X-Received: by 2002:a25:f20a:: with SMTP id i10mt1203550ybe.236.1629930758075;
 Wed, 25 Aug 2021 15:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210825222051.2106481-1-jiancai@google.com>
In-Reply-To: <20210825222051.2106481-1-jiancai@google.com>
From:   Jian Cai <jiancai@google.com>
Date:   Wed, 25 Aug 2021 15:32:27 -0700
Message-ID: <CA+SOCLLxWxwpMO_JP2p2FfNRdrH-82mR8ZcDGmPAkRnqxeYZPg@mail.gmail.com>
Subject: Re: [PATCH] coresight: syscfg: Add initial configfs support
Cc:     mike.leach@linaro.org, dianders@chromium.org, mka@chromium.org,
        Guenter Roeck <linux@roeck-us.net>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>, coresight@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this patch. The title is incorrect, I've updated and
resented it at https://lore.kernel.org/lkml/20210825222514.2107728-1-jiancai@google.com/.
Sorry for any inconveniences.

Jian



On Wed, Aug 25, 2021 at 3:20 PM Jian Cai <jiancai@google.com> wrote:
>
> This fixes build failures with -Wimplicit-function-declaration, e.g.
>
> ^[[1m/mnt/host/source/src/third_party/kernel/v5.4/drivers/hwtracing/coresight/coresight-syscfg.c:455:15: ^[[0m^[[0;1;31merror: ^[[0m^[[1mimplicit declaration of function 'kzalloc' [-Werror,-Wimplicit-function-declaration]^[[0m
>         csdev_item = kzalloc(sizeof(struct cscfg_registered_csdev), GFP_KERNEL);
> ^[[0;1;32m                     ^
>
> Signed-off-by: Jian Cai <jiancai@google.com>
> ---
>  drivers/hwtracing/coresight/coresight-syscfg.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> index fc0760f55c53..43054568430f 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -5,6 +5,7 @@
>   */
>
>  #include <linux/platform_device.h>
> +#include <linux/slab.h>
>
>  #include "coresight-config.h"
>  #include "coresight-etm-perf.h"
> --
> 2.33.0.259.gc128427fd7-goog
>
