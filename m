Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E0833D005
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhCPIiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:38:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235132AbhCPIh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615883876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwYMPkghKSi78ypCL3Mf4zRzURyEmjf0Bxk8gD4fMyM=;
        b=UP2wiaffZWgXvJU7ilXb621t3o8+I9UTs1io3bn23CdB1nhd0DjhRTmlQQVI72X4rtKPzf
        kulg4ZS02cQa7FQaqXWem8KcVtDM6DootFkxekG1vN+YAxKn1HY8CTL/RavP+TU0UkVUAi
        lSt+j/kS+6DwSgtuHNjW1G1VRR1bhVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-dlWIF-f9MoiE1W-ClZevFw-1; Tue, 16 Mar 2021 04:37:52 -0400
X-MC-Unique: dlWIF-f9MoiE1W-ClZevFw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E845192D78C;
        Tue, 16 Mar 2021 08:37:51 +0000 (UTC)
Received: from [10.36.114.203] (ovpn-114-203.ams2.redhat.com [10.36.114.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E63460C13;
        Tue, 16 Mar 2021 08:37:48 +0000 (UTC)
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
To:     "Liang, Liang (Leo)" <Liang.Liang@amd.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>
References: <MW3PR12MB4537B49678884A1EB1F75AB5F36E9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0AE49D98-171A-42B9-9CFC-9193A9BD3346@redhat.com>
 <YEzCm/Uwvw7kKpd7@linux.ibm.com>
 <22437770-956e-f7b4-a8f6-3f1cc28c3ec2@redhat.com>
 <MW3PR12MB45371072D7C3FDA6986C6318F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <YFBVNEC7jMZxwleL@linux.ibm.com>
 <MW3PR12MB453781F0AD49AF3787DE4230F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0cc972a1-5b40-3017-33f8-b2610489ee18@redhat.com>
Date:   Tue, 16 Mar 2021 09:37:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <MW3PR12MB453781F0AD49AF3787DE4230F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.21 09:00, Liang, Liang (Leo) wrote:
> [AMD Public Use]
> 
> Hi Mike,
> 
> Thanks for help. The patch works for me and boot time back to normal. So it's a fix, or just WA?

Hi Leo,

excluding up to 16 MiB of memory on every system just because that 
single platform is weird is not acceptable.

I think we have to figure out

a) why that memory is so special. This is weird.
b) why the platform doesn't indicate it in a special way. Why is it 
ordinary system RAM but still *that* slow?
c) how we can reliably identify such memory and exclude it.

I'll have a peek at the memory layout of that machine from boot logs 
next to figure out if we can answer any of these questions.

Just to verify: this does happen on multiple machines, not just a single 
one? (i.e., we're not dealing with faulty RAM)

-- 
Thanks,

David / dhildenb

