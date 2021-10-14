Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BBC42DB71
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhJNO1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 10:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhJNO1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:27:36 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E42C061570;
        Thu, 14 Oct 2021 07:25:31 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so8438239ote.8;
        Thu, 14 Oct 2021 07:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DgggYFRN9gnata5M3CUjSHFufPP55fUbunNLNw/C/eY=;
        b=b7seyn2A9tEw8HJUvgJVcUP4WwRhr5TXX60R//wRT36q7M8FOcm0TZEJjIcOwmo0P8
         FXwA4AQC7xTw7emN/c9ES3qiGI8aqqrLQZeQCxX/nDkwvHPFjRG02ZJvhiNUygbCdF0S
         uLomW0egGJN4ZjC/iak/ae0kDUIYskWcATOWV48xSWijQ+/MJq+Bd96vGjY3y92XGqyd
         bkVr7CJo070kAgbxs4tQEcaKLoqQmpWUg5OK39EfUR32phhRD7eF0sBJyP55uiwg9ZMG
         6RVt0gyctabfZvr+zpN1iBm412AEMBxtQGf/uprAcR5CBGosajV6DYvmrgr2neHm2aTT
         oMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DgggYFRN9gnata5M3CUjSHFufPP55fUbunNLNw/C/eY=;
        b=Hy7oDMxcxVT77D8vwHfJXU66POZgRqMTs79OJyZx9u77A58eM/XIF8L/n68T8nGQk6
         bhs0w1H5Hb5M7sHQ4/HT3JpqfwSVQOdSlK+5F99hdcz5xxYzlaZ9uK/CLfs1Ch2IUrMH
         TYneL+qyUWUxST6mOhtyzERgNriJWehwH0IhET02Pun3UJoOGPg3zrB/B9gfk+HqKEfq
         qGGKyj8L4ZXv512cPetxcIOSzMHPpKnzcvm8MziKtBkjbkd+8pMsebeq0KBGVF7rYhlK
         JRBUEKG8AorTwb6CToToa1H8yT8SvRnRN2Mt2stF2LPOLc7NQ5G78h/3y2YFqyuIDnGj
         uvcA==
X-Gm-Message-State: AOAM5338yFb7e0mR2H4MnkzqDnqtW1q53DNOd62Ku6Gvl55B82wHhBBn
        J3KpBUKHMmoHaccWRylX1Pzw51suaXk=
X-Google-Smtp-Source: ABdhPJyhNVhhmxeGNDO19iv3OtTgAOWDcQTjpC0JLm0n0PMtbLPeGqjMIBFvWE10qt2AFsbovzDonQ==
X-Received: by 2002:a9d:4b95:: with SMTP id k21mr2708925otf.345.1634221530195;
        Thu, 14 Oct 2021 07:25:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l10sm563680otj.9.2021.10.14.07.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 07:25:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v6 1/2] hwmon: (asus_wmi_ec_sensors) Support B550 Asus
 WMI.
To:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, platform-driver-x86@vger.kernel.org,
        Tor Vic <torvic9@mailbox.org>,
        kernel test robot <lkp@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211014072537.190816-1-pauk.denis@gmail.com>
 <20211014072537.190816-2-pauk.denis@gmail.com>
 <CAB95QAQQC6KJcbd-WhexBm=jusyoFkkB_a69RizMHpjSEbrqgA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e1a141d4-20e7-62c4-fae3-11166b8d0a66@roeck-us.net>
Date:   Thu, 14 Oct 2021 07:25:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAB95QAQQC6KJcbd-WhexBm=jusyoFkkB_a69RizMHpjSEbrqgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/21 5:08 AM, Eugene Shalygin wrote:
>> +struct asus_wmi_ec_sensor_address {
>> +       u8 index;
>> +       u8 bank;
>> +       u8 size;
>> +};
> The fourth field which you removed was supposed to hold the data
> encoding type, and together those four were packing nicely in u32...
> 

The compiler aligns the data nicely anyway (it will just leave
a 1-byte hole where needed), so the packing is really irrelevant.
Apart of that, does the above suggest that some information/
code is now missing from the driver ?

Guenter
