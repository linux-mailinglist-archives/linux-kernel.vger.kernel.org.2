Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4494439C3B4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 01:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhFDXJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 19:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFDXJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 19:09:46 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19709C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 16:07:50 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id d21so11315411oic.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 16:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=OB03ucavBIv1Fu1kgEzILIrohfiYiezA2Xid0FDJmDk=;
        b=HeKtaLiCGa6paPflJcTEDWoHzS6FrNqO1m/tyMIG/il/3UkirSRcdhIdMBKROLQAJr
         iyh2vXp58k6pThN6ZLrKPK7a8aioKhFv+3Q6R+iBd2S/rUI/9bg1ozNi682XrtPAmtjQ
         pK4InDy+1uObK5Oea/nx8znyGenF7ttf/X0qCtBDhsduxhbvZEFPIwJ9UOsatiB0KcGB
         azLOCYZijyxhH7VwlE0SwgG4M1Y9ZbZyFrOt/pP+6rJAyFcaON7yo4he7Akbbf/nuq2S
         tulPGYOzHd73IPXGeR1yxRoITA5oRyKTOYLx7Y129QHcfCFBHdOE2wMPDVMUgjn04NO2
         cV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=OB03ucavBIv1Fu1kgEzILIrohfiYiezA2Xid0FDJmDk=;
        b=od3y45izbmLazRWbLkVeWAI3WBhXNo+E/mgl/Ux6BtfIipnAs524fkWWzdLwsi0//Y
         aYN1BIZQWesG0NXn2ObgCShy3+bL8B5MUcc8RoRPp7CaAxTupgm/25XDfpJ5uK8ba5qg
         e1AvOXmkk3WTWGt0HFJiqnVNkSLLhaSS8T0l8wJhaWanmS276cqS629wX13ZWmcLg5Sk
         N+LJfzMhGTs8pyPmIQPg1Cl7XbcjFOHEIfsy3bZvtMeA5OrDT1hqBh99DCSQ1BNU0aFh
         LACZ13BRwDceZQ4q6fXluR8vrsgItG2ukSeyJdPuR2vKXF6qqURnFAa9y+LHciLMvDWr
         aNzQ==
X-Gm-Message-State: AOAM530bEo8XzDNFGxwFVv1TkYL6sI9Vgz7hk/FabVdrFj9JW6vAju+s
        lklJ4sbblVsa6eUvlmrNCX4AUA==
X-Google-Smtp-Source: ABdhPJwycqr3uyfkRirLbiJnEhGc0fdxusGBrAkbhpvq6AIbRai4YVZslFrHUpaMXjKSGuSSvuPQsA==
X-Received: by 2002:aca:1e0b:: with SMTP id m11mr12204212oic.45.1622848069276;
        Fri, 04 Jun 2021 16:07:49 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l9sm715795oou.43.2021.06.04.16.07.47
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 04 Jun 2021 16:07:48 -0700 (PDT)
Date:   Fri, 4 Jun 2021 16:07:46 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] mm/thp: unmap_mapping_page() to fix THP
 truncate_cleanup_page()
In-Reply-To: <20210604163933.h6dj6cgr6tudpprd@box.shutemov.name>
Message-ID: <alpine.LSU.2.11.2106041601050.14037@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils> <alpine.LSU.2.11.2106011413280.2148@eggly.anvils> <20210604163933.h6dj6cgr6tudpprd@box.shutemov.name>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021, Kirill A. Shutemov wrote:
> 
> I think adding support for THP in try_to_unmap_one() is the most
> future-proof way. We would need it there eventually.

Yes, I'd love to delete unmap_mapping_page() and use try_to_unmap(),
but couldn't easily do it.  I did cut out one paragraph which said:

"Next iteration, I would probably refactor zap_huge_pmd() so that the
same code could be used from zap_pmd_range() or try_to_unmap_one();
but that seems riskier and more trouble than this current iteration."

And I've certainly not found time to go back and try that since.

> 
> But this works too:
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thanks,
Hugh
