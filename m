Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DB13FB9C7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbhH3QHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:07:40 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:42980 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbhH3QHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:07:39 -0400
Received: by mail-wm1-f46.google.com with SMTP id k20-20020a05600c0b5400b002e87ad6956eso360329wmr.1;
        Mon, 30 Aug 2021 09:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=lI18TvRw73yAlqH1vs/eUgEBLdxdcJZcXEoVMwFprjI=;
        b=rSsbxR0v5E9vbQZVvumlFzppX2zFeUwCELMo1F+jDZrau/JtAomkir8p2Ed299RPoz
         8S+UnYcrJ0Ij6A5X4ZWLg9Ds+fdmXMMowNq8H17O3hEizSkq9iEhJSD7lvDFSt1VICdU
         bwhzbhci+UQodMO8cTK7UoBNduc+v8qAQODbX+NLpefSlf4dVhAfi8/UFUXe7M6WRENo
         3heuuzpg/eGTqnFyIe+YYQXmtLsN+7T4eHCR3CiEy/y1JHnWm2ulujmipCBwWGdC2AG9
         rIEE8wQizUFcfsxr9wTYhTWjFyuZu8qe0QwJb9jx0O30EWWUQMnDSfetbi6j5mwXHuFV
         ThlQ==
X-Gm-Message-State: AOAM532J12pRNJPM+Iy7dCJ9H/HTtLk6pFxTQymV466BZnR2bfkgZhJe
        4unKg/Bfa6ObaCjtfVLApx5Kmo/r83eflw==
X-Google-Smtp-Source: ABdhPJz4UbbvQLnrjjaJud6LBo7F3PB+mQ+z+4aSK5uL+M3DxshWfrxVtfQpGM5RVMwk0cbImrxirA==
X-Received: by 2002:a7b:cc16:: with SMTP id f22mr33124661wmh.99.1630339604953;
        Mon, 30 Aug 2021 09:06:44 -0700 (PDT)
Received: from Johanness-MBP.fritz.box ([2001:a62:1533:3701:9cbd:e8f2:43f7:60cc])
        by smtp.gmail.com with ESMTPSA id s1sm9933008wrs.53.2021.08.30.09.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 09:06:44 -0700 (PDT)
Subject: Re: [PATCH] mcb: fix error handling in mcb_alloc_bus()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andreas Werner <andreas.werner@men.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <YLX7bAD4UPCpIBmq@mwanda>
 <c4cffc84-be11-6558-60aa-a5217963b1f6@kernel.org>
 <20210830140856.GX7722@kadam>
From:   Johannes Thumshirn <jth@kernel.org>
Message-ID: <c2fe69bd-316a-b255-9957-9beab6ed60fe@kernel.org>
Date:   Mon, 30 Aug 2021 18:06:43 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210830140856.GX7722@kadam>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.08.21 um 16:08 schrieb Dan Carpenter:
> On Tue, Jun 01, 2021 at 03:23:55PM +0200, Johannes Thumshirn wrote:
>>
>> Am 01.06.21 um 11:18 schrieb Dan Carpenter:
>>> There are two bugs:
>>> 1) If ida_simple_get() fails then this code calls put_device(carrier)
>>>    but we haven't yet called get_device(carrier) and probably that
>>>    leads to a use after free.
>>> 2) After device_initialize() then we need to use put_device() to
>>>    release the bus.  This will free the internal resources tied to the
>>>    device and call mcb_free_bus() which will free the rest.
>>>
>>> Fixes: 5d9e2ab9fea4 ("mcb: Implement bus->dev.release callback")
>>> Fixes: 18d288198099 ("mcb: Correctly initialize the bus's device")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>
>> Thanks applied
> This is still not in linux-next.
>
> regards,
> dan carpenter

Hi Dan,

Greg asked me to resend the patch with Cc stable and I totally forgot to
do that, my bad.

I'll do that ASAP once the merge window opens again or earlier if Greg
is OK with it.

Byte,
    Johannes
