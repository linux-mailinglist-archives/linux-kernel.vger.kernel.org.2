Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61AA30A8BA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhBAN3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:29:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232142AbhBAN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612186031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Ni6ON1DaumUn4NQGvN11aguziI9BM6ZdjEMulkoRks=;
        b=hCbD7Dgq7yk4c6bb/7iwb6hViYdbnq94EBZirwu1pB+zG/Qz7Bj8HlKPqHxiyZ5cFV+O42
        2tAJN3XP1+r0Vbu1z5I39Xe/GVdr29AnQbMqUjcfNgsuPmw8nmrpMo7tZOaiHr4tp8wxEb
        b3y2tntx2wPTrOUJFhEM/QhzA8OWAiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-QDv8UcN_Psads-gDO9OXaA-1; Mon, 01 Feb 2021 08:27:07 -0500
X-MC-Unique: QDv8UcN_Psads-gDO9OXaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4258859;
        Mon,  1 Feb 2021 13:27:06 +0000 (UTC)
Received: from [10.36.115.24] (ovpn-115-24.ams2.redhat.com [10.36.115.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A0A310016FB;
        Mon,  1 Feb 2021 13:27:03 +0000 (UTC)
Subject: Re: [PATCH v1 1/2] drivers/base/memory: don't store phys_device in
 memory blocks
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
References: <20210201105158.6393-2-david@redhat.com>
 <202102012056.KCZmZLEr-lkp@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <616070a6-fcd6-f16d-cbf6-68b8b2a8f5aa@redhat.com>
Date:   Mon, 1 Feb 2021 14:27:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <202102012056.KCZmZLEr-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> All warnings (new ones prefixed by >>):
> 
>     drivers/base/memory.c: In function 'init_memory_block':
>>> drivers/base/memory.c:573:16: warning: variable 'start_pfn' set but not used [-Wunused-but-set-variable]
>       573 |  unsigned long start_pfn;
>           |                ^~~~~~~~~

Indeed, we no longer need start_pfn in init_memory_block().

-- 
Thanks,

David / dhildenb

