Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEC34361C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhJUMhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231572AbhJUMhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634819736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pcCL6CdZH83Z0UE+ms2Bf+J5zETTW6d5Cs7+RZXJ0w4=;
        b=AoeuQgYKUSMMUCs18ZoNEkrKxAnOakWV2eMCYfurdOesoi0oOs9YZGzAzfXWVYtTOYJTFX
        GrD2WYJ4IqPgJydIYaqBqSRKb3FmIzYN054R0+yfMtSKGqi8T6lvyt0jUZt1N8iYkfyRhC
        TthX23xXBEx/hHoLYcXUEreLaLD79i0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79--fRdbLHJPVODx_uVChRbBA-1; Thu, 21 Oct 2021 08:35:35 -0400
X-MC-Unique: -fRdbLHJPVODx_uVChRbBA-1
Received: by mail-wm1-f72.google.com with SMTP id k20-20020a7bc414000000b0030dcd454771so259109wmi.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=pcCL6CdZH83Z0UE+ms2Bf+J5zETTW6d5Cs7+RZXJ0w4=;
        b=eMR/wPxbOnOAijRmLGv3abBtpu0132mygZXBFTra/97HKUHIr+6gJL6o869nw5KZu9
         zvVSLDaQOkrdfANaEK7Tv63RM5/bCFTyxT4O7WzDS71QVi3U/JfTe6k+d8dkZpxaUOov
         4lzovzqKS3kf+HsJvctvAPiBtXv9Nxi0+FVRlVGtVQrlAddyDu2gEPhPx1GTRHVYFUA5
         LrW7/awaldl2TWaeFzzATqKOZ5Y6P3I29atN3/kdwdVXTaP1OEr5yC1s3dMTCeRM56K8
         udHFyo8PZ/jFTWNcKQ+t0n4eSfWEUqdVyIaY30bXFRZpwkfiENpx/aTLEZoUrfzo8osh
         Fekw==
X-Gm-Message-State: AOAM533mnXwuE7KFKkTn8zw8wWiOJfLfc9L4OGPcoZVGAfGunq6fNYqR
        OjbyiyjWYa5PnoPkF0jMu1OC/2lDBaqjkgs7LhGgMV2JhhJWJMY7LJmJ5wrao1IDI/w200yTTLg
        gxb5FYq8SZlZOVNQg8L0V0hDN
X-Received: by 2002:a5d:598a:: with SMTP id n10mr6855146wri.93.1634819734168;
        Thu, 21 Oct 2021 05:35:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygTB13YIzbisqOQrzKIUBIvuJx4J8sCISPd+GfQ3nZfE1HhayO8oEr5WMTr4X9Cpc4e9kMVQ==
X-Received: by 2002:a5d:598a:: with SMTP id n10mr6855104wri.93.1634819733890;
        Thu, 21 Oct 2021 05:35:33 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23aba.dip0.t-ipconnect.de. [79.242.58.186])
        by smtp.gmail.com with ESMTPSA id x7sm4732213wrq.69.2021.10.21.05.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 05:35:33 -0700 (PDT)
Message-ID: <2fc2c5da-c0e9-b954-ba48-e258b88e3271@redhat.com>
Date:   Thu, 21 Oct 2021 14:35:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
References: <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org> <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <996b3ac4-1536-2152-f947-aad6074b046a@redhat.com>
 <YXBRPSjPUYnoQU+M@casper.infradead.org>
 <436a9f9c-d5af-7d12-b7d2-568e45ffe0a0@redhat.com>
 <YXEOCIWKEcUOvVtv@infradead.org>
 <f31af20e-245d-a8f1-49fa-e368de9fa95c@redhat.com>
 <YXFXGeYlGFsuHz/T@moria.home.lan>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
In-Reply-To: <YXFXGeYlGFsuHz/T@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.21 14:03, Kent Overstreet wrote:
> On Thu, Oct 21, 2021 at 09:21:17AM +0200, David Hildenbrand wrote:
>> On 21.10.21 08:51, Christoph Hellwig wrote:
>>> FYI, with my block and direct I/O developer hat on I really, really
>>> want to have the folio for both file and anon pages.  Because to make
>>> the get_user_pages path a _lot_ more efficient it should store folios.
>>> And to make that work I need them to work for file and anon pages
>>> because for get_user_pages and related code they are treated exactly
>>> the same.
> 
> ++
> 
>> Thanks, I can understand that. And IMHO that would be even possible with
>> split types; the function prototype will simply have to look a little
>> more fancy instead of replacing "struct page" by "struct folio". :)
> 
> Possible yes, but might it be a little premature to split them?

Personally, I think it's the right thing to do to introduce something
limited like "struct filemap" (again, bad name, i.e., folio restricted
to the filemap API) first and avoid introducing a generic folio thingy.

So I'd even consider going with folios all the way premature. But I
assume what to consider premature and what not depends on the point of
view already. And maybe that's the biggest point where we all disagree.

Anyhow, what I don't quite understand is the following: as the first
important goal, we want to improve the filemap API; that's a noble goal
and I highly appreciate Willy's work. To improve the API, there is
absolutely no need introduce generic folio. Yet we argue about whether
generic folio vs. filemap specific folio seems to be the right thing to
do as a first step.

My opinion after all the discussions: use a dedicate type with a clear
name to solve the immediate filemap API issue. Leave the remainder alone
for now. Less code to touch, less subsystems to involve (well, still a
lot), less people to upset, less discussions to have, faster review,
faster upstream, faster progress. A small but reasonable step.

But maybe I'm just living in a dream world :)

-- 
Thanks,

David / dhildenb

