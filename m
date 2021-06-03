Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6811139AB84
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 22:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhFCUJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 16:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229661AbhFCUJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 16:09:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E333F613D7;
        Thu,  3 Jun 2021 20:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622750879;
        bh=s+GFoK0CcrBhtHRxHPLs58CMRcGtBRU75Q3Rrs2tEbA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hm12yZR6aJD++LSXbEVDoVaaDp4Edic/IwebPvSU5I+y2YCRFV4OPm9HftXdpmFrO
         +MZidBr3cTy+FzpxVPLNcVG0jjqrcTTHVausfunIH3e8Ui6Ts55x3myPMSs+nFkp0r
         obr7D7OmrhRtQT5g+VMdlMCJkPI4BuD7JO+tsU+U9s55wHncTy/t9AAoIIpLrU3H9D
         joNT4xGVpJkt2++myelBF86017ZiTSz3yYdPFio4s4BVTxtJkd7rv0RdTXCrjhTvMe
         1KDzUICIUSp1xBK9M9qPA5mDJtv0fiNQHLqQmkHQKTKLedVHlWSvZRRaMKKGT5SfvZ
         o3NzUJhnrhXIA==
Subject: Re: Sealed memfd & no-fault mmap
To:     Simon Ser <contact@emersion.fr>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
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
 <CAHk-=wjv3-eP7mSDJbuvaB+CbyyKc4g_nEzhQLcueOd0_YuiBg@mail.gmail.com>
 <80c87e6b-6050-bf23-2185-ded408df4d0f@gmail.com>
 <CAHk-=whSGS=R8PtrfNcDTkCKOengEqygqeWjOZa2b8QkuOueDg@mail.gmail.com>
 <alpine.LSU.2.11.2105291315330.25425@eggly.anvils>
 <36fc2485-11f1-5252-904d-f26b63a6cd58@gmail.com>
 <e7454046-c071-888d-f673-276f9c24d9d3@gmail.com>
 <CAHk-=whce3vmj+g7jcE0rasoDavJutxno3ZZrvvWYQywWXH31Q@mail.gmail.com>
 <0464f8dd-d082-b246-83ff-609f0f48de59@gmail.com>
 <8By7yERxX_qlsLZuOeJihJqeU-pZtFxsS2zrQ1ssN6-NkyIRrv-r81Ux_PTcb8qy7QA1HmkRxTeixT5MaJs7NKk0rqxDC9Nu9DoTRmS0UHw=@emersion.fr>
From:   Ming Lin <mlin@kernel.org>
Message-ID: <ca7afd0e-4fea-4601-6c06-36e0e3664945@kernel.org>
Date:   Thu, 3 Jun 2021 13:07:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <8By7yERxX_qlsLZuOeJihJqeU-pZtFxsS2zrQ1ssN6-NkyIRrv-r81Ux_PTcb8qy7QA1HmkRxTeixT5MaJs7NKk0rqxDC9Nu9DoTRmS0UHw=@emersion.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/2021 6:01 AM, Simon Ser wrote:

> 
> Regarding the requirements for Wayland:
> 
> - The baseline requirement is being able to avoid SIGBUS for read-only mappings
>    of shm files.
> - Wayland clients can expand their shm files. However the compositor doesn't
>    need to immediately access the new expanded region. The client will tell the
>    compositor what the new shm file size is, and the compositor will re-map it.
> - Ideally, MAP_NOSIGBUS would work on PROT_WRITE + MAP_SHARED mappings (of
>    course, the no-SIGBUS behavior would be restricted to that mapping). The
>    use-case is writing back to client buffers e.g. for screen capture. From the
>    earlier discussions it seems like this would be complicated to implement.
>    This means we'll need to come up with a new libwayland API to allow
>    compositors to opt-in to the read-only mappings. This is sub-optimal but
>    seems doable.
> - Ideally, MAP_SIGBUS wouldn't be restricted to shm. There are use-cases for
>    using it on ordinary files too, e.g. for sharing ICC profiles. But from the
>    earlier replies it seems very unlikely that this will become possible, and
>    making it work only on shm files would already be fantastic.

In the new version of the patches, MAP_NOSIGBUS is not restricted to shmem.
It can be used on ordinary files.
