Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680C33EBC0C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhHMS1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhHMS0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:26:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4209AC0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 11:26:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f12-20020a05600c4e8c00b002e6bdd6ffe2so4471744wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 11:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mzFaXUU/x0+sUupGX2omqXEd8e4JzxswlubxRenky6w=;
        b=ScYlXF5tHV8j2XrA2jNLLzo8Rab8MRZldCrvA9HegVr5y92+/z3K5kNNonQHZE5CIp
         xfj9mMkzV+/tJiheHAPX6B6JjDct4b3lvUjknyYrimNkzEBnjq+mSSi8oEYGCBSSbuwm
         k8ZeSxQ9iZoLcNg3jP/GPiL5Pw15HHo+JRsMP445xt8EKfrOn1sqYV/3sguXbnAUkloW
         EmFiU1A9WTZdSvFT0ml0jKd/4IbM9Z3JzlLTzkvJeSotXrj7bZFXHN+HEajHKFxfHwrV
         YKq6nAavtsoSEUCSSuN8Lu12fF2EbNSrrNDsNQ7pvHIGuEKoSCFc9rxMAw4spomShvDe
         SxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mzFaXUU/x0+sUupGX2omqXEd8e4JzxswlubxRenky6w=;
        b=h7aVIX6tfk38RirorbU9ooLL/9bVTztLKgCL9+6z+WfDE00i896tuMXqw8UFRVyq6q
         RCEDYX637icTnlY6OGwRjdlgHQ1S2XwFiZ73qDEZcT19ETvbic2smRGFD2V0GePvex3Y
         RLKMPZCf1GIWQ6F4B1JVGYpu/0BDFP6WBqfqi09Op4jBX82v8SYdEH8PJGHBUIpylrmB
         8P/r8dCJRc5ufnl5dBGziZ/9oGE6+6xgSfwkGIV5WHAisT/OuqHLpDCN1k/Mn8rxchDK
         RGFRPP28cM+o8d1U1jhZy0WcqSTo6cXpGrDglBp4hpWYjaI/q6O5z5TsNB2NQA1tRBry
         Drvg==
X-Gm-Message-State: AOAM533WvRhrFiKjJTc8M3mT1UNn/aKj22+KVFXlfcgakXLSEc9Mn86p
        KOkruwjijKKqCGiJXqnb54XpvXZ1NJ8=
X-Google-Smtp-Source: ABdhPJxQFjf8JQn/5VnVYjev/ZHIaQJ2q8FdQ5/sVuFvBUdt/Mlfal5NlbRoF/1ca5UJOvsJVfvWRA==
X-Received: by 2002:a1c:4a:: with SMTP id 71mr3991907wma.87.1628879185892;
        Fri, 13 Aug 2021 11:26:25 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::2571? ([2a02:8108:96c0:3b88::2571])
        by smtp.gmail.com with ESMTPSA id p14sm2267405wro.3.2021.08.13.11.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 11:26:25 -0700 (PDT)
Subject: Re: [PATCH 1/4] staging: r8188eu: remove 5GHz code from
 Hal_GetChnlGroup88E()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210813073109.25609-1-straube.linux@gmail.com>
 <20210813073109.25609-2-straube.linux@gmail.com>
 <7543688.ql1GSxUkq4@localhost.localdomain>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <945d66b4-122c-33e2-659d-b7028de1bfcc@gmail.com>
Date:   Fri, 13 Aug 2021 20:25:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <7543688.ql1GSxUkq4@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/21 6:27 PM, Fabio M. De Francesco wrote:
> On Friday, August 13, 2021 9:31:06 AM CEST Michael Straube wrote:
>> Remove 5GHz code from Hal_GetChnlGroup88E().
>>
>> Signed-off-by: Michael Straube <straube.linux@gmail.com>
>> ---
>>   .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 62 +++++--------------
>>   1 file changed, 14 insertions(+), 48 deletions(-)
> 
> I missed those lines in my "Remove 5GHz band related code" series.
> Nice work, so...
> 
> Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> Thanks,
> 
> Fabio
> 
> 

Thanks for your review and ack Fabio. :)

Michael
