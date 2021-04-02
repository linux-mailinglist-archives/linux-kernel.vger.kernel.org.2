Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B63353019
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbhDBUEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhDBUEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:04:20 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E318FC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 13:04:17 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id f19so6355681ion.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 13:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MplQbzRQT+z1bdJmXaR1KVHy2BkjrU2G1JmE86JIobE=;
        b=QNtwHbIU+TmlqWMAulG7h9/kinoTe8R4yMngOQsbuR+nXnUNGwfjAgj8W5wieJKwn7
         ZCCEI5tzGZ7RQ0iYBirGX9Myhl61mXP4e0WJIa7xC0bFdDEihLonXjgM3wGBTQg1vzmR
         D3LQi1nmVQkObKfLjl78OeDKNybUR9fVGLTcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MplQbzRQT+z1bdJmXaR1KVHy2BkjrU2G1JmE86JIobE=;
        b=j0xuhudGqgu2WSKbP/6voFhrUytT7hqnIrKTmcND3yD/u3Vd1f/2XQ3lPj/eZsGZtF
         +MTlqr6NGCNd8Ii3RMoe1WupygTCUb5vPVJqQIYRLIVCcaWG97O7wdkzJ8jARP3PBmIL
         WpnsJ3vjmJ95UC/fNUdHaFKu/abHOJ2qv6ighmmg+9VTINW2EpFVXwYGdVmvWdSGiKOr
         U9w8Nge5y2qtmvH6CkgW+eXOoQPNBwfXeQQNYRb/8Dnseo5IGDJkuTzbUTv3nAqfMQzu
         efK+tfTdsGKGl4335IHN8GMXa6yKWfa/fjHG6lTaj4+Zo9BZJH3ziocMKqO3qr8eEb/1
         zy2g==
X-Gm-Message-State: AOAM533j/tkgUY+vFHXn8zp7vZUJfpPFdcpFxKKrbSME5CjlX6eJ/qtf
        i8SDOKgVA7512qd1PVtA05z9Dw==
X-Google-Smtp-Source: ABdhPJzJDkZYkTZKB1YRuviJOlyg7HgTbjG4HV0Ef/gdB8gbkEVvTlYX78jr9Q53a6SmOkXuzkYlxQ==
X-Received: by 2002:a02:c6c4:: with SMTP id r4mr13881161jan.77.1617393857400;
        Fri, 02 Apr 2021 13:04:17 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n10sm4307445ili.15.2021.04.02.13.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 13:04:16 -0700 (PDT)
Subject: Re: [PATCH v6 00/21] Miscellaneous fixes for resctrl selftests
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
 <YF451jic7QNyUCVD@otcwcpicx3.sc.intel.com>
 <b10f5509-5111-e3e4-c247-dde542c36358@linuxfoundation.org>
 <YGdgDqyma+/VXNcc@otcwcpicx3.sc.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c2221c02-5646-0521-a501-87717d872b37@linuxfoundation.org>
Date:   Fri, 2 Apr 2021 14:04:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YGdgDqyma+/VXNcc@otcwcpicx3.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/21 12:18 PM, Fenghua Yu wrote:
> Hi, Shuah,
> 
> On Fri, Apr 02, 2021 at 12:17:17PM -0600, Shuah Khan wrote:
>> On 3/26/21 1:45 PM, Fenghua Yu wrote:
>>> Hi, Shuah,
>>>
>>> On Wed, Mar 17, 2021 at 02:22:34AM +0000, Fenghua Yu wrote:
>>>> This patch set has several miscellaneous fixes to resctrl selftest tool
>>>> that are easily visible to user. V1 had fixes to CAT test and CMT test
>>>> but they were dropped in V2 because having them here made the patchset
>>>> humongous. So, changes to CAT test and CMT test will be posted in another
>>>> patchset.
>>>>
>>>> Change Log:
>>>> v6:
>>>> - Add Tested-by: Babu Moger <babu.moger@amd.com>.
>>>> - Replace "cat" by CAT_STR etc (Babu).
>>>> - Capitalize the first letter of printed message (Babu).
>>>
>>> Any comment on this series? Will you push it into linux-kselftest.git?
>>>
>> Yes. Will apply for 5.13-rc1
> 
> Great! Thank you very much for your help!
> 

Done. Now applied to linux-selftest next.

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/ 
next

Ran sanity test and suggested a change in message for 12/21.

Please take a look other such messages and improve them as well
and send follow-on patches.

thanks,
-- Shuah
