Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2AE34ADE8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhCZRvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhCZRv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:51:26 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC724C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:51:25 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id d10so5722117ils.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=euxpSkKZsbBi+wcR3rfJjwiU7iLCyXxn3SXHsO4EML4=;
        b=DSU8OH7FvYaqdnYyVDG0rgompnvNDC46skuht74sguikXGrjPmrNT0eYhffkOTEfs7
         AJ2L27+8Uq1q9pwjhsX9eI866Y7HDEO3phsvuip5p5AizAdnzxnQXlkVm/czMc4eAXx/
         ZZf84l9QpxvVvnZ3/l7mVhWNJJttaTKnpoI60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=euxpSkKZsbBi+wcR3rfJjwiU7iLCyXxn3SXHsO4EML4=;
        b=mOMr1pSKSKzfIfur+Ij9+GoJQOhMjB8AuBW75I3XC0FO46/1O8RfAdRgEDh9zv76BH
         7M81mBItJv5o2ecZrv7KNh7tb7JCRayY5CAtmMom4DFmFwKJUV/U5UqgMzh6KNb9OeKH
         5TAo9TR0qj8lWWtje00B4I5S0+vF07JOCT0qvo5Kt0abcB9l2faM17ZO76jy4xUX2RfP
         60HHTeCSxMLKW4LF/nCWuu/DRaeJoJkFuNS8sGO1wv2RgFkyIh9R9cQUQvRUR/h3LCwt
         V+7Vpj16V+7OZypCr6xwaKP3IMj/kLpZ8jcthm9edLKgVCETT9dx0LqVTnpq776ZApag
         NiFw==
X-Gm-Message-State: AOAM530hiYGRAJ7heKtmOKRVmDo2jntYivyNL+Mkd2AcRwdvOu6oJ2rv
        8fzOj05FQofjOQPoSMEbd+PPMA==
X-Google-Smtp-Source: ABdhPJzOJwAKgsZnIvfpcWuFy6OwqYGvXMYKA4jujrHo34M9jWp49zAnbxULyebzbh45m04J7Y/rvQ==
X-Received: by 2002:a92:2c04:: with SMTP id t4mr11726344ile.99.1616781085287;
        Fri, 26 Mar 2021 10:51:25 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e195sm4667537iof.51.2021.03.26.10.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 10:51:24 -0700 (PDT)
Subject: Re: [PATCH] selftests/timers: Fix spelling mistake "clocksourc" ->
 "clocksource"
To:     John Stultz <john.stultz@linaro.org>,
        Colin King <colin.king@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210315123303.10218-1-colin.king@canonical.com>
 <CALAqxLW1VaMTVx3piKnLcEqWxMcQFG9LujH1ijHP2dbXBQaxqA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <60bb110d-799c-e4cf-6107-d5dff72187fc@linuxfoundation.org>
Date:   Fri, 26 Mar 2021 11:51:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLW1VaMTVx3piKnLcEqWxMcQFG9LujH1ijHP2dbXBQaxqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 12:41 PM, John Stultz wrote:
> On Mon, Mar 15, 2021 at 5:33 AM Colin King <colin.king@canonical.com> wrote:
>>
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> There is a spelling mistake in a comment. Fix it.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Akcde-yb: John Stultz <john.stultz@linaro.org>
> 
> I kid, I kid!  My apologies and thanks!
> 
> Acked-by: John Stultz <john.stultz@linaro.org>
> 

Thank you both. Applied now for 5.13-rc1

thanks,
-- Shuah
