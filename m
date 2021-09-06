Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2ED401FCC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238560AbhIFSjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhIFSje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:39:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F4DC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:38:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g8so9320429edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5qxOSUsAvpDHSMLpGbVT+4MUrgaqCQsk57usbM5FUQA=;
        b=oS1pJaJNmoKNUp3OAGHbYYPiDbcwyH4364r5pn/7SRLQvOUU3JWcM9TbyfYQFuznI3
         sCCLZDQ/HkGPU6uwzExVsF4qvRTRRMx+QTSrm5py4ybdu3fQMnWNZx/yqMBAIbKciY97
         cLHwWAUevCOBqtcrOWhD3YN4kPTzD1EdB7w7TF6VgPBFSsraPj3oYFosmVvFJVpgWoN4
         vLvPU2CSqG9WsjxRMgLpdHZxER4DOxV94LxELhhsBARaGtWGr97CoriAdpLJi4MJWAOG
         bjuVhCH9nY8WJUfrXf5clF/cQQjjyCBpAjwsNmxU+bge4I9XC63Qdy6TYnk0b+SrCtGy
         KzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5qxOSUsAvpDHSMLpGbVT+4MUrgaqCQsk57usbM5FUQA=;
        b=IEO24xP9zM+Oo9ebXn1zmQbDt1LkVczu7jVGG2Ds0rX99bCjQ59Vs8uzIxHxQ6IeMF
         u26C8TGhScSXlpjSyzysHIewbdQ4ojpH+cJB69an5Vjb6JDD/IXsUcLviu3rqMsUhnj1
         rsWDUGm1L6zpg0wj4q+wCpJYghyHG7ZQqlfTH2HIy3V1QDboDy17OghOEfv8YaMK5l1v
         JwAKuiRIK180o66wvA9IhaqScT2cSJU6z1ndpLcdvL4hseUznwqQhvSXrkb9CHRpBe6X
         wXaDq1aov04qwK9+y9fWOuVk5xlxl236E8JvXPg+gW1g7YLo8Rt4iOe3evpC7u/YZh5u
         i4Aw==
X-Gm-Message-State: AOAM532frGD0G8hmZd9kMZmX6y6BcgsLvXAllYkPzrRC8DavDLoy1UiS
        IuoUqPkxfNdpOt/MVTd/Phs+Ih9uu2lZbA==
X-Google-Smtp-Source: ABdhPJwpoEZWa4qVwaKDjw3npiXsKUEdhmQzDxp74swm3Ht6EjZvBjb3PAvJ1JJuxE//ph7uUcf98g==
X-Received: by 2002:a05:6402:350d:: with SMTP id b13mr14569940edd.1.1630953507637;
        Mon, 06 Sep 2021 11:38:27 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::8fe1? ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with UTF8SMTPSA id r11sm4355205ejy.71.2021.09.06.11.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 11:38:27 -0700 (PDT)
Message-ID: <a762c010-e6b3-6fed-30e9-1520664b6b25@gmail.com>
Date:   Mon, 6 Sep 2021 20:38:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 00/40] staging: r8188eu: remove function pointers from
 struct hal_ops
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210906182438.5417-1-straube.linux@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 20:23, Michael Straube wrote:
> In order to get rid of the HAL layer this series removes the next
> bunch of function pointers from struct hal_ops.
> 
> Also it removes some empty functions and cleans up some minor style
> issues I stumbled upon.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 

Ouch, although I've checked everything, starting with patch 20 there
is a typo in the commit messages. The word 'from' is missing. :(

I'll fix it and send v2, sorry.

Michael
