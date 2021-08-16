Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A0C3ED989
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhHPPKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhHPPKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:10:37 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA2C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:10:06 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id i7so23449477iow.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ApokTc8mxObi8oLsmYtRa9frQO6t6d0mzitkU5awMsA=;
        b=Ktq396n8+YfDiWEgaDGrc2kjUj/FbqM187aiv6pP6u0LMj3/QFpzl/GCX8JmtA78jY
         yBDs/I6ZiBu2UH7uoTcze9yCn7oF0JmgH6GSGMtMkvghXspXiIAgu+DIUqXPzA9nxlj4
         wUQC2zigW6KRNF7d3zu+lzRo8g8k/o6ybatkPaKFGzYXWpbX5yez8Qx/PvzKGzlGcREU
         AssuQ9yIsg1jOgYvYeBQp/S6j7z0Dx5XRad1af35c8fy0m+kinIguuxrhb0lGx4GVWrc
         wUyPmrhPTicTNIw6oWM/gK0bvsT5INnjm7r5z6idw7bkGR+VeJVa7bOYGb974rHE+jv1
         5ZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ApokTc8mxObi8oLsmYtRa9frQO6t6d0mzitkU5awMsA=;
        b=cOw4XaGOqNnTlLBnV9IBfBIr8Lj5jMTP8YQNqH0UmcG8Gk98QG9bi2784xGr+ALXUA
         7S+Pa+TpSrqJ++5IWP+96XOC+ku72grS7O1C2M8QcJ4ZLu3X7Yiifh+5GNQcej4/4b0i
         JQUcSUPc+AefxoL0HDLQEp95m/2UsQYVhb94h2urQZN8y+TQecpHmpWSe9DO7hVYtbaT
         Tm65zeIausEGrwHB1R+MUyIRHu1WpllqX14K2iL8FRQhtI+EhZtbN3HMa5CMd99jxi4Z
         Ne670LFq70PqJSG+pldEFUa5cjhAj8LtTCs4yrCxe5hpNUKeq55mWFMwcNjcKc87P18F
         VXFw==
X-Gm-Message-State: AOAM532md8WZPKWFQypvvy/H/aRxECRGNdyhfYSWOnw0Lh28UJZwP1DA
        ycHvphL/kYwkNXo5/faWXFpkRQ==
X-Google-Smtp-Source: ABdhPJzyIkOm/xZ02NFnTH6W4iDNwHM/gJaa4hr0GPRjC4doNqTHl9+QaDOnw/R0q7UZnod0GL2mSw==
X-Received: by 2002:a05:6638:329d:: with SMTP id f29mr15989957jav.140.1629126605321;
        Mon, 16 Aug 2021 08:10:05 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id w10sm5725935ioc.55.2021.08.16.08.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 08:10:04 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH v2] staging: greybus: Convert uart.c from
 IDR to XArray
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alex Elder <elder@kernel.org>, kernel test robot <lkp@intel.com>,
        linux-staging@lists.linux.dev, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
References: <20210814181130.21383-1-fmdefrancesco@gmail.com>
 <5541b638-db1e-26f2-2682-81f35504c9a3@ieee.org> <YRp9rnCardsCukju@kroah.com>
 <20210816150653.GH1931@kadam>
From:   Alex Elder <elder@linaro.org>
Message-ID: <687f29ce-6245-e549-9b7b-7cc2befba962@linaro.org>
Date:   Mon, 16 Aug 2021 10:10:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816150653.GH1931@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/21 10:06 AM, Dan Carpenter wrote:
> On Mon, Aug 16, 2021 at 05:01:02PM +0200, Greg Kroah-Hartman wrote:
>> On Mon, Aug 16, 2021 at 09:46:08AM -0500, Alex Elder wrote:
>>> On 8/14/21 1:11 PM, Fabio M. De Francesco wrote:
>>>> Convert greybus/uart.c from IDR to XArray. The abstract data type XArray
>>>> is more memory-efficient, parallelisable, and cache friendly. It takes
>>>> advantage of RCU to perform lookups without locking. Furthermore, IDR is
>>>> deprecated because XArray has a better (cleaner and more consistent) API.
>>>
>>> I haven't verified the use of the new API (yet) but I have a few
>>> comments on your patch, below.
>>>
>>> 					-Alex
>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>>>
>>> I'm not sure I'm right about this...  But the actual change you're
>>> making has nothing to do with what the Intel test robot reported.
>>> I personally find the "Reported-by" here a little misleading, but
>>> maybe the "Link" line that gets added will provide explanation.
>>>
>>> Anyway, unless someone else contradicts/corrects me, I'd rather
>>> not have the "Reported-by" here (despite wanting to provide much
>>> credit to <lkp@intel.com>...).
>>
>> You are correct, "Reported-by:" does not make sense here.
> 
> There should be a Fixes-from: tag for bugs found in review (not style
> issues) but when I suggest it then people just say to use the
> Reported-by tag.

I think things caught during review aren't normally worthy
of specific mention in the commit message (though maybe in
the non-committed part under "---").  I mean, that's what
review is for.  And in the case of what <lkp@intel.com>
does, that's effectively a technical aspect of "review."

So I don't think "Fixes-from" (whatever that means) or
"Reported-by" make sense for this type of update.

					-Alex

> 
> regards,
> dan carpenter
> 
> _______________________________________________
> greybus-dev mailing list
> greybus-dev@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/greybus-dev
> 

