Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63D345DBBF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 14:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350014AbhKYOAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 09:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355476AbhKYN54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:57:56 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8DDC061396;
        Thu, 25 Nov 2021 05:51:09 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id u74so12684306oie.8;
        Thu, 25 Nov 2021 05:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oPvLxBeJdvDXQLehO8hqRXM+353CvYMcT7nXLMFxPOg=;
        b=CpxVdTUgwis3KFy/Iytjtqgm+16I5y4B9UfyfJ1ssfBe1DQLqZTX/pZrZOBF3i5lkV
         OLHtSisquroUIx+s9pfCoTX6/1CdBmo3B5q2ieOKikljO7Qdsb0aJCPvSTy15lLf94qd
         ZRt178PclLltsSQ0cVGtsD6g3G0U6nZ+JIJ+6sUY4jvFDUWm0iF9/8BS1YrxfzOPr3Mw
         NvUXk7Ub6j9qa2RAy9VBt1QunFXsEZf3pCKrEHAW7RGMCohSUeTbyqyvgu6xvDotZsfO
         ZNDEKW0wEd8DDWw5gyjivZfY27O6FH4mDkmKfyoSLUp7hj0AnvK8U73pvHP6JM9YYiJU
         p11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oPvLxBeJdvDXQLehO8hqRXM+353CvYMcT7nXLMFxPOg=;
        b=sznKCq23kWOn4ROmYCxII43wnUVAWkQss5DWvPCOCm3smmttNpKyLAWo/vfnm5kXbB
         iAn/ihb7ZBpAh31mdavQ7mtB5GaoKhgEaML+hi3xtE+RdpoqMSxf1zlvdPSpdCH5ImlK
         mlyviRy15EC3IGDQnyLiB9IknyMYDhAvFDEATyaihMCFkX5zBAOHOeJlol9ERAtVLxF7
         yQsgMdGvUUMarJzQz1u7AAVXpGtqHE2H10cO7avIe2v2RxnLT1ausYu5iV74ozeI+Gn0
         P5uuuwtMhLuxgG/OhEry6o1lqTub8EE4zzeDfSQSGauPEn0vHHV6BxeqhIO9VCIXKiQG
         mYLA==
X-Gm-Message-State: AOAM532mlQsc++0IHHo02pEM3WV/V1nFJIjQ6OfzFeTP9fk6iK+FMFS/
        mdlrBEVww8bsYuR+ZOBKiJXjrKLZIeI=
X-Google-Smtp-Source: ABdhPJxw09sWh8YJA9nsX7d/R9aFDyBdi7CXJzoV6x6bzc3SxdvbmBx6LWUmOC+k1Jwc0UILbxKsjw==
X-Received: by 2002:aca:1001:: with SMTP id 1mr15890103oiq.55.1637848268869;
        Thu, 25 Nov 2021 05:51:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s17sm532592otp.20.2021.11.25.05.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 05:51:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Implement custom lock by ACPI mutex.
To:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211122212850.321542-1-pauk.denis@gmail.com>
 <20211122212850.321542-3-pauk.denis@gmail.com>
 <CAHp75Vfg7LKX-21+b6f5c34G4Y=ZUqrWRbfDt_quCiJe+By-Ww@mail.gmail.com>
 <CAB95QASDiwM+-AwPgGfc7dP=Ctm0s2WP4xrapJzNHJ22B9foAw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4b00cd7e-4d40-8220-b313-6a5f8381b5af@roeck-us.net>
Date:   Thu, 25 Nov 2021 05:51:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAB95QASDiwM+-AwPgGfc7dP=Ctm0s2WP4xrapJzNHJ22B9foAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/21 5:14 AM, Eugene Shalygin wrote:
> Dear Andy, Denis, and Günter,
> 
> Denis worked on my code with the first attempt to read EC sensors from
> ASUS motherboards and submitted it as a driver named
> "asus_wmi_ec_sensors", which is not in hwmon-next. Now he adds the
> ACPI lock feature to support other motherboards, and I have another
> iteration of the EC sensor driver under development (needs some
> polishment) that utilizes the same concept (ACPI lock instead of WMI
> methods), which is smaller, cleaner and faster than the WMI-based one.
> I'm going to submit it to the mainline too. I think it should replace
> the WMI one. In anticipation of that, can we change the name of the
> accepted driver (asus_wmi_ec_sensors -> asus_ec_sensors) now, in order
> to not confuse users in the next version and to remove implementation
> detail from the module name? The drivers provide indistinguishable
> data to HWMON.
> 

Two drivers with the same functionality ? What would be the benefit of that ?
Why not drop the current one entirely instead ?

Guenter
