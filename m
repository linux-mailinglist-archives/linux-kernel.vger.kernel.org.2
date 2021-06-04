Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DBE39B916
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 14:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhFDMfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 08:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFDMfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 08:35:54 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199A0C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 05:34:08 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so7839765otu.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 05:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tCu/tKeYJwFaB3OgK7bagOEU6jq2x5jscMl3fnvsW4U=;
        b=qnFJVP/DW5Te8bJnZoC2h1qT0G1R0vO9fkYS5f86+H4eEFZNB4QZQXAvpUr7Pn5Owv
         SaHLAHFjSrMFdaVxjlgur5uvyZPRHgotUV+2TjuI9BM47xZX+uLq2WuJvmRj/vOom6AV
         mjPUniSxHJ1Apdu9EamFo9v8LPDBNovSP0C7QlhoXh8ZE+qRNi3ygF0axGGMgwycg4QX
         dONIz8rOqEGNz1hNS5/uBmWmMgAyD5bGfTbmGL3wUwYhz5/L/46bEu6K/b8hVe4NmHfR
         45Cnc3QfFb13qx2VeqkTK/jobUDS32F2IN4mA793UFCxIhQLaLPEKnbCm/OdEJ+C/H58
         TR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tCu/tKeYJwFaB3OgK7bagOEU6jq2x5jscMl3fnvsW4U=;
        b=Abl7eolI+A/gB5Tftn/WUcdvCh8PGv4mVylRVQuGSkgf42sXDyuVmzB15+smLkYyi+
         OfTBW57+SAyW6Ni4+wP7E7SBvvdCHNu49NXaxWNisEKKnfPsON4qEu5dZtA7XiOUvp31
         U65+Uyj69M3Lk6TiGLJ31y0sGymXq9l+dRAFRmagzb7+ULs4S8UAWAEdwJG44iQJf8Jp
         qQIazKGf/QLom87E90gPwbNFAhHqk+1mJr335BU8RL0GvtTrzN8X9GWLBFE7pQ+3gk85
         DlxgyWx6OZweQI/RWwwsjq5y1Sx/EdeZuLFSNE1oDdAWMYP5J5nZ5OAdnvRqWGBA4sey
         56Fw==
X-Gm-Message-State: AOAM533IMiM1peXIEYuJc3707z8t53U+eaLAQn/nL3rgaX2ealZxpjku
        +IMvMnW31YoldUaT8tS94kFpGsVSQwsWLqfo
X-Google-Smtp-Source: ABdhPJx/leSy51Y3cV58L2zpY1aK2i6EasrduwOlR++peaXucg2t2uW8ciCzlwcdAECGF6C5CeU/lA==
X-Received: by 2002:a9d:29:: with SMTP id 38mr3622473ota.30.1622810047206;
        Fri, 04 Jun 2021 05:34:07 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id a7sm403852ooo.9.2021.06.04.05.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 05:34:06 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH] staging: greybus: fixed the coding style,
 labels should not be indented.
To:     David Laight <David.Laight@ACULAB.COM>,
        'Manikishan Ghantasala' <manikishanghantasala@gmail.com>,
        Alex Elder <elder@ieee.org>
Cc:     Alex Elder <elder@kernel.org>,
        "greybus-dev@lists.linaro.org" <greybus-dev@lists.linaro.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        Johan Hovold <johan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210602133659.46158-1-manikishanghantasala@gmail.com>
 <9a3878fd-3b59-76f5-ddc7-625c66f9fee8@ieee.org>
 <CAKzJ-FNW8EPX2oQd1qr5NagnvjtWwvSeuAh8DNLetj11+BJ6RA@mail.gmail.com>
 <792dd57c0ef8454497e5ae4c4534dea2@AcuMS.aculab.com>
 <e1c36fb4-ab72-0cce-f6fe-3f04125dae28@linaro.org>
 <e23879ae78404be2b707b550b3029e43@AcuMS.aculab.com>
 <10ad30e2-c906-b210-bf0e-5e20b6de1993@linaro.org>
 <c29b5c97f97b48c894917647915bf510@AcuMS.aculab.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <613239d4-c4a6-8585-5f9e-0241f0caa5ec@linaro.org>
Date:   Fri, 4 Jun 2021 07:34:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c29b5c97f97b48c894917647915bf510@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/21 3:13 AM, David Laight wrote:
> Yes, and it isn't at all clear what it actually means.
> If the value of a bool memory location isn't 0 or 1
> what does 'bool_a & bool_b' mean.

I think this discussion is done, but I wanted to point out
that the above expression is incorrect.  It might be valid,
but it would be bad code.  A Boolean, when properly used,
should only be compared with true and false (or the result
of another Boolean expression).  Therefore "&" is not the
right operator, "&&" is.  The reason is similar to why you
would never use ~bool_a, you use !bool_a to invert its value.

					-Alex
