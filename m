Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1389C3754FB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhEFNnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233973AbhEFNnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620308533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/JFKzJsZWKfZev+/Rh9j9dVZ1lFg13LxLM7R/XtjBvQ=;
        b=ZXr/Y8kq6U7xKrRgcvRJ6LUEgrux1+S4EST31QbaOL0YcPy5e8pMUIPDMsp4yxzU3N7414
        miOHNFkQVpyzBHsuKyyENRl49KO/Nr1Q10UYSTMAeTSv09QpYjwKhkF5RKtVqk7zufQGRD
        0iw9uMXAWn2ngsQBLjPKuAorDXKmAbA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-peIpyyRAMCm8Eb9RvV6yKg-1; Thu, 06 May 2021 09:42:12 -0400
X-MC-Unique: peIpyyRAMCm8Eb9RvV6yKg-1
Received: by mail-ej1-f70.google.com with SMTP id zo1-20020a170906ff41b02903973107d7b5so1699506ejb.21
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 06:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/JFKzJsZWKfZev+/Rh9j9dVZ1lFg13LxLM7R/XtjBvQ=;
        b=jTXOwcVGrZ+bJryBcGNxPg0fJj/8Z0KMEkPbJmoQlcL8YDLizNppWn5hYrpeAKmpja
         Maknrumhng3UmnMRk4khTEcmy4idGM2q+5EyWxi4HLqYSGWDmYpfbabQuno1VSkVMpys
         9HkUd7b1V14qT2QuCuW4M36IPhjco+QxpG6K1eEWby5yZZWsaj8SANA+XN73o79Jb0lj
         ks1pcgxlApLkWtSkfZg3DzWYK4p56AqSETvOX4s2jKEKw7fvsnhAugBDMSIlLi5XaLmz
         rwSu7cl5rR8H5p77bJhBkuEk2CDiBQCyFGLBShjzeUF2GDOe3q+Eg+wlNIZv1fukvUxx
         QWhg==
X-Gm-Message-State: AOAM5309lUB8O1uSBE+rJO1+/zrhgKu3C+LcC3GBMWmsdHrLS4feP2RL
        9b3RxmTEk+OoF/2lFAYgMLIeRkT8IBTEfCOvfCkZuomBXtDXreEwU7tHm1zqb3lwlElQVcWdCL4
        AxHbO1cTd2CKfSwTVoY+PjJwN
X-Received: by 2002:a17:907:2117:: with SMTP id qn23mr4504976ejb.48.1620308529838;
        Thu, 06 May 2021 06:42:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3wxu/IZ9ntNTNuPeckWWVyR06mYdB053KKHEZETX5A+51tqYWcq2oTBKVUX2IhbEoR8+dQA==
X-Received: by 2002:a17:907:2117:: with SMTP id qn23mr4504954ejb.48.1620308529647;
        Thu, 06 May 2021 06:42:09 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id z22sm1906428edm.57.2021.05.06.06.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 06:42:09 -0700 (PDT)
Subject: Re: [PATCH v2] iio: bme680_i2c: Remove ACPI support
To:     Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20210506034332.752263-1-linux@roeck-us.net>
 <CAHp75Vd0N5s=D9LFiVU75gYCLnpqOwfBogbWUTwZNC1CV2n88Q@mail.gmail.com>
 <20210506133754.GA2266661@roeck-us.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <768c06ff-663c-eacb-fd3c-628b4e4ba449@redhat.com>
Date:   Thu, 6 May 2021 15:42:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210506133754.GA2266661@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/6/21 3:37 PM, Guenter Roeck wrote:
> On Thu, May 06, 2021 at 12:28:40PM +0300, Andy Shevchenko wrote:
>> On Thu, May 6, 2021 at 6:43 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> With CONFIG_ACPI=n and -Werror, 0-day reports:
>>>
>>> drivers/iio/chemical/bme680_i2c.c:46:36: error:
>>>         'bme680_acpi_match' defined but not used
>>>
>>> Apparently BME0680 is not a valid ACPI ID. Remove it and with it
>>> ACPI support from the bme680_i2c driver.
>>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>
>> with the SPI part amended in the same way.
>>
> Right. I just sent a patch doing that. Oddly enough 0-day didn't complain
> about that one to me, nor about many other drivers with the same problem.
> No idea how it decides if and when to make noise.
> 
> Is there a way to determine invalid ACPI IDs ?

No, unfortunately not. There is a format which ACPI IDs are
supposed to follow, but some "out in the wild" API ids don't
follow this; and many fake (made up) ACPI ids do follow it...

We (mostly Andy and me) are not even 100% sure this one is
a fake ACPI ID, but we do pretty strongly believe that it is.

Regards,

Hans

