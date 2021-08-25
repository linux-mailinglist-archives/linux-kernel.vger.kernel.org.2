Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834A43F7E32
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhHYWJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhHYWJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:09:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C20C061757;
        Wed, 25 Aug 2021 15:09:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h4so1609609wro.7;
        Wed, 25 Aug 2021 15:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HgSYLkAP+VjT/goIhd/z4sYO3yeXDg14TVtIyAVKrxg=;
        b=gx5n10z1MucqZio6cXa9TrIkaimFOV9IjWBEW0HuzBDyL776ERlcoglh5rtEICUcNl
         jfHb/9dCvy2GSCeJpuFaFy+ho8dEK+qnXgmlnVTy9UpAj09MPwl4rjp1yXaQpm3t97rA
         828WabpU/cvGpUezLDvCvgLs8edYhb0urOzWoLXwzB5Pydbr/3+DdM90hdCp+lJ//An8
         FBPwK73VHvaiNKHtsPy1EfJq8wyj8MzEJZAiwSs8Vli5siMGR2PUboUzvURCEFMW4E7C
         Wma422JCItjjKjl56zeXxNxl2TfYKklc9yfxxo2ZnEPFCh3AP4/8bKgrRvYZUkXWg8Tk
         ATRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HgSYLkAP+VjT/goIhd/z4sYO3yeXDg14TVtIyAVKrxg=;
        b=AU+zSekKgDuPeJd5DzR/69UZoE/+F8WcYH8r1rtiynUp/C7dZVgPyCqWr11ddGnbIG
         dSU9B1i63BFcV4pBJd4zHoLpSzjGgeew3MUOhAxwh8kOEnlLbF/cLzOhNjbAliYMEaU8
         0Iduq9lGTbDUAY+SZV1RCifmVd1/aSEwHov5TBerlgSYC/V0JU/aYOwSLii2W2UqtVIc
         xCilNaMFYCIhiTeJXADJxrqyKd9N9dR14yDxQs2KlqR18v5z2cYz5svwdvEZks74c+T8
         dj0EHClBPCEgV93hiASzKTt4/Dgd4owNtzh9+/UFpowisCEd9vNVZm3D5aNMO7xFJ3mH
         4dsA==
X-Gm-Message-State: AOAM5317L0sJzWYeoz4iUmTHNNn6YOX3qB39Q2DU4EomFZB3oPOrSYH0
        rQvzLAA6r4JagXg7ia9ICiQ=
X-Google-Smtp-Source: ABdhPJxKHfnKYHyK8j6YFQkRj8qqFAFogEfVkkqbuVKS0RynnrB+5vpK5iRloiSE/m8fHAGNgF9ESw==
X-Received: by 2002:adf:804a:: with SMTP id 68mr355370wrk.236.1629929350508;
        Wed, 25 Aug 2021 15:09:10 -0700 (PDT)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id c3sm1178229wrd.34.2021.08.25.15.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 15:09:10 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
To:     Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
References: <20210824230620.1003828-1-djrscally@gmail.com>
 <20210824230620.1003828-2-djrscally@gmail.com>
 <20210825103301.GC5186@sirena.org.uk>
 <CAHp75VdHpjbjz4biTP11TKT6J+7WQi-a1Ru3VLuSxM5tSLCB3Q@mail.gmail.com>
 <20210825113013.GD5186@sirena.org.uk>
 <CAHp75VfKJgux8k_mPauYB3MHcEOcnnzhSpoUDi4mVFDgtmNXeg@mail.gmail.com>
 <20210825131139.GG5186@sirena.org.uk>
 <YSZMxxJ76vF316Pi@pendragon.ideasonboard.com>
 <4ac0acb9-83ea-7fcd-cde3-669ba3b699c6@gmail.com>
 <YSZSOZXxSac307/A@pendragon.ideasonboard.com>
 <20210825145232.GI5186@sirena.org.uk>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <bce63128-3dde-f4c6-b0cd-00818293ebc3@gmail.com>
Date:   Wed, 25 Aug 2021 23:09:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825145232.GI5186@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

On 25/08/2021 15:52, Mark Brown wrote:
> On Wed, Aug 25, 2021 at 05:22:49PM +0300, Laurent Pinchart wrote:
>
>> a very large number of regulators, it may not be too bad in practice. If
>> I were to maintain the regulator subsystem I'd probably want a
>> centralized implementation there, but that's certainly a personal
>> preference, at least partly.
> We already have some generic platform data for regulators so if it
> doesn't want to define anything custom all a driver has to do is forward
> that struct on to the core for handling, otherwise it just has to pick
> the generic struct out of whatever custom thing it defines.
>
>> On a side note, this RFC looks quite similar to what the GPIO subsystem
>> does, which I personally consider nice as differences between regulator
>> and GPIO in these areas are confusing for users.
> My pushback here is that if all we're doing is providing a mechanism to
> match platform data with firmware provided devices we shouldn't be
> implementing it per API in the first place, we should have a generic
> mechanism for system level quirking to pass platform data to devices
> which works with anything - it could also absorb a lot of the DMI based
> quirking we have in drivers already which boil down to using a DMI match
> to pick some platform data.


Alright; and what about parsing the platform data into a struct
regulator_init_data then...at the moment that's left up to the
individual regulator drivers. In my mind that's something better left to
core, so rather than finding the right instance of struct
regulator_init_data from the regulator_lookup_list the
regulator_lookup_init_data() function would be finding the right
instance of the struct from cfg->dev->platform_data instead...what are
your thoughts on that?

