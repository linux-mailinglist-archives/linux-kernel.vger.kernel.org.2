Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD79243A989
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 03:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhJZBE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 21:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbhJZBE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 21:04:57 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FECC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 18:02:34 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id e59-20020a9d01c1000000b00552c91a99f7so17449814ote.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 18:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QoNo/gJ6xc/Lk71yUFY24yh/oDqwuM2rlI5YSI1Io30=;
        b=GPfYmTWaHMBbwyAoKorrgVTbZsmFqlu3TOEUwGHy2OWxrtvOOFmL05VvF2U0sO6yq0
         cVG2pGChgd50T10TZSsWNX05FELD1uvjy4vLApxnevG1JaFlX/01wc7bxYRIYPX9ot1j
         mhYj1Tn0i4N36hjzzsBFrFWjLhvHNK5OzDFjtK4IGQ/3RZsFvUyASOSC146FiTC7yTWx
         HZ/+VrrW4xUyv5bJobb84DMvFKh18sl1EjBuYTM6yOx7G8gWIfIcOy/Lv+2OP97aLqdm
         kVSOnhDE6i8MzbciAdTRwtEDm22pLsFy89+ZvJOg2agEUTAHLC62rfazSXLNYffW8WL8
         azdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QoNo/gJ6xc/Lk71yUFY24yh/oDqwuM2rlI5YSI1Io30=;
        b=m97+SQOxOidvaJg7xHDdpsUwlyd5FXun4zRqE94o8AejgtrKxN8nzC8bknZAjZzZbM
         k4zq9vO0W8JTBIQmQnVg3nPQc41DA55mCE2o4z/s+IBr07ROdYCUUhMmzEr+jwD7A1uV
         4bIiPT6He/+rArW8Ms6tGhKQMOa608ONY8VqFCW8+31TzN48BEMG/jZ8RPqbQxunglGg
         CZ4tWkeH/lADg6ElDOb70n6Go+kANl6r/wJ4p+dN34zRyqF20V8nKOMDOFTofzzGv9bt
         oLV0fscxHdQ6n1xwnJMAtpAH087sFsDsQJo76Tylwf1yr6fD4WbOWniC48+Rl7LQIcjc
         2lbg==
X-Gm-Message-State: AOAM5319tTtNyhSpUtwCHRdkOyvugDl2SL4EtS4Hc0JRqeKMf/iEcLWs
        mSG7XnTbnujXHnMFuXUcPNzNpUKP7Fk=
X-Google-Smtp-Source: ABdhPJxMlKWW+1zbC7QoBnBIjxiIfh66+rRIl5XDXf7TN2O3gbhH6mxZxLAaz09z6baWVCUcqaQD8g==
X-Received: by 2002:a9d:4616:: with SMTP id y22mr16425867ote.165.1635210154279;
        Mon, 25 Oct 2021 18:02:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o12sm3987438oti.21.2021.10.25.18.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 18:02:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [RESEND 0/5] ARM/arm64: arm_pm_restart removal
To:     Dmitry Osipenko <digetx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sstabellini@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsa+renesas@sang-engineering.com, treding@nvidia.com,
        arnd@arndb.de, xen-devel@lists.xenproject.org,
        patches@armlinux.org.uk
References: <20210604140357.2602028-1-lee.jones@linaro.org>
 <526fe66f-df08-c873-2a20-f1295e30a855@gmail.com>
 <a4fe088f-0f13-f80f-5011-4eee2d44ef63@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <321b167f-8744-9ca8-58b0-e09ff39dfa02@roeck-us.net>
Date:   Mon, 25 Oct 2021 18:02:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a4fe088f-0f13-f80f-5011-4eee2d44ef63@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/21 4:55 PM, Dmitry Osipenko wrote:
> 26.10.2021 02:29, Florian Fainelli пишет:
>> On 6/4/21 7:03 AM, Lee Jones wrote:
>>> This is a rebase/refresh of a set sent out, reviewed,
>>> then forgotten about.  It's still considered useful.
>>>
>>> Here is an excerpt from the previous attempt:
>>>
>>>   "Hi Russell, ARM SoC maintainers,
>>>
>>>   here's the full set of patches that remove arm_pm_restart as discussed
>>>   earlier. There's some background on the series in this thread:
>>>
>>> 	https://lore.kernel.org/linux-arm-kernel/20170130110512.6943-1-thierry.reding@gmail.com/
>>>
>>>   I also have a set of patches that build on top of this and try to add
>>>   something slightly more formal by adding a power/reset framework that
>>>   driver can register with. If we can get this series merged, I'll find
>>>   some time to refresh those patches and send out for review again.
>>
>> What happened to this patch series? Is there any chance we will get it
>> included at some point? It is included in the Android13-5.10 tree AFAICT
>>
> 
> It's in mainline since v5.14, AFAICS.
> 

Yes, indeed.

Guenter
