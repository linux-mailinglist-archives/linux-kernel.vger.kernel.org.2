Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066693ACBB7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhFRNIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFRNIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:08:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D73FC061574;
        Fri, 18 Jun 2021 06:06:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d11so8337572wrm.0;
        Fri, 18 Jun 2021 06:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dhEuPtsR/KNuGS/VgmTVMfARz6wFRoqIXPQfU/Gtd54=;
        b=WXwG0ImU0W+FCIwSp/R90xf5d8IUZpDwj8Cq2yls4n3j5ToW1p21WLELba6IhAD8jf
         OErGnbLxAtw/fR9WUGyN/zLvu/oVXGlJtoXgHMtDuD6tCdQLvuMA6Ptsrd7RbGb1gFmV
         bcMQjszW8U5VIgG2Ok0FzpDMd2NXaxqZ0Jn3mv5JWfJXcoaj0rzmjHUF7684XeoXrTXV
         R/q3qvoEqzyV7PWxcsVTJAgwtH6dIedodhFEuK+F2hUn5PiYLk8tebSwfa22bDVXC/7H
         Jr4tZX9YhFouWR0JxtQBZF7T81BgxGgWGuh7ksEIKrx/XxoYerHPUKoVCnMr9NPgeHxz
         6r6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dhEuPtsR/KNuGS/VgmTVMfARz6wFRoqIXPQfU/Gtd54=;
        b=IdTsIMu0xGUA2CLd8w9ktDv+iiBU1UEB+LNPHRqyS/c91YCzpiIzjaiGUfafPtIHyH
         mtSxJQVoQRkm3lCHxF7xT6Ymp3WSjrk8E45j31pkbmIujx2x7a3c4phnh1TgWvyxWLlK
         crl1RhJgaGqJM784MdKa4hw0kPtNj7jDzVw7dYybql6hUeXEO/UBJKsW/RzzulYjOC5K
         XBYH2K0h/U6XaP2TDhme/WME22Xj9WPGT20sc8pwCHWxdrh6U2ZmxIAtR53kJZenxpnB
         yTnDnxHPQkHyUkXgtePLvYnpCdiqRNsq3Ctbxi7l4tX1J9nGCxMvpTPs9d/YfsiNtF6B
         Uw5Q==
X-Gm-Message-State: AOAM5318zi1zPyrB9TazRV3q9FlyvJyUJRx+d3/L+ePl09/Bz6w7Id8c
        4JkoZMr6OKAIVz8A4rnFsco=
X-Google-Smtp-Source: ABdhPJzSrcojCkaxwj+uuLYe+Yxj0KiP0W9bjeXKIMlVP2mlIGd7Hr6QLnYmVxBUgQ6cU0qVvyWtGg==
X-Received: by 2002:a05:6000:18ab:: with SMTP id b11mr12585540wri.42.1624021590283;
        Fri, 18 Jun 2021 06:06:30 -0700 (PDT)
Received: from [192.168.1.211] ([2.29.20.116])
        by smtp.gmail.com with ESMTPSA id u12sm8960739wrr.40.2021.06.18.06.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 06:06:29 -0700 (PDT)
Subject: Re: [PATCH v1 2/4] platform/x86: intel_skl_int3472: Fix dependencies
 (drop CLKDEV_LOOKUP)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>
References: <20210617183031.70685-1-andriy.shevchenko@linux.intel.com>
 <20210617183031.70685-2-andriy.shevchenko@linux.intel.com>
 <c3aec3b4-1ba1-6442-fbed-57a16febde68@gmail.com>
 <YMyX4dxscWirfsBj@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <1ba47a56-2ab0-ab79-69a4-b8c6cd40086d@gmail.com>
Date:   Fri, 18 Jun 2021 14:06:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMyX4dxscWirfsBj@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

On 18/06/2021 13:56, Andy Shevchenko wrote:
> On Thu, Jun 17, 2021 at 11:50:36PM +0100, Daniel Scally wrote:
>> Hi Andy
>>
>> On 17/06/2021 19:30, Andy Shevchenko wrote:
>>> Besides the fact that COMMON_CLK selects CLKDEV_LOOKUP
>>
>> So it does - thanks
>>
>>> , the latter
>>> is going to be removed from clock framework.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Reviewed-by: Daniel Scally <djrscally@gmail.com>
> Thanks!
> I have sent v2 with more patches added (twice bigger than this).
> Would you be able to test them?
>
Sure - I'll test them later tonight - thanks!
