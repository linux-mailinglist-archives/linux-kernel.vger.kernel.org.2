Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB302439ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 21:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhJYTDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 15:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48418 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233719AbhJYTDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635188458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QkyoC/NexH1Nu0O2R4wJhF/62iz6WrFzKuF9woFeRsA=;
        b=FMgtWL46advIFc7a6Z4Daj5ZHup5t8m+GSfyUGpbsOs3yNJiysWmY6X4so8zxrrF8RdYHb
        KYr9DvZLg1Rwjnlg9PbS+aoALmXhDNDC4lZIhyj10VO5tixNxrwqy2IIBOa97gYtty03QF
        hA+w8TXa7lI0lp/nfm32RH8f4G3KqQ0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-NDeFFj-BNW2zmvHWaONXBQ-1; Mon, 25 Oct 2021 15:00:56 -0400
X-MC-Unique: NDeFFj-BNW2zmvHWaONXBQ-1
Received: by mail-wr1-f72.google.com with SMTP id d10-20020adffd8a000000b00167f0846597so2904234wrr.16
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 12:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QkyoC/NexH1Nu0O2R4wJhF/62iz6WrFzKuF9woFeRsA=;
        b=uCtutGaDd5ZeHYiy8jRBWiBpS0LacaxRnPquOe7upCNhY5y9I1px1Hq2jQ9VSGBhya
         R58JCpmcSg6DsmPMXHxJXsEa0HtzBp1lspypOcKYLUHHL+/kJ11DMPnlzRth0qSH++jo
         nCSFAArSUGapKnGXUAF46Q6Pup0MUdkLJzRRDXf+7IfbS51NAHZJ9DpStMtMpYb8ojl/
         ZxPNWvQN1xVQS/Or4Aj9Nd/TySMGyX3pU2u6u2CuIi+x0s0QcbtaH8q9PCAfj1WSfaPH
         jKGH4ohajuhwxOl0JeZSB4h0y6CJGGp25MwXPF5nHooj4E3w/5tf96d6RFkKj2Fvz15X
         8R2A==
X-Gm-Message-State: AOAM531dpIJb7n1X1hOQ+QG6RR07oJYIJcesCUC3GsEygQDCtYmbVS59
        yAu1llpY5U8/MzszH97kzdIJ1JjoTESNKLSLEFO070djG8ighwmkhb/KnHKqULnTIGHA56ddPN7
        fuBTsFZsvBvNCG/83DgqcL20JDDOOaM+LM2kUu3R+
X-Received: by 2002:a7b:c74f:: with SMTP id w15mr21890331wmk.186.1635188455482;
        Mon, 25 Oct 2021 12:00:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzXLWqbHTas2L+Ep0jJ8Ym3FrcHaKtpcTPgh7nV35XP5aJDxyjNlJ4UaNmG9hWfJd1eun8dCJKnnE+XiZ6mmk=
X-Received: by 2002:a7b:c74f:: with SMTP id w15mr21890297wmk.186.1635188455236;
 Mon, 25 Oct 2021 12:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211019134204.3382645-1-agruenba@redhat.com> <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
 <YXBFqD9WVuU8awIv@arm.com> <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
 <YXCbv5gdfEEtAYo8@arm.com> <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
 <YXL9tRher7QVmq6N@arm.com> <CAHk-=wg4t2t1AaBDyMfOVhCCOiLLjCB5TFVgZcV4Pr8X2qptJw@mail.gmail.com>
In-Reply-To: <CAHk-=wg4t2t1AaBDyMfOVhCCOiLLjCB5TFVgZcV4Pr8X2qptJw@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 25 Oct 2021 21:00:43 +0200
Message-ID: <CAHc6FU7BEfBJCpm8wC3P+8GTBcXxzDWcp6wAcgzQtuaJLHrqZA@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 9:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Oct 22, 2021 at 8:06 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > Probing only the first byte(s) in fault_in() would be ideal, no need to
> > go through all filesystems and try to change the uaccess/probing order.
>
> Let's try that. Or rather: probing just the first page - since there
> are users like that btrfs ioctl, and the direct-io path.

For direct I/O, we actually only want to trigger page fault-in so that
we can grab page references with bio_iov_iter_get_pages. Probing for
sub-page error domains will only slow things down. If we hit -EFAULT
during the actual copy-in or copy-out, we know that the error can't be
page fault related. Similarly, in the buffered I/O case, we only
really care about the next byte, so any probing beyond that is
unnecessary.

So maybe we should split the sub-page error domain probing off from
the fault-in functions. Or at least add an argument to the fault-in
functions that specifies the amount of memory to probe.

Thanks,
Andreas

