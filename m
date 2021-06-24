Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451AF3B2FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 15:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhFXNPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFXNPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:15:19 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7621FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 06:13:00 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so5541795otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4SF5a3kJdcjfWJZpedrg2y4hs9MoI05TwLUsIxF/D4Q=;
        b=ZhRieZYzvRBPi0/6nnXVxybiLtozerYBMutruvdWEpnOZeSZ9wHm5HTX21AScLl+n0
         Ak4LZ9jAEfp+CxLL0jBRqFjUMi/OTQsg45Sam4dO1r+eoHHVvBpMOaLzeKQZtaHRKzdE
         a8lEbNeg/RE8B19zl1lxQBjkYBDAeyaG5ZZZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4SF5a3kJdcjfWJZpedrg2y4hs9MoI05TwLUsIxF/D4Q=;
        b=cODcjM72zBG6Amx7K5/xTcBsnql8ck52KRACPqFsNwn+hOwZnP2jC4rM4vRj3wr2Cm
         MulVIseyLxEZXZ/nJ/2pt0/7Vp49YzeVLAWTGnKzJhGCLd6kuymAzRlzahtQyTikpPMN
         xITOjyNSezy3qKdaKYImimgL0oEFT15Xro1pTdejxIIp3iM8oLV0gkZjF0VoWnFrsY/I
         eUNvCzLEdveF8WU/xqK7VMj8HL6lW5qVoSow7VLnC153i1LtPx+f2hd6SIyN9cRdpLEN
         7cjbS0mQxdIPIhgHDlAtoX7wyemOoNSupa/AwZXxEX1+ctNxg61NB4Fle0PKMf3PTPp9
         gdww==
X-Gm-Message-State: AOAM530U6uKcTnOg0yTOhP7t5jU3Nc0lwX0aWTSgb9OJNmaihKcvpGkb
        NW2cH3fGnrW07soVJDDuhVFkbg==
X-Google-Smtp-Source: ABdhPJxaH3NzKbqaBGkp4qCphwU/Avg8Jw0NOxVdPCxyIoNq2eACWJ7Mpdr/7V6l8+X4pmqjj3rVyQ==
X-Received: by 2002:a9d:1444:: with SMTP id h62mr4687643oth.166.1624540379798;
        Thu, 24 Jun 2021 06:12:59 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s2sm581628ooa.39.2021.06.24.06.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 06:12:59 -0700 (PDT)
Subject: Re: [PATCH kunit-next] thunderbolt: test: Reinstate a few casts of
 bitfields
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-usb@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210624084823.15031-1-davidgow@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <50840b08-5735-f63b-91b7-a7117a25d3da@linuxfoundation.org>
Date:   Thu, 24 Jun 2021 07:12:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624084823.15031-1-davidgow@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/21 2:48 AM, David Gow wrote:
> Partially revert "thunderbolt: test: Remove some casts which are no
> longer required". It turns out that typeof() doesn't support bitfields,
> so these still need to be cast to the appropriate enum.
> 
> The only mention of typeof() and bitfields I can find is in the proposal
> to standardise them:
> http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2619.htm
> 
> This was caught by the kernel test robot:
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/FDKBHAV7QNLNFU5NBI2RKV56DWDSOLGM/
> 
> Fixes: 	8f0877c26e ("thunderbolt: test: Remove some casts which are no longer required")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> Whoops: I didn't notice this was broken earlier. If it's easier to just
> revert the broken patch, that's fine, too.
> 

Thanks for fixing this quickly. I will apply this on top of the broken 
patch.

thanks,
-- Shuah
