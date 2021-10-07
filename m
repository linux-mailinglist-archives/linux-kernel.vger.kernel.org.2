Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5A2424B24
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbhJGAcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhJGAcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:32:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C98C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 17:31:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id d8so16266582edx.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 17:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HjjnY/5ioVuSKKrQ72CKMb7OQDureT7pno/lrOdWOyw=;
        b=fxUJdQ/r/+2XvlGqaUbhr8eKDzsu3QnQkkHKaqWCIqJ6fl1Kh6voheiaBankZx3G2x
         dNF2e1qQhmlLWW6ywLMkNHXscv6QdAUzdKUcybn4zdzY7DixjMGq5F/MHfVR58HzRhWT
         z7ByrJf27iMvwVF0iWr/0n/DCorQm1zTTAXTiwAQONykrv5WGIvECIei4Ft/huDjrG5J
         UzuNxmo3/u4q/jz/BzWdJjBOsD5jixkdI0A6GdLvh54Xaf6e2BLJOLzyRBL1M8D7kZV5
         RIY1XGrYLGVX4ZIteStmKJEYCn9Id2zK1aY8N3292h1rpW2fx0y8FQ8QJmUvOWK9XsHb
         L+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HjjnY/5ioVuSKKrQ72CKMb7OQDureT7pno/lrOdWOyw=;
        b=qZUpSiEeNxRoAQj784uIJqTG4vMgU0MPhu0tCFg75fSfC8QpzbK950xztBxyEy7nNC
         uyJAtKBb9WiND3dqX622/GvzJ1SVj6jg8irtodyObYsyREbHZvqN3Gfze/8oQzmYPjHy
         MyFscUoO6svna3r3xHKUBMUH1QvYmAW3uLk/Bctvy3EW6WrkM1PJqHQMJLkP9j9FCmJn
         EjSHfF7c+6gICcOwHvrd1kBvQfXRphDna1zJXPGoG6ViW2NU95XzaN9tpSymYs7ZNP5R
         DQt8/tit2jo4adOTe3oC9yx93hvpQY5WtZh9f2ycyokFd5tjr8TfU+HsV20BPpkT+XQ/
         nyLw==
X-Gm-Message-State: AOAM531P9ZR4WuepQmcCnQX+5BOzCSdatiS9zUA79L31ZnCbF3sEJSSZ
        /0YyAXQzRA+o23oKVGzGrYQ=
X-Google-Smtp-Source: ABdhPJwGiHf8LqDU9BkU/zEBF5/0lM+nHilkYAwfYabUcZeY5cGV7mDl4lH7URpAo9Xl7lIW8cqTHw==
X-Received: by 2002:a17:906:12c6:: with SMTP id l6mr1645020ejb.373.1633566659578;
        Wed, 06 Oct 2021 17:30:59 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id dx2sm2026209ejb.125.2021.10.06.17.30.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Oct 2021 17:30:59 -0700 (PDT)
Date:   Thu, 7 Oct 2021 00:30:58 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Wei Yang <richard.weiyang@gmail.com>, kuba@kernel.org,
        gregkh@linuxfoundation.org, mojha@codeaurora.org, jkosina@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hashtable: remove a redundant check in
 hash_for_each_xxx()
Message-ID: <20211007003058.uj35ekwibbrxqzku@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20211006152100.17795-1-richard.weiyang@gmail.com>
 <163355497171.31063.8329134032738647570@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163355497171.31063.8329134032738647570@noble.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 08:16:11AM +1100, NeilBrown wrote:
