Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F30E33D27A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbhCPLLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237094AbhCPLKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615893035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9pLs1zGEDar7rmvjegU/ndIm/ewQhz/fax5H5GVpbcM=;
        b=BLBbYo1rJ8So0ygQH6d+fDDC+Y+1PY980P8zuhy2Nl+XuvXdi2J32IEj6Qq5o6rwD50rj9
        5YdKmXKKueAkwcwkKFialFRTD9fcFiR6iG9GzC9WMVuz49RQ1ph/hHuAYdHsdynIAWqTQH
        vQL+Hx0ru2TvYqptqPR42qsa+kGLVXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-ZSPsLwjJM66mBXOm1n7TXw-1; Tue, 16 Mar 2021 07:10:31 -0400
X-MC-Unique: ZSPsLwjJM66mBXOm1n7TXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E9F0760C0;
        Tue, 16 Mar 2021 11:10:30 +0000 (UTC)
Received: from [10.36.114.203] (ovpn-114-203.ams2.redhat.com [10.36.114.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D2665C1A1;
        Tue, 16 Mar 2021 11:10:27 +0000 (UTC)
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
References: <YEzCm/Uwvw7kKpd7@linux.ibm.com>
 <22437770-956e-f7b4-a8f6-3f1cc28c3ec2@redhat.com>
 <MW3PR12MB45371072D7C3FDA6986C6318F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <YFBVNEC7jMZxwleL@linux.ibm.com>
 <MW3PR12MB453781F0AD49AF3787DE4230F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0cc972a1-5b40-3017-33f8-b2610489ee18@redhat.com>
 <MW3PR12MB453771424C9B2866BBBAE036F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <b9b324e4-4c98-b81d-ddae-52e4feb33064@redhat.com>
 <MW3PR12MB4537B6D5911092E456220818F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <9e869214-7a3b-e86d-4832-7117f7c6090f@redhat.com>
 <YFCIqLmn3u1be1yo@linux.ibm.com>
 <MW3PR12MB4537C3C6EFD9CA3A4B32084DF36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <41dc97ec-d3ab-07b1-d7e3-84dc2bced8fc@redhat.com>
Date:   Tue, 16 Mar 2021 12:10:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <MW3PR12MB4537C3C6EFD9CA3A4B32084DF36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.21 12:02, Liang, Liang (Leo) wrote:
> [AMD Public Use]
> 
> Hi David and Mike,
> 
> It's BIOS buggy. Now fixed by new BIOS. Thanks you so much! Cheers!
> 
> [    0.000034] MTRR variable ranges enabled:
> [    0.000035]   0 base 000000000000 mask FFFF80000000 write-back
> [    0.000037]   1 base 0000FFE00000 mask FFFFFFE00000 write-protect
> [    0.000039]   2 base 0000FFDE0000 mask FFFFFFFE0000 write-protect
> [    0.000040]   3 base 0000FF000000 mask FFFFFFF80000 write-protect
> [    0.000041]   4 disabled
> [    0.000042]   5 disabled
> [    0.000043]   6 disabled
> [    0.000044]   7 disabled
> [    0.000045] TOM2: 0000000280000000 aka 10240M
> 
> root@scbu-Chachani:/home/scbu# cat /proc/mtrr
> reg00: base=0x000000000 (    0MB), size= 2048MB, count=1: write-back
> reg01: base=0x0ffe00000 ( 4094MB), size=    2MB, count=1: write-protect
> reg02: base=0x0ffde0000 ( 4093MB), size=  128KB, count=1: write-protect
> reg03: base=0x0ff000000 ( 4080MB), size=  512KB, count=1: write-protect

Great :)

(another latent BUG found with 7fef431be9c9 :) )

-- 
Thanks,

David / dhildenb

