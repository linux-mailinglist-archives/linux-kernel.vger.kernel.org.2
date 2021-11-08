Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851E2449C4A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 20:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbhKHTWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 14:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbhKHTWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 14:22:21 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1D4C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 11:19:36 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id q17so4406725plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 11:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=gndiY3SwaFnBMfGN+spjX8zdUV8+ozqOT92uYItx5iw=;
        b=QUPBIewkNaz/Muwlqw/7Cmy5EBnPH9S6LAWnjyg2QAQN9t/VFnvVit39lfcjPkJMGy
         soo2NglVYZ6OYX59DNIZ+HciKiTn7ok9GhfN10rXSrfvl12tXXA3RHfn0g3g73Aawb3F
         w8jcJEeOYW/ILwleoU0cuDeQvCYNXjaXzbhzBaVbpKvRHdOInUISn5o5+fA116g+y1Wo
         zKVdpaHXwS1y2nxqj1sNJ5oLU7tlS5mQLvk/jn/i9P5qSMnn8GWo8QB1gGd0nJ+f1UQn
         3tLDt2I8vqBtOZzPpOsQpqhkeGa7+L2bwrDWQNqnm8gbOE2CrcgT4F0tFEEOF/HuhnE7
         mJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=gndiY3SwaFnBMfGN+spjX8zdUV8+ozqOT92uYItx5iw=;
        b=DoHN5ssf9JYSNRGU65Pz+fc0/HZymQfOkG7G7/2AmMDREaQJn2QoebW0AXS3kxrBv0
         crRzoowFLGBXpApOEc5yP6ai9xQxYqDgFBxrJp4HSkbbtvRAWwDa86+Lj4He95qPn6C1
         Nm9vTSivPTpdJX7HxpXi0zC2oH8YCiAhQoENi6Dky7rAfKwjQjX91F3uet9+wNiFhARE
         8EGulWptUBUkRNbaJFKRaL3LGBJVUw7fTiygEF5zJvZRKvQd7kcZGlw50C6uv9LI2S/D
         SE3P+HcP0H4wvEoipg2MPwmcJilpYlFdx9GcjoHlzFR3l4p61ycCHsdbDb5uiH8cw+f2
         k2eA==
X-Gm-Message-State: AOAM531XKai33cyGPPP8/4Mw12U/uvl79066WN+ZuhznuuSnKTEaR8jE
        oHHbX07nm0HZif5GnQv+WtTwpg==
X-Google-Smtp-Source: ABdhPJwHVnb2uit/WuanE2Tm+miQWIflK9BnI8ZDWMyq3YXlBiJ4eWtAUxbd/13be5UPVAQa84unVg==
X-Received: by 2002:a17:902:9887:b0:13f:7704:425f with SMTP id s7-20020a170902988700b0013f7704425fmr1598793plp.20.1636399176514;
        Mon, 08 Nov 2021 11:19:36 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id z22sm10408570pfe.20.2021.11.08.11.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 11:19:36 -0800 (PST)
Message-ID: <0423c908-00c9-e22b-38cc-bae899f18834@linaro.org>
Date:   Mon, 8 Nov 2021 11:19:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7468db5d-55b4-07c9-628a-9a60419d9121@linaro.org>
 <2bf04f26-4e82-a822-90ce-4c28e2c0e407@linaro.org>
 <90d72173-edd8-79d9-b680-b1d47ab78150@kernel.dk>
 <YYDehlqjWUKizzmB@infradead.org>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: general protection fault in del_gendisk
In-Reply-To: <YYDehlqjWUKizzmB@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/21 23:45, Christoph Hellwig wrote:
>> People will take a look at it, but you sent it out on a Saturday right
>> before a merge window, doing a 'ping' kind of followup on a Monday is
>> way too soon.
> Please retests on 5.16-rc1 once it is out.  Sorting out add_disk error
> handling is one of the big changes in this merge window.  And no, it is
> not easily backportable.

I have ran this on the latest mainline. I can confirm that the errors are
nicely handled there. It triggers a warning and panics in device_add_disk()
because of:
return WARN_ON_ONCE(ret); /* keep until all callers handle errors */
and
Kernel panic - not syncing: panic_on_warn set ...

I will close the issue.
-- 
Thanks,
Tadeusz
