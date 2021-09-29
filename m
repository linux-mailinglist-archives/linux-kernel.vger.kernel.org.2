Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F308F41C3B1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244924AbhI2Lr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhI2Lr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:47:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C6AC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:46:15 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id b192-20020a1c1bc9000000b0030cfaf18864so1517894wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SWXVwTQRJHBBCNW1cozXs7nMfXfaPPeM3zo56GxdwE0=;
        b=YAC/yGPyE2OF1VstCfmO5tA+s1p0v+YfIGzmKydEr8lVsQEGvRuyLp03dWVwWwJaAB
         qZ1BvsvlrFE6dHIzjEzE8cmP/2RIeZPdHcIKC1bJ1V/47kmLzyoMov6kLNJXJ9TTAUjw
         zd0syKBZIEPv4Tqn4M2ssPSkX+1SJTRFsIAAj7X7Mkyl/fwgtvcwg4iXCzBQjDgnE2qS
         JV/dm3jgA3TztxRITopEyHsnRHu0tH8HO9Bc9NxMwSDAliSg5nIQtnZcMwSiIR0TeOvG
         8xRBgeuDqNZIWjZ/w+39bMojdD5RorEwEX+pGaPael01QMiTdtbPpE8R5b2Ws0o2eF05
         Zr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SWXVwTQRJHBBCNW1cozXs7nMfXfaPPeM3zo56GxdwE0=;
        b=iZK4+RwaqRJiVQYedHcnHT1OA1a3+cQD9BVVP0YcfpH8yp9YhMYpN1APnmCuRf3B0z
         7vET9B2M4rjbd8++EaStf4qo1Qy1/HbbxRmKj7htMEcSSw4080ArAon/VMjy65Yn7VXO
         8d+iJtauGwAsqzcMdu14K3+bNkPoMMrR+ZgGa5CPvTMuf5zax70FNWkpguVp2M45GgDI
         Co+IHjl74z/wh+qhEv16Dh1seWmGWZSMb2EP7dNywtBkQWpGIVaXRYsuozurJ60vEmwN
         4JgK8WokWr2kVMH9Ekick4J+ZmcEsYWTzXWjEbft9L+Ojemafg4Cf1DsblohEK/xf2/P
         aXbw==
X-Gm-Message-State: AOAM5330eCS8GoQJC55o2JJonH9xmjgwTpF0L3zdICVNrJkFQlmTcS4d
        BYlArLtb5zHhC5bEgITs5DHq9bUh3iL3/c8B
X-Google-Smtp-Source: ABdhPJx4yAZ6/VxBAeivP5vIdcJoKdZCE3kmZccldVQ3sYVTpLaEuWqfvmJEy9XdQAwhEF5jHN6PXw==
X-Received: by 2002:a1c:149:: with SMTP id 70mr9695860wmb.187.1632915973631;
        Wed, 29 Sep 2021 04:46:13 -0700 (PDT)
Received: from ?IPv6:2a02:8084:20c7:8d80:b92e:b532:3d37:f10b? ([2a02:8084:20c7:8d80:b92e:b532:3d37:f10b])
        by smtp.gmail.com with ESMTPSA id z12sm2117400wrv.31.2021.09.29.04.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 04:46:13 -0700 (PDT)
Subject: Re: Subject: [PATCH] staging: r8188eu: Fix misspelling in comment
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <5174112d-d0a5-e908-aee8-7d494914e89b@gmail.com>
 <YVP8CYJ6MpWCjRB0@kroah.com>
From:   hallblazzar <hallblazzar@gmail.com>
Message-ID: <24ecdbbd-aa05-8d67-99af-f7bbb7cfcfed@gmail.com>
Date:   Wed, 29 Sep 2021 12:46:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YVP8CYJ6MpWCjRB0@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/09/2021 06:39, Greg KH wrote:
> On Tue, Sep 28, 2021 at 06:49:48PM +0100, hallblazzar wrote:
>> As format check raised by scripts/checkpatch.pl, comment in the rtw_ap.c
>> looks misspelled by accident. Help fix it.
>>
>> The original error is as below shows:
>>
>> CHECK: 'followign' may be misspelled - perhaps 'following'?
>> +Set to 0 (HT pure) under the followign conditions
>>
>> Signed-off-by: Siou-Jhih, Guo <hallblazzar@gmail.com>
>> ---
>>  drivers/staging/r8188eu/core/rtw_ap.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Your subject line has "Subject:" in it twice for some reason :(
>
> Please fix up and send a v2.
>
> thanks,
>
> greg k-h

Hello Greg,

Thanks for point that out.
It should be my mail client issue. I've fixed it and re-sent
new v2 patch

    [PATCH v2] staging: r8188eu: Fix misspelling in comment

If anything should I additionally aware, I'd like to fix them.

Regards,
Bill G.

