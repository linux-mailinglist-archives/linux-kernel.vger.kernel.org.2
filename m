Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C153332F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 03:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhCJCIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 21:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhCJCHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 21:07:50 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E80C061760
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 18:07:39 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id v14so14067402ilj.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 18:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i5b/iy0A4Dj0bqvDcrMMLPgadLbrgb3seHckWJMKqm0=;
        b=KzR4vCG8NRwxSNzo8g6kvruQE8lyfuW08waAiJ89v3xf9FYQmb5VOryQe++msbPfaW
         OS6WxyRroFYgC1zSNhpQrKleyV4Vye1VQ1dYJQzIlnCEYpNNCO6D0VPgZH5K7SOoyMTb
         PizakQnwXbFB1xrAx2S8FxoMB77UdXvz0USdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i5b/iy0A4Dj0bqvDcrMMLPgadLbrgb3seHckWJMKqm0=;
        b=UD0um9uT7TKw7MWsFCIcpIRaDe+mn1ut/VMUBPvVjP8ElmRTzw+AvafE6TMobeOgPY
         /a3jNJyoIVGqzkzlzvq7hsMcPxnEgciGxvLEXbvN+8mTDQ3I/P3yPeRHG9vgMLb0V4nq
         JYbtgpNJPSxlQOJUSRJQJSfCao39VqN9r0qOgJCkOAR9XQ8Bjidk1lkwPKQqvEsNDm4+
         O6MgqcMfIb/e+EAHWxWPMgRFJs1qWzJAi2hPPdXBpKHkszt6bZmiTOycg3JDeLJnS1oy
         v5HuQdEebUCtgVNLGwy1+pwGSFjw3JNEc8/e8tYAV5feRZbKxU84McXydLHO6hTQrzJo
         JV+A==
X-Gm-Message-State: AOAM530BCXQqahiS/wb/gIlycJQMrEXd1L/6KHge0Q1Reykv6bVqF7jN
        bqg1cUaL+MkSGim4mqbK6Z2AKQ==
X-Google-Smtp-Source: ABdhPJyGmrp1G6U2w1WoD09LPitrttQNiyAlbEYLIY8mhEYBNna9x7jbu0PhU4afFf4y0AbUmIxicQ==
X-Received: by 2002:a05:6e02:19c5:: with SMTP id r5mr904694ill.171.1615342059015;
        Tue, 09 Mar 2021 18:07:39 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k3sm8375059ioj.35.2021.03.09.18.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 18:07:38 -0800 (PST)
Subject: Re: [PATCH 4/6] usbip: fix stub_dev usbip_sockfd_store() races
 leading to gpf
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1615171203.git.skhan@linuxfoundation.org>
 <268a0668144d5ff36ec7d87fdfa90faf583b7ccc.1615171203.git.skhan@linuxfoundation.org>
 <05aed75a-4a81-ef59-fc4f-6007f18e7839@i-love.sakura.ne.jp>
 <5df3d221-9e78-4cbe-826b-81cbfc4d5888@i-love.sakura.ne.jp>
 <3305d1a1-12e2-087b-30f5-10f4bf8eaf83@linuxfoundation.org>
 <f8f5e763-da2d-b26f-c6a5-d345bbe55448@i-love.sakura.ne.jp>
 <30a1afb2-d5a4-40b2-385d-24a2bf110e92@linuxfoundation.org>
 <7b9465aa-213e-a513-d033-12c048df15d6@i-love.sakura.ne.jp>
 <05e8e744-0847-cde2-b978-0bfd7ef93a9f@linuxfoundation.org>
 <9653ae69-86f4-7608-ce97-4ec39b063ed2@i-love.sakura.ne.jp>
 <1edb9542-59c9-bbf6-9f16-99614605a800@linuxfoundation.org>
 <47dbbf10-368c-6e45-5eac-c57b75f7ae9c@i-love.sakura.ne.jp>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0e8d26dc-d99c-bcaa-1e95-0b5d0e0e535b@linuxfoundation.org>
Date:   Tue, 9 Mar 2021 19:07:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <47dbbf10-368c-6e45-5eac-c57b75f7ae9c@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 6:02 PM, Tetsuo Handa wrote:
> On 2021/03/10 9:29, Shuah Khan wrote:
>>> It is not a large grain lock. Since event_handler() is exclusively executed, this lock
>>> does _NOT_ block event_handler() unless attach/detach operations run concurrently.
>>>
>>>>
>>
>> event handler queues the events. It shouldn't be blocked by attach
>> and detach. The events could originate for various reasons during
>> the host and vhci operations. I don't like using this lock for
>> attach and detach.
> 
> How can attach/detach deadlock event_handler()?
> event_handler() calls e.g. vhci_shutdown_connection() via ud->eh_ops.shutdown(ud).
> vhci_shutdown_connection() e.g. waits for termination of tx/rx threads via kthread_stop_put().
> event_handler() is already blocked by detach operation.
> How it can make situation worse to wait for creation of tx/rx threads in attach operation?
> 

event_lock shouldn't be held during event ops. usbip_event_add()
uses it to add events. Protecting shutdown path needs a different
approach.

In any case, do you have comments on this patch which doesn't even
touch vhci driver?

I understand you are identifying additional race condition that
the vhci patches in this series might not fix. That doesn't mean
that these patches aren't valid.

Do you have any comments specific to the patches in this series?

thanks,
-- Shuah



