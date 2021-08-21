Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494573F3987
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 10:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhHUIb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 04:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhHUIb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 04:31:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0D8C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 01:31:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o15so7251655wmr.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 01:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r7pMHJHEpzcWJsiIgozc5/rwwa0w5oIqSH99Gp1LvZc=;
        b=uPCKWc8K8AKx5H4A21P2GNS3AbV/2CMVbHGyoHRDLOhZPkfYmDbe2dn7DhykZSwiNu
         uzH+PTrsrK1UQeCUMbU+ZMO8KzEqmoML2lkzF4hByVNnnhHTPpN9Sujxe1csS9X3DeOd
         1bJcx2ERWwrQVjhlO+NwXPiRcKFzqL1w1q51Uz43vAROVPuXXOcLMxgTOpsHFuf3kjTw
         YGRlnPXApvJnQg+tQU9Iw7RpH2l31pxrIKNlSBljO4WB3icMr8SbOc4s3unTkLKB7DLB
         jncwp4mbC4p42kCOyAvV9P5JZ1FvXmzPwZh50uKjEasMldBMhqGncittlmjn2c1nEbWq
         i1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r7pMHJHEpzcWJsiIgozc5/rwwa0w5oIqSH99Gp1LvZc=;
        b=DeQFdEIh8h52+4PXaA317dbu9MogB2yXQ9WX+ou3PiqaHxo9BzegwrCwOINVz5t3R7
         Gp9dYbFPXqIV1cleVJM2GPY7KTJATEpvOwQqq/0c/FAyahyjEXyUCuWZV/SXlqScgprO
         6PdUa2DlzZGBBpVl3i4413SPIlecmZ6fOXgLEM/3G+s255ONA8Vjsvqsoa0SMzgi4z8U
         rvcNFJ/N/IcxBkgBVN84osddt6PGGK6QZIkMW0tqn05T0LkLmI9g+tNJrdtI/hU7DpKh
         b6PZ+QFLISisjeO79ptBaYYqiTNiHeiaw/+8YrnDxEYc3sSPtBwNyTYj/dAOpw7+PUqM
         aqAQ==
X-Gm-Message-State: AOAM533kdBGzoGREw2qV9zwgon77nNs7dLeWBE3SCZNTe5bbSNRz0aoq
        98/orSdX5L8EdVd4d+72r8rWNqArmU0=
X-Google-Smtp-Source: ABdhPJx7NgH1Z2cNI0g3ADakQrP0PNMiBePXzpV5ILN0HSt72FliKqv8qda4/OSzKlG/TVvhxlTSTQ==
X-Received: by 2002:a1c:cc03:: with SMTP id h3mr6687171wmb.73.1629534677135;
        Sat, 21 Aug 2021 01:31:17 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::2744? ([2a02:8108:96c0:3b88::2744])
        by smtp.gmail.com with ESMTPSA id y13sm6991025wmj.27.2021.08.21.01.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 01:31:16 -0700 (PDT)
Subject: Re: [PATCH] staging: r8188eu: remove forward declaration of
 Efuse_Read1ByteFromFakeContent
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        gregkh@linuxfoundation.org, Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, Larry.Finger@lwfinger.net
References: <20210821000508.79422-1-phil@philpotter.co.uk>
 <5110838.kRcMR4ARJC@localhost.localdomain>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <b0819fe2-e7cf-b6bc-5930-a31e10da811d@gmail.com>
Date:   Sat, 21 Aug 2021 10:30:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5110838.kRcMR4ARJC@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/21 5:17 AM, Fabio M. De Francesco wrote:
> On Saturday, August 21, 2021 2:05:08 AM CEST Phillip Potter wrote:
>> Remove forward declaration of Efuse_Read1ByteFromFakeContent function
>> from core/rtw_efuse.c, as the function is defined in full directly
>> after this and therefore this forward declaration is redundant.
>>
>> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
>> ---
>>   drivers/staging/r8188eu/core/rtw_efuse.c | 6 ------
>>   1 file changed, 6 deletions(-)
> 
> Philip,
> 
> It's pretty clear that this function has only a translation unit visibility.
> Why don't you make it clear by defining it with storage class "static"?
> 
> Thanks,
> 
> Fabio
> 
> 

Hi Phillip,

I agree with Fabio, making the function static avoids the 
[-Wmissing-prototypes] warning and makes it clear that it is only used 
in this file.

Thanks,

Michael
