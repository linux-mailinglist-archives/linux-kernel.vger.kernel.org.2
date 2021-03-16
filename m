Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704EF33D02C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbhCPIyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30697 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235866AbhCPIyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615884860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWL8TXDgSITEncLOH2wDWqKpeFdlpFDWceFXFRX5TOQ=;
        b=d9zXSe5MUFAtdvKiS17yM2ukn/inISpbfawx/P9Dd7gvv+qH8tYAi94ol7jbBVON6nf0N1
        Z0DjyoQcAc01GTLwFvc5d20GKX/xL6eENULaYkh88pwT1q0iXfO/+Axex7ZP+DprAO/fke
        iYLGuMaBInnLmxZva6U3thyPN2sqCg8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-qUXa6Pn7PayX9LbBOCiMZA-1; Tue, 16 Mar 2021 04:54:16 -0400
X-MC-Unique: qUXa6Pn7PayX9LbBOCiMZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05C48801597;
        Tue, 16 Mar 2021 08:54:15 +0000 (UTC)
Received: from [10.36.114.203] (ovpn-114-203.ams2.redhat.com [10.36.114.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69C1F60C0F;
        Tue, 16 Mar 2021 08:54:12 +0000 (UTC)
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
 <0cc972a1-5b40-3017-33f8-b2610489ee18@redhat.com>
 <MW3PR12MB453771424C9B2866BBBAE036F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b9b324e4-4c98-b81d-ddae-52e4feb33064@redhat.com>
Date:   Tue, 16 Mar 2021 09:54:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <MW3PR12MB453771424C9B2866BBBAE036F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.21 09:43, Liang, Liang (Leo) wrote:
> [AMD Public Use]
> 
> Hi David,
> 
> Thanks for your explanation. We saw slow boot issue on our farm/QA's machines and mine. All of machines are same SoC/board.

I cannot spot anything really special in the logs -- it's just ordinary 
system ram -- except:

[    0.000027] MTRR fixed ranges enabled:
[    0.000028]   00000-9FFFF write-back
[    0.000029]   A0000-BFFFF uncachable
[    0.000030]   C0000-FFFFF write-through
[    0.000031] MTRR variable ranges enabled:
[    0.000032]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000034]   1 base 0000FFE00000 mask FFFFFFE00000 write-protect
[    0.000035]   2 base 000100000000 mask FFFFFF000000 write-protect
[    0.000036]   3 base 0000FFDE0000 mask FFFFFFFE0000 write-protect
[    0.000038]   4 base 0000FF000000 mask FFFFFFF80000 write-protect
[    0.000039]   5 disabled
[    0.000039]   6 disabled
[    0.000040]   7 disabled

Not sure if "2 base 000100000000" indicates something nasty. Not sure 
how to interpret the masks.

Can you provide the output of "cat /proc/mtrr" ?

-- 
Thanks,

David / dhildenb

