Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB5644D1B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 06:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhKKFnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 00:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhKKFnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 00:43:08 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51897C061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 21:40:20 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id r5so4947428pls.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 21:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=meyjLeNOTUfo/ee3VzQRg1KbYxNfJ6VkJ/+ojTjTB4k=;
        b=0q6iXr1gWfsI3+U1OwmmNzhJdspbuGX62qVda9lzJFerbSiIIpXwFWpmdDVHCbKTxz
         xfa45O984MSggxxd1HewlseOG6eX2t3ilVMOzK0UdMf5F9IDPoRZZx/+LuMI1GwlXn19
         2CLZZMKWfCONJ5ELn/9A7i3YcsPBpMwSy/MiR37wyV/lLOKWIhHRNAa0F8BAeQkQ3E2w
         1VFXUl0Nb2jTQp8RijvBVe4fKfvsTA57xHh6fc7WDOnUi34iBT0B87jpgVDULzYqf6/a
         SQVD6wS+Stvq7I1Ce1X97Y/DCnXBRjeVKczrhIV73oZCGWf1rPOh7x9yDIakERBXVf/y
         xHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=meyjLeNOTUfo/ee3VzQRg1KbYxNfJ6VkJ/+ojTjTB4k=;
        b=IwzCtk0FD/OexmTipJFbUP1K/H4fLBQq4sg68AT3ICbN0X4uU6jlrB4OY5RhQZlpQY
         3KnI0wRAIM6o0UfwRG9DC43qPjFrhOltch3YupBFpHxio4ICmWFXc/XnorCRXWN8TKxo
         4d9ZY5SnQ94PKRmEiRHBlV25m05qJY8vuanDAL2dcPA41vMuMN6Imun+/YtK9OE5E1X7
         V6VKftxkTMpNeImkFqMVE/3cXAOcPH0BsGnv46Kh8iGWUNkFbAqlfXOofzt99jwEt5td
         jE4ln6tuZM+bhKlvlk2VeZeiz39l3HSN42gQqFj0cdEOx/sgw5f/k3pm088nSJImU8Nd
         Rgfw==
X-Gm-Message-State: AOAM5314vejX+NwjCxtreWuKL4T3fWmlZYTMgHhBAWDfqkX4B2ObiXYA
        24Qb5SWirkRPb2FNU1OALQE7ng==
X-Google-Smtp-Source: ABdhPJwgrx/NnYB9a213ApL25hip5UQURu1AsnZb8zCu64ngyBsg/8QSfliZKaJvOKT2rhze5DC6Wg==
X-Received: by 2002:a17:902:c943:b0:142:1758:8ee7 with SMTP id i3-20020a170902c94300b0014217588ee7mr4920255pla.58.1636609219858;
        Wed, 10 Nov 2021 21:40:19 -0800 (PST)
Received: from [10.254.173.217] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id bt2sm7134464pjb.33.2021.11.10.21.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 21:40:19 -0800 (PST)
Message-ID: <9e630c7a-8c29-3a05-5056-a045e11c7949@bytedance.com>
Date:   Thu, 11 Nov 2021 13:40:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v3 14/15] Documentation: add document for pte_ref
To:     Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, david@redhat.com, jgg@nvidia.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
 <20211110105428.32458-15-zhengqi.arch@bytedance.com>
 <875yt0krcj.fsf@meer.lwn.net>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <875yt0krcj.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/21 10:39 PM, Jonathan Corbet wrote:
> Qi Zheng <zhengqi.arch@bytedance.com> writes:
> 
>> This commit adds document for pte_ref under `Documentation/vm/`.
> 
> Thanks for documenting this work!
> 
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   Documentation/vm/pte_ref.rst | 212 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 212 insertions(+)
>>   create mode 100644 Documentation/vm/pte_ref.rst
> 
> When you add a new RST file, you also need to add it to the associated
> index.rst file or it won't be included in the docs build.  Instead,
> you'll get the "not included in any toctree" warning that you surely saw
> when you tested the docs build with this file :)

OK, I will add it to the associated index.rst in the next version.

> 
>> diff --git a/Documentation/vm/pte_ref.rst b/Documentation/vm/pte_ref.rst
>> new file mode 100644
>> index 000000000000..c5323a263464
>> --- /dev/null
>> +++ b/Documentation/vm/pte_ref.rst
>> @@ -0,0 +1,212 @@
>> +.. _pte_ref:
> 
> Do you need this label anywhere?  If not, I'd leave it out.

I will remove this label in the next version.

Thanks,
Qi

> 
> Thanks,
> 
> jon
> 
