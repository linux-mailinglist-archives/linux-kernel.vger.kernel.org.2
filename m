Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8187347F66
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbhCXRdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbhCXRdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:33:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6192EC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:33:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k10so34266530ejg.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0ia9XkGHN8cpyt/SNHTlV6h0g+8s/qDF70Hmi8JWq3o=;
        b=SvtBKLat/CRx0Qu+JD4uXYjs0QfiZh3LK3TOczSV2qLDQGzU3O8i/2910n1VgWqb16
         X4H57OUsl/jV3qzjYvAtlJELU6cNl2LCjyaMrxMt0cyBpC1UYQXxcRnQe2hk68AsQJmN
         J0dX9sbv9I45DKriCBZBlC7i6LpnFC/htiw74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ia9XkGHN8cpyt/SNHTlV6h0g+8s/qDF70Hmi8JWq3o=;
        b=KhFCchFOIvbkSPLPd8Qrj1bUPuFYeqBxDVvm7O+sSuK+C+xzK+1mPGLQHWU6JOpzrJ
         H/u1xjzRO907qjVYqZ64lbL3brRzC3Srg33SbOdr01dD3Tc261gnWTPdF8IdGZiawzT4
         TsJbXcJCsRlij3JJQCIcP7+NBkz1F8AYlHPBtcUgz/SIjgI3lTsv2N4iBAVuZ5ldEZxs
         u7/6aGBZYTPchwj4u1Qnbrtj96KBB9mUOYKkdhBXp28RCl8WFvsJEPv7xd+KpeVsUezA
         SM7rG8+9LmQxKB8vb7TK5yMRclwj1I+bqssrnzVTsGzgWAgob9F2CiqCDUNa0zpiysdf
         1ecw==
X-Gm-Message-State: AOAM532PgG1Hjm6QxfjFuIm9IcK/sJgZGIu/DOGQ0ikqpuRD0TT9LSqt
        5ZW/nurf2rR1JZw2QijZu3Nem15+HBJ/aJs2
X-Google-Smtp-Source: ABdhPJzAvd1bvs+j7PzqB5nRnbeU7vt6/iMe8D4YVkWYBJ1ZPi+NFvO248ZS8JBhmHEYCGVPOPt52w==
X-Received: by 2002:a17:906:39cf:: with SMTP id i15mr4954508eje.534.1616607203805;
        Wed, 24 Mar 2021 10:33:23 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id hd8sm1212155ejc.92.2021.03.24.10.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 10:33:23 -0700 (PDT)
Subject: Re: [RFC patch] vsprintf: Allow %pe to print non PTR_ERR %pe uses as
 decimal
To:     Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liu Ying <victor.liu@nxp.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210324121832.3714570-1-arnd@kernel.org>
 <e1310273dcc577f3a772380ada7b6cc1906d680b.camel@perches.com>
 <CAK8P3a0JyoAtTYTi+M_mJ3_KtUJ6NeJB=FNWhzezqcXMac++mQ@mail.gmail.com>
 <810d36184b9fa2880d3ba7738a8f182e27f5107b.camel@perches.com>
 <3252fd83141aa9e0e6001acee1dd98e87c676b9a.camel@perches.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <9feab1e8-4dee-6b79-03f7-7b9f0cb24f6e@rasmusvillemoes.dk>
Date:   Wed, 24 Mar 2021 18:33:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <3252fd83141aa9e0e6001acee1dd98e87c676b9a.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 18.20, Joe Perches wrote:
> On Wed, 2021-03-24 at 09:52 -0700, Joe Perches wrote:
>> On Wed, 2021-03-24 at 17:42 +0100, Arnd Bergmann wrote:
>>> On Wed, Mar 24, 2021 at 3:20 PM Joe Perches <joe@perches.com> wrote:
>> []
>>>>> diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
>>>> []
>>>>> @@ -197,6 +197,12 @@ static void imx_ldb_encoder_enable(struct drm_encoder *encoder)
>>>>>       int dual = ldb->ldb_ctrl & LDB_SPLIT_MODE_EN;
>>>>>       int mux = drm_of_encoder_active_port_id(imx_ldb_ch->child, encoder);
>>>>>
>>>>> +     if (mux < 0 || mux >= ARRAY_SIZE(ldb->clk_sel)) {
>>>>> +             dev_warn(ldb->dev, "%s: invalid mux %d\n",
>>>>> +                      __func__, ERR_PTR(mux));
>>>>
>>>> This does not compile without warnings.
>>>>
>>>> drivers/gpu/drm/imx/imx-ldb.c: In function ‘imx_ldb_encoder_enable’:
>>>> drivers/gpu/drm/imx/imx-ldb.c:201:22: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘void *’ [-Wformat=]
>>>>   201 |   dev_warn(ldb->dev, "%s: invalid mux %d\n",
>>>>       |                      ^~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> If you want to use ERR_PTR, the %d should be %pe as ERR_PTR
>>>> is converting an int a void * to decode the error type and
>>>> emit it as a string.
>>>
>>> Sorry about that.
>>>
>>> I decided against using ERR_PTR() in order to also check for
>>> positive array overflow, but the version I tested was different from
>>> the version I sent.
>>>
>>> v3 coming.
>>
>> Thanks.  No worries.
>>
>> Up to you, vsprintf would emit the positive mux as a funky hashed
>> hex value by default if you use ERR_PTR with mux > ARRAY_SIZE so
>> perhaps %d without the ERR_PTR use makes the most sense.
>>

> 
> Maybe it's better to output non PTR_ERR %pe uses as decimal so this
> sort of code would work.

No, because that would leak the pointer value when somebody has
accidentally passed a real kernel pointer to %pe.

If the code wants a cute -EFOO string explaining what's wrong, what
about "%pe", ERR_PTR(mux < 0 : mux : -ERANGE)? Or two separate error
messages

if (mux < 0)
  ...
else if (mux >= ARRAY_SIZE())
  ...

Rasmus
