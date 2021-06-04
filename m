Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2274F39C305
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhFDVzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:55:17 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:46804 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDVzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:55:16 -0400
Received: by mail-qk1-f176.google.com with SMTP id 76so10796171qkn.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=5ALgaqHb4Ps4FEwMFfNaWGSDMjcH3JF+dL8YdWEXIPU=;
        b=hwbq82k9vMgWFKloVlJ2XlYpNE6rWAmJsCAvCH1RcWEFw1WWNXtuikZXcPE4SzmqXw
         RqkKYab5vj6MNgQoLiUWDhJLjnj1C3ZcWIPXDdBytN+3zTtFjp7JRK1+RgQX7+hRXz9O
         RThWudmiBRFZUvFzZqZfSCsE9Gs06Z9EOqRfahuqGxCEqF7KuWt6slPLsvIga7KxRdMW
         JPOk37kTve0uV88/+36KtMnNHoGqRfddzQBEGUTSnjQvU6/M8BFUdX+jIzWJbKeppH+7
         grmIJJu3TQDh0hQmrTpomqz4mgdGr7LWktmw5X6GkhXEdikSuoZ3jFi34e0A6NZ2z8ET
         C7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=5ALgaqHb4Ps4FEwMFfNaWGSDMjcH3JF+dL8YdWEXIPU=;
        b=o500axQlnw/7lAkHmEL+94npuxUR4vJvB1N2K5Xm2dBBsPSiVbc/JF492yySyBQ6YS
         kIpaZX7aylxHLHslUDtS0FMyXbNPCY6KTs1HXI3pakX0l8Yre5StlkaB/b+naGc4tFPG
         Aok5lza3hjee0D340+NDVXFGFhsoMJEta8xrNLvxCmfGN8EyL7gS0n6QDj5CHQvE9soi
         g1yY6cqRgTIZxTgSBH9Y4DqKdbaoUUE4LpL1O5IBHXcOvmtXoMQZYQz730XLK5yXaWXm
         Wyki4TTGeeWhzNCRbkVW2Lh5nb3sZa5Ehu7YbkfUiFNzVwKdHzgejpWZJCm1VeiGyFjD
         kJuQ==
X-Gm-Message-State: AOAM532J8UzTTRYR0ogVGclldHBSmM3HHfyW+OoIlPXyJt6d0g8JaMfi
        sOXrIEL0DxUXg4L6+gGs35Hiew==
X-Google-Smtp-Source: ABdhPJzcLao8TwXtuyU+4+xr5mTTOURG8is2Ws5i5yjPMOn2BcNK9veCKI7sf81F5xj4tjiIM9T+jQ==
X-Received: by 2002:a37:8507:: with SMTP id h7mr6224742qkd.277.1622843532434;
        Fri, 04 Jun 2021 14:52:12 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f13sm4728423qkk.107.2021.06.04.14.52.10
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 04 Jun 2021 14:52:12 -0700 (PDT)
Date:   Fri, 4 Jun 2021 14:52:09 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] mm/thp: fix __split_huge_pmd_locked() on shmem
 migration entry
In-Reply-To: <CAHbLzkqYyoXm1sAq7yBi3s8PbY127VbbgNGZ-5e-zqZMzFOzWA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2106041429250.14037@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils> <alpine.LSU.2.11.2106011403540.2148@eggly.anvils> <CAHbLzkobMaW15iN6y8Zot3kmpA1c4z2r6rSR7B9Pqwg5YY+hcA@mail.gmail.com> <alpine.LSU.2.11.2106031918400.12760@eggly.anvils>
 <CAHbLzkqYyoXm1sAq7yBi3s8PbY127VbbgNGZ-5e-zqZMzFOzWA@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021, Yang Shi wrote:
> On Thu, Jun 3, 2021 at 7:23 PM Hugh Dickins <hughd@google.com> wrote:
> > On Thu, 3 Jun 2021, Yang Shi wrote:
> > > On Tue, Jun 1, 2021 at 2:05 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > The point here (see commit message above) is that some unrelated pmd
> > migration entry could pass the is_huge_zero_pmd() test, which rushes
> > off to use pmd_page() without even checking pmd_present() first.  And
> > most of its users have, one way or another, checked pmd_present() first;
> > but this place and a couple of others had not.
> 
> Thanks for the elaboration. Wondering whether we'd better add some
> comments in the code? Someone may submit a fix patch by visual
> inspection in the future due to missing these points.

I don't really want to add a comment on this, there in zap_huge_pmd():
I think it would be too much of a distraction from that dense code
sequence.  And the comment will be more obvious in the commit message,
once I split these is_huge_zero_pmd() fixes off from
__split_huge_pmd_locked() as Kirill asked.

But... now I think I'll scrap these parts of the patch, and instead
just add a pmd_present() check into is_huge_zero_pmd() itself.
pmd_present() is quick, but pmd_page() may not be: I may convert it
to use a __read_only huge_pmd_pfn, or may not: I'll see how that goes.

Hugh
