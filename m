Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CCB3333C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhCJDUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhCJDUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:20:34 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4522FC06174A;
        Tue,  9 Mar 2021 19:20:34 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id y13so7633421pfr.0;
        Tue, 09 Mar 2021 19:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=J2XwB36eXJKYuuPFa+xQF2Oj55lS2ihjK8QzJTmob/g=;
        b=E31twb0Z4lcvg9i9/gts8lWTTOVTklysLXiv3MiWV0m5jKStkjgKYyLAF+kIU9hVUZ
         Gj6JzKr1oTd4eBG/PWErAJmHFGHenxFY6bpPMA7YjiL7qBJIiPt4FbXUqmPebDj4MA+8
         +DQPTCUywaIzsb5s28o7yObucsZyGNJEgzJrSY98XQOxPZL58MkhsdXoM8SsH5nozVNn
         Q7DviyBgTweka2XOqImPqy5vj5jU4zHp0K1XRPxq8htFM6WUJVff7uxEQjAQn4dB+0X8
         0ce0fmM6wh91FSk8Og6CNCBkFoaR/p3E4aq/qa1YJ+mxZu61/yy7cPMLrlcoJHtL+VVc
         mZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=J2XwB36eXJKYuuPFa+xQF2Oj55lS2ihjK8QzJTmob/g=;
        b=F4MCIqcIG7KUJyRi5VxIknoVz+gm2PMCNTxMm/oB/HAx4NjOu3mIGwNOw9Kpcf4qGh
         Hc4is7ClPKrpf7of5P0dKFZRG30RKyszZ9Zz9GFY1Y0i2xIZBBJLvOY7YFqs5VitTNSw
         tTGRCeSjmPdZOntp7rEy6azRgYXOKk475rycswgCi4/+PeUebgbRYrUwcA1knNdD9XTO
         /I12IU/chSzKG5fd7XoVJ49qF07vORIXeryy4IXShztBHm69bA/hMmgqAzWcUan82VZt
         4Yf204OuN3ujEZ4mjk8qxeBe660mRYLoEFk4N7PkStEmcmF86ZP7dhiWHbRYsr5pnbIu
         h1Gw==
X-Gm-Message-State: AOAM530E6DuUSeA0fhLQENXACc2Ne3xzwNRKfayoeT0+B5E8UPfK7hN2
        c2bLuksRT8mAv8ezz0qVV02FABGWug3WQsw3
X-Google-Smtp-Source: ABdhPJyelEfNr9Ijnj6uy61F8uQ4/94uwc90wZOfPzyMaef8k4dOKd/3+Q773Exsuj9Ieid6UNPYhQ==
X-Received: by 2002:aa7:8488:0:b029:1fc:f312:b24e with SMTP id u8-20020aa784880000b02901fcf312b24emr840441pfn.55.1615346433876;
        Tue, 09 Mar 2021 19:20:33 -0800 (PST)
Received: from [10.62.0.178] ([45.135.186.89])
        by smtp.gmail.com with ESMTPSA id d6sm13998934pfq.109.2021.03.09.19.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 19:20:33 -0800 (PST)
Subject: Re: [PATCH] usb: renesas_usbhs: fix error return code of
 usbhsf_pkt_handler()
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <20210307090030.22369-1-baijiaju1990@gmail.com>
 <TY2PR01MB36929E9390A48F6FC7042AF8D8929@TY2PR01MB3692.jpnprd01.prod.outlook.com>
 <255bce3c-1680-593d-9083-6635e1a57b63@gmail.com>
 <TY2PR01MB3692E5843AC864F7F549927AD8919@TY2PR01MB3692.jpnprd01.prod.outlook.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <05aecdb3-23f5-54aa-c396-bff7f1624899@gmail.com>
Date:   Wed, 10 Mar 2021 11:20:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB3692E5843AC864F7F549927AD8919@TY2PR01MB3692.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/3/10 10:54, Yoshihiro Shimoda wrote:
> Hi Jia-Ju,
>
>> From: Jia-Ju Bai, Sent: Tuesday, March 9, 2021 10:39 PM
>> On 2021/3/9 19:59, Yoshihiro Shimoda wrote:
>>> Hi Jia-Ju,
>>>
>>> Thank you for the patch!
>>>
>>>> From: Jia-Ju Bai, Sent: Sunday, March 7, 2021 6:01 PM
>>>>
>>>> When __usbhsf_pkt_get() returns NULL to pkt, no error return code of
>>>> usbhsf_pkt_handler() is assigned.
>>> Yes. Also I realized that no error return code of usbhsf_pkt_handler()
>>> was assigned if the type value was unexpected value. So, I'm thinking
>>> initial value of ret should be -EINVAL instead of 0.
>> This is okay to me.
>> Need I write a new patch for this?
> Thank you for your reply. I can write such a new patch with your
> Reported-by for this as minor refactoring of the usbhsf_pkt_handler().
> May I write such a patch?

Okay, sure :)


Best wishes,
Jia-Ju Bai
