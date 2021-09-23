Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBAA415A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 10:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbhIWItf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 04:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbhIWIte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 04:49:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15BDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 01:48:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x27so23763869lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 01:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=YLhOQn+Jnote/jetddmL5KWhArEpZJ+bxFl8aVZbrxw=;
        b=ZkNsr7s2eLMbpMuW3mZ3vdtZ+4tlM7k1QNFPatU7oePxZhqLepT0lMLSw7He1Q2JZJ
         LCL/4ZxwPUANjqO/AzlIA7pJuuQ+/WoqBaitDSxhZz5ZzANfh00MQdzmt0wKkhCktzSJ
         trqgRXhnjFct2lCEp6CjiEtF3rWfAhThkRa0XI190oDuBeLhDQ4uhUFuZ7BGG27OXimz
         dnLTmR6JDpCux8iCDALKnuHp8jXegxLA0WJZqAbqAcy4PsfRgRUFb69MJXex58T7uaNk
         5/b0jbQhXqz61B6P/sIYfbU3IIF7S89cK2W1mXugfml2WSuij5uIDSXYSYxzIp+GeiAO
         Q5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=YLhOQn+Jnote/jetddmL5KWhArEpZJ+bxFl8aVZbrxw=;
        b=4R0F1kNE6X0w5IjeKUkfXruoVfiNkkXrU58ssNWyHJeg4IQ5lhwj0dH1YRnp0HPRIh
         DTQ85ka+oW7/C3j/kRf8qCbdo7rZU7CzpNts1PwSQUutllQuqJuAIlEMQobJmF0Gl6Sr
         gkNbg82ONtzAf16VD98Y1OZeEjQ/lRJFlCPLW2/FxXKAlpTRh6mQmzDFHObFYC5YgJDT
         NLYcxQoeuy9kx2wOvuQV7mmFceDbrCbPMnpQNAu59VMMWkMGI5W4UGz2u9nMeX0SDNnX
         vQB+hBYK1QoaqvEgk8BwyA4rm4E53pIRFUQufYo63evCFiILKXVTJlJJe+vPx8IH6pSl
         3m9A==
X-Gm-Message-State: AOAM532Ini7JlMcf+wBWqK7N89tbdMVsn145i5QoLyvBO5LvjNUW+nXS
        TcVhjd58e8yuHpuPDYqB0OE=
X-Google-Smtp-Source: ABdhPJw1J3y4qLeJYG9w1mREqK82SnGndgOBUDU6BmiLhXKpw92ZNRmAAmyD0zvkLijUi+dFs4oNjA==
X-Received: by 2002:a2e:9ad6:: with SMTP id p22mr3938778ljj.65.1632386881019;
        Thu, 23 Sep 2021 01:48:01 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.246.37])
        by smtp.gmail.com with ESMTPSA id o23sm396623lfc.172.2021.09.23.01.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 01:48:00 -0700 (PDT)
Message-ID: <4434c136-6bfc-9a25-d0ba-f989c655fa69@gmail.com>
Date:   Thu, 23 Sep 2021 11:47:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v9 16/16] staging: r8188eu: remove usb_vendor_req_mutex
Content-Language: en-US
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
References: <20210921181834.29677-1-fmdefrancesco@gmail.com>
 <20210921181834.29677-17-fmdefrancesco@gmail.com>
 <dd99d40d-297e-8d27-dabe-d0e4c633d391@gmail.com>
In-Reply-To: <dd99d40d-297e-8d27-dabe-d0e4c633d391@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/21 16:21, Pavel Skripkin wrote:
> On 9/21/21 21:18, Fabio M. De Francesco wrote:
>> From: Pavel Skripkin <paskripkin@gmail.com>
>> 
>> This mutex was used to protect shared buffer for USB requests. Since
>> buffer was removed in previous patch we can remove this mutex as well.
>> 
>> Furthermore, because it was used to serialize the calls to the Core USB
>> API, we thoroughly tested the enabling of concurrent firing of USB requests
>> without the mutex and found no problems of any kind in common use cases.
>> 
>> Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> 
> Hi, Greg!
> 
> If all is OK with previous 15 patches, please, do not take this one, it
>    causes problems with connection... :)
> 
> I don't understand what went wrong after v8, but anyway, this one should
> not be applied for now, since it's broken
> 
> 
> Thank you
> 
>


Just to be clear: previous 15 patches _are_ tested and do not cause any 
misbehavior or bugs.

I guess, the stack buffer maybe the problem here, since it's the only 
change on this side since v8. I didn't have a chance to take a closer 
look, but I will do it on weekends, I hope :)



With regards,
Pavel Skripkin
