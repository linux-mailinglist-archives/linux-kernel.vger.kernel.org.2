Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A7530A8A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhBANZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:25:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231493AbhBANZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612185825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FO28Yto7go7+rO9NIvxhqqef8rH+XR+/w56sMd7KMmQ=;
        b=ELJezfFSV0+n+nX84l+UxOQcq/ekHJdZQIpZLqia0rJ48Z/gC+wNDzdRaVSGinfMAV4LF1
        2GtEjkU22bfkzF7RBeZzUGyPu5FERTVd4gFBiXOcw6AGUAN53hOc8At88dU0y9Qf78QPlM
        3asyr5/UeD7io2IQB12c4k60ZFATvn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-i1ELzcegNYKVRo7oijAh3w-1; Mon, 01 Feb 2021 08:23:42 -0500
X-MC-Unique: i1ELzcegNYKVRo7oijAh3w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0BD99CC01;
        Mon,  1 Feb 2021 13:23:38 +0000 (UTC)
Received: from [10.36.115.24] (ovpn-115-24.ams2.redhat.com [10.36.115.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6221E10016DB;
        Mon,  1 Feb 2021 13:23:34 +0000 (UTC)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v2 3/3] vsprintf: dump full information of page flags in
 pGp
Message-ID: <66784ea1-29c7-6bed-ca7f-cd3e7ea9155b@redhat.com>
Date:   Mon, 1 Feb 2021 14:23:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210201115610.87808-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.21 12:56, Yafang Shao wrote:
> Currently the pGp only shows the names of page flags, rather than
> the full information including section, node, zone, last cpupid and
> kasan tag. While it is not easy to parse these information manually
> because there're so many flavors. Let's interpret them in pGp as well.
> 
> - Before the patch,
> [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> 
> - After the patch,
> [ 6871.296131] Slab 0x00000000c0e19a37 objects=33 used=3 fp=0x00000000c4902159 flags=0x17ffffc0010200(Node 0,Zone 2,Lastcpupid 0x1fffff,slab|head)

For debugging purposes, it might be helpful to have the actual zone name 
(and to know if the value is sane). You could obtain it (without other 
modifications) via

const char zname = "Invalid";

if (zone < MAX_NR_ZONES)
	zname = first_online_pgdat()->node_zones[zone].name;


Similarly, it might also be helpful to indicate if a node is 
online/offline/invalid/.

const char nstate = "Invalid";

if (node_online(nid))
	nstate = "Online";
else if (node_possible(nid))
	nstate = "Offline";


Printing that in addition to the raw value could be helpful. Just some 
thoughts.

-- 
Thanks,

David / dhildenb

