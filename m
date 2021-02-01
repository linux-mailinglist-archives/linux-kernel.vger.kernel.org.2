Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C0930ABE2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhBAPtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhBAPtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:49:31 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED53EC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 07:48:50 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id y19so17854268iov.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F1mnhlO0flsCywigXafEGxOn7yCz7E9oyMZu0YbbR1Q=;
        b=pZaVNCnGKC2Edaoj0/qJ0HCh8tubWgmT3AJpDon6mHTuGL9WNG7GqbaOqwCTqXQeNj
         Dk0EnJqTcTk2hjqWwTZtrZbYdav2Yp2fCeT6TrI/eI8tjV41fFMu7xBjU2gyv6dqHODA
         88oHkTMFxFtqea5L3Fqqu83EUpCXER/2Fj8RVsVPFuj9XQkqQ4YbVIKeH/FeP49bIrqY
         1s9XvfK1txHig+aObdoD4n14csOB/VN37gJciUacoCPFCP6kE/PeFh+/AcFh2KDgcSZ4
         InG779tXsM3PZnGT6pffy4NZU3LHzSjFFteyp49dBHlm5o4k/agng4nEY9YdlhH5LBkf
         U68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F1mnhlO0flsCywigXafEGxOn7yCz7E9oyMZu0YbbR1Q=;
        b=AbiCDhcpCF827KyWekcsJ0EzAt28IG4ie2Z60G9DdrQ4jKdzEY+w0tMZ3AwzZYKXe7
         hmP5l+iQt2dq9ZCACfd2oZEwoA0wOk5MtaP9So30sHBZXuANARzLbL3pqxnG2Fy/Mni+
         fKmmhq3svFOBgilGCuIKLRlsHE/IxagiPgBJkM+eknf5stHHLrgNrJFRFuzMC/Lks2oH
         6KE5pjjYs46gKF909NsidSsFxr3lZ87flPQDhZrNdONSz9TAqJzgoPynfRGd8Pno8YB1
         bEgNH70BmLby0pFx54BjW5DElh4dzCbIurBTyq5JOaGRBfeD5v9PUpQcqMlkWyhNo+uu
         0i7Q==
X-Gm-Message-State: AOAM533sFoyV+BercqjfK6yrM2s4ppUonZzJI0hKcObuW+zpApBNBWDL
        D62DsREXnlvnoIFqzaa73cx/Lg/r+FTOFQ==
X-Google-Smtp-Source: ABdhPJzspkyew+dHWJOQ4vUS9ewwECuZQxsToDFk+w3k+xSNbmhBoUtY/J5x0sOUhZ8i7L1n0IPJhg==
X-Received: by 2002:a05:6638:2407:: with SMTP id z7mr15100326jat.110.1612194530101;
        Mon, 01 Feb 2021 07:48:50 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id l20sm8788084ioh.49.2021.02.01.07.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 07:48:49 -0800 (PST)
Subject: Re: [PATCH net-next 9/9] net: ipa: don't disable NAPI in suspend
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, elder@kernel.org,
        evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210129202019.2099259-1-elder@linaro.org>
 <20210129202019.2099259-10-elder@linaro.org>
 <CAF=yD-L1SKzu+gsma7KN4VjGnma-_w+amXx=Y_0e78rQiUCu7Q@mail.gmail.com>
 <e27f5c10-7b77-1f12-fe36-e9261f01bca1@linaro.org>
 <CAF=yD-+4xNjgkWQw8tMz0uvK45ysL6vnx86ZgEud+kCW9zw9_A@mail.gmail.com>
 <67f4aa5a-4a60-41e6-a049-0ff93fb87b66@linaro.org>
 <CAF=yD-+ABnhRmcHq=1T7PVz8VUVjqC073bjTa89GUt1rA3KVUw@mail.gmail.com>
 <a1b12c17-5d65-ce29-3d4f-e09de4fdcf3f@linaro.org>
 <CAF=yD-JSpz5OAp3DtW+1K_w1NZsLLxbrviZRQ5j7=qyJFpZAQg@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <af60d526-ffbd-2a35-ced7-7c988c2603b8@linaro.org>
Date:   Mon, 1 Feb 2021 09:48:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAF=yD-JSpz5OAp3DtW+1K_w1NZsLLxbrviZRQ5j7=qyJFpZAQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 8:47 AM, Willem de Bruijn wrote:
>> I tried to do a survey of that too and did not see a
>> consistent pattern.  I didn't look*that*  hard because
>> doing so would be more involved than I wanted to get.
> Okay. If there is no consistent pattern, either approach works.
> 
> I'm fine with this patchset as is.

OK.  I'm sending version 2 of the series to address the
comment about returning success early--before the end
of the function.  I'm also tweaking one or two patch
descriptions.

As I looked at the series I saw some other things I'd
like to do a little differently.  But to keep things
simple I'm going to do that in a follow-on series
instead.

Thank you very much for your time on this.

					-Alex
