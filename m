Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A817453515
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbhKPPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237722AbhKPPGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:06:49 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2412C06120F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:01:48 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id t11so43952348ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UuIR/LC5SZev9/eHpT6QZZqfs4WuN126EuywzDwkq7g=;
        b=nqTPwTBVRq32cNn1Jujn9/JLlQohZJJjJf5gVKmHbROJAU3xq4TV+9GJexVSAtzdti
         YgtX1tWHKce4IliAELS3DhH9r2+6gwhu4aYoDVI8yqTx7ccPo5YuBpDJ7IsKWoB0bsSP
         eupb1zU9syyjZkrVs56pwf7iLj9aSneLB0BFFQ2lbBX3WOnr2rZCLR+ppEBhXQ/+laI+
         fAfrcRfLxKbCm2327cFBNQIUjTj9jIXeW1Um+i9Cv1xEKah9Uj/jEIRTJbQy3To8JKj7
         085KSwX84gUjPRWWEU87II8WrD0OOTayfIyNU5RXBRPakgMQE7EU5QVQoaNQpDxY48lb
         OT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UuIR/LC5SZev9/eHpT6QZZqfs4WuN126EuywzDwkq7g=;
        b=gV8nN74fNce1OjGa5n6Q2CTgSHDOLsKUSHxM4GO5P1Zq/jvUMmEKy0QtrKt8OEJUo+
         bCvqAZOw0rWtWIYhBrHYg8aM3hj0x/7Ee22ZVWH4JuF6aFtev9h5RKZTxhZecpFFX/CC
         ggBfB5xAs6r+uzW+3Mesl5/kuWbWZppvgqKZVI/GAswZWZVpgcys4U+4gLM6CTE3H9XU
         6Ob5ar75k9KB5ZBbUPwYPE/4Y4K1PEPX0MUWjs/C6xm4PAZUhm5RRR8V6Be23vRnbp4E
         dVKjfpPJ0y67oeX527XVYWOoF6o8xoovioSOZtSG58mJCiZYDg1Q1scA8XG6QmaRQHkE
         jvGw==
X-Gm-Message-State: AOAM532YfVbeCnHrB8hoH8Sbd3KsxUQQxylrQnrwBqziDGACiY00X2y0
        GCIgeESC3s2lKLZ7ykzoHp4=
X-Google-Smtp-Source: ABdhPJwKXYaVHZATt0RLChSCOq+HG2P+t+x0FPazQIoy7EwZg6loUPIlGN9o5As0jSAZqoVpQIX4Jg==
X-Received: by 2002:a2e:a6a0:: with SMTP id q32mr7873917lje.148.1637074906230;
        Tue, 16 Nov 2021 07:01:46 -0800 (PST)
Received: from [192.168.1.11] ([94.103.224.112])
        by smtp.gmail.com with ESMTPSA id f10sm1783979lfu.122.2021.11.16.07.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 07:01:45 -0800 (PST)
Message-ID: <a072c468-f9dd-25f4-70fa-535cb7196b13@gmail.com>
Date:   Tue, 16 Nov 2021 18:01:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] staging: r8188eu: remove unused defines in wifi.h
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Zameer Manji <zmanji@gmail.com>, gregkh@linuxfoundation.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211116011451.896714-1-zmanji@gmail.com>
 <6d2d9c4a-3f05-1d51-42dc-b1ebbb4aefe1@gmail.com>
 <CABtXzjSPNxe-n9QTujMB7=CmhqPFp8V2e86BXmoErWm+6c5coA@mail.gmail.com>
 <22a48290-814e-bcae-81e5-c23e6310f8f6@gmail.com>
 <20211116141838.GI26989@kadam>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211116141838.GI26989@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/21 17:18, Dan Carpenter wrote:
>> I cannot ack, since I am not the maintainer (or even reviewer) of this
>> driver :) I just saw this BIT() definition and decided to say, that it can
>> be also removed
> 
> Just give a Reviewed-by tag...  No one is appointed as a maintainer, you
> just have to start handing our reviewed-by tags until people start to
> respect your judgement and then you're a maintainer.
> 

Ok, I will send the R-b tag, since patch looks correct to me as is :)

I think, I misunderstood what "ack" means. I thought Zameer means 
Acked-by tag, which can sent only by maintainers (Larry and Phillip in 
case of r8188eu), but I was wrong, I guess...





With regards,
Pavel Skripkin
