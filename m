Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4BE31F4A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 06:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhBSFUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 00:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBSFUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 00:20:52 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA23EC061574;
        Thu, 18 Feb 2021 21:20:11 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id o21so3210552qtr.3;
        Thu, 18 Feb 2021 21:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qpRergSCzfJW95JxDDP5AUDY1cRqYZWFeg2pzxMeUO4=;
        b=MjLASgAtWQ9ZkpLGCJyIEFWTEaWwOO2GySxtSoZNynBGm+b8Iv14PFvcJi8B+IkXEu
         uUQTHTwyqmcB5oRrc51fhUxbvHSL+16XiZl3fkvhC3ph9NQS0yvigSIW0HppC2NULT0C
         Qep5U4Vc6EoW6oiljKzffsHGcjm7mLWu/8Q4e5TMeIO1OeAw7t1adYN//AxZzC2Q4Qha
         zoxyC4fu0GVRmJUyi8T9898ynoMRnfio02SV5B0pBGtaPk2n9upLXhdgTGJ1065qULMD
         HqEPpNjkbzJTTvMwi8HdnyMjEUOif23ZX9eVA3Elng93LWJFUBNfdeE6TVOjFA/6SA7B
         8KHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qpRergSCzfJW95JxDDP5AUDY1cRqYZWFeg2pzxMeUO4=;
        b=PvtbVH5BG0iCGKdNR+I6iH/cVD42sKU92RGwm0xxY+4LvgQsDI7NmnCFGqV2PJO6Vo
         tVUIApOpwqGqipXDGP/Uisx8iOWCzjTmNqS3194qxBbVCRSie2Enm4P2bYrOAQNfd8uT
         UwWOD8dP0cawL7mxFnf7dUTQGm+T0ND9PgVvFUMh5nh1+q5L8dmYs/KEmf0Z7sNWhuQq
         52IFqqqROjHPHe5lzsUXayvB08SvpWfRtG1Aoa+AJbVx47aDZPlkdwH4v+MUdTR01nXT
         PIwlpKuHN1rz8bKOtIERKIHsP5Hgdu64IOwaN0pQ7YVK9QSPjY1RdkXk9IV6o1DM318E
         2zSg==
X-Gm-Message-State: AOAM532R+mZT9XgwWICNRK3j5zzYdn6FFVeFOuI2uhcb0eibVOcCEwnm
        /SkZxE71C+2UclX82GxIDow=
X-Google-Smtp-Source: ABdhPJyc/Mf+pYyDtKGmDLGTYnSrD52TTx8FTWct9ruXDFWegwKrFwTlHrHFFooeRZ3xLqhUzAs7OA==
X-Received: by 2002:a05:622a:453:: with SMTP id o19mr7630667qtx.344.1613712010899;
        Thu, 18 Feb 2021 21:20:10 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id v12sm3621820qtw.73.2021.02.18.21.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 21:20:10 -0800 (PST)
Subject: Re: [PATCH V7 5/6] of: unittest: Create overlay_common.dtsi and
 testcases_common.dtsi
From:   Frank Rowand <frowand.list@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
References: <cover.1611904394.git.viresh.kumar@linaro.org>
 <585e77b8c8a613103f3251af969514f2aa6d0e0d.1611904394.git.viresh.kumar@linaro.org>
 <a87385f3-2795-27cc-42bb-d5aab033e9a8@gmail.com>
Message-ID: <e8dedc0a-0ee6-3d63-94ab-2be132fface3@gmail.com>
Date:   Thu, 18 Feb 2021 23:20:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a87385f3-2795-27cc-42bb-d5aab033e9a8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

I am in the wrong version with the comments below.  You are at version 8 now.

-Frank

