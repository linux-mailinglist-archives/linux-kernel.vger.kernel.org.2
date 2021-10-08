Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1FE426B02
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242005AbhJHMkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:40:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54704 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241727AbhJHMkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:40:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D1F82012F;
        Fri,  8 Oct 2021 12:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633696696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gq+hip/cz9+KCMolU9vZOYoItZXwsILEnNojNwcDp8k=;
        b=uW3JT+Khkp3ErXS1Gq2aBdPYB9JfAHAk6xGe1WjOAb51bvrciH7OuwSG/bu5LoOviykZS9
        zpbZQT1YEvyN+IBtkpvfaFKkJadolxIFIqosfgz/Tzv2wF9TRzIq4aNR72dc7Qy+/mb4z7
        SgEIqT+4QxUwctL8aRcV1KIsOIZBAig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633696696;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gq+hip/cz9+KCMolU9vZOYoItZXwsILEnNojNwcDp8k=;
        b=3kPX6+yvOVMNHdLxsRtMTm0vlsmARA0BjJLTC+OvCMjwJJwfa63rwX/pvfQEX81S//okpj
        fLiKbsbXm0e6KIDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A56E13ECA;
        Fri,  8 Oct 2021 12:38:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B5LRBbg7YGHTVgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 08 Oct 2021 12:38:16 +0000
Message-ID: <8f30837b-5186-e836-21bc-9964456400c1@suse.cz>
Date:   Fri, 8 Oct 2021 14:38:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mm: Free per cpu pages async to shorten program exit time
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, ultrachin@163.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     brookxu.cn@gmail.com, chen xiaoguang <xiaoggchen@tencent.com>,
        zeng jingxiang <linuszeng@tencent.com>,
        lu yihui <yihuilu@tencent.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20211008063933.331989-1-ultrachin@163.com>
 <d71e6021-777b-3ca9-b08f-64fe7ff51e08@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <d71e6021-777b-3ca9-b08f-64fe7ff51e08@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/21 10:17, David Hildenbrand wrote:
> On 08.10.21 08:39, ultrachin@163.com wrote:
>> From: chen xiaoguang <xiaoggchen@tencent.com>
>>
>> The exit time is long when program allocated big memory and
>> the most time consuming part is free memory which takes 99.9%
>> of the total exit time. By using async free we can save 25% of
>> exit time.
>>
>> Signed-off-by: chen xiaoguang <xiaoggchen@tencent.com>
>> Signed-off-by: zeng jingxiang <linuszeng@tencent.com>
>> Signed-off-by: lu yihui <yihuilu@tencent.com>
> 
> I recently discussed with Claudio if it would be possible to tear down the
> process MM deferred, because for some use cases (secure/encrypted
> virtualization, very large mmaps) tearing down the page tables is already
> the much more expensive operation.

OK, but what exactly is the benefit here? The cpu time will have to be spent
in any case, but we move it to a context that's not accounted to the exiting
process. Is that good? Also if it's a large process and restarts
immediately, allocating all the memory back again, it might not be available
as it's still being freed in the background, leading to a risk of OOM?

> There is mmdrop_async(), and I wondered if one could reuse that concept when
> tearing down a process -- I didn't look into feasibility, however, so it's
> just some very rough idea.
> 
