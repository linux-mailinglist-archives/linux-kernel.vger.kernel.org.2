Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94553A68C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhFNOQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbhFNOQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:16:14 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F5DC061766
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 07:14:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E8C422B4;
        Mon, 14 Jun 2021 14:14:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E8C422B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1623680051; bh=84hiFI19DiptVMLMg3BpxaUs+Oe9dUr6GlBqtCGKFTs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bcQ3XuhS504Do2ASrtbD8mymWytRAK0Al9Jnm/o8QPH4i5eraEXv1eid0rTGDkfGO
         0BBiS5oaDdvW2QIHhYHwqL1pXcxSYwjAibjvBf4VAnlVjO4e+N3ukasXYyTUHjZSzq
         cVOtE+S2v4CW+YrCeuvKDl8p+IdYH6ijn21vz865mFg76Ad6aJWPVbpZzX/m8qWwaf
         MeE0FDesfknHzQzAPmD2LzF0t+ZDRK9El7qsJaXatzMMiW6U5PiIV6lu/JBrP5zSok
         lFqXNPzlfleepmjpVUW4BXi5PC2u8GfkOJl/uxVfdYfdpDirJLhQJJSXGI+rtHU7oU
         NJ5RpLiACcrhg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v3 0/2] memory-hotplug.rst: complete admin-guide overhaul
In-Reply-To: <d517106f-64ba-5d3a-59f5-c87d5e032bdc@redhat.com>
References: <20210609075752.4596-1-david@redhat.com>
 <87y2bd9wse.fsf@meer.lwn.net>
 <d517106f-64ba-5d3a-59f5-c87d5e032bdc@redhat.com>
Date:   Mon, 14 Jun 2021 08:14:10 -0600
Message-ID: <87fsxka5zh.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> Essentially against Andrew's mmotm, which already contains v1. Note 
> mmotm was chosen due to a conflict in:
>
> https://lkml.kernel.org/r/20210510030027.56044-1-songmuchun@bytedance.com
>
> I'd suggest we take this via Andrew's tree, unless you have other 
> preference on how to handle the conflict. Thanks!

That's fine with me - one less thing for me to deal with :)

Thanks,

jon
