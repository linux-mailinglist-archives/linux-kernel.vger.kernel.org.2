Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D652241C162
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244965AbhI2JOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:14:34 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:56227 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239961AbhI2JOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:14:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uq0BRJ3_1632906770;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Uq0BRJ3_1632906770)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Sep 2021 17:12:50 +0800
Subject: Re: [PATCH] ocfs2: mount fails with buffer overflow in strlen
To:     =?UTF-8?Q?Valentin_Vidi=c4=87?= <vvidic@valentin-vidic.from.hr>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20210927154459.15976-1-vvidic@valentin-vidic.from.hr>
 <00850aed-2027-a0ab-e801-c6498a5a49f8@linux.alibaba.com>
 <20210928131450.GM28341@valentin-vidic.from.hr>
 <212f878e-1bbe-347c-ba43-e4ffb9b4afbe@linux.alibaba.com>
 <20210929062434.GN28341@valentin-vidic.from.hr>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <1ab61ba3-8c9b-092c-7843-9c45b58e3987@linux.alibaba.com>
Date:   Wed, 29 Sep 2021 17:12:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929062434.GN28341@valentin-vidic.from.hr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/21 2:24 PM, Valentin Vidić wrote:
> On Wed, Sep 29, 2021 at 10:38:59AM +0800, Joseph Qi wrote:
>> Okay, you are right, strlen(src) is indeed wrong here.
>>
>> But please note that in strlcpy():
>> size_t ret = strlen(src);
>> if (size) {
>> 	size_t len = (ret >= size) ? size - 1 : ret;
>> 	memcpy(dest, src, len);
>> 	dest[len] = '\0';
>> }
>>
>> Take ci_stack "o2cb" for example, strlen("o2cb") may return wrong if the
>> coming byte is not null, say it is 10.
>> The input size is 5, so len will finally be 4.
>> So dest is still correct ending with null byte. No overflow happens.
>> So the problem here is the wrong return value, but it is discarded in
>> ocfs2_initialize_super().
> 
> strlcpy starts with a call to strlen(src) and this is where the read overflow
> happens. If the kernel is compiled with CONFIG_FORTIFY_SOURCE this gets
> executed instead (include/linux/fortify-string.h):
> 
> __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
> {
>         __kernel_size_t ret;
>         size_t p_size = __builtin_object_size(p, 1);
> 
>         /* Work around gcc excess stack consumption issue */
>         if (p_size == (size_t)-1 ||
>                 (__builtin_constant_p(p[p_size - 1]) && p[p_size - 1] == '\0'))
>                 return __underlying_strlen(p);
>         ret = strnlen(p, p_size);
>         if (p_size <= ret)
>                 fortify_panic(__func__);
>         return ret;
> }
> 
> So while strlcpy did work before this fortify check, it is probably not the
> best option anymore due to the missing null terminator in the source.
> 
Got it, it really triggers panic in strlen().
So could you please update the commit log? I think CONFIG_FORTIFY_SOURCE
is necessary information since it is not default enabled.
And add comments with your changes, e.g.

/*
 * ci_stack and ci_cluster in ocfs2_cluster_info may not null
 * terminated, make sure no overflow happens here.
 */

BTW, since we use kzalloc to alloc osb, so we don't have to manually
set the last null byte.

Thanks,
Joseph
