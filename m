Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5E03B19B4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFWMUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWMUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:20:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0EFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:17:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u11so2380271wrw.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KuVFAJxMALq05Bzeoy9nqG4MLHSRlPaxvvFAUb5EeGY=;
        b=jlzRfYswY5CR74NIvgjjjLj932LY+6Ad4V1u62rEpXASsP2wnq6xAkE3eTKGG5ia6z
         ATkL7W58410WWOJ4r8/BBGCAOvjQgapPdwVbRhp5RNdSuWz2LJHN1akhn3DWOiEZs5Xn
         H5N/YnrFLKjQcIpm0N/zWmQHyd/WIUx9zcGWbRbP9jIuJV6lZGtMf9k4K0ruxXMbxA6Z
         YEDBiX07kuwCLHWXBKnbsAPfD5ezwUFys/gEz5uKAY8jqUIdiKOB1kiCzwv3POokxE6L
         hzyySC0Xqkkmj+oiQUEU9yR6ugBBCcxF6mEh6x5gyFMPUuzUKiyphtYtWnAzvUJgX3N+
         XGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KuVFAJxMALq05Bzeoy9nqG4MLHSRlPaxvvFAUb5EeGY=;
        b=Bha3oEextppsvzxFn4yIzN+p+cFlIlp/9UARuoPkMKDAqV+FVZBajR2MwiG5qIng5J
         CMC7FuO70Knr47sMShvxpPJ6p2FRP1c8WQe+UngHqlcpObLjM8ME2bChn1PNHQHXxddj
         J9e2GH0hgtxGAXrREfc5ADMuRUEqedDqzeIkuyAWWr2zl/tmvPezndiszS+ztGQ/wnXb
         3avmm17zwlI+O3fThlfsB9oJBQMB4Kzz4TVLr/mFesPMEzSZNzuBC7Bde5IfbUlkkF3U
         phYPVfB9VNEVTCuV+dZF/3hrYdcBGf4dXLTtwvXTVKRwOXNaFzoNT0KaCvCockUnvlMG
         /nNQ==
X-Gm-Message-State: AOAM533exAMIXP97rhD09Xdh8E/UBk46brbZJj/qPgR8YL+3Ko1vU9la
        QHsAAgUn+e+BtHkfhmXENqUcGUtzWRr+OL/x
X-Google-Smtp-Source: ABdhPJwhMEY/Tg5fuEFD1TW4FbI86HGuN2hWzOLC/lejHps4GYNz6Vr/0DeEff4RfLRrKhCq522Kig==
X-Received: by 2002:adf:c18a:: with SMTP id x10mr11246588wre.193.1624450675576;
        Wed, 23 Jun 2021 05:17:55 -0700 (PDT)
Received: from [172.25.20.242] (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id t82sm5764991wmf.22.2021.06.23.05.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 05:17:55 -0700 (PDT)
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
To:     David Laight <David.Laight@ACULAB.COM>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "philipp.deppenwiese@immu.ne" <philipp.deppenwiese@immu.ne>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <20210622142334.14883-1-hans-gert.dahmen@immu.ne>
 <5ee9e467bfbf49d29cb54679d2dce1c3@AcuMS.aculab.com>
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Message-ID: <d61176a0-67cf-268f-8c31-8de8739753c3@immu.ne>
Date:   Wed, 23 Jun 2021 14:17:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5ee9e467bfbf49d29cb54679d2dce1c3@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

these are some good points.

On 23.06.21 00:18, David Laight wrote:
> Are you saying that my 15 year old 64bit Athlon cpu and bios
> have this large SPI flash

No. The reads will wrap, i.e. if your flash is 2MB then it would be 
repeated 8 times in the 16MB window.

> and the required hardware to
> convert bus cycles to serial spi reads?

Yes. The window is part of the DMI interface and the south bridge or PCH 
converts the bus cycles to SPI reads. It is because this region contains 
the reset vector address of your CPU and the very first instruction it 
executes after a reset when the internal setup is done will actually be 
loaded from the serial SPI bus. It is AFAIK part of AMD's original 
64-bit specification.

However, after reading your mail I understand that I should have looked 
up the exact explanations in the respective specs. So to definitively 
answer your question I need to know which south bridge there is in your 
15 year old system and have a look into its datasheet. Do you know which 
one it is by any chance?

Hans-Gert Dahmen
