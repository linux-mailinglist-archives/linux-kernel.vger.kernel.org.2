Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7470C3E10AD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbhHEJAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbhHEJAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:00:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2458FC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 01:59:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso5715043wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 01:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SOkJGUnznb2UUN/rrCtzoL7ydZijlH7J+pEb9m1fY/o=;
        b=lqyff9n6rmWw/JPml/F26x3wPUEIv4OpgVTBVWogyNy/JRzvR5IphQtdXG3dLpeBqZ
         6gyW8gEO6N3eOL+CzBjXGlx/zzvPr2X9Fgl2Qn4CpJpmKXctS2nou5LyJ+ZG+sRMFBEG
         sNsY9FqfapPzOlhDoLKYAp2UmrBR/LSrDpwWQWuubD74mcTohA84YiVF0ZhXJCOHzVmF
         xdRsNmvAeMfmKVbjMpEJvCJjoKS4WeIVM35fo8R9WlFOx6+Dv9Tzc5oEhmLsn/eaAbpt
         bwbSFhO5Khihhc14fo/WjlE4oLVjWaecSUyZtfsIL52MBB94T8Y3p+YeTG51QDKQF8U4
         zosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SOkJGUnznb2UUN/rrCtzoL7ydZijlH7J+pEb9m1fY/o=;
        b=UVgvUXO3dPWdqtbM17O7sPogV4UilX6JNlNCpvJ2BrilyI+xSBdpF4TOGJobVpnyiX
         lEzJuXdMt3K1wJq8bhWjQFhxrIbhLJu7MmMrtfIdFI81MTR875c0V09NdY/cNtU2LlX1
         JI1ZUDjeI9rviQ2ulmfd86jzqw72V9RxcRxd4RTp2zVMeTPFZLF4aSlU3aZ7uzrkRSET
         GpOMvxRQpLv8nx4SC1bfyYxoO0HFtv3PF97AowdQv6EhOYF4M7zt7alyL4ffKHTFQU1A
         A4Jzw87Ois9YbjJjlJtVv4vDqZR4Q6ow37Ipfbnl8DTZ0NHd3/CCJHRkHahoxBAeDbXN
         KJSA==
X-Gm-Message-State: AOAM531am/j7781JlP8g8Gc2TUoyEnn0sVHAFo86wqeYlvuXs/bSfQHo
        Yz1+Z1hinPyQ7qQ/FbEO8yk=
X-Google-Smtp-Source: ABdhPJxkE9xJvAUeEuz/wQy5h2EWkGSLcTTPeed5k5ZRsNJJE05c1I6mkdXuaP1Rk/06H1a6b/7xWA==
X-Received: by 2002:a05:600c:4fc4:: with SMTP id o4mr13087547wmq.109.1628153996743;
        Thu, 05 Aug 2021 01:59:56 -0700 (PDT)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id w3sm4826633wmi.44.2021.08.05.01.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 01:59:56 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] Revert "media: device property: Call
 fwnode_graph_get_endpoint_by_id() for fwnode->secondary"
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com,
        laurent.pinchart@ideasonboard.com
References: <20210804230313.78238-1-djrscally@gmail.com>
 <20210804230313.78238-3-djrscally@gmail.com> <YQujbIj0ynE43vw9@kroah.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <384a39d3-6817-7e42-60cc-43615a4e4ae8@gmail.com>
Date:   Thu, 5 Aug 2021 09:59:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQujbIj0ynE43vw9@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2021 09:38, Greg KH wrote:
> On Thu, Aug 05, 2021 at 12:03:13AM +0100, Daniel Scally wrote:
>> This reverts commit acd418bfcfc415cf5e6414b6d1c6acfec850f290. Checking for
>> endpoints against fwnode->secondary in fwnode_graph_get_next_endpoint() is
>> a better way to do this since that function is also used in a bunch of
>> other places, for instance sensor drivers checking that they do have an
>> endpoint connected during probe.
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Daniel Scally <djrscally@gmail.com>
>> ---
>>  drivers/base/property.c | 9 +--------
>>  1 file changed, 1 insertion(+), 8 deletions(-)
> This can only be reverted due to your 1/2 change, right?


Yes, that's correct.

> If so, you
> might want to make that explicit here...


Fair point - thanks, I'll do that.

>
> thanks,
>
> greg k-h
