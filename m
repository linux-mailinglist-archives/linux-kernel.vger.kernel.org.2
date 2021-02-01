Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4579730A8CE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhBANeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:34:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhBANdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612186347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5KNMdkH+v6Gcyhmh6MX5JD5WTgQep8ALNRpHlvtT0Q=;
        b=MLopFCV30ur2GnmmVM7A8ZBP5aeB6dWAefcKmJ38xBRTEooIanIxdFxIW99g6MD9BSjz7O
        UpV17/WNBpst2JJqdUxA2GgvFALMmKd8SfwfqpHaWCE4i4nu7+OYA6Jj3cUvtPjqjqIS7W
        8iaUjDisOObOiVPX43Y4KdglnRuykOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-lbne02fTM9CdQQCu0G93gQ-1; Mon, 01 Feb 2021 08:32:23 -0500
X-MC-Unique: lbne02fTM9CdQQCu0G93gQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68338B811D;
        Mon,  1 Feb 2021 13:32:20 +0000 (UTC)
Received: from [10.36.115.24] (ovpn-115-24.ams2.redhat.com [10.36.115.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E05B55DA33;
        Mon,  1 Feb 2021 13:32:14 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] vsprintf: dump full information of page flags in
 pGp
From:   David Hildenbrand <david@redhat.com>
To:     Yafang Shao <laoar.shao@gmail.com>,
        andriy.shevchenko@linux.intel.com, vbabka@suse.cz,
        linmiaohe@huawei.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
References: <20210201115610.87808-1-laoar.shao@gmail.com>
 <20210201115610.87808-4-laoar.shao@gmail.com>
 <66784ea1-29c7-6bed-ca7f-cd3e7ea9155b@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a9790427-1028-6acc-18e6-aafc1a5eb29d@redhat.com>
Date:   Mon, 1 Feb 2021 14:32:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <66784ea1-29c7-6bed-ca7f-cd3e7ea9155b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.21 14:23, David Hildenbrand wrote:
> On 01.02.21 12:56, Yafang Shao wrote:
>> Currently the pGp only shows the names of page flags, rather than
>> the full information including section, node, zone, last cpupid and
>> kasan tag. While it is not easy to parse these information manually
>> because there're so many flavors. Let's interpret them in pGp as well.
>>
>> - Before the patch,
>> [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
>>
>> - After the patch,
>> [ 6871.296131] Slab 0x00000000c0e19a37 objects=33 used=3 fp=0x00000000c4902159 flags=0x17ffffc0010200(Node 0,Zone 2,Lastcpupid 0x1fffff,slab|head)
> 
> For debugging purposes, it might be helpful to have the actual zone name
> (and to know if the value is sane). You could obtain it (without other
> modifications) via
> 
> const char zname = "Invalid";
> 
> if (zone < MAX_NR_ZONES)
> 	zname = first_online_pgdat()->node_zones[zone].name;
> 
> 
> Similarly, it might also be helpful to indicate if a node is
> online/offline/invalid/.
> 
> const char nstate = "Invalid";
> 
> if (node_online(nid))
> 	nstate = "Online";
> else if (node_possible(nid))
> 	nstate = "Offline";

Just remembering that we have to take care of nid limits:

if (nid >= 0 && nid < MAX_NUMNODES) {
	if (node_online(nid))
		nstate = "Online";
	else if (node_possible(nid))
		nstate = "Offline";
}

-- 
Thanks,

David / dhildenb

