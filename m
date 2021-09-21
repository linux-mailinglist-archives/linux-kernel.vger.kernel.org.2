Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE82413A89
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhIUTNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhIUTM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:12:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3024C061574;
        Tue, 21 Sep 2021 12:11:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q26so42237120wrc.7;
        Tue, 21 Sep 2021 12:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oeXwuLKI4VPOt84PTF274pbXZwoHrnhHwnv+XDzjYhQ=;
        b=aEQCyBeXl9uud7znHNRy0g9EcOsfmBR6DIOd3+jjX3vqBzq2T0vhYFDPjDehm7P+wY
         NyPZHuv27vgkE2lw6Sh+s/MuU1nk1crwuKuEOpgB43k6HAen1biMJq2sVB79cq9VVSi/
         4hPD6yWlzYLf+Y/RvKQ0klneKRegaqBJ1nge11c1hNS/Wfg2HVyJ1WtKNDPu+7EmIhD5
         0mc8PCvBzqHRAaf9mDifD+2+jrB0cayBnogCAE9mo/4xJivzddMjMU5wtcaMbIDYsxog
         2ntlcusgSD0iZBvdbH5/HqTCju4977/uOlMvaMZEMsOfrQTvQz5D8fcYSj0U3PcXdEcP
         DVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oeXwuLKI4VPOt84PTF274pbXZwoHrnhHwnv+XDzjYhQ=;
        b=W1CLYMmTl2yjOmotF0aLmpqA04yiw+fm1jO44JJ+ykUrNoAGXIHaj/sNy/rBzVuBAK
         CXprwa0mwtqTevffR0YCHS7rlb4djR3e9aa2XKv90Sj9lZ03A/NyhLHeXyLb45eSD9ok
         IykXizs96OCMCu/MnHOrc3Ew+q4W4sLFCQs+rAQgHjR0tXS1CAuvpyCZXprN72iHYn1b
         pEwgxPuQPZ+syF+15MrDsMw/GpSEDMCBrsVWAsPjekUfOHFVIEKWc60VQ9ls8o8QJ6lK
         oEQuYyKyLono1zgPU9YiD0pf7WDz+Zs9VWvRuKYDeRELrofuCqeMQqRmIyPTGrwk5tjI
         mZOg==
X-Gm-Message-State: AOAM530HB2rd38BOKgkXoivMrVBTGugElIRMws+nlNRze/uT5gI+3k2U
        c3kyF3whf7UVg40GNtbQPpFX8+6uYds=
X-Google-Smtp-Source: ABdhPJwSxqZkIskvNA31B/yxld8hwX7RTQCYLYdBBO52tnUsA6tkh4kVXj8aNvy3HLXCWh0sEXU1Dg==
X-Received: by 2002:adf:f6c7:: with SMTP id y7mr37407342wrp.44.1632251487296;
        Tue, 21 Sep 2021 12:11:27 -0700 (PDT)
Received: from ?IPv6:2003:c7:8f4e:664:d2c3:5468:e139:48d7? (p200300c78f4e0664d2c35468e13948d7.dip0.t-ipconnect.de. [2003:c7:8f4e:664:d2c3:5468:e139:48d7])
        by smtp.gmail.com with ESMTPSA id c185sm4244308wma.8.2021.09.21.12.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 12:11:26 -0700 (PDT)
Subject: Re: [PATCH] Update min() to min_t()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210921055246.GA11535@matrix-ESPRIMO-P710>
 <YUl1067kvLA5KkGC@kroah.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
Message-ID: <a6185b27-a461-84e4-1301-485b88cddd02@gmail.com>
Date:   Tue, 21 Sep 2021 21:11:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUl1067kvLA5KkGC@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/21 8:04 AM, Greg KH wrote:
> On Tue, Sep 21, 2021 at 07:52:46AM +0200, Philipp Hortmann wrote:
>> diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
>> index 2dc58766273a..d87deee3e26e 100644
>> --- a/drivers/usb/usb-skeleton.c
>> +++ b/drivers/usb/usb-skeleton.c
>> @@ -363,7 +363,7 @@ static ssize_t skel_write(struct file *file, const char *user_buffer,
>>   	int retval = 0;
>>   	struct urb *urb = NULL;
>>   	char *buf = NULL;
>> -	size_t writesize = min(count, (size_t)MAX_TRANSFER);
>> +	size_t writesize = min_t(size_t, count, MAX_TRANSFER);
>>   
>>   	dev = file->private_data;
>>   
>> -- 
>> 2.25.1
>>
> 
> Has anyone actually built this driver in a while?
> 
> thanks,
> 
> greg k-h
> 
Hi,

I have build and loaded the driver. To me this seems OK.

dmesg from loading:
usb_skeleton: loading out-of-tree module taints kernel.
usb_skeleton: module verification failed: signature and/or required key 
missing - tainting kernel
usbcore: registered new interface driver skeleton

dmesg from unloading:
usbcore: deregistering interface driver skeleton

Used kernel 5.15.0-rc1+

Bye Philipp


