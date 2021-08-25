Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763D33F7EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhHYWeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhHYWeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:34:05 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81751C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:33:19 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id z5so1937536ybj.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=Kgp5GiEz4WmpnGVoTlE6arLJUO3fxcnpVDrKqn7lWLw=;
        b=HPFOPzBy6SGiYGP6n7007s+8XxhBCV9CfvtBH7fphvvbQzrKNdcVz4b6rSJdP2Bg/9
         2m7RCr7FuGNXyJiuMbVhjF9BO+JzG+K2q27BduY1+O9H++gmpSZeEsNP6DUseQW2bfSc
         AJWEEAnSXAAU/FP/rk/LIYRwuOf9ExaQkCPTeSS8swjluq/BVlnessP0ezYTuVZmIdFn
         bIQR9OvbSfef7PAFgO6NeUoRJ0XAPIdXlhS8Pwphw+6sHoHhJHvl1sVt1/9QI5kmbmqg
         rFM1d3qu7JvjL/WOawUvElCIN6Q45tWSqddqvpZrtjWX4bWBc9OYIaGrK7MJooOMzQkb
         zFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=Kgp5GiEz4WmpnGVoTlE6arLJUO3fxcnpVDrKqn7lWLw=;
        b=qd9XQEr8P5lCcooPH9wUP2YwIkHiLxxmQjjmJR74JYLgdiAyCuZgewlrePfwyFGkw2
         oEF+1Z0GImChZPLnsShZNjOAnthFHnC7/t27zur2Ae6EQxznuQWK8uAFvbtCm8jtX6y9
         s6K+9JqwbWobpLlNoDGV1rzvOc088ebKqbO9R8xcYD6GzsSpTSO1yl+E8dPo7nRcp0S6
         bmpixkeSepSFf5/tkJwD+S/k4yraBBHbHveJUpB7UWnG/xU3mbyXKDYo2VYcj457o+yW
         tgRvwKdsxTNMwmPkh2A9nedUNN/PJdmdXjO0D72Yi09acMD/yyYsmNa1JH6YV1iMedtN
         j8EQ==
X-Gm-Message-State: AOAM531t21hi4gEV81W0r15yLwXbUOmdWKPbY2+KZmXJ4IvUIIJQUks5
        24GJBoDEs3LDYbhG/qcKHVkED+JtodP3Euw0ri2sJA==
X-Received: by 2002:a25:9847:: with SMTP id k7mt1238946ybo.170.1629930798648;
 Wed, 25 Aug 2021 15:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210825222514.2107728-1-jiancai@google.com> <CA+SOCLLyKaEmCSrSNUKfpgPmUxcu8RyZLqZxpmw87BiO=m84Mg@mail.gmail.com>
In-Reply-To: <CA+SOCLLyKaEmCSrSNUKfpgPmUxcu8RyZLqZxpmw87BiO=m84Mg@mail.gmail.com>
From:   Jian Cai <jiancai@google.com>
Date:   Wed, 25 Aug 2021 15:33:06 -0700
Message-ID: <CA+SOCLKS=C6rNHXbbro+qHE2P-_M+nGg9kCdAuZPuZq0-VMLMQ@mail.gmail.com>
Subject: Re: [PATCH] coresight: syscfg: fix compiler warnings
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

The last message was meant for the wrong patch. Please ignore. Sorry
for the noise.

On Wed, Aug 25, 2021 at 3:27 PM Jian Cai <jiancai@google.com> wrote:
>
> Please ignore this patch. The title is incorrect, I've updated and resented it at https://lore.kernel.org/lkml/20210825222514.2107728-1-jiancai@google.com/. Sorry for any inconvenience.
>
> On Wed, Aug 25, 2021 at 3:25 PM Jian Cai <jiancai@google.com> wrote:
>>
>> This fixes warnings with -Wimplicit-function-declaration, e.g.
>>
>> ^[[1m/mnt/host/source/src/third_party/kernel/v5.4/drivers/hwtracing/coresight/coresight-syscfg.c:455:15: ^[[0m^[[0;1;31merror: ^[[0m^[[1mimplicit declaration of function 'kzalloc' [-Werror,-Wimplicit-function-declaration]^[[0m
>>         csdev_item = kzalloc(sizeof(struct cscfg_registered_csdev), GFP_KERNEL);
>> ^[[0;1;32m                     ^
>>
>> Signed-off-by: Jian Cai <jiancai@google.com>
>> ---
>>  drivers/hwtracing/coresight/coresight-syscfg.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
>> index fc0760f55c53..43054568430f 100644
>> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
>> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
>> @@ -5,6 +5,7 @@
>>   */
>>
>>  #include <linux/platform_device.h>
>> +#include <linux/slab.h>
>>
>>  #include "coresight-config.h"
>>  #include "coresight-etm-perf.h"
>> --
>> 2.33.0.259.gc128427fd7-goog
>>
