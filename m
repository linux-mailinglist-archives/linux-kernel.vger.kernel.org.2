Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805BB332759
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhCINjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhCINim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:38:42 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B3CC06174A;
        Tue,  9 Mar 2021 05:38:41 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id l7so9520308pfd.3;
        Tue, 09 Mar 2021 05:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RzyfOZOtsOn/zkUIU85dncgR8oIZvp2HY0V3Gm7gyvk=;
        b=iroTtrZVrEBEmPI2rtrQViK3kGUhpvvZsEWLsle08BYqMB1dNpaT+rnOaMegnuUJ8R
         BeUwUIKSE01sM3UF97AqneSenKmUsvWzP5qfoKbiaAkgIU1rxmWmTL97U1q7F8PTw4bQ
         Bd55s82zqX7qlXF7D3a+W4FiTfeWFughd6GrpjV64YyvtnnRH6SLJr5rx3jqk+fTsof8
         qnMqs632Qggpf7iFBn+0oL5WTeSuGDXnc8OKG57RWXvzbgrGSN3oumWgEOnuJICktyIl
         v6FMmjNCw8Lr9HRPXVlvKqpDcEo5VAmqBMsWO13T5InF+9J0Y6XVstecX6DRJ0vsBmOM
         4YXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RzyfOZOtsOn/zkUIU85dncgR8oIZvp2HY0V3Gm7gyvk=;
        b=AxNDtOzIcXkZAkdJkCYnt1RSMun4CekcmkszL1/iF/TwKXC/Q4RWuSyzbfm3NMogOr
         GqstfGr+1eqIULWa/Tb5npbD70xKMJAW87fz8haBEZlviiJ6TKetJrz54ecokXoBa3uL
         4IEvNWrqwOQXQuWriYCYTFFSNFGG4o7gRkQMb6MGIw6SWne3USqlwJlF5pdlvzi07gKr
         o7Q4b5UM4oj4KJ7e98CuVJlmUgfpex3N8+D9GJDKGgwUiaZB2onxiKjfSBq+gv1Ca7dq
         9HqtE+HBRdKUsGsVRnaZwnyEXetxqKSN1XCZFe9gR0CJP/LpRJNn7+z1H2u4I7KpGTQG
         IhTA==
X-Gm-Message-State: AOAM5310LfvFN5d+0/n1JDt3rEl/2i6PjGtU45nzBH1w0K0GvizjeULy
        IEgWuQiJ1dDiVk4v+RMkeNIH76JE5Xxen+UU
X-Google-Smtp-Source: ABdhPJwrb2Yh4LdwBpjmhobqV1QAZVV895I9MqFeVthsJqymVsE20Y48Bn3Hb4wtKhpt9sE3e5ycCQ==
X-Received: by 2002:a63:557:: with SMTP id 84mr13645304pgf.82.1615297121535;
        Tue, 09 Mar 2021 05:38:41 -0800 (PST)
Received: from [10.160.0.34] ([45.135.186.124])
        by smtp.gmail.com with ESMTPSA id ha8sm2975830pjb.6.2021.03.09.05.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 05:38:41 -0800 (PST)
Subject: Re: [PATCH] usb: renesas_usbhs: fix error return code of
 usbhsf_pkt_handler()
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <20210307090030.22369-1-baijiaju1990@gmail.com>
 <TY2PR01MB36929E9390A48F6FC7042AF8D8929@TY2PR01MB3692.jpnprd01.prod.outlook.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <255bce3c-1680-593d-9083-6635e1a57b63@gmail.com>
Date:   Tue, 9 Mar 2021 21:38:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB36929E9390A48F6FC7042AF8D8929@TY2PR01MB3692.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply!

On 2021/3/9 19:59, Yoshihiro Shimoda wrote:
> Hi Jia-Ju,
>
> Thank you for the patch!
>
>> From: Jia-Ju Bai, Sent: Sunday, March 7, 2021 6:01 PM
>>
>> When __usbhsf_pkt_get() returns NULL to pkt, no error return code of
>> usbhsf_pkt_handler() is assigned.
> Yes. Also I realized that no error return code of usbhsf_pkt_handler()
> was assigned if the type value was unexpected value. So, I'm thinking
> initial value of ret should be -EINVAL instead of 0.

This is okay to me.
Need I write a new patch for this?


Best wishes,
Jia-Ju Bai
