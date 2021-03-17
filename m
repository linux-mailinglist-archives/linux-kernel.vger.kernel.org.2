Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EA033F64A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhCQRKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhCQRJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:09:27 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC37C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 10:09:27 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id z9so2196211ilb.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 10:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ku1F19FbEW2/kGwkbxRDClLpZm2VczPviwk+jBdlSwA=;
        b=W0KbThET7NxpVuqZNPN6oYcH5kuZbSjuM/JAHTzTyJWWBC0Z+mWq7tQt4q0+PgoZhS
         +ffLgK3clTT1+CeuA+Y72gCftwHACppiMek8vDewF4mgK2H80qoOrYLdyAbnsJk09rH9
         hMZYx1Te3wcnWxhsFoGD8A8UTUEo4tf4kpYqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ku1F19FbEW2/kGwkbxRDClLpZm2VczPviwk+jBdlSwA=;
        b=b8lDVL1a0LJ8HYIdbW0E6KHkgWokBHwmsOhOZ0796BSE1PM+gndLHhs5+ji4cVXQUq
         gV7TdZlWJVXczRUHqcdlNb3omTcdMueaw6VCfmy8UJBbyD9wczuKunDl7hPzi4xGHNGB
         +U3/jNylT06y1DoBuSL4fquer2k8glQkPws7kSJ4WNyP5u8QNXRvEEKhf+YiX8HcUi0a
         aZM0WlgCLQL/3XDyPVYNkEkYeTEf9FjNfGDEA8F9AW2QB6CSQaJzksDO8cH8JuhUDOQK
         L/AlC+usGM+cUqbQ5pjeQuU0+cdm3KzVTgcLTyMKtBWvzFNV3wFDZ2JGf/PZB4Jk9PZo
         90SA==
X-Gm-Message-State: AOAM530XRZocekc/rCNy0KY3pNdwvKAc3NRulJwrwuUdJT8+e8veom/k
        6cL0L/tK1l8Rzg+FPKeNFWunNg==
X-Google-Smtp-Source: ABdhPJyzum9uJymMMZOJq223cfXwSx/BW9H+Vce4/ty3Exm0Lt+eEcWY/pWImDlj12r6skG58zMY2A==
X-Received: by 2002:a05:6e02:1608:: with SMTP id t8mr8186573ilu.183.1616000966161;
        Wed, 17 Mar 2021 10:09:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c16sm11346500ils.2.2021.03.17.10.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 10:09:25 -0700 (PDT)
Subject: Re: [PATCH 0/6] usbip fixes to crashes found by syzbot
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, shuah@kernel.org
Cc:     valentina.manea.m@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1615171203.git.skhan@linuxfoundation.org>
 <YEkQ4qS7tkwmjzDn@kroah.com>
 <5baf6b94-72c4-6e69-65a5-35c5cfb8ca0e@i-love.sakura.ne.jp>
 <YEoTw7CoK7Ob0YR+@kroah.com>
 <8dc1e893-4338-90ff-ea61-de727cad1d11@i-love.sakura.ne.jp>
 <afd1341b-2ed1-f781-d6c8-6064fea3aeb8@i-love.sakura.ne.jp>
 <192bdb07-da84-ce96-2e25-7c0df749940a@i-love.sakura.ne.jp>
 <9e089560-388a-a82d-4841-8092578b9d5d@i-love.sakura.ne.jp>
 <465479ca-544e-3703-cf4e-30f5be04fa11@i-love.sakura.ne.jp>
 <fbf64c33-87c3-137c-4faf-66de651243fc@linuxfoundation.org>
 <c4172173-3e54-4b09-303d-9c368b2b49c4@i-love.sakura.ne.jp>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <21ec4c04-bc67-0542-1c81-aec27c0f7473@linuxfoundation.org>
Date:   Wed, 17 Mar 2021 11:09:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c4172173-3e54-4b09-303d-9c368b2b49c4@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 9:38 AM, Tetsuo Handa wrote:
> On 2021/03/18 0:06, Shuah Khan wrote:
>> Yes. I haven't sent the patch for that reason. I am trying to test a
>> solution. I haven't come up with a solution yet.
>>
>> Holding event_lock isn't the right solution. I am not going to accept
>> that. This is a window that gets triggered by syzbot injecting errors
>> in a sequence. Fixing this should be done taking other moving parts of
>> the driver into account.
> 
> What is event_lock ? I questioned you what the event_lock is at
> https://lkml.kernel.org/r/3dab66dc-2981-bc88-a370-4b3178dfd390@i-love.sakura.ne.jp ,
> but you haven't responded to that post.
> 
> Also, you need to send https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/commit/?h=usbip_test&id=f345de0d2e51a20a2a1c30fc22fa1527670d2095
> because Greg already sent this regression into upstream and stable kernels.
> 

I acked it when it came in and it will be picked up.

thanks,
-- Shuah
