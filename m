Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350C33085F3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhA2Gki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhA2GkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:40:23 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6868CC061573;
        Thu, 28 Jan 2021 22:39:43 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id a7so7796685qkb.13;
        Thu, 28 Jan 2021 22:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RHRfdk0PzGbwGAFTV7pZ41CXfZAPj9sOJoKGdVpiFD8=;
        b=QNoe8Ozzm0cP2iUdWjWaE+s7UDSyNV8PQdOobs9GzLfZ7BhcXbuNbMBz87CIAYXMKA
         EG7EnZTHpgXa6c6d00zJxCF9DcB6ucZHsEYuAnhKv0DacfUNYg/AzKkCSmQzLC/wbl6o
         XlHX3v7jEjrGCRT4quI+31OmuxiDsnjBBtMtCeJBLJsb/bE2getnCY77ucEZMFy4PEgn
         z7U8PuFxg/phYqeGrTF6KWexN8TnLuzWjHmBF4K5H4ZEKaV9AIuYL+Ii2NVo412FY9Gl
         N+KNglbOxUbqxV8/MNXYFvykw65VOmuAafuS61Bqtff+zUfyoESu6QPFF8iGPR/WiOY2
         VtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RHRfdk0PzGbwGAFTV7pZ41CXfZAPj9sOJoKGdVpiFD8=;
        b=Kwi5wKQRSRAstCRBCLJ0evkqgp/XRQ5NmuJLlqV9BAExoNfn8qXQZ0IzH04ELQv2ys
         r6wJKk0Cnek+DKe8O9SpY9KGfAvYxb9Jvg2SJXvGR8oc1TIVqEF+lADXBU5Af+z2UIDO
         wR63MZy2OYsdG3hEcPZJZ7P7nKtPe8OfnuSlpKa5uQyGgIsjuMPbbQ+YJu5+ioo2LxH9
         i6/bRU/oWu7L1OZy1x9Rk0pjKidPxG9quTJ/dMfchpOQRWczDzAbZLPYDqZ8QN2Rtjh8
         F7D7lij90I9Su5l+cCTLscQFPgBYHr14GcdqAIdR8VwqfcVFDsQwuMdgrKv5AxG47h0V
         iVhQ==
X-Gm-Message-State: AOAM530S+xmV4TOGD3DeW/AhdocRs1X4WdAeMVIn2Asj1LunDz3zmQyv
        DF9q0bPYn39Bf9AczvoG3Rbdnde5lcHllA==
X-Google-Smtp-Source: ABdhPJwoZCCYF+DeEoc8Vng9mYD5vJEP0bQY3LlxGp9BIUi93GfEHKmWGHOXu+pXYhbg/zlkQCieQQ==
X-Received: by 2002:a37:b15:: with SMTP id 21mr2916011qkl.330.1611902382703;
        Thu, 28 Jan 2021 22:39:42 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id t14sm5166921qkt.50.2021.01.28.22.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 22:39:42 -0800 (PST)
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
Message-ID: <1100593b-c522-e7ca-4adc-c73cdc9f3d5b@gmail.com>
Date:   Fri, 29 Jan 2021 00:39:40 -0600
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

Second attempt, I think the first reply did not properly send.

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

In my first reply, I said "nope", or something to that effect.  Upon reflection, it looks
like the below diff will fix the problem.  This is base on source code inspection and
building with the diff applied.

I did not successfully boot my target (I have some issues to resolve after updating
the OS on my development host), so I have not verified that unittest is not impacted.

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

