Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DA1394E82
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 01:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhE2Xh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 19:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhE2Xh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 19:37:56 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2501AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 16:36:19 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso4591441pji.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 16:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c2WnM1zDO+Y6Htqu0TQxoQ5bjmD0kYCGJDdZojp1i3c=;
        b=enfSHxkJwnhPLf7LVybONTDL4gh2SRGRUlReeUB2CO4zwhYr2pAAD24zxC6jRDUYQl
         vHYBQF8chmH4bdHxCIXRKnG1TwGczwpyvE7b4K9DgVA+TpNSZhd8qEO84UCpXPWT4HTT
         55+gqD9DIBqTljFIlx+LIOzbiFuN1WSVEUGdzLXEEByY7LjreBX/YNbrLyXvoQu9S76F
         ObM/ipxp06VoOeMmnscIPReFo8psTiqoYa8l+cKY1PIt6VKR3PZFvcWAdUsTOE8/235f
         rQZIlXfK1MUA4ZGrcFu/J/OF872FezsybgCmZAq0ARZqGtJDun+KpAh+LOERUVBEPohT
         WO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c2WnM1zDO+Y6Htqu0TQxoQ5bjmD0kYCGJDdZojp1i3c=;
        b=ToLocKZMUdkh2fAev59svf0UiKkso7viece4IcKaV0/OzEvOu0u/18eAN5FzRtuuem
         3+bMLupopt4wF+qQAd+bQyuz7LguMK4jh/fdBhJotIvt0rJpun/ICmkLFSkAvuM0lB1m
         DYed5Gb9Ax0CiRLNN0DM+VcaD1IATtERWCrK0QGZ7GNBQEU0mDw9TJrf389AblayZHMr
         jt7sHX9p706PE9ZMrU5h9VZBUOcdI1tK8kOw94UiGRRnGz5l5EnMkYjFkEkzRm3EaOHg
         RfUuregToU7wpyJcKDRQ66XUy3w2lm5HhsMSKt/fCy1nW/+D6rfjrZANIfKN9ZObdDdk
         k76A==
X-Gm-Message-State: AOAM5326xUiowNAqghd+yWj2TA9lObXUNcC2mrasmqcGMkSwqgQdmtWB
        DP2VbbWClEoqYWkYUOt6zLM=
X-Google-Smtp-Source: ABdhPJwf0NK0abdbZJmuEYRFg6s2Ru7boT0tbz7uYaLpjwJPUpJdHFW2iCGSdQawDYo09KeavCyWpA==
X-Received: by 2002:a17:903:189:b029:f1:d67a:5168 with SMTP id z9-20020a1709030189b02900f1d67a5168mr14040327plg.82.1622331378465;
        Sat, 29 May 2021 16:36:18 -0700 (PDT)
Received: from ?IPv6:2601:647:5380:8c0:69f7:e9:4598:c206? ([2601:647:5380:8c0:69f7:e9:4598:c206])
        by smtp.gmail.com with ESMTPSA id v3sm7298769pfb.203.2021.05.29.16.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 May 2021 16:36:17 -0700 (PDT)
Subject: Re: Sealed memfd & no-fault mmap
To:     Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Simon Ser <contact@emersion.fr>, Peter Xu <peterx@redhat.com>,
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
 <CAHk-=wgmGv2EGscKSi8SrQWtEVpEQyk-ZN1Xj4EoAB87Dmx1gA@mail.gmail.com>
 <20210429154807.hptls4vnmq2svuea@box> <20210429183836.GF8339@xz-x1>
 <lpi4uT69AFMwtmWtwW_qJAmYm_r0jRikL11G_zI4X7wq--6Jtpiej8kGn8gePfv0Dtn4VmzsOqT2Q5-L3ca2niDi0nlC0nVYphbFBnNJnw0=@emersion.fr>
 <CAHk-=wiAs7Ky9gmWAeqk5t7Nkueip13XPGtUcmMiZjwf-sX3sQ@mail.gmail.com>
 <hnL7s1u925fpeUhs90fXUpD3GG_4gmHlpznN8E0885tSM40QYb3VVTFGkwpmxYQ3U8HkRSUtfqw0ZfBKptA4pIw4FZw1MdRhSHC94iQATEE=@emersion.fr>
 <CAHk-=wiY1BL-UHPMEAbd7nY3vu6w41A1hhvjg1DoBXWuRt9_qw@mail.gmail.com>
 <7718ec5b-0a9e-ffa6-16f2-bc0b6afbd9ab@gmail.com>
 <CAHk-=wjv3-eP7mSDJbuvaB+CbyyKc4g_nEzhQLcueOd0_YuiBg@mail.gmail.com>
 <80c87e6b-6050-bf23-2185-ded408df4d0f@gmail.com>
 <CAHk-=whSGS=R8PtrfNcDTkCKOengEqygqeWjOZa2b8QkuOueDg@mail.gmail.com>
 <alpine.LSU.2.11.2105291315330.25425@eggly.anvils>
From:   Ming Lin <minggr@gmail.com>
Message-ID: <36fc2485-11f1-5252-904d-f26b63a6cd58@gmail.com>
Date:   Sat, 29 May 2021 16:36:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2105291315330.25425@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/2021 1:15 PM, Hugh Dickins wrote:
> 
> NOFAULT? Does BSD use "fault" differently, and in Linux terms we
> would say NOSIGBUS to mean the same?
> 
> Can someone point to a specification of BSD's __MAP_NOFAULT?
> Searching just found me references to bugs.

Checked freebsd and openbsd, their MAP_NOFAULT seems quite different
than NOSIGBUS.

freebsd: https://github.com/freebsd/freebsd-src
MAP_NOFAULT: The mapping should not generate page faults

openbsd: https://github.com/openbsd/src
__MAP_NOFAULT only makes sense with a backing object

> 
> What mainly worries me about the suggestion is: what happens to the
> zero page inserted into NOFAULT mappings, when later a page for that
> offset is created and added to page cache?
> 
> Treating it as an opaque blob of zeroes, that stays there ever after,
> hiding the subsequent data: easy to implement, but a hack that we would
> probably regret.  (And I notice that even the quote from David Herrmann
> in the original post allows for the possibility that client may want to
> expand the object.)

Yes, that's problem ...

> 
> I believe the correct behaviour would be to unmap the nofault page
> then, allowing the proper page to be faulted in after.  That is
> certainly doable (the old mm/filemap_xip.c used to do so), but might
> get into some awkward race territory, with filesystem dependence
> (reminiscent of hole punch, in reverse).  shmem could operate that
> way, and be the better for it: but I wouldn't want to add that,
> without also cleaning away all the shmem_recalc_inode() stuff.

After we treat it as zero page, then no page fault for later read.
What is the timing to unmap the nofault page?

I'm reading filemap_xip.c to learn how to do it.
https://elixir.bootlin.com/linux/v3.19.8/source/mm/filemap_xip.c


