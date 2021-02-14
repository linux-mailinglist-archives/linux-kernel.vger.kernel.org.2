Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745A931AF95
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 08:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhBNHYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 02:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhBNHYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 02:24:43 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F7DC061574;
        Sat, 13 Feb 2021 23:24:03 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r21so4822757wrr.9;
        Sat, 13 Feb 2021 23:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=rsfpdVU9nQUkb0Hn8plZhbJavn6Bn7sQcQYoj21h4m4=;
        b=IlTfhDgyeX7NlFLj1Qy8cZXkjOh4CDjkh3fL6WxzPDTLt4tMJbtK1xGBSKQCgWHoUE
         iyol2OTeR9Nt33GxtwvIPeSIZWIr4+lCvM0Fd2QnmsnflgcRlOfZfrP+BP3Vmjkslv4f
         +MNYKDk9RtIy0PragzSOC3JBJRTaGtxrzkEuBQEOTOIWR/dh0nCcvq5hL+NDT2+ObrjM
         FWGv4ftrPRq364EJRb3/igB1NzjfCs83u7Y42T2h7zTSJ1kIslzkqJ91ZbJLCeJHNMhU
         rRCT8e2gAIzrhP78inSrvl7ClYBw+j2syGK3d071fdWleXIiv9kkLrypG+L6NjYnBCZm
         S3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=rsfpdVU9nQUkb0Hn8plZhbJavn6Bn7sQcQYoj21h4m4=;
        b=FqjixTQqjsv+MHRskWA4uy85hz44LnQLWsMI3Kf+t8va93mg1VnVXoI3fFcisvWIOV
         avvh/wSHIzXE/EfiTO7rfYJP7PB+ZynRC7907SdyDnti8H2gkULG7ZecCUVhNZQe33yV
         Cx3FJRyrLJcxBWwfFf2sOgEwRI+eYzTgQpqwwlHHZd1v3q/UOHlw0JZaTcYHPBgXXrln
         9VDX+6bE63FQUpuvCL76XGxomK/LItXE6lZKmuz7/km9jMObRRlP1FDheZqwXbbjPpIJ
         575hcBv+ihudtat5doUwRRN2n98FwUPJGQ3oZ84w5UR4h92+wjEssq1SfRwX0dPmnxAh
         O4yQ==
X-Gm-Message-State: AOAM531kBj+uicbLHC+zTYIinCqir9y11WONqMmV+iOpSlwy6nZm7duU
        +gWWuPr7wMyl3FLRfX2Aqrs=
X-Google-Smtp-Source: ABdhPJwHSBNZry74vzpPl+hsTNtlQYui+V4CKjLpOsGwaZofy8Bn1YF2X1eBC+TGSNehle+8iW/Yqw==
X-Received: by 2002:a5d:408a:: with SMTP id o10mr12148922wrp.427.1613287442135;
        Sat, 13 Feb 2021 23:24:02 -0800 (PST)
Received: from [0.0.0.0] ([2a01:4f8:c17:e10a::1])
        by smtp.gmail.com with ESMTPSA id o83sm20894670wme.37.2021.02.13.23.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Feb 2021 23:24:01 -0800 (PST)
Subject: Re: [PATCH v3 1/3] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     Randy Dunlap <rdunlap@infradead.org>,
        Perry Yuan <Perry.Yuan@dell.com>, oder_chiou@realtek.com,
        perex@perex.cz, tiwai@suse.com, hdegoede@redhat.com,
        mgross@linux.intel.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Mario.Limonciello@dell.com
References: <20210112171723.19484-1-Perry_Yuan@Dell.com>
 <cc83351b-a19a-9a3e-d511-4553cf4d7ef0@infradead.org>
From:   Perry Yuan <perry979106@gmail.com>
Message-ID: <68bd09cd-2bdb-2c4e-f38d-a28a7fb0cb48@gmail.com>
Date:   Sun, 14 Feb 2021 15:23:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <cc83351b-a19a-9a3e-d511-4553cf4d7ef0@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy.

On 2021/1/13 1:39, Randy Dunlap wrote:
> On 1/12/21 9:17 AM, Perry Yuan wrote:
>> +config DELL_PRIVACY
>> +	tristate "Dell Hardware Privacy Support"
>> +	depends on ACPI
>> +	depends on ACPI_WMI
>> +	depends on INPUT
>> +	depends on DELL_LAPTOP
>> +	depends on LEDS_TRIGGER_AUDIO
>> +	select DELL_WMI
>> +	help
>> +	This driver provides support for the "Dell Hardware Privacy" feature
>> +	of Dell laptops.
>> +	Support for a micmute and camera mute privacy will be provided as
>> +	hardware button Ctrl+F4 and Ctrl+F9 hotkey
> 
> 	End above with a period '.' please.
> 
>> +
>> +	To compile this driver as a module, choose M here: the module will
>> +	be called dell_privacy.
> 
> Please follow coding-style for Kconfig files:
> 
> from Documentation/process/coding-style.rst, section 10):
> 
> For all of the Kconfig* configuration files throughout the source tree,
> the indentation is somewhat different.  Lines under a ``config`` definition
> are indented with one tab, while help text is indented an additional two
> spaces.
> 
> 
> thanks.
> 

Thank you for the review.
Format checked again and will be updated in V4.
