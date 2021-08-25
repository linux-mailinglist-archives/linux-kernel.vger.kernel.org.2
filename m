Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993BE3F76F1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbhHYONQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239399AbhHYONN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:13:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D96C061757;
        Wed, 25 Aug 2021 07:12:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id j14-20020a1c230e000000b002e748b9a48bso3756133wmj.0;
        Wed, 25 Aug 2021 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mUGBvxxTO+M3FVNcUCixXfaj6SqueW/jfvs052Euehs=;
        b=tohcDDGWfa3c+6EPWUSvJZ/1a+oGsYPzotsIZe1u3SML6mKtdUpxwGoeOhfHBHsxbr
         WSts3y9djCyD63IdLzZ1ApoGFjOTzw/MLu5FE0kasDtgQdAocjJgMBQqg3i0syo8upx+
         TeGk7aozJ9yBgGfcKIGILEdRJ3+K5dn21aerAtPDx/E4uVyjevlP7MY6kXGxnYseRgkz
         +IO7d0HH/0K1G+GI8a0JBDHZCDCZhmRDXaHHwVp8xjgGLA4IU/3dRryV3X3/jGQNUY/y
         aE0+sAFKnMaKD8HFt2TUhJL6MAy06RPMfg25HeQg5VsEm5N3zgp9msqlwFBNrb7dw7e2
         PttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mUGBvxxTO+M3FVNcUCixXfaj6SqueW/jfvs052Euehs=;
        b=Fen4XJUCd7REc+osaH5MHKBwTrwGug4YOxCQxcyOPWTDjVdDMXg2O4a0FGn9poBgPv
         ukoNM1o0+vcd9AuoDPD+h5vTktKAlRhMTY9hhoNPKtZ0g8aGVWN3f2B88IubKw33Eaq9
         e4W259d2GM7LPnw/3aairrJP7pB6oLSYwEno6ZEFJrRdV0gsuwWfM8GFa9HQDMTeHhuz
         gUG65lIXbmOQSjbVStPJEUO4azA7IP5aa/StKng68l0pcKXmhwgAC9AbPzSJJ92ApJG2
         eXdb22rDEeUZ83RhcAGKaKSoDX84psRxr96PVCjtSnDefNDsk2tkfdvK7/nY5/9Wm7ln
         Ms3w==
X-Gm-Message-State: AOAM531hQa/c/kwM2i7KS6JMCoUZ/cYgfIjW271UQLF5E4g5lkIW6Yk3
        s1LIsPG4jzKVNcuptnsWw9U=
X-Google-Smtp-Source: ABdhPJxSvZmDP7eCID55tCsTYdbKUtR5exy7HKTLlLQuKVcEcVceuXr0yrUPo217UdXjJriVBo350Q==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr9545120wmq.101.1629900746434;
        Wed, 25 Aug 2021 07:12:26 -0700 (PDT)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id s12sm13640wru.41.2021.08.25.07.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 07:12:26 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        sailues@pendragon.ideasonboard.com
References: <20210824230620.1003828-1-djrscally@gmail.com>
 <20210824230620.1003828-2-djrscally@gmail.com>
 <20210825103301.GC5186@sirena.org.uk>
 <CAHp75VdHpjbjz4biTP11TKT6J+7WQi-a1Ru3VLuSxM5tSLCB3Q@mail.gmail.com>
 <20210825113013.GD5186@sirena.org.uk>
 <CAHp75VfKJgux8k_mPauYB3MHcEOcnnzhSpoUDi4mVFDgtmNXeg@mail.gmail.com>
 <20210825131139.GG5186@sirena.org.uk>
 <YSZMxxJ76vF316Pi@pendragon.ideasonboard.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <4ac0acb9-83ea-7fcd-cde3-669ba3b699c6@gmail.com>
Date:   Wed, 25 Aug 2021 15:12:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSZMxxJ76vF316Pi@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On 25/08/2021 14:59, Laurent Pinchart wrote:
> Hello,
>
> CC'ing Sakari.
>
> On Wed, Aug 25, 2021 at 02:11:39PM +0100, Mark Brown wrote:
>> On Wed, Aug 25, 2021 at 03:26:37PM +0300, Andy Shevchenko wrote:
>>> On Wed, Aug 25, 2021 at 2:30 PM Mark Brown <broonie@kernel.org> wrote:
>>>> No, what was proposed for regulator was to duplicate all the the DT
>>>> binding code in the regulator framework so it parses fwnodes then have
>>>> an API for encoding fwnodes from C data structures at runtime.  The bit
>>>> where the data gets joined up with the devices isn't the problem, it's
>>>> the duplication and fragility introduced by encoding everything into
>>>> an intermediate representation that has no purpose and passing that
>>>> around which is the problem.
>>> The whole exercise with swnode is to minimize the driver intrusion and
>>> evolving a unified way for (some) of the device properties. V4L2 won't
>> The practical implementation for regulators was to duplicate a
>> substantial amount of code in the core in order to give us a less type
>> safe and more indirect way of passing data from onen C file in the
>> kernel to another.  This proposal is a lot better in that it uses the
>> existing init_data and avoids the huge amounts of duplication, it's just
>> not clear from the changelog why it's doing this in a regulator specific
>> manner.
>>
>> *Please* stop trying to force swnodes in everywhere, take on board the
>> feedback about why the swnode implementation is completely inappropriate
>> for regulators.  I don't understand why you continue to push this so
>> hard.  swnodes and fwnodes are a solution to a specific problem, they're
>> not the answer to every problem out there and having to rehash this
>> continually is getting in the way of actually discussing practical
>> workarounds for these poorly implemented ACPI platforms.
>>
>>> like what you are suggesting exactly because they don't like the idea
>>> of spreading the board code over the drivers. In some cases it might
>>> even be not so straightforward and easy.
>>> Laurent, do I understand correctly the v4l2 expectations?
>> There will be some cases where swnodes make sense, for example where the
>> data is going to be read through the fwnode API since the binding is
>> firmware neutral which I think is the v4l case.  On the other hand
>> having a direct C representation is a very common way of implementing
>> DMI quirk tables, and we have things like the regulator API where
>> there's off the shelf platform data support and we actively don't want
>> to support fwnode.
> From a camera sensor point of view, we want to avoid code duplication.
> Having to look for regulators using OF lookups *and* platform data in
> every single sensor driver is not a good solution. This means that, from
> a camera sensor driver point of view, we want to call regulator_get()
> (or the devm_ version) with a name, without caring about who establishes
> the mapping and how the lookup is performed. I don't care much
> personally if this would be implemented through swnode or a different
> mechanism, as long as the implementation can be centralized.

I think rather than sensor drivers, the idea would be just to have the
tps68470-regulator driver check platform data for the init_data instead,
like the tps65023-regulator driver [1] does. I'm sure that'll work, but
it's not particularly centralized from the regulator driver's point of
view.


[1]
https://elixir.bootlin.com/linux/latest/source/drivers/regulator/tps65023-regulator.c#L268