>On Thu, 07 Oct 2021, Wei Yang wrote:
>> The three hash_for_each_xxx() helper iterate the hash table with help
>> of hlist_for_each_entry_xxx(), which breaks the loop only when obj is
>> NULL.
>> 
>> This means the check during each iteration is redundant. This patch
>> removes it.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>  include/linux/hashtable.h | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>> 
>> diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
>> index f6c666730b8c..a15719ed303f 100644
>> --- a/include/linux/hashtable.h
>> +++ b/include/linux/hashtable.h
>> @@ -124,8 +124,7 @@ static inline void hash_del_rcu(struct hlist_node *node)
>>   * @member: the name of the hlist_node within the struct
>>   */
>>  #define hash_for_each(name, bkt, obj, member)				\
>> -	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
>> -			(bkt)++)\
>> +	for ((bkt) = 0, obj = NULL; (bkt) < HASH_SIZE(name); (bkt)++)	\
>>  		hlist_for_each_entry(obj, &name[bkt], member)
>
>I think you are missing an important property of this code.
>What we have here is a new loop command (hash_for_each()) that is
>constructed from 2 nested loops.  This sort of construct is in general
>difficult to use because in C it is common to use "break" to exit a loop
>early.  'break' cannot exit two levels of loop though.  So if you aren't
>careful, doing something like
>
>  hash_for_each() {
>     do something
>     if (some test)
>        break;
>  }
>
>might not do what you expect.  The 'break' will exit the inner loop, but
>not the outer loop.  That could easily lead to buggy code.
>
>But this macro *is* careful.  If the loop body *does* use break, then
>the inner loop will abort but 'obj' will still be non-NULL.  The test
>for NULL in the outer loop causes the outer loop to abort too - as the
>programmer probably expected.
>

Thanks for pointing out. I missed this case.

>So by removing the 'obj == NULL' test, you would cause any usage which
>breaks out of the loop to now be incorrect.
>
>I recommend that instead of this patch, you provide a patch which
>improves the documentation to make this clear. e.g.
>
>  Note: it is safe to 'break' out of this loop even though it is a two
>  nested loops.  The 'obj == NULL' test ensures that when the inner loop
>  is broken, the outer loop will break too.
>

Here is a draft patch based on you comment:

diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
index f6c666730b8c..2ff4cb5e6a22 100644
--- a/include/linux/hashtable.h
+++ b/include/linux/hashtable.h
@@ -116,6 +116,13 @@ static inline void hash_del_rcu(struct hlist_node *node)
 	hlist_del_init_rcu(node);
 }
 
+/**
+ * Note: the following three hash_for_each[_xxx] helpers introduce a new loop
+ * command that is constructed from 2 nested loops. It is safe to 'break' out
+ * of this loop even though it is a two nested loops.  The 'obj == NULL' test
+ * ensures that when the inner loop is broken, the outer loop will break too.
+ */
+
 /**
  * hash_for_each - iterate over a hashtable
  * @name: hashtable to iterate


If you feel good, I would like to add 

Sugguested-by: NeilBrown <neilb@suse.de>

>Thanks,
>NeilBrown
>
>
>>  
>>  /**
>> @@ -136,8 +135,7 @@ static inline void hash_del_rcu(struct hlist_node *node)
>>   * @member: the name of the hlist_node within the struct
>>   */
>>  #define hash_for_each_rcu(name, bkt, obj, member)			\
>> -	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
>> -			(bkt)++)\
>> +	for ((bkt) = 0, obj = NULL; (bkt) < HASH_SIZE(name); (bkt)++)	\
>>  		hlist_for_each_entry_rcu(obj, &name[bkt], member)
>>  
>>  /**
>> @@ -150,8 +148,7 @@ static inline void hash_del_rcu(struct hlist_node *node)
>>   * @member: the name of the hlist_node within the struct
>>   */
>>  #define hash_for_each_safe(name, bkt, tmp, obj, member)			\
>> -	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
>> -			(bkt)++)\
>> +	for ((bkt) = 0, obj = NULL; (bkt) < HASH_SIZE(name); (bkt)++)	\
>>  		hlist_for_each_entry_safe(obj, tmp, &name[bkt], member)
>>  
>>  /**
>> -- 
>> 2.23.0
>> 
>> 

-- 
Wei Yang
Help you, Help me
