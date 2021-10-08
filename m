Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E996426D13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242604AbhJHOzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhJHOy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:54:59 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689C1C061570;
        Fri,  8 Oct 2021 07:53:04 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 24so14196946oix.0;
        Fri, 08 Oct 2021 07:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=foYn8H7q3UIU7Of1c0FoDcVDC713rvA1GWkczdQekyI=;
        b=T/o++cVBomAjw5uW/ulvoVFPzEyUBZ7/bSHSLnGv3znmS3lyRV2xnll/7QK6O8xtBn
         DJgQerKW9BxIbH3IfmB7B7kqb/KnEsk0P0MPEmKIWCD92yfDN2KxT825JpLFreU/18tH
         6z28nYb4xIFV5GANFPFYZdqZqYkBSMR7ckyI7Kr9VBud2CO5pszCxcdDyt0mgOBakJc3
         V66mbBLNgKSn9lR1YfH1mxZOTg8tq3I+eedxRINClbWFFDWK1KYGTXFB9N1BzMiHWo9D
         rwv4SCdyFBc8yuF6vsVWVldftbePJWv/70IuX2Jq/K3Ew4hUjutHxThJQydjR2y+03i/
         Hxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=foYn8H7q3UIU7Of1c0FoDcVDC713rvA1GWkczdQekyI=;
        b=FmVJiIGJg+AX0Iv3eOu/eDJCLhwoIZnl35Xda+SpvBOFBe1IDWnP1GvHe1lYobgWSA
         1n6KHoMexi/Nn3TfnEXjCl04p5fEYVGwl1mMEF6Jc/bcTMGemNWdQn396qJbZ8NfYPiC
         dZYqQgbsH4zclXPfSOPkaR8uQEL1gv78SrOfe9GC73AP61UUXCtncSVSIUgXYOAlzadW
         OVjDEnYczWce1voTqG0YWAnD96m3rLj7+SOXngAmH5UGPiDrK4PFsF10keDvWq2HgmJ1
         xiP9NSneVsWssTnwelwqRbHqfMQlJ+DpFtNXYH1s7aWnhp4BJp6DPZ4qrM92CkLsq5fP
         Rf0g==
X-Gm-Message-State: AOAM532e/PAjbjOmtw3ILKX7P3zXSegrLMK9vQ6uFsEU1woVvmEA6NtH
        M9uKNSNXNDsdc4Sq3n2Y8COndUCjeRo=
X-Google-Smtp-Source: ABdhPJx1XMhR0uVbMK1h8u+IVRwzaj8497xzhUJrR/nSvpauLmjCDjJbKKCfXFxZMpou3iFg6VlMtA==
X-Received: by 2002:a05:6808:2107:: with SMTP id r7mr7557160oiw.153.1633704783489;
        Fri, 08 Oct 2021 07:53:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d14sm584747otq.65.2021.10.08.07.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 07:53:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1632994837.git.mchehab+huawei@kernel.org>
 <a14f98e1b23ea14cf14da3c3169955343ec28bbe.1632994837.git.mchehab+huawei@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 3/7] ABI: sysfs-class-hwmon: add a description for
 tempY_crit_alarm
Message-ID: <3ae66959-1bc0-09ed-b772-079030bc1c1f@roeck-us.net>
Date:   Fri, 8 Oct 2021 07:53:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a14f98e1b23ea14cf14da3c3169955343ec28bbe.1632994837.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/21 2:44 AM, Mauro Carvalho Chehab wrote:
> Such ABI symbol is currently not described. Document it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> See [PATCH v2 0/7] at: https://lore.kernel.org/all/cover.1632994837.git.mchehab+huawei@kernel.org/
> 
>   Documentation/ABI/testing/sysfs-class-hwmon | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
> index ea5a129ae082..1f20687def44 100644
> --- a/Documentation/ABI/testing/sysfs-class-hwmon
> +++ b/Documentation/ABI/testing/sysfs-class-hwmon
> @@ -410,6 +410,20 @@ Description:
>   
>   		RW
>   
> +What:		/sys/class/hwmon/hwmonX/tempY_crit_alarm
> +Description:
> +		Critical high temperature alarm flag.
> +
> +		- 0: OK
> +		- 1: temperature has reached tempY_crit
> +
> +		RW
> +
> +		Contrary to regular alarm flags which clear themselves
> +		automatically when read, this one sticks until cleared by
> +		the user. This is done by writing 0 to the file. Writing
> +		other values is unsupported.
> +

That is not really correct. It _may_ be current implementation for some drivers,
but such an implementation would not be correct. The proper implementation would
be to auto-clear the flag after it was read unless the condition persists.

>   What:		/sys/class/hwmon/hwmonX/tempY_crit_hyst
>   Description:
>   		Temperature hysteresis value for critical limit.
> 

This should be documented as part of the previous patch, together with
all other alarm attributes.

Guenter
