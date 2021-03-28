Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B94534BC1B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 13:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhC1LLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 07:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhC1LLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 07:11:34 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80856C0613B1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 04:11:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso5237528wmi.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 04:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=03U8ZMcgkCMSWbeLEL3An/d37+jEYP73/KLFh0oPZkk=;
        b=dSHU3AkY20kHSycyny0dJXlEcmUIE/a4hb26zil3sNljjaXhXGl/feAyLZsHwBbiO/
         /1D35gNUay9qNctUYaxMb1+klydlmlDAlmcx6zCXThSi4ydunwKtB7o+ZmSqutDPiO/x
         yihvI2T6Bsgb/ztwJcWEI4Kk34YuqstE/QExX5VMswWyTmTXpH+rSJ4zDQQYKVPPYfHd
         eE+RaSY61hxEXDFHVcFVJ687anq23Vatqezzkz1RqyJ791ddIauHQOOxmrzMGOyBPAik
         vMdvYca5FINBW97aKto8OS9z2pkmCtc9gR9ob2sceZ5KRJPXhc/SFj5e7q0UQr9lwkFa
         2hxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=03U8ZMcgkCMSWbeLEL3An/d37+jEYP73/KLFh0oPZkk=;
        b=UxPjML9GNGPXPz2hBXVhTM7+Lxmd3QyzYlQKh80vbb+pTyC8VOlGMucZEZEFOhpFHF
         SW4CfSaMFp2RKWs0Z4hBcAuLQzCcgm+e4UIJiikD9bZHpF/Hl6y8j257RNWA3RxXNiMT
         2aLxt7lSDpKpQ6REv0dNo/zQgeoqVYyR0JRJheFfoudfxvn/ItmNBOWl7ODdnLkjKmoj
         UWOYb3s7KLOHdBegVl6rZETeBHUNPYeAHM744wybQb8nth+9Dl3UjKR5qHjYDuUcz55V
         JqTRpZmXU/E33ooSIr5tdsqj74LTgFDSUDp4h+SnSIwuuBRihYsPWALsoW8v4++dcyvL
         V84A==
X-Gm-Message-State: AOAM532OJMiXId9Fs3dDOkWyhCzI/7Ym+rUTYv8aBYci4KFOELQCIx3B
        9MQSpAmnBzDCRp2vwgGPpOAlFA==
X-Google-Smtp-Source: ABdhPJw5Ey5kw3tDAPC4O1P6YYfhEgqqOwo1zCJo692Orwzm8Id8fgGseOsIDV3Bsl/mwSzQRZ5tMw==
X-Received: by 2002:a1c:bac2:: with SMTP id k185mr20937198wmf.148.1616929891924;
        Sun, 28 Mar 2021 04:11:31 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2d8b:2e0e:777b:e562? ([2a01:e34:ed2f:f020:2d8b:2e0e:777b:e562])
        by smtp.googlemail.com with ESMTPSA id 135sm20185846wma.44.2021.03.28.04.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 04:11:31 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] powercap/drivers/dtpm: Create a registering system
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com
References: <20210312130411.29833-1-daniel.lezcano@linaro.org>
 <20210312130411.29833-2-daniel.lezcano@linaro.org>
 <YF8qIw4UBLnj9TCA@kroah.com>
 <433ec4ac-a7a9-ecf9-f1c1-f658d279a2df@linaro.org>
 <YGAnRx8SiZHFPpY6@kroah.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7df276d1-abea-622c-2c7e-2c5e412aa4a9@linaro.org>
Date:   Sun, 28 Mar 2021 13:11:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YGAnRx8SiZHFPpY6@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

On 28/03/2021 08:50, Greg KH wrote:

[ ... ]

>>> And any reason why you are not using "real" struct devices in this
>>> subsystem?  You seem to be rolling your own infrastructure for no good
>>> reason.  I imagine you want sysfs support next, right?
>>
>> Actually, the framework is on top of powercap, so it has de facto the
>> sysfs support. On the other side, the dtpm backends are tied with the
>> device they manage.
> 
> So why are they not a "real" device in the driver model?  It looks like
> you almost are wanting all of that functionality and are having to
> implement it "by hand" instead.

I'm sorry I misunderstanding your point. dtpm is the backend for the
powercap subsystem which is the generic subsystem to do power limitation.

We have:

struct dtpm_cpu {
	struct dtpm dtmp;
	...
}

struct dtpm {
	struct powercap powecap;
};

struct powercap {
	struct device dev;
};



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
