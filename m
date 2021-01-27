Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0943A305644
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 09:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhA0I6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 03:58:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37568 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232902AbhA0Iv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611737401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZKX1UCx3ZNXEFtloLyNV1dAqkIOruWYHKq9kXw8w0Wk=;
        b=Ctw5qBFgb4TQg+qkWxI4F/XefGPJD8WOp7sauKJOp0xBFTR81GyK/G1eJ8mt9TS8ox4myk
        APQbTDypbLPJe4fXpGuD7RX2+bv+mNVHe5xELj7oobKkdb3g35Nffem9r0iXscKOOhbJMV
        F5ZoAeDiCvlMNyofjI1XLIeaLxPMDTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-PdZiYRXNML-Ra9KKEtWSEQ-1; Wed, 27 Jan 2021 03:49:57 -0500
X-MC-Unique: PdZiYRXNML-Ra9KKEtWSEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A2C6802B40;
        Wed, 27 Jan 2021 08:49:56 +0000 (UTC)
Received: from [10.36.114.237] (ovpn-114-237.ams2.redhat.com [10.36.114.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56F2260C05;
        Wed, 27 Jan 2021 08:49:53 +0000 (UTC)
Subject: Re: [PATCH v1] csky: use free_initmem_default() in free_initmem()
To:     Guo Ren <guoren@kernel.org>, Mike Rapoport <rppt@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-csky@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20210126181420.19223-1-david@redhat.com>
 <20210126182648.GR6332@kernel.org>
 <CAJF2gTRsqZ4DTvZm2V9VRKP_f6u-p5aupCjrvuGy_7m8tiQQVQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <fb51bf47-a6ab-1a5a-60cf-0ec375a9511a@redhat.com>
Date:   Wed, 27 Jan 2021 09:49:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAJF2gTRsqZ4DTvZm2V9VRKP_f6u-p5aupCjrvuGy_7m8tiQQVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.21 08:52, Guo Ren wrote:
> Thx Mike,
> 

Thanks for triggering a build/test! I'd be curious if there is an easy 
way to trigger this myself (I assume, fork csky buildroot on gitlab, 
reroute CSKY kernel repo, adjust CSKY_LINUX_NEXT_VERSION); if so, it 
would be worth documenting - thanks!

Thanks Mike for the valuable links :) For now I was only relying on 
cross-compilers as shipped by Fedora, now I can upgrade my cross-build 
environment :)

> It's under test:
> https://gitlab.com/c-sky/buildroot/-/pipelines/247353584
> 
> kernel:
> https://github.com/c-sky/csky-linux/commit/9d986b01feb991ded3fb8c1f8153a0c80ea84b9c
> 


-- 
Thanks,

David / dhildenb

