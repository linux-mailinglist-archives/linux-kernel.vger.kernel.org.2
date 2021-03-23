Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A57A346A60
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 21:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhCWUmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 16:42:43 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:11634 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbhCWUma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:42:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 77B923F8A2;
        Tue, 23 Mar 2021 21:42:24 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=sPJS18NN;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LggnGvMgF1Sj; Tue, 23 Mar 2021 21:42:23 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 175623F700;
        Tue, 23 Mar 2021 21:42:21 +0100 (CET)
Received: from [192.168.0.209] (unknown [192.198.151.43])
        by mail1.shipmail.org (Postfix) with ESMTPSA id D723836062E;
        Tue, 23 Mar 2021 21:42:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616532141; bh=iPJ77EGHgOIrO9GhucTb28ntff/+vJnaRdy9R+OY4lo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sPJS18NN29rFWkVlri0remQJEnGvAMc5uNaAzOG+2DZyFbsbL6HT+f7bKV/53yxK4
         WnheLIuBVVbHA0XdXpkcfyDzrml2Z5u1SRDpR8+LtCmOWIm3FfzrkjBRAo2JodoDPC
         6eScF9gFQYOGN4xc1NDIGF120IZ74jlJsnN5mh2M=
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-2-thomas_os@shipmail.org>
 <ec99146c7abc35d16b245816aba3e9d14862e624.camel@intel.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <c2239da2-c514-2c88-c671-918909cdba6b@shipmail.org>
Date:   Tue, 23 Mar 2021 21:42:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ec99146c7abc35d16b245816aba3e9d14862e624.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/21 8:52 PM, Williams, Dan J wrote:
> On Sun, 2021-03-21 at 19:45 +0100, Thomas Hellström (Intel) wrote:
>> TTM sets up huge page-table-entries both to system- and device
>> memory,
>> and we don't want gup to assume there are always valid backing struct
>> pages for these. For PTEs this is handled by setting the pte_special
>> bit,
>> but for the huge PUDs and PMDs, we have neither pmd_special nor
>> pud_special. Normally, huge TTM entries are identified by looking at
>> vma_is_special_huge(), but fast gup can't do that, so as an
>> alternative
>> define _devmap entries for which there are no backing dev_pagemap as
>> special, update documentation and make huge TTM entries _devmap,
>> after
>> verifying that there is no backing dev_pagemap.
> Please do not abuse p{m,u}d_devmap like this. I'm in the process of
> removing get_devpagemap() from the gup-fast path [1]. Instead there
> should be space for p{m,u}d_special in the page table entries (at least
> for x86-64). So the fix is to remove that old assumption that huge
> pages can never be special.
>
> [1]:
> http://lore.kernel.org/r/161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com
>
Hmm, yes with that patch it will obviously not work as intended.

Given that, I think we'll need to disable the TTM huge pages for now 
until we can sort out and agree on using a page table entry bit.

Thanks,

/Thomas


