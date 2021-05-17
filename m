Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94DC382DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 15:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbhEQNtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 09:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbhEQNtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 09:49:51 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F20C061573;
        Mon, 17 May 2021 06:48:33 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so5624723oto.0;
        Mon, 17 May 2021 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Y7G3TzUfMF26NrwSfO4KjIdPwYhYispCIDNJBE6rnKU=;
        b=IlUjmEUztnRpvBfIDXO7inyXDXdMskWLTvaqVIFQNg/sz7Sm85rGV+V/NycCnzCMqp
         pR41oIEn6xzSWBDCE66TpcjX6qvaIxxkpGkrsNqRDG6fpqnsu2OSG8vTPdzkJ4UQcAmF
         vCk4Og0AUaXC+Rx6Tycg1z1yITNJBeGIVh+EKO+wJpyfqne9xBYo6GBQVfvgLU03xVpB
         qHvIQ3dwr+nVtRMdn4xrH2UGRqgIu9jxk4ditSoGxHEyIiEN7hQeODI70v97xH6/mTw3
         0h3rOWsJ0JiedFQaXs1hiDZDR4l0+g8RR+/wHKjxHwaBPWEc0DGLcB9//Ng8jc9U+/9E
         a5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y7G3TzUfMF26NrwSfO4KjIdPwYhYispCIDNJBE6rnKU=;
        b=VbvS1DaTaWkbW40H2+c6Ve4sFIAaXcEHMKxwiWEv2GqBQ/D2oLLpL9PTUXe/EKqZs5
         /eWv+UQvH/imgRNUSbPVAAwAPLP2aEpCsPNS/3s4oiGlrrdfYY1JREWLFDmKmnMQsRo8
         IUSVE0iE78Kei+/079H4QioLD0RG/eRvZDEiauqxvt4ljHEKC6XHmuRCSQdmXTJdk6sj
         T62GUaa7fJ5UGxF4nykZpCK5NxBLorrtNBY3iJhiPQE+zRlf5unqqnLMkZZM4daYNERN
         ZLz/5XXgIbA3B8DkZiuAw0gTunMNARWIYSGwtiZpIb8TBdtuHK7hxbzR4WqYCX+9dPRQ
         iaWw==
X-Gm-Message-State: AOAM530mlWSn3ll8uwQtblMdUBVWhqMzCmW7rAL+JGAuOKF33NpPaAeE
        X0qLbuQZ+veohiIHWnYUvwyOxu4Ty3KYTQ==
X-Google-Smtp-Source: ABdhPJyLzO83i4D+oIyg6HoPQKkQpEgGaCBeACLMXfFi8Xmghwtvoqj4t3iSgcq4bojWvN+4i7BQhA==
X-Received: by 2002:a9d:a14:: with SMTP id 20mr45335812otg.86.1621259312975;
        Mon, 17 May 2021 06:48:32 -0700 (PDT)
Received: from [192.168.99.80] (142-79-211-230.starry-inc.net. [142.79.211.230])
        by smtp.gmail.com with ESMTPSA id f9sm3160208otq.27.2021.05.17.06.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 06:48:32 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] usb: early: Avoid using DbC if already enabled
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Jann Horn <jannh@google.com>, Lee Jones <lee.jones@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1620950220.git.connojdavis@gmail.com>
 <d160cee9b61c0ec41c2cd5ff9b4e107011d39d8c.1620952511.git.connojdavis@gmail.com>
 <8ccce25a-e3ca-cb30-f6a3-f9243a85a49b@suse.com>
From:   Connor Davis <connojdavis@gmail.com>
Message-ID: <16400ee4-4406-8b26-10c0-a423b2b1fed0@gmail.com>
Date:   Mon, 17 May 2021 07:48:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <8ccce25a-e3ca-cb30-f6a3-f9243a85a49b@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/17/21 3:32 AM, Jan Beulich wrote:
> On 14.05.2021 02:56, Connor Davis wrote:
>> Check if the debug capability is enabled in early_xdbc_parse_parameter,
>> and if it is, return with an error. This avoids collisions with whatever
>> enabled the DbC prior to linux starting.
> Doesn't this go too far and prevent use even if firmware (perhaps
> mistakenly) left it enabled?
>
> Jan

Yes, but how is one supposed to distinguish the broken firmware and 
non-broken

firmware cases?

>
>> Signed-off-by: Connor Davis <connojdavis@gmail.com>
>> ---
>>   drivers/usb/early/xhci-dbc.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
>> index be4ecbabdd58..ca67fddc2d36 100644
>> --- a/drivers/usb/early/xhci-dbc.c
>> +++ b/drivers/usb/early/xhci-dbc.c
>> @@ -642,6 +642,16 @@ int __init early_xdbc_parse_parameter(char *s)
>>   	}
>>   	xdbc.xdbc_reg = (struct xdbc_regs __iomem *)(xdbc.xhci_base + offset);
>>   
>> +	if (readl(&xdbc.xdbc_reg->control) & CTRL_DBC_ENABLE) {
>> +		pr_notice("xhci debug capability already in use\n");
>> +		early_iounmap(xdbc.xhci_base, xdbc.xhci_length);
>> +		xdbc.xdbc_reg = NULL;
>> +		xdbc.xhci_base = NULL;
>> +		xdbc.xhci_length = 0;
>> +
>> +		return -ENODEV;
>> +	}
>> +
>>   	return 0;
>>   }
>>   
>>
Thanks,

Connor

