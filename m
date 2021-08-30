Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186883FB6E1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 15:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbhH3NVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 09:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhH3NVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 09:21:21 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70585C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 06:20:27 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id f6so19915639iox.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 06:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WKeT62ZadWDNocW3Ll/HW/hDyCa9+Jb52I2zuSuGv8I=;
        b=D6Lakt9yDWreyBDiRnMhUGB0xjXpntWU5IEh/lIaDXuQtc9m9IqAPv+lefK8iIfTET
         qTWt/9H/DgGcVNm0rFd5ddIT1vOqVR1v42iTIbXxv/nHIKPDQOGVMa1mMddL0WrHx+YJ
         ECW2qVbbwcA/otpaYLM1ylSzpNmpsA0kt0ggU0LiAQYHjXHgPjcuLzaJaeJZxOR7v65v
         x7m8jzUsWhRtzbN40jjEs69tSkywqdEuCLWWT7gzh6SHoqbpSjx3Qqx0cZyswa6ERVWY
         OnzDMKWqJmA3RJTWWVY1Ftyzg3Ilwq4oqjAxpTg2RHlyq4eXiU64FmIEaCmCjUSATU+F
         IPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WKeT62ZadWDNocW3Ll/HW/hDyCa9+Jb52I2zuSuGv8I=;
        b=mfHnj7Hc60lijvcU4vrypDCPqOCGXqcF+dc3qivSEMl0jFx6xxaaa8vz4R+AkX7cQ7
         DoqjNfu3Ph+YyyAsCD/bgPOcmChTnzKentlZCIV6+Pi0nLRSDMXxjGxs+OsbeB/mcAmm
         M1ryN/AMcn5r0rFA8Gz/ypb6nAKp5Xmk3HQ2I4P0pt20kHB6lAP68RtQqyv07kr8P1DQ
         LOdDWhverFo/Z0uzgBIwF8+N97YOvlud2N6GwSLBtiKwCfFf7KBMzrvmmG8JRNRI57yq
         RwCXHfSL3QQWQgMgiNSzTPlTvjYIAqvyCrRlQKb5nVECJJY5RSaj/qE2oxYo0X37la/m
         /3ww==
X-Gm-Message-State: AOAM531ob0HRxD0mFVXtdnU9WW2dQb6muyqiFs97l6qsd3BTUVrege2x
        az7a/uaI4k/+f3YZFxR2pej4Fg==
X-Google-Smtp-Source: ABdhPJxdAZVSMUUC/poZw8meLf37RZC8FmhD1StS6b+WVSZk0XkojKPb6/PuOqSm65UQzkkpWRUe7g==
X-Received: by 2002:a5d:9681:: with SMTP id m1mr18008859ion.113.1630329626767;
        Mon, 30 Aug 2021 06:20:26 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id h9sm8322370ioz.30.2021.08.30.06.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 06:20:26 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH v4] staging: greybus: Convert uart.c from
 IDR to XArray
To:     Johan Hovold <johan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Alex Elder <elder@kernel.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
References: <20210829092250.25379-1-fmdefrancesco@gmail.com>
 <YSyg/Db1So0LDGR+@hovoldconsulting.com>
 <2879439.WEJLM9RBEh@localhost.localdomain>
 <YSzGkNfG6HOayiXi@hovoldconsulting.com>
 <YSzMB80NOkNvdjy1@casper.infradead.org>
 <YSzQAd0Rg5CF/eLe@hovoldconsulting.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <f7a25eb1-20f4-5031-a156-9e5dc019ad28@linaro.org>
Date:   Mon, 30 Aug 2021 08:20:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSzQAd0Rg5CF/eLe@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/21 7:33 AM, Johan Hovold wrote:
> On Mon, Aug 30, 2021 at 01:16:07PM +0100, Matthew Wilcox wrote:
>> On Mon, Aug 30, 2021 at 01:52:48PM +0200, Johan Hovold wrote:
>>> Whether the API is better is debatable. As I said, almost no drivers use
>>> the new XArray interface, and perhaps partly because the new interface
>>> isn't as intuitive as has been claimed (e.g. xa_load() instead of
>>> ida_find()). And IDR/IDA isn't marked/documented as deprecated as far as
>>> I know.
>>
>> I can't just slap a 'deprecated' attribute on it.  That'll cause a
>> storm of warnings.  What would you suggest I do to warn people that
>> this interface is deprecated and I would like to remove it?
> 
> I'd at least expect a suggestion in the IDR documentation to consider
> using XArray instead.
> 
>> Why do you think that idr_find() is more intuitive than xa_load()?
>> The 'find' verb means that you search for something.  But it doesn't
>> search for anything; it just returns the pointer at that index.
>> 'find' should return the next non-NULL pointer at-or-above a given
>> index.
> 
> We're looking up a minor number which may or may not exist. "Find" (or
> "lookup" or "search") seems to describe this much better than "load"
> (even if that may better reflect the implementation of XArray).
> 
> And no, I would not expect a find implementation to return the next
> entry if the requested entry does not exist (and neither does idr_find()
> or radix_tree_lookup())

For what it's worth, I think of "find" as meaning "look up this one
thing, and return it if it's there (or tell me if it's not)."  That
is irrespective of underlying implementation.

That verb sometimes might mean something else (like create it if it
doesn't exist, or perhaps "get it or the next available" as suggested)
but I wish we had a slightly different naming convention for those
things.

The XArray interface was designed to better match typical usage of
IDR/IDA, as I understand it.  And its name suggests it is modeled
as an array, so "load" seems like a reasonable verb to mean returning
the value associated with an identified entry.  (Even though the
"doesn't exist" part doesn't match normal array semantics.)

So I guess I agree in part with both Johan and Matthew on the
 meaning
of "load" as used in the XArray interface.  Either way, that *is* the
interface at the moment.


I have been offering review feedback on this patch for three reasons:

- First, because I think the intended change does no real harm to the

  Greybus code, and in a small way actually simplifies it.

- Because I wanted to encourage Fabio's efforts to be part of the

  Linux contributor community.

- Because I suspected that Matthew's long-term intention was to

  replace IDR/IDA use with XArray, so this would represent an early

  conversion.



The Greybus code is generally good, but that doesn't mean it can't

evolve.  It gets very little patch traffic, so I don't consider small

changes like this "useless churn."  The Greybus code is held up as
 an
example of Linux kernel code that can be safely modified, and I
 think
it's actively promoted as a possible source of new developer
 tasks
(e.g. for Outreachy).



So aside from the details of the use of XArray, I'd rather we be
more open to changes to the Greybus code.

					-Alex

> 
> Johan
> _______________________________________________
> greybus-dev mailing list
> greybus-dev@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/greybus-dev
> 

