Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876983FC635
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 13:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241097AbhHaKnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 06:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241017AbhHaKnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:43:17 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F06C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 03:42:22 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id j18so23956325ioj.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 03:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4i4U3chg4RrpvJeefmoTUcAUO8DCreq+/zj+injJGdg=;
        b=FEL1nLFI3SxmT0kdXKNnikjiCFRkxxQ8mEWAkbNkLZZhRa2V7Yj2amzMCGhz9qnym0
         KS3F8ID7UX9zEmKrXPD5nTliLBExT81PoSaRn725bVRruE7XAuR8bmzelXAd9jsn/8O2
         bf2xGX0r+EK4SQfg1dCjBKtqNiQKssbXTIMDP0MgyjXa5LEeNa38uP4vUt+6TewRie8d
         6HG7P9wI/VpfAej1IbbPrlnmPOo3uh3jpe5KMIA3VTcD4uIq9sxrV491n2mVP9sqLZ0C
         Oy8H2FUUXKmGnBsv7OuXn9vO8PFfWrlWv8ONCyGV11YJ4uD9w8ansP2YHZiMCnHbEtNb
         tuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4i4U3chg4RrpvJeefmoTUcAUO8DCreq+/zj+injJGdg=;
        b=buWI2Mm2esqxqusqdZftAYdFXnpYAT1AQtSnjY+Y4a8fFBfOBJDQpdX0xfnwVLCiHx
         csvo/YVVgaaPUWKvfEw7DhtChKQyT9YX7tZQQCpFo2nmUkKki0pxtKYgJ5quqYWAX7Wn
         bEsaDfE1Ck6ieNrYQRFrRJvF/2BrKO3jsSq8PPdD+E9NhGpCqy8+KoYQ4aFyz/SZbKnk
         YNZ6Imf2u1w44ZgX4AM/nx/RIZ4LguWGGLnHL9jQOuW/k3HRtuDhsQWFVRoP+Mgt5GF7
         k1hdPaqVDcOJTWRMlyywCWRMUGDEf9YJqXrKdDGJ6HeT3ZD8MPm+nX2FxtRFR6cInqGT
         penA==
X-Gm-Message-State: AOAM533lMTlf6uPdkOATtbXy1A3kgfm5PfC77Z8XWSweiJnB0jbgI+Gf
        dBN5XQQQW6cptIOL0HmGs61luQ==
X-Google-Smtp-Source: ABdhPJzOMrOo4lTEIL/8iFunOOHOhJ3nkE010J0VNpmxtY895bk9PWC6kTdAdNodXpVrEA3yPsJrSA==
X-Received: by 2002:a02:c7d2:: with SMTP id s18mr2266000jao.22.1630406541615;
        Tue, 31 Aug 2021 03:42:21 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id v5sm9864790iln.42.2021.08.31.03.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 03:42:21 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH v4] staging: greybus: Convert uart.c from
 IDR to XArray
To:     Johan Hovold <johan@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alex Elder <elder@kernel.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
References: <20210829092250.25379-1-fmdefrancesco@gmail.com>
 <YSyg/Db1So0LDGR+@hovoldconsulting.com>
 <2879439.WEJLM9RBEh@localhost.localdomain>
 <YSzGkNfG6HOayiXi@hovoldconsulting.com>
 <YSzMB80NOkNvdjy1@casper.infradead.org>
 <YSzQAd0Rg5CF/eLe@hovoldconsulting.com>
 <f7a25eb1-20f4-5031-a156-9e5dc019ad28@linaro.org>
 <YS3jSsGSs0yAw/Ba@hovoldconsulting.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <51c57831-71bf-92f8-2b20-3e542160a8bf@linaro.org>
Date:   Tue, 31 Aug 2021 05:42:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YS3jSsGSs0yAw/Ba@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/21 3:07 AM, Johan Hovold wrote:
> On Mon, Aug 30, 2021 at 08:20:25AM -0500, Alex Elder wrote:
> 
>> I have been offering review feedback on this patch for three reasons:
>>
>> - First, because I think the intended change does no real harm to the
>>    Greybus code, and in a small way actually simplifies it.
> 
> You leave out that we've already seen three versions of the patch that
> broke things in various ways and that there was still work to be done
> with respect to the commit message and verifying the locking. That's all
> real costs that someone needs to bear.

This is true.  But it's separate from my reason for doing it,
and unrelated to the suggested change.

>> - Because I wanted to encourage Fabio's efforts to be part of the
>>    Linux contributor community.
> 
> Helping new contributers that for example have run into a bug or need
> some assistance adding a new feature that they themselves have use for
> is one thing.
> 
> I'm not so sure we're helping either newcomers or Linux long term by
> inventing work for an already strained community however.
> 
> [ This is more of a general comment and of course in no way a critique
>    against Fabio or a claim that the XArray conversions are pointless. ]

Yes, yours is a general comment.  But I would characterize
this as Fabio "scratching an itch" rather than "inventing
new work."  The strained community needs more helpers, and
they don't suddenly appear fully-formed; they need to be
cultivated.  There's a balance to strike between "I see
you need a little guidance here" and "go away and come
back when you know how to do it right."

In any case, I don't disagree with your general point, but
we seem to view this particular instance differently.

>> - Because I suspected that Matthew's long-term intention was to
>>    replace IDR/IDA use with XArray, so this would represent an early
>>    conversion.
> 
> That could be a valid motivation for the change indeed (since the
> efficiency arguments are irrelevant in this case), but I could not find
> any indications that there has been an agreement to deprecate the
> current interfaces.
> 
> Last time around I think there was even push-back to convert IDR/IDA to
> use XArray internally instead (but I may misremember).
> 
>> The Greybus code is generally good, but that doesn't mean it can't
>> evolve.  It gets very little patch traffic, so I don't consider small
>> changes like this "useless churn."  The Greybus code is held up as an
>> example of Linux kernel code that can be safely modified, and I think
>> it's actively promoted as a possible source of new developer tasks
>> (e.g. for Outreachy).
> 
> Since most people can't really test their changes to Greybus perhaps it
> isn't the best example of code that can be safely modified. But yeah,
> parts of it are still in staging and, yes, staging has been promoted as
> place were some churn is accepted.

Testing Greybus code is a problem.  *That* would be something useful
for people to help fix.

					-Alex

>   
> Johan
> 

