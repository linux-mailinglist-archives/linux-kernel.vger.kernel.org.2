Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF64139F4CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhFHLUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231609AbhFHLUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623151140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CBLtrFhiRKeFc7Q7qn/8AZzS8tEb5Usg8INInZ6WYCs=;
        b=NCgNublPpUc65Nv9VMJ1ZXh7G8ulTDOg+GeMHxs5AdLA5wdvFcVbC1riX+BPiVNsB1FrsM
        bnC+0xwjq5QRyorxATrmLJeJ+9atPcJONYGUkeK4ty51NCsaD10GHwoNsQYLa0rZLMLaHb
        stXbO8E4RkU/aCKdNnYhnSeQhE4W4a0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-u6Ex2_oLOwyXGw60vwaqLQ-1; Tue, 08 Jun 2021 07:18:58 -0400
X-MC-Unique: u6Ex2_oLOwyXGw60vwaqLQ-1
Received: by mail-wr1-f72.google.com with SMTP id z13-20020adfec8d0000b0290114cc6b21c4so9244175wrn.22
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 04:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CBLtrFhiRKeFc7Q7qn/8AZzS8tEb5Usg8INInZ6WYCs=;
        b=orQuQSJCbB/ub6KNdm/hH+TE3mPx1RBtce9/fDMoWye/vtl2vWGMaDSOqVAGxCpqcO
         ZmxajrafoLfcrjKMaxKaq4r1o085+KNOKSUcxCh9gsOj7uQTH5dL/UVzQtY+vCWaFkkK
         I6PEJwq6iNDS/Z5tFxuOMfdXOsBFHLtZU/urCBvfrKWNUTnFTdXvrkidqq5Bm7O4T945
         6kF1/RTemH5sRNDmsqL0ACvCZCDbFfAfSGXlBtbF2feVX7H3IpgXmVDW0KA4KQ/2dYZw
         5MMdkJ/bHb19M0ynoEcTNwRkyZyF7ipFjEpLlTzwOG1/ZRltcd9Bpk0MY3x0RD+EPdW2
         wdHQ==
X-Gm-Message-State: AOAM532kqFl5UU2vYALFyxPKBLGy16Yvs9D+Ie8J7GHAtv0McBWBKvov
        /Vs6OSCSOyo0k8m9q6D6JBZ64x7Gz3dXn8sOqfA2/BkZwO0s7gn85n4Lpuopg3pBGsPvUy9mcZB
        qdwZUCzATXz8+vzQKaE2ahtDU
X-Received: by 2002:adf:df86:: with SMTP id z6mr22061245wrl.255.1623151137784;
        Tue, 08 Jun 2021 04:18:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrB9z1bqXKLNgH1xZgLenFDxAm/18wrzcUUIce09tn+BporQC3UeSbXcvGrkz4TceLSHiMMw==
X-Received: by 2002:adf:df86:: with SMTP id z6mr22061199wrl.255.1623151137577;
        Tue, 08 Jun 2021 04:18:57 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c61cf.dip0.t-ipconnect.de. [91.12.97.207])
        by smtp.gmail.com with ESMTPSA id u2sm19236473wrn.38.2021.06.08.04.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 04:18:57 -0700 (PDT)
Subject: Re: [PATCH v1 05/12] mm/memory_hotplug: remove nid parameter from
 remove_memory() and friends
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        Hui Zhu <teawater@gmail.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev
References: <20210607195430.48228-1-david@redhat.com>
 <20210607195430.48228-6-david@redhat.com> <87y2bkehky.fsf@mpe.ellerman.id.au>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7463b3ed-07d3-7157-629d-a85a3ff558d6@redhat.com>
Date:   Tue, 8 Jun 2021 13:18:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87y2bkehky.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.06.21 13:11, Michael Ellerman wrote:
> David Hildenbrand <david@redhat.com> writes:
>> There is only a single user remaining. We can simply try to offline all
>> online nodes - which is fast, because we usually span pages and can skip
>> such nodes right away.
> 
> That makes me slightly nervous, because our big powerpc boxes tend to
> trip on these scaling issues before others.
> 
> But the spanned pages check is just:
> 
> void try_offline_node(int nid)
> {
> 	pg_data_t *pgdat = NODE_DATA(nid);
>          ...
> 	if (pgdat->node_spanned_pages)
> 		return;
> 
> So I guess that's pretty cheap, and it's only O(nodes), which should
> never get that big.

Exactly. And if it does turn out to be a problem, we can walk all memory 
blocks before removing them, collecting the nid(s).

-- 
Thanks,

David / dhildenb

