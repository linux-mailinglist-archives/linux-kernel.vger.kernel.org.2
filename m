Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26A6396DC0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhFAHKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhFAHKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:10:35 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1252C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 00:08:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l10-20020a17090a150ab0290162974722f2so1317994pja.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 00:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WR3r+ydE1Ns9ygBtsSiaRQAr3k4CSXyTaNQimiETYP8=;
        b=rADtEdgmCPtVLRAUh7JzJ/+vJ/3a3Z1925ItFXCUt1JdcoRqbluar+SxAJkeNGME3G
         r6qIdWLJWEpE6Jn78SyAM9FWY4GMw2aAKDiSCKOsgLvQ01hF8cGqRW3/6w4dS6ytehw5
         b1PAfiIQPxR0pX9Hg6YhWqwhvVeChw36xrZe51unywzExo1yYu2u3129udOQbNftNXyF
         z6fbrGXM3H15zKCJmj4Mzf9ivA6KOvhTHQZeMkZQqZDFh0jHVfBC+C8RCDVM/2Tx1+Hk
         ugIXoiMbg2Jvj1KoRVFlrVToos5TjOrXYb6ZmVj8O/gd+49Cj/uxfF2JkiOjcvUFWtuS
         D1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WR3r+ydE1Ns9ygBtsSiaRQAr3k4CSXyTaNQimiETYP8=;
        b=URnPCB4RC/Dknm+BniCLDfbhc0WzWNiTpKWYosGl9KlP1L+DI/hHyDXlX0upH1HMMr
         9RKcAJ7OccaKuTveJ/+VRnlt8ESdv3g7i8j9aGAKsroZK88MjhqwcNAorl3fQV6dt/8p
         tj6cRIN1E4fUlLZmkQ1oN+K0qq51uPZoXs38K1k6U+iw56QXe7/6BmhnGrjm/R21iZHC
         Acj58WNofnpETcDTpyBCayTzemfDOJsJstaTOtM3hE2OSwskB0pRKgZ+CVfjsmSp9tVb
         ldC7atcLNg6+oQB2IbvMbKUrglaI6pf/AR4F31guou9CUrH+gUYUSrgox/VFV+5hINrs
         qhNg==
X-Gm-Message-State: AOAM533LBg+HSi9xMzt+Oa3yCUifN4BZNGWm11aAHjfdKpR0jMZBzBLS
        I9ePHq8eHPcZjSxLqwc0Q5k=
X-Google-Smtp-Source: ABdhPJwbCQbRSU0axncpTGKphEGrkgWYCFiPVSqT5pqBfkUKonjSx+vS+tQcrPNfFPwsjvuYEyNPKA==
X-Received: by 2002:a17:90a:8991:: with SMTP id v17mr3327483pjn.132.1622531332783;
        Tue, 01 Jun 2021 00:08:52 -0700 (PDT)
Received: from [192.168.0.15] (c-73-158-171-241.hsd1.ca.comcast.net. [73.158.171.241])
        by smtp.gmail.com with ESMTPSA id c128sm12728998pfa.189.2021.06.01.00.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 00:08:51 -0700 (PDT)
Subject: Re: Sealed memfd & no-fault mmap
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Simon Ser <contact@emersion.fr>,
        Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "tytso@mit.edu" <tytso@mit.edu>
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr>
 <lpi4uT69AFMwtmWtwW_qJAmYm_r0jRikL11G_zI4X7wq--6Jtpiej8kGn8gePfv0Dtn4VmzsOqT2Q5-L3ca2niDi0nlC0nVYphbFBnNJnw0=@emersion.fr>
 <CAHk-=wiAs7Ky9gmWAeqk5t7Nkueip13XPGtUcmMiZjwf-sX3sQ@mail.gmail.com>
 <hnL7s1u925fpeUhs90fXUpD3GG_4gmHlpznN8E0885tSM40QYb3VVTFGkwpmxYQ3U8HkRSUtfqw0ZfBKptA4pIw4FZw1MdRhSHC94iQATEE=@emersion.fr>
 <CAHk-=wiY1BL-UHPMEAbd7nY3vu6w41A1hhvjg1DoBXWuRt9_qw@mail.gmail.com>
 <7718ec5b-0a9e-ffa6-16f2-bc0b6afbd9ab@gmail.com>
 <CAHk-=wjv3-eP7mSDJbuvaB+CbyyKc4g_nEzhQLcueOd0_YuiBg@mail.gmail.com>
 <80c87e6b-6050-bf23-2185-ded408df4d0f@gmail.com>
 <CAHk-=whSGS=R8PtrfNcDTkCKOengEqygqeWjOZa2b8QkuOueDg@mail.gmail.com>
 <alpine.LSU.2.11.2105291315330.25425@eggly.anvils>
 <36fc2485-11f1-5252-904d-f26b63a6cd58@gmail.com>
 <e7454046-c071-888d-f673-276f9c24d9d3@gmail.com>
 <CAHk-=whce3vmj+g7jcE0rasoDavJutxno3ZZrvvWYQywWXH31Q@mail.gmail.com>
From:   Ming Lin <minggr@gmail.com>
Message-ID: <0464f8dd-d082-b246-83ff-609f0f48de59@gmail.com>
Date:   Tue, 1 Jun 2021 00:08:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=whce3vmj+g7jcE0rasoDavJutxno3ZZrvvWYQywWXH31Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/2021 11:24 PM, Linus Torvalds wrote:
> On Mon, May 31, 2021 at 11:13 AM Ming Lin <minggr@gmail.com> wrote:
>>
>> OK, I borrowed code from filemap_xip.c and implemented this behavior.
> 
> I think that "unmap page" is too complicated and fragile.
> 
> The only page that could possibly validly be unmapped is a stale zero
> page, but that code in shmem_unmap_nofault_page() seems to try to
> handle other cases too (ie that whole page_remove_rmap() - afaik a
> zero page has no rmap).
> 
> I get the feeling that the simpler thing to do is to just say "if you
> use MAP_NOSIGBUS, and you access pages that don't have a backing
> store, you will get zero pages, and they will NOT BE SYNCHRONIZED with
> the backing store possibly later being updated".
> 
> IOW, just document the fact that a MAP_NOSIGBUS mapping isn't coherent
> wrt shmem contents that are expanded and filled in later.
> 
> Don't try to "fix" it - because any user that uses MAP_NOSIGBUS had
> better just accept that it's not compatible with expanding the shmem
> backing store later.
> 
> Keep it simple and stupid. Hmm?

Simon,

Is this "simple" solution good enough for Wayland compositor use case?

