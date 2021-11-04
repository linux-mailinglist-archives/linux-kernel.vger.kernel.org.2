Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB8E445CC4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 00:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhKDXvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 19:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKDXvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 19:51:17 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3034C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 16:48:38 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id v23so12187241ljk.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 16:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RUydRgKitS7xjl4fUt0DmUmUJFyOp4TRNw35dFlgrg8=;
        b=MZKfUpmfymkhP20bCj4T/LQGFFD4TKWsAiGHdVXd3kwJPDnWfMcAnqxRJ08O8QT1OY
         dwtn6D9ewzqc8BkE0xYN4gtsU2zfsNzEWhBkte4+mUewcvVfXfe3MtK2QXR9+w7RHB0i
         80LHGxbyyxLaUEJg60P6V4UiVFSMqXREUwuG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RUydRgKitS7xjl4fUt0DmUmUJFyOp4TRNw35dFlgrg8=;
        b=cBpUcgg9sGAHEikPt/opxXAdQlEaMSW9rx6wb2Rf5iocBB834KqDuriI0BmtmRa6WL
         /PhH0SED+gYuzGdGPQ8DYVXxHkqV9xUvQWchEE4IbfVBzoQHrlSiesALgl0uzOWGeVPx
         5R/+lTFSi4zpX0ls2QZ12eTk/WveGhyG7CJ4E4FsMM0DlP/xdRKP3CzW9DW1qHOW9Msp
         kQdI2VpMYQpBdRvR84xhmBgfoliI2ywIXePaBWPY+hUKm/XhVjL44A6hykPaWYtfAuuP
         CT+DxhM5wGywc7Oqrmd3ei6WUpcoUdQ9R7fYptweFvSh/VU0RnxlO6TSnQzzXpzt1g4N
         SS9w==
X-Gm-Message-State: AOAM532LTRkQbf40b81gCm+ovBV4BmXINjFDhE5s2laVwrtSnXL1/Dmd
        Fn8lHl/KOFxnsdXLpAe5junFZt+rNwgYsCJE
X-Google-Smtp-Source: ABdhPJzqhSdiZEejEYJVUbQ3BCY3gencg26ds4J+BDb+Er3LkAH//wW0ciLNYDH75b594eDGqUzT0Q==
X-Received: by 2002:a2e:90da:: with SMTP id o26mr951677ljg.292.1636069716793;
        Thu, 04 Nov 2021 16:48:36 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id i11sm621766lfu.269.2021.11.04.16.48.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 16:48:35 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id j5so12161877lja.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 16:48:35 -0700 (PDT)
X-Received: by 2002:a05:651c:113:: with SMTP id a19mr11688124ljb.249.1636069714934;
 Thu, 04 Nov 2021 16:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211104115001.GU20319@twin.jikos.cz> <CAHk-=whYQvExYESEOJoSj4Jy7t+tSZgbCWuNpdwXYh+3zq2itw@mail.gmail.com>
 <CAHk-=whBOXM3mh-QtzK-EQtDEHQLcziAXu07KxU1crUc5jiQUg@mail.gmail.com>
In-Reply-To: <CAHk-=whBOXM3mh-QtzK-EQtDEHQLcziAXu07KxU1crUc5jiQUg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Nov 2021 16:48:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGUxtcL8Z67y4A6_diSmtQdnOq1p_gyBAMzpKD9yk+gw@mail.gmail.com>
Message-ID: <CAHk-=whGUxtcL8Z67y4A6_diSmtQdnOq1p_gyBAMzpKD9yk+gw@mail.gmail.com>
Subject: Re: Kmap-related crashes and memory leaks on 32bit arch (5.15+)
To:     David Sterba <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 4:37 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Having looked at it once more, it still looks "ObviouslyCorrect(tm)"
> to me, but I suspect I'm just being blind to some obvious bug.

Oh, I was just looking at the pattern of kmap/kunmap, but there does
seem to be a questionable pattern outside of that:

This pattern looks odd:

        kaddr = kmap(cur_page);
        write_compress_length(kaddr + offset_in_page(*cur_out),
                              compressed_size);
        ...

(and then whether you kunmap immediately, or you leave it kmap'ed and
use it again at the end is a different issue)

In particular, what if "offset_in_page(*cur_out)" is very close to the
end of the page?

That write_compress_length() always writes out a word-sized length (ie
LZO_LEN bytes), and the above pattern seems to have no model to handle
the "oh, this 4-byte write crosses a page boundary"

The other writes in that function seem to do it properly, and you have

        u32 copy_len = min_t(u32, sectorsize - *cur_out % sectorsize,
                             orig_out + compressed_size - *cur_out);

so doing the memcpy() of size 'copy_len' should never cross a page
boundary as long as sectorsize is a power-of-2 smaller or equal to a
page size. But those 4-byte length writes seem like they could be page
crossers.

The same situation exists on the reading side, I think.

Maybe there's some reason why the read/write_compress_length() can
never cross a page boundary, but it did strike me as odd.

             Linus
