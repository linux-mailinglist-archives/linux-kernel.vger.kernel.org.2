Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134D335F4A9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351230AbhDNNSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351237AbhDNNSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:18:04 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF37C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 06:17:40 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id c18so17042770iln.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 06:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KR5tUi2Pjym92G8VJBGTvp1Vw9Vmq14ckbna/IAfvxY=;
        b=LXpcpQcBz4zfAoS3GCoj2F36fqCg83/wkDUE/2flZ4QY/NLdrXBzUHPJp5syo5f+uV
         NzYemHAM0XS0+RWtXiKoERGidOZnVfMZtnV86xTUC6CWr1B5ykeho2l7NbBK+IJbfzXk
         p5D7/PA7yRi9D1nhZy78UuT+H1i2dXHhIiOZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KR5tUi2Pjym92G8VJBGTvp1Vw9Vmq14ckbna/IAfvxY=;
        b=I9AgXPi3FAvdcbdBNsZUphp4xC8Wgzhqog5GFtHZnKTWdaunmMs/xUj4IHE1tcoZSF
         sMtVBL3sIfBPbhMw1sId8eu8rsxMuL9LkqUaZeFMs+RpyF7GhkmJQfhPors6LF9EuHXk
         le3Icn7i6R/wpaRH1OFVkZlhC2DvHHqZeargdBuKKH+aySWdoocB3vZX++P3eN8YEXgC
         yA8pXUCeSKo125c+8HGVfBS1E6uuP0WjOtrTDNJr/w+l4hu5ttAZ79oeTk8sZuNXXRPh
         7YJkjnfojGDjbsPs2kYfEfkmYoFlLBHrCAJbRHoK9zS/wDZHUTyKagju7ZzgaIk0a4vD
         Rm5Q==
X-Gm-Message-State: AOAM530s+TJG4g6sYsNLFcOGuNOI3+1bqIAujwU8kVJJPr/AALaWfPNf
        vjC1u42M2PIFDiyXcG947wBKAfBtsQ8ToLgE
X-Google-Smtp-Source: ABdhPJyb+zve3gy2tS0pVuePobkDcZJ6i03AHQgQ4GPnJtCEoPevEY/e3ov0ozoSq1Yrkb46lfVeqA==
X-Received: by 2002:a92:7f0c:: with SMTP id a12mr16080857ild.54.1618406260271;
        Wed, 14 Apr 2021 06:17:40 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id h17sm3621738ilh.55.2021.04.14.06.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 06:17:39 -0700 (PDT)
Subject: Re: [PATCH] staging: greybus: Match parentheses alignment
To:     Joe Perches <joe@perches.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <20210406124259.GA96537@zhans> <YGxhrLZPIPjILWUH@kroah.com>
 <7d7be8bcc0e80d826083890ed7791070ad25e603.camel@perches.com>
From:   Alex Elder <elder@ieee.org>
Message-ID: <1607b040-6bc4-9a58-ae81-4ea0adf5885d@ieee.org>
Date:   Wed, 14 Apr 2021 08:17:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7d7be8bcc0e80d826083890ed7791070ad25e603.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 12:21 PM, Joe Perches wrote:
> On Tue, 2021-04-06 at 15:27 +0200, Greg KH wrote:
>> On Tue, Apr 06, 2021 at 06:42:59PM +0600, Zhansaya Bagdauletkyzy wrote:
>>> Match next line with open parentheses by adding tabs/spaces
>>> to conform with Linux kernel coding style.
>>> Reported by checkpatch.
> []
>>> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> []
>>> @@ -378,8 +378,8 @@ struct ap_csi_config_request {
>>>   #define GB_CAMERA_CSI_CLK_FREQ_MARGIN		150000000U
>>>   
>>>
>>>   static int gb_camera_setup_data_connection(struct gb_camera *gcam,
>>> -		struct gb_camera_configure_streams_response *resp,
>>> -		struct gb_camera_csi_params *csi_params)
>>> +					   struct gb_camera_configure_streams_response *resp,
>>> +					   struct gb_camera_csi_params *csi_params)
>>
>> And now you violate another coding style requirement, which means
>> someone will send another patch to fix that up and around and around it
>> goes...
> 
> None of the coding style document is an actual requirement Greg.
> It's all rules of thumb.  Useful rules, but not hard and fast right?

I agree with this, but this ambiguity causes some problems.

Greybus is a go-to place for just-starting developers to
work with some reasonably good "real" code.  But someone
just starting has no way of judging whether the warnings
issued by checkpatch are real or not.  Even experienced
developers will lack the insight to judge this if they
are modifying on a less-familiar part of the kernel.

The result--for Greybus certainly--is fairly regular
stream patches that suggest making trivial changes based
on checkpatch recommendations.  And unfortunately each
one is destined to be rejected by the maintainers.  This
is no good for anybody.

Can you think of a way to try to further characterize
how "serious" a warning message is?  I recognize that
even if (for example) you had something like 1-10 severity
scale, the scale might not be uniform across the whole
kernel tree.  Perhaps (like the -W options for GCC) there
could be a way to specify in a Makefile which checkpatch
messages are reported/not reported?  I don't claim that's
a good suggestion, but if I could optionally indicate
somewhere that "two consecutive blank lines is OK for
Greybus" (one example that comes to mind) I might do so.

> To me, the biggest issue with this code isn't whether or not the
> code is aligned at open parentheses or stays within 80 columns,
> but is the use of 30+ character length identifiers.

I agree with you on this one...  I've worked with code
like that and it's very difficult to make it readable.
I've made a mental note to go look at this and see if
I can make it better.  I can't say when I'll get to it
but I think it's a good suggestion.

					-Alex

> Using identifiers of that length makes using 80 column, or even
> 100 column length lines infeasible.
> 
> Perhaps seeing if include/linux/greybus/greybus_protocols.h
> could be updated to use shorter length identifiers might be useful.
> 
> The median length identifier there is ~25 chars long and the
> maximum length identifier is ~50 chars.
> 
> 
> 

