Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C274260A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbhJGXmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhJGXms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:42:48 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C26C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 16:40:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g10so28420106edj.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 16:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Bz0RSGdKeZQrW1VwPwP7duCmDdWr0IQEge2rSP3rZ0=;
        b=CT7u/advcgXDCgtaWGU6VZ2JpZER0qICJEA4d1RiIeF0cz/sI19KPZRSytEBKmJd1A
         DWOAbHvK6iyTSBihSleJxRufI7SnfFD3q4QHpLkBD5AU0nei2de9oEyFqblR+hXJu5kx
         3NOVJLqjLS4KMS51WB+BL9CEdVpEUcpFqVz8dzPa9m89wC27NZB+W9NeptDrJhrJHFFa
         gIPlUbZbsK3Vh4I/Vexw+k2kP3500jsgEVpKhomc1IpMuDmCXaAJAncUmTKaQV3syWV/
         opMP+BVQA1SOKs/3hcC9iNyhMImeXxrHms0D/+lTmGGdXdlFlk+EyfsToIYeobzgqrl2
         b3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Bz0RSGdKeZQrW1VwPwP7duCmDdWr0IQEge2rSP3rZ0=;
        b=d/l8CD68f72JYeHA/NBiDUqI66GJ7hAXUFTqmkA+3mVhVhKP5mLTura5Cu2OX6xa7l
         lnuyaSs0mrbcP+l7KBg8OdFqPVOc4ekp32hYxr70N7TvAJ9XZbOSRP5Ob2tzBrNLEAqO
         BYFgQ4bHzbtUj9s5WwpB09gab7pTOHhImdE9vaIO5TtvlofsPLmu5mINAqNxGhT3mAux
         TYA5bZelU5nCet4SJK6MosNFlbmTBEC2AUQc8JmNhMdWBCFDB2BjFD7fDj2Kt+jN5X7l
         px3fgcVqTTf/h4E684h01d53/+jkRo51oSsSl7CIF5cmMOyKuCrw2F2BY/1Y8zTzfYZa
         vGRw==
X-Gm-Message-State: AOAM530T1nc4DbmxGTREvdhdm8aSupRLXT2m8KjzxCAo6Q4YksoeG/PI
        2jW4bv9tBq06bRUImMCLUWE=
X-Google-Smtp-Source: ABdhPJwtPcQanaYkdwhRGBFcXVwhwm+RpHNsNk3knrhQaGngV0dxvLn973qE0wmB6PX7y8Ic9/RYpQ==
X-Received: by 2002:a17:906:f243:: with SMTP id gy3mr9728902ejb.327.1633650052904;
        Thu, 07 Oct 2021 16:40:52 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v10sm311920edw.96.2021.10.07.16.40.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Oct 2021 16:40:52 -0700 (PDT)
Date:   Thu, 7 Oct 2021 23:40:51 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Wei Yang <richard.weiyang@gmail.com>, kuba@kernel.org,
        gregkh@linuxfoundation.org, mojha@codeaurora.org, jkosina@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hashtable: remove a redundant check in
 hash_for_each_xxx()
Message-ID: <20211007234051.km5w3o4err7vrpqm@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20211006152100.17795-1-richard.weiyang@gmail.com>
 <163355497171.31063.8329134032738647570@noble.neil.brown.name>
 <20211007003058.uj35ekwibbrxqzku@master>
 <163356782206.31063.3710696596883334978@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163356782206.31063.3710696596883334978@noble.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 11:50:22AM +1100, NeilBrown wrote:
>On Thu, 07 Oct 2021, Wei Yang wrote:
>> 
>> Here is a draft patch based on you comment:
>> 
>> diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
>> index f6c666730b8c..2ff4cb5e6a22 100644
>> --- a/include/linux/hashtable.h
>> +++ b/include/linux/hashtable.h
>> @@ -116,6 +116,13 @@ static inline void hash_del_rcu(struct hlist_node *node)
>>  	hlist_del_init_rcu(node);
>>  }
>>  
>> +/**
>> + * Note: the following three hash_for_each[_xxx] helpers introduce a new loop
>> + * command that is constructed from 2 nested loops. It is safe to 'break' out
>> + * of this loop even though it is a two nested loops.  The 'obj == NULL' test
>> + * ensures that when the inner loop is broken, the outer loop will break too.
>> + */
>> +
>>  /**
>>   * hash_for_each - iterate over a hashtable
>>   * @name: hashtable to iterate
>> 
>> 
>> If you feel good, I would like to add 
>> 
>> Sugguested-by: NeilBrown <neilb@suse.de>
>
>That's definitely an improvement.
>
>I'd probably put it in the kernel-doc comment for hash_for_each,
>then in the other two just put the "it is safe" bit.  Something like
>the following.  But I don't feel strongly about it.
>I'm happy to say
>  Reviewed-by: NeilBrown <neilb@suse.de>
>

Thanks for your detailed instruction :-)

>for your patch.
>
>Thanks,
>NeilBrown
>
>
>diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
>index f6c666730b8c..61db940c9501 100644
>--- a/include/linux/hashtable.h
>+++ b/include/linux/hashtable.h
>@@ -122,6 +122,10 @@ static inline void hash_del_rcu(struct hlist_node *node)
>  * @bkt: integer to use as bucket loop cursor
>  * @obj: the type * to use as a loop cursor for each entry
>  * @member: the name of the hlist_node within the struct
>+ *
>+ * Note: It is safe to 'break' out of this loop even though it is a two
>+ * nested loops.  The 'obj == NULL' test ensures that when the inner loop
>+ * is broken, the outer loop will break too.
>  */
> #define hash_for_each(name, bkt, obj, member)				\
> 	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
>@@ -134,6 +138,8 @@ static inline void hash_del_rcu(struct hlist_node *node)
>  * @bkt: integer to use as bucket loop cursor
>  * @obj: the type * to use as a loop cursor for each entry
>  * @member: the name of the hlist_node within the struct
>+ *
>+ * It is safe to 'break' out of this loop.
>  */
> #define hash_for_each_rcu(name, bkt, obj, member)			\
> 	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
>@@ -148,6 +154,8 @@ static inline void hash_del_rcu(struct hlist_node *node)
>  * @tmp: a &struct hlist_node used for temporary storage
>  * @obj: the type * to use as a loop cursor for each entry
>  * @member: the name of the hlist_node within the struct
>+ *
>+ * It is safe to 'break' out of this loop.
>  */
> #define hash_for_each_safe(name, bkt, tmp, obj, member)			\
> 	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\

-- 
Wei Yang
Help you, Help me
