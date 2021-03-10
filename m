Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3195633462D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhCJSAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 13:00:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234040AbhCJSAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615399209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jMUG/MYMBAlLtck7raTA6W9NoAqKNam72W1I4W+SUDA=;
        b=VLLlZtRE2yA2uFJbFhbJG6ttJqaYEGsLUvZsDl8lHZAGiywH/6/bbCmM89MVuaR/ovOXxs
        NB4mCS0sls5vm5GFOpumdp3n18+802MYD/NPVuhgFErDodv/G/5REsy2OuN9bI63ntAOl2
        1ks45VtPoZCm+sFK9uVosLeve6Yz/Q8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-ezZB1u16O1iv4YgJisAxVg-1; Wed, 10 Mar 2021 13:00:05 -0500
X-MC-Unique: ezZB1u16O1iv4YgJisAxVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 472AE802B5B;
        Wed, 10 Mar 2021 18:00:03 +0000 (UTC)
Received: from [10.36.112.107] (ovpn-112-107.ams2.redhat.com [10.36.112.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1510560C13;
        Wed, 10 Mar 2021 17:59:55 +0000 (UTC)
Subject: Re: [PATCH v3 0/2] x86/setup: consolidate early memory reservations
To:     Mike Rapoport <rppt@kernel.org>, x86@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210302100406.22059-1-rppt@kernel.org>
 <YEkHQ4PnxJkqJeoU@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ee92d29d-9593-4d9b-443b-10acee6dc400@redhat.com>
Date:   Wed, 10 Mar 2021 18:59:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEkHQ4PnxJkqJeoU@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.21 18:52, Mike Rapoport wrote:
> Any comments on these?
> 

Take my

Acked-by: David Hildenbrand <david@redhat.com>

it looks sane to me ... but not sure what it's worth in that x86-64 code :)

-- 
Thanks,

David / dhildenb

