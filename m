Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8353D6877
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 23:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhGZUcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 16:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbhGZUcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 16:32:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A46C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 14:13:06 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id n2so12430425eda.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 14:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gzMiAu+6hqv58f59FOXN+E6RyEGYjVzhigo/P1uv5vc=;
        b=tbk2vF7YuP+kV18pZr4EGMkFVR8482zaix0jguLF+CRuSpcHpLAYU7/xcezT1SqoNp
         2EBi3qZdwi4994IVcpOAtly3DyMxkAFZIyqHg1IY7+xWhaWy6haBYP9OZMtduzcLYToe
         Jf8VTgxwTSLXWriaZMpDj+UpmlqbrPzDWAUdYJpukxLYgxYsBcbfvnfeIGrOQtUjiH8U
         FHKIUxubEBvLyd7a1+SVZ8zmHPld3amIbFnB1CwPffxTrUcbP0A3WAfHT0BDgrpXzqnR
         kthHwCZIp3utz8r2IgefQdDiQ72zXbUr8yLdj7DBOw8KPndH5jJK3U3HIsWz7RIxCC4a
         wLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gzMiAu+6hqv58f59FOXN+E6RyEGYjVzhigo/P1uv5vc=;
        b=EHw2Mv8hJub51U8dwfMjnBBk8Q16zjCC2D4TE+6AdZufT2GaVtFciJeFIhdiP4vmkN
         2Wq9iv9uX+T9VDIlevtJfyR2EB+oOiO3YOyXyGrsyyAKEfq81e2Gw6vj87ILiREzI3jf
         tRSVVD4Iq7SD9wMgQX+68CWbaGtOrh8+sGnrDOPzxBT11C7EbLwbLvNq/uE+JNpg4iq6
         sRAJqhiMZVgE31GSnNNj7GwYHsT5Y2cUhd2qFEG18j/yhOZhi2PcHe+28LwrZp6zL6Ar
         eCFnGywvK2rixCc2gE6MSck3q1zwxGf6IkNpfqrVRZ2OvCZjcpw4wOGrMv1NNtS9Z5KP
         Guyw==
X-Gm-Message-State: AOAM5329CthVRXPGQ/IzH9IluaTPR39chx+zw/VPs65dCvBnqfQyaL4T
        vY4aUhQd5drC6PAArKjdGDY=
X-Google-Smtp-Source: ABdhPJw6yNb7UMbaNDMv1uyDaw5G0gw04+Ap5C7MgmzHtuXLhcTMr99+Q+PY0jeV6VrspUeMLlMApQ==
X-Received: by 2002:aa7:d146:: with SMTP id r6mr10501399edo.264.1627333984763;
        Mon, 26 Jul 2021 14:13:04 -0700 (PDT)
Received: from [192.168.178.40] (ipbcc187b7.dynamic.kabel-deutschland.de. [188.193.135.183])
        by smtp.gmail.com with ESMTPSA id t4sm231812ejo.125.2021.07.26.14.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 14:13:04 -0700 (PDT)
Subject: Re: [PATCH 2/4] configfs: Fix writing at a non-zero offset
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Brendan Higgins <brendanhiggins@google.com>
References: <20210723212353.896343-1-bvanassche@acm.org>
 <20210723212353.896343-3-bvanassche@acm.org>
 <7bee65ce-f5f1-a525-c72d-221b5d23cf3e@gmail.com>
 <d12f24b6-7066-f9bb-1b88-6cc23c9c45c1@acm.org>
From:   Bodo Stroesser <bostroesser@gmail.com>
Message-ID: <4055ca70-7669-d00d-7c08-86fe75a3d377@gmail.com>
Date:   Mon, 26 Jul 2021 23:13:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d12f24b6-7066-f9bb-1b88-6cc23c9c45c1@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.21 18:26, Bart Van Assche wrote:
> On 7/26/21 7:58 AM, Bodo Stroesser wrote:
>> On 23.07.21 23:23, Bart Van Assche wrote:
>> Let's say user writes 5 times to configfs file while keeping it open.
>> On every write() call it writes 1 character only, e.g. first "A", then 
>> "B", ...
>>
>> The original code before the changes 5 times called flush_write_buffer 
>> for the
>> strings "A\0", "B\0", ... (with the '\0' not included in the count 
>> parameter,
>> so count is 1 always, which is the length of the last write).
> 
> Isn't that behavior a severe violation of how POSIX specifies that the 
> write() system call should be implemented?

Hmm. I'm not sure which detail should violate POSIX spec? Is there any
definition how data should be flushed from buffer internally? (I'm by
far not a POSIX expert!)

I would rather say the new behavior, to call flush_write_buffer during the
first write() for the data of that write, and then on the second write to
call flush_write_buffer for the concatenated data of the first and the
second write, could be a violation of POSIX, because the one times written
data of the first write is flushed twice.

I don't like the idea of breaking the "one write, one flush" principle that
was implemented before. The old comment:
"There is no easy way for us to know if userspace is only doing a partial
write, so we don't support them. We expect the entire buffer to come on the
first write."
as I interpret it, makes clear that configfs code has to work according to
that principle. (Or even block all but the first write, but that would even
more break compatibility to old implementation.)

Thank you,
Bodo

