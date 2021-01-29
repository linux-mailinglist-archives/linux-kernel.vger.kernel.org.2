Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F7E30856B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhA2GAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhA2GAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:00:35 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C56C061573;
        Thu, 28 Jan 2021 21:59:54 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id u16so4008270qvo.9;
        Thu, 28 Jan 2021 21:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QUeH3EobdhlwWiIHKkInYCjoa2uGooqIYSSFgluMm3c=;
        b=GIitH5mpBu0U2vHntzB1uENdz9z7eYAcAOGOY276XwzQJK8/lFACDDjO1qqubA5jf/
         kGVqOnbununpJ3l/IwCEQMF2QQbsH1NsrJnNmGPYekyUr1SCgpm85WeJpJxcq1faVV5x
         zNrFPUgQas6IzC7LYUw/R0Gc0wTr6/elCAqsBQUeDIt+3xlSMEbWfuRrqKnU0F3SWR1w
         6MpbozQxZjQNLESpTcWnu1bmqyA19HZxBE+idUAcs4PI+zFE+rHq9khwNbT6WIatPxxJ
         UxAAkELh0jd7/ynk8e28V5g/kDMnL8Id17l92o1hbggyXp3kJQNZiR/lvaJQd1kkwJ2b
         V41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QUeH3EobdhlwWiIHKkInYCjoa2uGooqIYSSFgluMm3c=;
        b=HIVpiPaugU3AN40qVpT5ZwPhFb3DUxbdP2rlWkwLYBCR01cVZADDwxwHS9mf8/9qAm
         UpZ4iiTTsEslyqJOOY76WCK7aTU3RRrLn/ZL3+ncIiTPNyDyNDcCiJ8knQbo4v2/FgnM
         Kp34+TUJP4hsEjiEfd6P9KdTSGO4wQ0YdchGGbtEHPMLmINBRPSuZmKcieujsHP/8ygN
         lsQ933dsLB8etvhzQjjtlPhXu/wteRfyxu8G8PxTixMyXMQqKDVWiwfNRqCnnGdBdi9w
         10RQBZ3E12Rs5eS6Lsqyk+M/mWEUGqk1vrISD2qfTR2pBFDnM2Lemn6cbCI2KrA71gLv
         8bvA==
X-Gm-Message-State: AOAM530VvLoPvqHbMowk2vatqIl5ek1QlOfwhaTmIA/8kALvuFniH7RA
        sDvQ3DbRuI7tT0ELmsw7oAmpmK9a6iM0yA==
X-Google-Smtp-Source: ABdhPJwSN517cb/JmY48RE9OlGouu0YrTJ4xJJohOV5W+VRBNe+54U1bJTr8tzGabTzzXeT6OurzTA==
X-Received: by 2002:ad4:4431:: with SMTP id e17mr2702498qvt.45.1611899994068;
        Thu, 28 Jan 2021 21:59:54 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id q25sm5229305qkq.32.2021.01.28.21.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 21:59:53 -0800 (PST)
Subject: Re: [PATCH V6 5/6] of: unittest: Create overlay_common.dtsi and
 testcases_common.dtsi
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
References: <cover.1611312122.git.viresh.kumar@linaro.org>
 <94180731aa4a17e4834458a979de7de782dc73d4.1611312122.git.viresh.kumar@linaro.org>
 <20210127055652.vmkx5sczef2mjwey@vireshk-i7>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <543de786-4f08-d1f6-8034-252662a39786@gmail.com>
Date:   Thu, 28 Jan 2021 23:59:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210127055652.vmkx5sczef2mjwey@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 1/26/21 11:56 PM, Viresh Kumar wrote:
> On 22-01-21, 16:20, Viresh Kumar wrote:
>> In order to build-test the same unit-test files using fdtoverlay tool,
>> move the device nodes from the existing overlay_base.dts and
>> testcases_common.dts files to .dtsi files. The .dts files now include
>> the new .dtsi files, resulting in exactly the same behavior as earlier.
>>
>> The .dtsi files can now be reused for compile time tests using
>> fdtoverlay (will be done in a later patch).
>>
>> This is required because the base files passed to fdtoverlay tool
>> shouldn't be overlays themselves (i.e. shouldn't have the /plugin/;
>> tag).
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/of/unittest-data/overlay_base.dts     | 90 +-----------------
>>  drivers/of/unittest-data/overlay_common.dtsi  | 91 +++++++++++++++++++
>>  drivers/of/unittest-data/testcases.dts        | 17 +---
>>  .../of/unittest-data/testcases_common.dtsi    | 18 ++++
>>  4 files changed, 111 insertions(+), 105 deletions(-)
>>  create mode 100644 drivers/of/unittest-data/overlay_common.dtsi
>>  create mode 100644 drivers/of/unittest-data/testcases_common.dtsi
> 
> Frank,
> 
> As I mentioned in the cover-letter, I get a build warning right now:
> 
> drivers/of/unittest-data/tests-interrupts.dtsi:20.5-28: Warning (interrupts_property): /testcase-data/testcase-device2:#interrupt-cells: size is (4), expected multiple of 8

Thanks for catching that.

> 
> I think I need to add below diff to this patch to fix this warning, will that
> be okay ?

Nope, the change below won't work because it removes the node testcase-device2 from the tests
that unittest.c does (if I am thinking correctly).  I will double check my thinking, but I
know you are spinning the patch, so I didn't want to delay this reply.

Note that this node has a deliberate error in it "/* invalid specifier - too short */".

I'm not sure why the dtc warning triggers on line 20 instead of line 68.  I'll have to go
look at the dtc source to better understand the warning.

-Frank

> 
> diff --git a/drivers/of/unittest-data/testcases.dts b/drivers/of/unittest-data/testcases.dts
> index 185125085784..04b9e7bb30d9 100644
> --- a/drivers/of/unittest-data/testcases.dts
> +++ b/drivers/of/unittest-data/testcases.dts
> @@ -3,3 +3,14 @@
>  /plugin/;
>  
>  #include "testcases_common.dtsi"
> +
> +/ {
> +       testcase-data {
> +               testcase-device2 {
> +                       compatible = "testcase-device";
> +                       interrupt-parent = <&test_intc2>;
> +                       interrupts = <1>; /* invalid specifier - too short */
> +               };
> +       };
> +
> +};
> diff --git a/drivers/of/unittest-data/tests-interrupts.dtsi b/drivers/of/unittest-data/tests-interrupts.dtsi
> index ec175e800725..0e5914611107 100644
> --- a/drivers/of/unittest-data/tests-interrupts.dtsi
> +++ b/drivers/of/unittest-data/tests-interrupts.dtsi
> @@ -61,12 +61,5 @@ testcase-device1 {
>                         interrupt-parent = <&test_intc0>;
>                         interrupts = <1>;
>                 };
> -
> -               testcase-device2 {
> -                       compatible = "testcase-device";
> -                       interrupt-parent = <&test_intc2>;
> -                       interrupts = <1>; /* invalid specifier - too short */
> -               };
>         };
> -
>  };
> 

