Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E3144DB15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 18:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhKKR3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 12:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhKKR3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 12:29:52 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629CCC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:27:03 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id x9so6528633ilu.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aXLTRBYI13KZIO+dfsEzstJMnF2RCHP2vfbXWKYn5mc=;
        b=Y6uLcEYJHJeBK4ccBUp+MEuFdX/9DKrSAoQHajAyWJda+2QNQESC5GXiYtQlqTssRL
         fElMFFNGJnU/dgfl7FVrv986rbK6zijwlU/8syNNafUSyckQXprEtdj1CtIS1dR4jj1b
         ON8nT/NQIC6U3owagvNAiAbfTy1Dv8AHscQUl2mnQmnSuWbz7Bbl2a9mXqDaA94FWbBV
         B3gjTzQ2McE57pwMlcu9rLm6uxbQP5R8LTqE3casbqONyNVzd4iBnXDZNsf0hiHHvd9h
         h5fE1rCVQ2baEjk2x6ZueRGHvqz49bgkyp24QTwkiniQFVWPF49JTENISX4bD+pbz/wB
         q7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aXLTRBYI13KZIO+dfsEzstJMnF2RCHP2vfbXWKYn5mc=;
        b=eY7l3pZUroq/MWrAI88+SPPjZ3pqeCwaxE5Biy/XfWoziLP6J6IBuK8FqhRmP/zMAE
         2mFwVeLqph6vcOqJxAFm+a+PYfOBK+m8uItYrcry5pPy8mTaMRRUidB2v6vBXYEij1W7
         vTcxZlLT2Eri3us2anXRH7twZ/Q3Vk4XF7D8Bvxx8E6pPotxRKfZ/pQtiLxELFTwDXLB
         zEkKukvIUtTCQaYn8LWemcaT8yh9mIQOW8f2M6N4bja3lTINs+dHOmbkP036EAYMh+Rq
         irfLkvNVzKUUwJOL2UzoJJ6Kj0XjLgJBpJCt6St7sXDLYySxfYQM/wDwr+YcsQSbxqud
         iPng==
X-Gm-Message-State: AOAM530GAMdzJAgpO/6mykXptbALLnHwdywEe/WPp1dAoK8+Ke3bBGei
        Pd4P9eZbWdkbk6gIsM9tYDt57XKPv3dGqiP8
X-Google-Smtp-Source: ABdhPJwxEk4fywkXqq80kmRZqPGAGeQVzlO7dK8j3AbPBjNVmn39bvExC3YmD97V853PntJExnTnBg==
X-Received: by 2002:a05:6e02:174d:: with SMTP id y13mr4982545ill.183.1636651622464;
        Thu, 11 Nov 2021 09:27:02 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y12sm2549196ill.71.2021.11.11.09.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 09:27:02 -0800 (PST)
Subject: Re: ____i915_gem_object_get_pages() -> shmem_get_pages() crash in
 -git
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
References: <c19e9907-4651-7503-915e-60f4df530e95@kernel.dk>
 <CAHP4M8WdJUH4UY5s0La=Xq9sMnqDQzk=zSaFTZ9G321KYVmx0A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6bb8c25c-cdcf-8bca-3db2-9871a90d518f@kernel.dk>
Date:   Thu, 11 Nov 2021 10:27:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHP4M8WdJUH4UY5s0La=Xq9sMnqDQzk=zSaFTZ9G321KYVmx0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/21 10:03 AM, Ajay Garg wrote:
> Hi Jens.
> 
> Same issue at my side.
> 
> Have posted a patch at
> https://lore.kernel.org/linux-mm/CAMZfGtUp6dkT4OWzLhL8whqNnXAbfVw5c6AQogHzY3bbM_k2Qw@mail.gmail.com/T/#m2189d135b9293de9b4a11362f0179c17b254d5ab
> 
> Will be great to hear back if it fixes things at your side too.

Yep, looks like that'd fix it indeed.

-- 
Jens Axboe

