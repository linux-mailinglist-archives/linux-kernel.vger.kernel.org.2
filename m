Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76A530F3C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbhBDNU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:20:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236029AbhBDNU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612444740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+vAM9v4eMZKg6YBIf04QqVg9hAruxcJZ81FnwmCn3uw=;
        b=XKgEEhQ8n3iRIpNae7i7mPTBB8YGAdaIFwzBGQKnLARPnPDTh0QhLo71HiUa9XHFe4JxTt
        WEdEB/W0FE2cTYaGRX9U+DOS/FJsAof0G+05RuS5feytP88v+qyjvf20kONgULH8h9oGL3
        Z9Od7dtaduGwD3w3tG1TCYiuw0Z2ZSY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-60LBYem7OlK7pHNDp4q96Q-1; Thu, 04 Feb 2021 08:18:56 -0500
X-MC-Unique: 60LBYem7OlK7pHNDp4q96Q-1
Received: by mail-ed1-f72.google.com with SMTP id ck25so2733338edb.16
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 05:18:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+vAM9v4eMZKg6YBIf04QqVg9hAruxcJZ81FnwmCn3uw=;
        b=OCaYfNiTsCxGczFxOafq8Bvif8T++zFFdL1pDEaoNL+8DX/YxMmveoTpl/+B+wqMvW
         zVVpzpXLaUENl6pYdm4h5BZ4VcQKGbdCV64i/O1D9G7AplrYDPgNl7sXzaYJTjAyYMBl
         uomb/4s1VzChKvHiSXzlFCqbwcsBicrjkZ3ugJZmmBCOWQ5UotPJqs7qZiFSGXzAUa2d
         Y0PuNbcJMPRJg9whhRVMzt4xjDxhXuexmQnggy3/tq3J7AzzgJdXWIdhJW9PFWAXLSw4
         9Xg5wB382/0OrZYzdM1OhtCH9+pxKSyiinH4c5SCjA4PpPwlYsD8LJ6PmJCfsbHq0UTw
         7Y7g==
X-Gm-Message-State: AOAM531P20TXxBXoZt9Rz8TM7EZhX81jnDO+WirnpkMpyj9blnF8m6Ft
        M/nJVBgeKr99PjtGrwD9/uZb8LJDKFIwQC+1DCulhu1FV/MvJi975ok3Jg7ncbiWbljKfnvcvyz
        RO8c6rh0m5PAg9bq5hwQXH8c8
X-Received: by 2002:a50:b5c5:: with SMTP id a63mr7829383ede.227.1612444735672;
        Thu, 04 Feb 2021 05:18:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2epJQrWbJJX+FnAr7MKarJjT9f2YzxU/r4xM9FHyMjplb+G8hEPNok/ANUNzd9X3viV9Qzg==
X-Received: by 2002:a50:b5c5:: with SMTP id a63mr7829370ede.227.1612444735537;
        Thu, 04 Feb 2021 05:18:55 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id r4sm2445330edv.27.2021.02.04.05.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 05:18:55 -0800 (PST)
Subject: Re: [PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail boards
 with WM5102 codec
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <249f1a7c-048e-d255-d860-68a97a0092c8@redhat.com>
 <20210204105748.GD2789116@dell>
 <7f53dede-946e-c38e-e871-3df1119f1faf@redhat.com>
 <20210204124335.GA4288@sirena.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e646cd26-f61c-8414-c3ae-15fb5d5cc21d@redhat.com>
Date:   Thu, 4 Feb 2021 14:18:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210204124335.GA4288@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/4/21 1:43 PM, Mark Brown wrote:
> On Thu, Feb 04, 2021 at 12:07:49PM +0100, Hans de Goede wrote:
>> On 2/4/21 11:57 AM, Lee Jones wrote:
>>> On Thu, 04 Feb 2021, Hans de Goede wrote:
> 
>>>> series are both ready for merging. All patches have Reviewed-by and/or
>>>> Acked-by tags now.
> 
>>> I don't think they do.  You're missing ASoC and Extcon Acks.
> 
>> Right, what I meant is that the patches have been reviewed by other
>> stake-holders, including the follow-up series being tested by the cirrus
>> codec folks (thank you Charles).
> 
>> But yes the actual subsys maintainers have not acked these yet;
>> and I'm aware that you will need those for merging this through
>> the MFD tree.
> 
> The usual pattern here is that the MFD patches get merged and then I
> pull a shared branch in for any dependencies - at this point the series
> is now on the backlog of serieses where I'm waiting for the MFD to sort
> itself out before I really look at it again.

I understand. But this series is somewhat special, if you also take
the follow-up series into account:

"[PATCH v4 resend 00/13] MFD/extcon/ASoC: Rework arizona codec jack-detect support"

That again has some MFD bits, and some extcon patches and ASoC patches
which depend on the extcon bits and this series.

So it is really hard to merge all the bits through there separate trees
and just merging it all through one tree and then pulling in the end-result
as a shared branch would IMHO be easier.

In the follow-up series one of the patches is moving the jackdet code from the
extcon dir to sound/asoc/codecs. So that is a single commit touching 2 trees ...

Regards,

Hans

