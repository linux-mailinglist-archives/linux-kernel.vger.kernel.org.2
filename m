Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E176345E51
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhCWMi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhCWMiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:38:11 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF258C061574;
        Tue, 23 Mar 2021 05:38:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id q5so14177806pfh.10;
        Tue, 23 Mar 2021 05:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CYO3jLLdqXeezxgml/hOLnYiONhTc329cwaZR8YnfiQ=;
        b=k7Jr9GILdZSElGIi5VbITBzMKBzdNw7s2UrGa+8ukYKELiDWRgL7Y4gtDzz2Sp8eBw
         6oQgOd+o9dlpbmKNcqvP+ZZvUwy4Y7F9sQMyft7Bd9P8+fibrSt9EfVJOcbNGZj7qEdT
         D/l8oHa+TK5FxF5s4sxOyz3gvsRqRxWLTzu4kM+NAdWeYBIGE4IYz7Md1+MRd74GcijR
         ozAEXjm/ZAJqvlDnUOtAtr5Vk78N6cNPokGXeNk5tGoSaMQ60CjM6gp2yunDnWCCWyY1
         LYcYF+A09QLndK5W7TIuNtaSUVDWqH3UQHxP2/PwSWFMOVUYXKn3oDhDDQiRfQq52NFP
         1KBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CYO3jLLdqXeezxgml/hOLnYiONhTc329cwaZR8YnfiQ=;
        b=fouzPfwEc+88WqO6podomvzMq4ILrQJdeuuiEyhXOM3vT01qp0PcEKCl1kq/R0v6nt
         nM8iF/0sdaUpNaAST1w4IuZ5XEUD1IVlahMyITH5oRsfR77s1ScF73Ut7wP6y5yH4oNW
         J4MP178P6qWMppHmM7t3/pRgaeswAXX7t4yMEAWHgcLQTIKudAHEoVsTOvzK7myfA6dr
         I+9GjyBdvdszRSNzTj9d+s2UOBA8/zJRxJfxuQLKXXCVEq2EwQzLjUbZxmSjU0f/1hTE
         J1Eugg8lDBZ9wKdZ043hvS0aSsuX4+H0q1QLCxXNoXJAmttCJXSZsmqyNRNvAUt42SBC
         QOIg==
X-Gm-Message-State: AOAM531kwIW4TuU90ZdIyQ1w1vVdI5tv0/YM+yecJm05UI5nb0wR1DaT
        MhmB9nioIBmpDCSXsdfHq0c/azuBAXOeYg==
X-Google-Smtp-Source: ABdhPJzH5NeYjK6zrqjIYA/8z6ia3MihtWb4YPddf4jRgAbsteYuMy7sLDq4B4ucrSTu2T3N09erIg==
X-Received: by 2002:a17:902:c808:b029:e6:4204:f62f with SMTP id u8-20020a170902c808b02900e64204f62fmr5612453plx.0.1616503089158;
        Tue, 23 Mar 2021 05:38:09 -0700 (PDT)
Received: from [10.75.0.42] ([45.135.186.113])
        by smtp.gmail.com with ESMTPSA id q15sm3172835pje.28.2021.03.23.05.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 05:38:08 -0700 (PDT)
Subject: Re: [PATCH] usb: gadget: legacy: fix error return code of msg_bind()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, weiyongjun1@huawei.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210307084915.22022-1-baijiaju1990@gmail.com>
 <YFnSe716okrldCHJ@kroah.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <68012333-f9f6-74bb-1ff6-c1b77824ed7e@gmail.com>
Date:   Tue, 23 Mar 2021 20:37:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <YFnSe716okrldCHJ@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/3/23 19:35, Greg KH wrote:
> On Sun, Mar 07, 2021 at 12:49:15AM -0800, Jia-Ju Bai wrote:
>> When usb_otg_descriptor_alloc() returns NULL to usb_desc, no error
>> return code of msg_bind() is assigned.
>> To fix this bug, status is assigned with -ENOMEM in this case.
>>
>> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn
>> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>>
> These lines are not written correctly :(
>
> Please fix up and resend.

Sorry for the mistake.
I will fix it and send a V2 patch.


Best wishes,
Jia-Ju Bai
