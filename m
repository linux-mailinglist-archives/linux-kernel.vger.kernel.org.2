Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4ACD39D591
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 09:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhFGHHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 03:07:17 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:40538 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhFGHHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:07:16 -0400
Received: by mail-wm1-f48.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so11864683wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 00:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=IXQ0rHuIq8Sp6ZPSHkZylxeYQH0sxVpoEqp3jeaqYmE=;
        b=CusfUE99qmUxcpVDkjaGEVIrFMA4hxU1A186jcqV+McU6E+Nau4xkvIptLglW8Q7fx
         mvNUugrdAmpkGz27Vpjk+wrZ9DqTJSf5o/I31z0NO/9FG2oWcH0DRYYeoKBvO9mqMDvH
         aXWzNmhUaK43gb8N4fK2tvYHYNmFj2mTs4i0UpTuqCFTMJfLeUz7pGPFm1qYokleH5QI
         p/aKxMcG8RQusn0Fpo2RffkWJE4xDF8CJxCkJpXu4+QpfVvW+QB0C2sCj/BVJU8dZ7Zh
         f9LJijY+4Qq7zQxq52HYYFSac2GZgD4IONIZCtGlmYKdrcbbqNHWKtSA5yvv5pFbrnqJ
         NBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=IXQ0rHuIq8Sp6ZPSHkZylxeYQH0sxVpoEqp3jeaqYmE=;
        b=cEl0vmM+nKqpH7snkXOhgu8VfqbBytrJNp6WyGZbdGTJiNvRanhK3JtXh7eMRFpqbi
         IBASXu5LN5dQxH4HwoIo8UxJeKO2WQuLSjq/biF2NUjX3CVziZ7x6kSdDOUU7IIoP2wB
         lIgaNNiBI6F2NKw4SAgmGjZASws5rYEam6HYFajA3fyjaD5Y+YLs2GysO3k+Rg36Seaw
         k0HrCpk1hP3ar1fsq+2U1nHtsfNoVdXaHNRZxvtAK3+ETKR/NuLi6ed/T4mJsvo2mQNU
         jfC7vs5ZlcFBrsajuGL0yvME6ZCIEMrEQfAJFTJl1d5eAemfHiP9w+utI3v/eXeqRPYW
         mDiw==
X-Gm-Message-State: AOAM530/FgAwLc6xKj+2AAMISM52gDtprMz+TGgQwn4zGDtd74Vej8j0
        JBmE9FFrL3L2qC0eA5dqi4Bv8Q==
X-Google-Smtp-Source: ABdhPJyZOO/5rHk78956yRcE3dQpHyZg1qpWa64vJWaG0F4aawYYlClHtW4UBWk8JDkkqJx41AlDeA==
X-Received: by 2002:a05:600c:20d:: with SMTP id 13mr15430122wmi.174.1623049454701;
        Mon, 07 Jun 2021 00:04:14 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id l9sm13019639wme.21.2021.06.07.00.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 00:04:14 -0700 (PDT)
References: <20210524103733.554878-1-martin.blumenstingl@googlemail.com>
 <CAFBinCDn_0TeyLG9b9uB+4-4PdeNXgja11wf2CGcQ99tUNjkyQ@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        sboyd@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, mturquette@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 0/3] clk: meson: rounding for fast clocks on 32-bit SoCs
In-reply-to: <CAFBinCDn_0TeyLG9b9uB+4-4PdeNXgja11wf2CGcQ99tUNjkyQ@mail.gmail.com>
Message-ID: <1jr1heqhoy.fsf@starbuckisacylon.baylibre.com>
Date:   Mon, 07 Jun 2021 09:04:13 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 04 Jun 2021 at 19:18, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Jerome, Hi Stephen,
>
> On Mon, May 24, 2021 at 12:37 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>>
>> On the 32-bit Amlogic Meson8/8b/8m2 SoCs we run into a problem with the
>> fast HDMI PLL and it's OD (post-dividers). This clock tree can run at
>> up to approx. 3GHz.
>> This however causes a problem, because these rates require BIT(31) to
>> be usable. Unfortunately this is not the case with clk_ops.round_rate
>> on 32-bit systems. BIT(31) is reserved for the sign (+ or -).
>>
>> clk_ops.determine_rate does not suffer from this limitation. It uses
>> an int to signal any errors and can then take all availble 32 bits for
>> the clock rate.
>>
>> Changes since v1 from [0]:
>> - reworked the first patch so the the existing
>>   divider_{ro_}round_rate_parent implementations are using the new
>>   divider_{ro_}determine_rate implementations to avoid code duplication
>>   (thanks Jerome for the suggestion)
>> - added a patch to switch the default clk_divider_{ro_}ops to use
>>   .determine_rate instead of .round_rate as suggested by Jerome
>>   (thanks)
>> - dropped a patch for the Meson PLL ops as these are independent from
>>   the divider patches and Jerome has applied that one directly (thanks)
>> - added Jerome's Reviewed-by to the meson clk-regmap patch (thanks!)
>> - dropped the RFC prefix
> please let me know what you think about this v2
> I am asking because clk-divider is widely used, so I'd appreciate if
> this gets some time in linux-next (so for example Kernel CI can test
> this and report issues if there are any).
>

Looks good to me
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

>
> Best regards,
> Martin

