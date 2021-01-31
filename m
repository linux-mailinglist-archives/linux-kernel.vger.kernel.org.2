Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F31309A42
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 05:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhAaElH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 23:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhAaEbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 23:31:38 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C02CC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 20:30:55 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d13so13771982ioy.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 20:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MBMLQFfZf3+VVkosf/RU/oYBaJJAMATBRJAHhn4sV/I=;
        b=z5D/1CMGacEWl+IFkkBW9M9HrZCDkISf1IzuDJkzFxFkOfBMp+V4tgMpgQtmfSzAIY
         LE61IQbCSyWC6y2yEg6T8rwJga80Sz7o0777HaYNjcHoLLTSCWhMslPiYTc4FCT3xPvi
         ZNNRp4aukl9AEymCsrKMiuNQkwL08rrSWE0WXgkLGZWQwGLKohYWePcc5J2xpM08S1pQ
         XjpNcKQ1sGj5uz7+Ag/Ehp+N9s+NJbDrYIICvNv+vQ8mdRDpNbisbWGEoHYi2JU/0tHo
         NrSGqK/WAjxUF5SwVV2u1qgSQEkCtq6aReHqO92uJRjgGA/KEteRiByYb9lXQykRtowU
         di+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MBMLQFfZf3+VVkosf/RU/oYBaJJAMATBRJAHhn4sV/I=;
        b=UDXQSRfmK1WpNGlorz8pR6AVWaNnrwox3750Veam8OA9UkdfGThqKMhoY/WJG7SPGj
         AROwC3/hCEBaxUVrJPGcB54DogrTN5Fb3kAZZ6dgv/yx+3Vd1N/KMZTrP/LmS7Yy/suy
         t7nykX8NbUgD4a+jfS6vkq+NYzy8gCsVywTE3LA7DbeQ94/mP1wiLNsk3pbgRRBqnQd/
         fnkVZ0rz0PNuriWd5QU9Z6nX63ZbOYDD6vmDXDLO+u7Pv6f6udF1ortIy530wNSfzXIf
         LxejeJxIDVrzM08tGYRWtfuomHSfbP6V9JEZZksMYGGuCgvtsggLy+5IkN9VmOdvvSbb
         g0Fg==
X-Gm-Message-State: AOAM532bETg6JyAC+MKY1w6YzYMylIxIMvRdKTZq/r3wMRSvoy0s2Sz4
        iSHI7ozOtGwQN0fovq8juK9KVsprCi4NNQ==
X-Google-Smtp-Source: ABdhPJxx6H05+Qkucfq0WpFoVTHgRXjb0EHZy9uyURuSdF0LCKatvzKI3gfAeZCZlK6XysORWrlTCQ==
X-Received: by 2002:a05:6602:3303:: with SMTP id b3mr27261ioz.49.1612067454366;
        Sat, 30 Jan 2021 20:30:54 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id u3sm7125344ilg.48.2021.01.30.20.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 20:30:53 -0800 (PST)
Subject: Re: [PATCH net-next 9/9] net: ipa: don't disable NAPI in suspend
To:     Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>, elder@kernel.org,
        evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210129202019.2099259-1-elder@linaro.org>
 <20210129202019.2099259-10-elder@linaro.org>
 <CAF=yD-L1SKzu+gsma7KN4VjGnma-_w+amXx=Y_0e78rQiUCu7Q@mail.gmail.com>
 <20210130112252.131ead6c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <241d4f55-318c-1e1b-f97e-bd60ef2982f0@linaro.org>
Date:   Sat, 30 Jan 2021 22:30:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210130112252.131ead6c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/21 1:22 PM, Jakub Kicinski wrote:
> On Sat, 30 Jan 2021 10:25:16 -0500 Willem de Bruijn wrote:
>>> @@ -894,12 +894,16 @@ int gsi_channel_start(struct gsi *gsi, u32 channel_id)
>>>          struct gsi_channel *channel = &gsi->channel[channel_id];
>>>          int ret;
>>>
>>> -       /* Enable the completion interrupt */
>>> +       /* Enable NAPI and the completion interrupt */
>>> +       napi_enable(&channel->napi);
>>>          gsi_irq_ieob_enable_one(gsi, channel->evt_ring_id);
>>>
>>>          ret = __gsi_channel_start(channel, true);
>>> -       if (ret)
>>> -               gsi_irq_ieob_disable_one(gsi, channel->evt_ring_id);
>>> +       if (!ret)
>>> +               return 0;
>>> +
>>> +       gsi_irq_ieob_disable_one(gsi, channel->evt_ring_id);
>>> +       napi_disable(&channel->napi);
>>>
>>>          return ret;
>>>   }
>>
>> subjective, but easier to parse when the normal control flow is linear
>> and the error path takes a branch (or goto, if reused).
> 
> FWIW - fully agreed, I always thought this was part of the kernel
> coding style.

That's fine.  I will post a v2 of the series to fix this up.
I'll wait a bit (maybe until Monday morning), in case there's
any other input on the series to address.

Thanks both of you for your comments.

					-Alex
