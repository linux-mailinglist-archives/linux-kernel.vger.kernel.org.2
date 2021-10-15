Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDDC42E757
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 05:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbhJODmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 23:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbhJODmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 23:42:01 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8421EC061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 20:39:44 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id o133so7238359pfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 20:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qcraft-ai.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8tJVhTiQMmvCknI0GqVyNSnP+8+m2C9KfZp82f5A95w=;
        b=OgPHax59p7dxOq1UneLj2e24WVL+J8TRz9e5yW7DQz3JIOUVWWi2uUX013KkbDxBgt
         jE9CFu6TM/B3csSS7vLYRSzn/HObUJq82Rq5RJw1nQcc/mZQeQSyv2KoTFJpBelI3Qmo
         M3QwP7qpXdpsrLogBW3MQekgDEn+2YV5JJuDvDG2E/wVe8bUH11QERDFn9kiitfyi+2h
         jIbzaXChRWrqQEyZsN3HKFSPdx5ik8RpMvFyUPysoLHFoPCaO+RqZ046pNV0O55vKhOe
         5zFo2QAd1fstBRKoUJ9e/mno6f3oPTtChI5VIc8RW0DmV7joHl1JvdTD9fsNAx71Awxa
         SQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8tJVhTiQMmvCknI0GqVyNSnP+8+m2C9KfZp82f5A95w=;
        b=rU9k5oeEelQyTB9kEhD5sYqSupk0XIhhvvBFibnHS+qhK4LMv/24YD9kM91hkNAy2M
         9uHu+OtTA3tLhpdf+pGrBrbAQH92a4uP8NWBAKBNwzzGIipUc2KrE1AwSFiPmO8EpQJE
         JLL8gdefzH2WIp0111+dpvXjrLjva7/UxM68dqPUmV8Fw2xcz8dKguQIuKQ3NGcvg8J3
         A1offMBg1xL4O0HsBRCSEe5SzTLdSFErJaSAKZyFAkfpuY7F72hz4qyTdox9Wv8VjZmX
         HCf1fqrVkEAalRkNxUtl2rB844KPDCahQYd3xFDPLasuPRS7clbb5rTSb+4s0YuKXPtL
         Oz6g==
X-Gm-Message-State: AOAM531pBjNYFem+jqaPZrWPOvpbgs6XhBUev0Evu1zWHww0yEjpHBGO
        QIu7hjMul+lCHsNSC5r/YWBrcw==
X-Google-Smtp-Source: ABdhPJwS4CJKkN0q/MXyh0mORBFW5eWSnNoCUxu/gCWLts25/W4/CT6tTymJiYq0q1ruu0FBhsxYZg==
X-Received: by 2002:a63:cf44:: with SMTP id b4mr7363255pgj.215.1634269184039;
        Thu, 14 Oct 2021 20:39:44 -0700 (PDT)
Received: from [172.18.2.138] ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id v12sm3726240pjd.9.2021.10.14.20.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 20:39:43 -0700 (PDT)
Subject: Re: [PATCH] mm: backing-dev: use kfree_rcu() instead of
 synchronize_rcu_expedited()
To:     Matthew Wilcox <willy@infradead.org>,
        Zqiang <qiang.zhang1211@gmail.com>, hch@infradead.org
Cc:     akpm@linux-foundation.org, sunhao.th@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20211014082433.30733-1-qiang.zhang1211@gmail.com>
 <YWgTZjDtZik/9l4J@casper.infradead.org>
From:   zhangqiang <zhangqiang@qcraft.ai>
Message-ID: <0c31aa44-62fb-58a7-abaf-aec580e561bd@qcraft.ai>
Date:   Fri, 15 Oct 2021 11:39:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YWgTZjDtZik/9l4J@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/10/14 下午7:24, Matthew Wilcox wrote:
> On Thu, Oct 14, 2021 at 04:24:33PM +0800, Zqiang wrote:
>> The bdi_remove_from_list() is called in RCU softirq, however the
>> synchronize_rcu_expedited() will produce sleep action, use kfree_rcu()
>> instead of it.
>>
>> Reported-by: Hao Sun <sunhao.th@gmail.com>
>> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>> ---
>>   include/linux/backing-dev-defs.h | 1 +
>>   mm/backing-dev.c                 | 4 +---
>>   2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
>> index 33207004cfde..35a093384518 100644
>> --- a/include/linux/backing-dev-defs.h
>> +++ b/include/linux/backing-dev-defs.h
>> @@ -202,6 +202,7 @@ struct backing_dev_info {
>>   #ifdef CONFIG_DEBUG_FS
>>   	struct dentry *debug_dir;
>>   #endif
>> +	struct rcu_head rcu;
>>   };
> Instead of growing struct backing_dev_info, it seems to me this rcu_head
> could be placed in a union with rb_node, since it will have been removed
> from the bdi_tree by this point and the tree is never walked under
> RCU protection?
>
Thanks for your advice, I find this bdi_tree is traversed under the 
protection of a spin lock, not under the protection of RCU.
I find this modification does not avoid the problem described in patch, 
the flush_delayed_work() may be called in release_bdi()
The same will cause problems.

may be  we can replace queue_rcu_work() of call_rcu(&inode->i_rcu, 
i_callback) or do you have any better suggestions?

Thanks
Zqiang


