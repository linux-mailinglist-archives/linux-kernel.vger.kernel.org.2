Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91306316140
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhBJIki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:40:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229940AbhBJIgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612946121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYx5QDeee+NlLS2PNW9UB9LPhcyb8m+LMnAIKiIuGCg=;
        b=AXCKvowiwEJK1XcxVydfeDjINe1X1Pa2UlwxNc+BZNsLalQ9KKQIPSU2M9TXMT7jo9nrNe
        rFj7l9OSOFE5VabKxVvO1fntdQTjh+GovYUCbZfVeVNnkHhhfa0I+c7jNkQTq5fGEC0+AN
        H/c0qKWTtx+BqMO9VUabXhUM+WIXvOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-6Xo7U8PnPd27ReM2N1qCPA-1; Wed, 10 Feb 2021 03:35:17 -0500
X-MC-Unique: 6Xo7U8PnPd27ReM2N1qCPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5A8A107ACE3;
        Wed, 10 Feb 2021 08:35:15 +0000 (UTC)
Received: from [10.36.113.218] (ovpn-113-218.ams2.redhat.com [10.36.113.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2479C5D749;
        Wed, 10 Feb 2021 08:35:13 +0000 (UTC)
Subject: Re: [PATCH] mm/hugetlb: use some helper functions to cleanup code
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210210065346.21958-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4bb381fc-eae5-effd-214d-8d62e66da272@redhat.com>
Date:   Wed, 10 Feb 2021 09:35:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210210065346.21958-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.02.21 07:53, Miaohe Lin wrote:
> We could use pages_per_huge_page to get the number of pages per hugepage,
> use get_hstate_idx to calculate hstate index, and use hstate_is_gigantic
> to check if a hstate is gigantic to make code more succinct.
> 

Another suggestion, please collect and group your cleanups for a 
subsystem and send them in a single cleanup patch series where possible. 
Again, makes life easier for reviewers and maintainers.

Thanks!


-- 
Thanks,

David / dhildenb

