Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0B941BCE0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 04:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243806AbhI2Cko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 22:40:44 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:37784 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243800AbhI2Ckn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 22:40:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UpzQBf1_1632883139;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UpzQBf1_1632883139)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Sep 2021 10:39:00 +0800
Subject: Re: [PATCH] ocfs2: mount fails with buffer overflow in strlen
To:     =?UTF-8?Q?Valentin_Vidi=c4=87?= <vvidic@valentin-vidic.from.hr>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20210927154459.15976-1-vvidic@valentin-vidic.from.hr>
 <00850aed-2027-a0ab-e801-c6498a5a49f8@linux.alibaba.com>
 <20210928131450.GM28341@valentin-vidic.from.hr>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <212f878e-1bbe-347c-ba43-e4ffb9b4afbe@linux.alibaba.com>
Date:   Wed, 29 Sep 2021 10:38:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928131450.GM28341@valentin-vidic.from.hr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, you are right, strlen(src) is indeed wrong here.

But please note that in strlcpy():
if (size) {
	size_t len = (ret >= size) ? size - 1 : ret;
	memcpy(dest, src, len);
	dest[len] = '\0';
}

Take ci_stack "o2cb" for example, strlen("o2cb") may return wrong if the
coming byte is not null, say it is 10.
The input size is 5, so len will finally be 4.
So dest is still correct ending with null byte. No overflow happens.
So the problem here is the wrong return value, but it is discarded in
ocfs2_initialize_super().

Thanks,
Joseph

On 9/28/21 9:14 PM, Valentin Vidić wrote:
> On Tue, Sep 28, 2021 at 08:05:22PM +0800, Joseph Qi wrote:
>> strlcpy in ocfs2_initialize_super() is introduced 8 years ago, so I
>> don't understand why you've mentioned that the issues starts from
>> v5.11.
> 
> v5.11 introduced the overflow checks to string functions so that is
> when the mount started to fail.
> 
>> osb->osb_cluster_stack and osb->osb_cluster_name is always larger by
>> 1 than which in ocfs2_cluster_info, and the input size of strlcpy does
>> the same, so I don't see how it overflows.
> 
> strlcpy internally calls strlen on the source argument, in this case
> that is ci_stack array with size of 4. That array stores the value
> "o2cb" so the strlen continues reading into the union until it reaches
> a zero byte somewhere. The same would happen with ci_cluster if the
> cluster name is long enough.
> 
> struct ocfs2_cluster_info {
> /*00*/	__u8   ci_stack[OCFS2_STACK_LABEL_LEN];
> 	union {
> 		__le32 ci_reserved;
> 		struct {
> 			__u8 ci_stackflags;
> 			__u8 ci_reserved1;
> 			__u8 ci_reserved2;
> 			__u8 ci_reserved3;
> 		};
> 	};
> /*08*/	__u8   ci_cluster[OCFS2_CLUSTER_NAME_LEN];
> /*18*/
> };
> 