On 2/18/21 3:02 PM, Frank Rowand wrote:
> On 1/29/21 1:24 AM, Viresh Kumar wrote:
>> In order to build-test the same unit-test files using fdtoverlay tool,
>> move the device nodes from the existing overlay_base.dts and
>> testcases_common.dts files to .dtsi counterparts. The .dts files now
>> include the new .dtsi files, resulting in exactly the same behavior as
>> earlier.
>>
>> The .dtsi files can now be reused for compile time tests using
>> fdtoverlay (will be done by a later commit).
>>
>> This is required because the base files passed to fdtoverlay tool
>> shouldn't be overlays themselves (i.e. shouldn't have the /plugin/;
>> tag).
>>
>> Note that this commit also moves "testcase-device2" node to
>> testcases.dts from tests-interrupts.dtsi, as this node has a deliberate
>> error in it and is only relevant for runtime testing done with
>> unittest.c.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/of/unittest-data/overlay_base.dts     | 90 +-----------------
>>  drivers/of/unittest-data/overlay_common.dtsi  | 91 +++++++++++++++++++
>>  drivers/of/unittest-data/testcases.dts        | 18 ++--
>>  .../of/unittest-data/testcases_common.dtsi    | 19 ++++
>>  .../of/unittest-data/tests-interrupts.dtsi    |  7 --
>>  5 files changed, 118 insertions(+), 107 deletions(-)
>>  create mode 100644 drivers/of/unittest-data/overlay_common.dtsi
>>  create mode 100644 drivers/of/unittest-data/testcases_common.dtsi
>>
>> diff --git a/drivers/of/unittest-data/overlay_base.dts b/drivers/of/unittest-data/overlay_base.dts
>> index 99ab9d12d00b..ab9014589c5d 100644
>> --- a/drivers/of/unittest-data/overlay_base.dts
>> +++ b/drivers/of/unittest-data/overlay_base.dts
>> @@ -2,92 +2,4 @@
>>  /dts-v1/;
>>  /plugin/;
>>  
>> -/*
>> - * Base device tree that overlays will be applied against.
>> - *
>> - * Do not add any properties in node "/".
>> - * Do not add any nodes other than "/testcase-data-2" in node "/".
>> - * Do not add anything that would result in dtc creating node "/__fixups__".
>> - * dtc will create nodes "/__symbols__" and "/__local_fixups__".
>> - */
>> -
>> -/ {
>> -	testcase-data-2 {
>> -		#address-cells = <1>;
>> -		#size-cells = <1>;
>> -
>> -		electric_1: substation@100 {
>> -			compatible = "ot,big-volts-control";
>> -			reg = < 0x00000100 0x100 >;
>> -			status = "disabled";
>> -
>> -			hvac_1: hvac-medium-1 {
>> -				compatible = "ot,hvac-medium";
>> -				heat-range = < 50 75 >;
>> -				cool-range = < 60 80 >;
>> -			};
>> -
>> -			spin_ctrl_1: motor-1 {
>> -				compatible = "ot,ferris-wheel-motor";
>> -				spin = "clockwise";
>> -				rpm_avail = < 50 >;
>> -			};
>> -
>> -			spin_ctrl_2: motor-8 {
>> -				compatible = "ot,roller-coaster-motor";
>> -			};
>> -		};
>> -
>> -		rides_1: fairway-1 {
>> -			#address-cells = <1>;
>> -			#size-cells = <1>;
>> -			compatible = "ot,rides";
>> -			status = "disabled";
>> -			orientation = < 127 >;
>> -
>> -			ride@100 {
>> -				#address-cells = <1>;
>> -				#size-cells = <1>;
>> -				compatible = "ot,roller-coaster";
>> -				reg = < 0x00000100 0x100 >;
>> -				hvac-provider = < &hvac_1 >;
>> -				hvac-thermostat = < 29 > ;
>> -				hvac-zones = < 14 >;
>> -				hvac-zone-names = "operator";
>> -				spin-controller = < &spin_ctrl_2 5 &spin_ctrl_2 7 >;
>> -				spin-controller-names = "track_1", "track_2";
>> -				queues = < 2 >;
>> -
>> -				track@30 {
>> -					reg = < 0x00000030 0x10 >;
>> -				};
>> -
>> -				track@40 {
>> -					reg = < 0x00000040 0x10 >;
>> -				};
>> -
>> -			};
>> -		};
>> -
>> -		lights_1: lights@30000 {
>> -			compatible = "ot,work-lights";
>> -			reg = < 0x00030000 0x1000 >;
>> -			status = "disabled";
>> -		};
>> -
>> -		lights_2: lights@40000 {
>> -			compatible = "ot,show-lights";
>> -			reg = < 0x00040000 0x1000 >;
>> -			status = "disabled";
>> -			rate = < 13 138 >;
>> -		};
>> -
>> -		retail_1: vending@50000 {
>> -			reg = < 0x00050000 0x1000 >;
>> -			compatible = "ot,tickets";
>> -			status = "disabled";
>> -		};
>> -
>> -	};
>> -};
>> -
>> +#include "overlay_common.dtsi"
>> diff --git a/drivers/of/unittest-data/overlay_common.dtsi b/drivers/of/unittest-data/overlay_common.dtsi
>> new file mode 100644
>> index 000000000000..08874a72556e
>> --- /dev/null
>> +++ b/drivers/of/unittest-data/overlay_common.dtsi
>> @@ -0,0 +1,91 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/*
>> + * Base device tree that overlays will be applied against.
>> + *
>> + * Do not add any properties in node "/".
>> + * Do not add any nodes other than "/testcase-data-2" in node "/".
>> + * Do not add anything that would result in dtc creating node "/__fixups__".
>> + * dtc will create nodes "/__symbols__" and "/__local_fixups__".
>> + */
>> +
>> +/ {
>> +	testcase-data-2 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +
>> +		electric_1: substation@100 {
>> +			compatible = "ot,big-volts-control";
>> +			reg = < 0x00000100 0x100 >;
>> +			status = "disabled";
>> +
>> +			hvac_1: hvac-medium-1 {
>> +				compatible = "ot,hvac-medium";
>> +				heat-range = < 50 75 >;
>> +				cool-range = < 60 80 >;
>> +			};
>> +
>> +			spin_ctrl_1: motor-1 {
>> +				compatible = "ot,ferris-wheel-motor";
>> +				spin = "clockwise";
>> +				rpm_avail = < 50 >;
>> +			};
>> +
>> +			spin_ctrl_2: motor-8 {
>> +				compatible = "ot,roller-coaster-motor";
>> +			};
>> +		};
>> +
>> +		rides_1: fairway-1 {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			compatible = "ot,rides";
>> +			status = "disabled";
>> +			orientation = < 127 >;
>> +
>> +			ride@100 {
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +				compatible = "ot,roller-coaster";
>> +				reg = < 0x00000100 0x100 >;
>> +				hvac-provider = < &hvac_1 >;
>> +				hvac-thermostat = < 29 > ;
>> +				hvac-zones = < 14 >;
>> +				hvac-zone-names = "operator";
>> +				spin-controller = < &spin_ctrl_2 5 &spin_ctrl_2 7 >;
>> +				spin-controller-names = "track_1", "track_2";
>> +				queues = < 2 >;
>> +
>> +				track@30 {
>> +					reg = < 0x00000030 0x10 >;
>> +				};
>> +
>> +				track@40 {
>> +					reg = < 0x00000040 0x10 >;
>> +				};
>> +
>> +			};
>> +		};
>> +
>> +		lights_1: lights@30000 {
>> +			compatible = "ot,work-lights";
>> +			reg = < 0x00030000 0x1000 >;
>> +			status = "disabled";
>> +		};
>> +
>> +		lights_2: lights@40000 {
>> +			compatible = "ot,show-lights";
>> +			reg = < 0x00040000 0x1000 >;
>> +			status = "disabled";
>> +			rate = < 13 138 >;
>> +		};
>> +
>> +		retail_1: vending@50000 {
>> +			reg = < 0x00050000 0x1000 >;
>> +			compatible = "ot,tickets";
>> +			status = "disabled";
>> +		};
>> +
>> +	};
>> +};
>> +
>> diff --git a/drivers/of/unittest-data/testcases.dts b/drivers/of/unittest-data/testcases.dts
>> index a85b5e1c381a..04b9e7bb30d9 100644
>> --- a/drivers/of/unittest-data/testcases.dts
>> +++ b/drivers/of/unittest-data/testcases.dts
>> @@ -2,19 +2,15 @@
>>  /dts-v1/;
>>  /plugin/;
>>  
>> +#include "testcases_common.dtsi"
>> +
>>  / {
> 
> Please add:
> 
>         /*
>          * testcase data that intentionally results in an error
>          * is located here instead of in testcases_common.dtsi
>          * so that the static overlay apply tests will not include
>          * the error
>          */
> 
>>  	testcase-data {
>> -		changeset {
>> -			prop-update = "hello";
>> -			prop-remove = "world";
>> -			node-remove {
>> -			};
>> +		testcase-device2 {
>> +			compatible = "testcase-device";
>> +			interrupt-parent = <&test_intc2>;
>> +			interrupts = <1>; /* invalid specifier - too short */
>>  		};
>>  	};
>> +
>>  };
>> -#include "tests-phandle.dtsi"
>> -#include "tests-interrupts.dtsi"
>> -#include "tests-match.dtsi"
>> -#include "tests-address.dtsi"
>> -#include "tests-platform.dtsi"
>> -#include "tests-overlay.dtsi"
>> diff --git a/drivers/of/unittest-data/testcases_common.dtsi b/drivers/of/unittest-data/testcases_common.dtsi
>> new file mode 100644
>> index 000000000000..19292bbb4cbb
>> --- /dev/null
>> +++ b/drivers/of/unittest-data/testcases_common.dtsi
>> @@ -0,0 +1,19 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/ {
>> +	testcase-data {
>> +		changeset {
>> +			prop-update = "hello";
>> +			prop-remove = "world";
>> +			node-remove {
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +#include "tests-phandle.dtsi"
>> +#include "tests-interrupts.dtsi"
>> +#include "tests-match.dtsi"
>> +#include "tests-address.dtsi"
>> +#include "tests-platform.dtsi"
>> +#include "tests-overlay.dtsi"
>> diff --git a/drivers/of/unittest-data/tests-interrupts.dtsi b/drivers/of/unittest-data/tests-interrupts.dtsi
>> index ec175e800725..0e5914611107 100644
>> --- a/drivers/of/unittest-data/tests-interrupts.dtsi
>> +++ b/drivers/of/unittest-data/tests-interrupts.dtsi
>> @@ -61,12 +61,5 @@ testcase-device1 {
>>  			interrupt-parent = <&test_intc0>;
>>  			interrupts = <1>;
>>  		};
> 
> Please add:
> 
>                 /*
>                  * testcase data that intentionally results in an error
>                  * is located in testcases.dts instead of in this file
>                  * so that the static overlay apply tests will not include
>                  * the error
>                  */
> 
>> -
>> -		testcase-device2 {
>> -			compatible = "testcase-device";
>> -			interrupt-parent = <&test_intc2>;
>> -			interrupts = <1>; /* invalid specifier - too short */
>> -		};
>>  	};
>> -
>>  };
>>
> 

