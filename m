Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C253437438
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhJVJFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:05:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231563AbhJVJFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634893374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OYnkK/ugidI49BFFj5mxnrcEA6t1Rlovv9DXEeR+Ht4=;
        b=SAMjUAGg+uY5yIUNgpp3wd9NvPXi24GriLyiYuZzvGXiAMSCLk9xXFCgyRUOquGaE0f0uu
        3y+V4YNRLJEeTtXZFEWKl/Ul0zNx3zIO89sQsJT/aliVt7K3L25AaiIc2nA5ppt5b59lZf
        ox3ZfKl9HH9v+8+lMDlrodxVCLdbsa0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-b7kmKuiMOYGxe8RvAXPUFQ-1; Fri, 22 Oct 2021 05:02:53 -0400
X-MC-Unique: b7kmKuiMOYGxe8RvAXPUFQ-1
Received: by mail-ed1-f70.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso3056465edj.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OYnkK/ugidI49BFFj5mxnrcEA6t1Rlovv9DXEeR+Ht4=;
        b=em93xo2ngNsNsVg309mxsamP5n9WZmfLyOaKh5vBSezwV0QgAQRbsA7cTYGVZ5yvIP
         YanDLK8o3pMo+4BCYehoc8Xb6oX+Jve6lIrB6LdzPARby9xPz6KnWSpdDEVTTLgIe6Sv
         MqFswNB/HvB6p+hsljLrY+X/dw6ds0GTxJERx70IxWNcdqPdyq9D4IMOCrRtKdOmtdDi
         ZdDLo7VMLMD5ZM9sfVvpABYbWbBLmn2duvrqGV7VgMmoQGolf5VOFicqwhpZaTvrore6
         E11rUgZJHXmJlZwmjGgaCftUDN6VltBQkVIMRpgmx2Bc/kzE5HG0X14Xgxwkqy/Y2EnA
         uqyQ==
X-Gm-Message-State: AOAM530G2kMZhxTXde5g0TUp0ZzYuuBODs//E6lFZb28SnVZdQZUf1Ur
        LTSzFo40ndOxWThgAxlQssO9Ijo+6ycPyrlrkDRfyPc62KoIifF0zHFvTwtu/Rq0gvNANbHotes
        A84IDxmkM/OmM7lg8/JSykHAM
X-Received: by 2002:a50:d558:: with SMTP id f24mr15678514edj.305.1634893371919;
        Fri, 22 Oct 2021 02:02:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJye92nZmEiPCT90la+U7ulelNZVortvgf1oMgs7297MBuXsB9bBlaq0BeoT6/NG9jphWx2M4g==
X-Received: by 2002:a50:d558:: with SMTP id f24mr15678480edj.305.1634893371628;
        Fri, 22 Oct 2021 02:02:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id j11sm3485626ejt.114.2021.10.22.02.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 02:02:51 -0700 (PDT)
Message-ID: <17e828ee-7338-e34e-db10-8af10d705a88@redhat.com>
Date:   Fri, 22 Oct 2021 11:02:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: linux-next: build warnings after merge of the drivers-x86 tree
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vadim Pasternak <vadimp@nvidia.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20211021184735.794b22a7@canb.auug.org.au>
 <BN9PR12MB53814D3DCD5BD5E9441DE3F3AFBF9@BN9PR12MB5381.namprd12.prod.outlook.com>
 <20211022070452.28924855@canb.auug.org.au> <87lf2mjd8b.fsf@meer.lwn.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <87lf2mjd8b.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/21/21 23:10, Jonathan Corbet wrote:
> [CC += Mauro]
> 
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> 
>> On Thu, 21 Oct 2021 09:07:03 +0000 Vadim Pasternak <vadimp@nvidia.com> wrote:
>>>
>>> What is wrong with the syntax at line 230 and where blank line is expected?
>>>
>>> What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/bios_active_image
>>> What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/bios_auth_fail
>>> What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/bios_upgrade_fail
>>> Date:		October 2021	<--- this is line 230
>>> KernelVersion:	5.16
>>
>> I am sorry, I don't know.  Added Jon to cc for advice.
> 
> The problem isn't that line at all, it's the use of a bulleted list a
> few lines further down; that doesn't work in ABI files.
> 
> Mauro, this ABI stuff is fragile, and this kind of problem occurs fairly
> often.  How hard would it be to (1) make it a bit more robust, (2) make
> it issue useful warnings where it can't be robust, and (3) properly
> document the restrictions for ABI files?
> 
> Meanwhile, the attached patch fixes it; feel free to use it or to just
> fold the change into your work.

Thank you. I've added the fix (as is) to my platform-drivers-x86/review-hans
branch. Once the lkp kernel test robot has done a successful build of that
branch (it also contains some other new patches) I'll push this to for-next
resolving these warnings.

Regards,

Hans



> -----------------------------
> From 97371e6afda75eef71b7d5d1794645e5cfaf1811 Mon Sep 17 00:00:00 2001
> From: Jonathan Corbet <corbet@lwn.net>
> Date: Thu, 21 Oct 2021 15:02:43 -0600
> Subject: [PATCH] docs: ABI: fix documentation warning in sysfs-driver-mlxreg-io
> 
> The use of a Sphinx list within this ABI file caused the following warning:
> 
>   Documentation/ABI/stable/sysfs-driver-mlxreg-io:230: WARNING: Unexpected indentation.
>   Documentation/ABI/stable/sysfs-driver-mlxreg-io:230: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Remove the bullets to make the warning go away and get proper formatting.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  .../ABI/stable/sysfs-driver-mlxreg-io         | 23 +++++++++++--------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> index c84795ccecad..12c3f895cd2f 100644
> --- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> +++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> @@ -231,16 +231,19 @@ Date:		October 2021
>  KernelVersion:	5.16
>  Contact:	Vadim Pasternak <vadimp@nvidia.com>
>  Description:	The files represent BIOS statuses:
> -		- bios_active_image: location of current active BIOS image:
> -		  0: Top, 1: Bottom.
> -		  The reported value should correspond to value expected by OS
> -		  in case of BIOS safe mode is 0. This bit is related to Intel
> -		  top-swap feature of DualBios on the same flash.
> -		- bios_auth_fail: BIOS upgrade is failed because provided BIOS
> -		  image is not signed correctly.
> -		- bios_upgrade_fail: BIOS upgrade is failed by some other
> -		  reason not because authentication. For example due to
> -		  physical SPI flash problem.
> +
> +		bios_active_image: location of current active BIOS image:
> +		0: Top, 1: Bottom.
> +		The reported value should correspond to value expected by OS
> +		in case of BIOS safe mode is 0. This bit is related to Intel
> +		top-swap feature of DualBios on the same flash.
> +
> +		bios_auth_fail: BIOS upgrade is failed because provided BIOS
> +		image is not signed correctly.
> +
> +		bios_upgrade_fail: BIOS upgrade is failed by some other
> +		reason not because authentication. For example due to
> +		physical SPI flash problem.
>  
>  		The files are read only.
>  
> 

