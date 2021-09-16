Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05AB40DB26
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbhIPNZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbhIPNZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:25:22 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63705C061574;
        Thu, 16 Sep 2021 06:24:02 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id l17-20020a4ae391000000b00294ad0b1f52so2046694oov.10;
        Thu, 16 Sep 2021 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E3ZPM+P8zZz/KMRpZqrjH3YgBj/qKGiMEQ0Fv8vv0Ts=;
        b=q2bBMwbkTegeYabkWSxlbx4+1tF6kfwauk6CiAdvtVHgA8kyjkDWxLdCu2J06z8AdA
         IWb7/V2x/NZEB29+IHsmSxsx5S796Ki7/PL7inWgiwOn2Q8a1DKnP0ZjrhiC9AKeAKS+
         jEoniDy3hI7prlPWblado2u8RIfAvXLxpXAtGrV01fGY1RPLR4EMV+pAuwdmyx5LQS5A
         tBd42KlaMj0Vl29VjJAzOsyZIhOaPb1io6gbmMtX6ptHwfEnukiMUxd8NdHEA4veASyo
         xITOV8RvI0LBl8h+gdkNwCKPiAaFmlojHiTutEhsq/6KqDBwOn9Yf90WI/DPIqEpR7Tc
         c/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E3ZPM+P8zZz/KMRpZqrjH3YgBj/qKGiMEQ0Fv8vv0Ts=;
        b=KsCskfCzb4B/qGTtie3qwr4GUBcVdOWa5RXoCCPuOtPe+0mAoYRakQQlzMlIfqfnls
         ke/xlZRKXdHUl/1+uH5vQ9B0XKaqS+r3z/45D4ak/iAwMgghFCcXpGCkdZlQC8NCVH3r
         AFAgo/6DlYCeEQB8saCDOwc9YQDtGH+BoitSzgSwHsic2P1Tx/xcPbcOlE1uy38Osq1l
         poRDr0AKXMihGd2Xeq8VKVCizLQaF+TYySba6fEBI+4wEjB1hJifnyXbaARVgudC58jT
         1Y3je3XuCwt9RddM2hoBLAmAH3dFyP2hq81qe7hC4kt7x3+mMSUnjLjE7s88o1+rySaz
         ceUQ==
X-Gm-Message-State: AOAM530kErD/m+RKiNUlnO+mi18Wi0JWWIsIsLyUm8CXB8Ut+xAczfEF
        /z3zsY0b0OIm4OLUF0G3zgbkTr9JH4s=
X-Google-Smtp-Source: ABdhPJxZefq2rpTF9z0JqV9a6vY9qIrpPL8Nc1CEEV/DcTKAhpGmrvt96KqxGeqnn2lqKMfLId9VFw==
X-Received: by 2002:a05:6820:253:: with SMTP id b19mr1569165ooe.28.1631798641185;
        Thu, 16 Sep 2021 06:24:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x4sm759417ood.2.2021.09.16.06.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:24:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v6 3/3] hwmon: (nct6775) Support access via Asus WMI.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>
Cc:     Bernhard Seibold <mail@bernhard-seibold.de>,
        =?UTF-8?Q?P=c3=a4r_Ekholm?= <pehlm@pekholm.org>,
        to.eivind@gmail.com, "Artem S . Tashkinov" <aros@gmx.com>,
        Vittorio Roberto Alfieri <me@rebtoor.com>,
        Sahan Fernando <sahan.h.fernando@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210915204251.26081-1-pauk.denis@gmail.com>
 <20210915204251.26081-4-pauk.denis@gmail.com>
 <CAHp75Vfj6yUrYxbCmYuw=poVjY3GmEBrhF2tJHqkKDVtQ4mywA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <522ecf24-8d9c-99d3-828d-069219739bd9@roeck-us.net>
Date:   Thu, 16 Sep 2021 06:23:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfj6yUrYxbCmYuw=poVjY3GmEBrhF2tJHqkKDVtQ4mywA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 1:34 AM, Andy Shevchenko wrote:
[ ... ]

>> +       u32 args = bank | (reg << 8) | (val << 16);
>> +       struct acpi_buffer input = { (acpi_size) sizeof(args), &args };
>> +       struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
>> +       acpi_status status;
>> +       union acpi_object *obj;
>> +       u32 tmp = 0;
> 

Ah, you changed the above to add the initialization.
Without knowing that, your comment below is a bit misleading.

Guenter

>> +       obj = output.pointer;
>> +       if (obj && obj->type == ACPI_TYPE_INTEGER)
>> +               tmp = obj->integer.value;
>> +
>> +       if (retval)
>> +               *retval = tmp;
>> +
>> +       kfree(obj);
> 
>> +       if (tmp == ASUSWMI_UNSUPPORTED_METHOD)
> 
> This is uninitialized tmp in case when no obj, or obj is of the wrong type.
> 
>> +               return -ENODEV;
>> +       return 0;
>> +#else
>> +       return -EOPNOTSUPP;
>> +#endif
>> +}
> 
