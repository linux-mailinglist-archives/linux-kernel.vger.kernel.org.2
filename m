Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62B744509F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 09:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhKDI4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 04:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230084AbhKDIz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 04:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636016000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mOpf3N8k5TmP0/CI17fGHAMr/m+bk2WcpGha5PDfEpM=;
        b=C07R68LupF1O830mwJfCZXzp3vKr6yuRDVkyYkHDGF7TGVKkQSLKLb65jQZ38vNat41U9V
        ow/4wqjNQiBKh9XuQrQY4GtSSGAzmFps7vIb3uzzqD5DS1/Qm/Z+D3Dr0EzA+E4jaSZuUI
        LUvCYo0fjvz3XX1qn5Yv6w+tJkYJ/30=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-K4AAL_WiOlKSdV9lrioW_g-1; Thu, 04 Nov 2021 04:53:19 -0400
X-MC-Unique: K4AAL_WiOlKSdV9lrioW_g-1
Received: by mail-ed1-f70.google.com with SMTP id y12-20020a056402270c00b003e28de6e995so5052344edd.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 01:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mOpf3N8k5TmP0/CI17fGHAMr/m+bk2WcpGha5PDfEpM=;
        b=qnhcpg0GAjCqUSkB5Z9zjw/aFX+I9UnORXwqd5Y7JUm/5fU6g0/zSMEhi7IfhZKyRg
         tZDq5flM+BuTJGPuE4SFFrXIuBSfFXX4GnOAtDdZTnasp0zz3O5dzf4abT9Vj5AvRbZf
         OU2hIEmhtW3kC+4LpPipfzrOSEvWAZ4Xknk4jPkmDuM4h3Z6qI0GsdWasUVh3iEc2UdQ
         8fUX9odTaHJz8cA1ZA8KoW51/Ovz+JNIavMmptBO4FmIy2kuYfXupdyLVRf9ayiaNSno
         yWEFRepWeSU3KQHb6qbsyUuAzk6PXNKbY6qdhGZ5gQZBk0xE1DqFw8KEcBVNhDVjFZKK
         HRpw==
X-Gm-Message-State: AOAM532BTKnJohWRP97tJkR+lcDhCIlEDzdlwMmLPysEbvXavcpYcu8+
        HNW2l+b44wzyYGHsz0fBgqcMRFriEI3pUJFxf0NC+B5OnyqRNGuRduZRHAgpdVSG5Y/n/uhRAJQ
        TdP2z6YdxiAQLRr4ytmvbxnyJ
X-Received: by 2002:a05:6402:35c2:: with SMTP id z2mr4555295edc.135.1636015998823;
        Thu, 04 Nov 2021 01:53:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgGEBlAZl//6XVnM2bnYFzF2EV8xe3d7ZYqWOwYgQkP5rn3A+uceioa6sefusXG/b67NWtGA==
X-Received: by 2002:a05:6402:35c2:: with SMTP id z2mr4555279edc.135.1636015998664;
        Thu, 04 Nov 2021 01:53:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id v10sm2453854edt.24.2021.11.04.01.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 01:53:17 -0700 (PDT)
Message-ID: <a30f80e5-9969-986c-0c27-f9a391c7686c@redhat.com>
Date:   Thu, 4 Nov 2021 09:53:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] backlight: lp855x: Add support ACPI enumeration
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211102225504.18920-1-hdegoede@redhat.com>
 <20211102225504.18920-3-hdegoede@redhat.com>
 <20211103171756.wxthncse2f4syeiz@maple.lan>
 <5d431db5-30dc-b51c-7abb-ab57a3de2f8f@redhat.com>
 <20211103173107.xlchsysme5xzpn24@maple.lan> <YYOZ4TI29Oq6i6za@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YYOZ4TI29Oq6i6za@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/4/21 09:29, Lee Jones wrote:
> On Wed, 03 Nov 2021, Daniel Thompson wrote:
> 
>> On Wed, Nov 03, 2021 at 06:28:15PM +0100, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 11/3/21 18:17, Daniel Thompson wrote:
>>>> On Tue, Nov 02, 2021 at 11:55:04PM +0100, Hans de Goede wrote:
>>>>> The Xiaomi Mi Pad 2 tablet uses an ACPI enumerated LP8556 backlight
>>>>> controller for its LCD-panel, with a Xiaomi specific ACPI HID of
>>>>> "XMCC0001", add support for this.
>>>>>
>>>>> Note the new "if (id)" check also fixes a NULL pointer deref when a user
>>>>> tries to manually bind the driver from sysfs.
>>>>>
>>>>> When CONFIG_ACPI is disabled acpi_match_device() will always return NULL,
>>>>> so the lp855x_parse_acpi() call will get optimized away.
>>>>>
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>
>>>> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>>>
>>> Thank you.
>>>
>>> So what is the process for upstreaming backlight patches,
>>> do these go through drm-misc-next (in that case I can push
>>> the series myself), or will you pick these up ?
>>
>> Lee Jones gathers up the backlight patches and sends a PR (but, except
>> in exceptional cases, treats my R-b as a pre-requisite before doing so).
> 
> Also the merge-window is open, so this is headed for v5.17.

Right, I didn't expect anything else.

Regards,

Hans

