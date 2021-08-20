Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C113F318F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 18:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhHTQjW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Aug 2021 12:39:22 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:40555 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229772AbhHTQjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 12:39:21 -0400
Received: from MTA-07-4.privateemail.com (mta-07-1.privateemail.com [198.54.122.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id A470A80514
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 12:38:42 -0400 (EDT)
Received: from mta-07.privateemail.com (localhost [127.0.0.1])
        by mta-07.privateemail.com (Postfix) with ESMTP id 9C5391800236;
        Fri, 20 Aug 2021 12:38:40 -0400 (EDT)
Received: from APP-04 (unknown [10.50.14.154])
        by mta-07.privateemail.com (Postfix) with ESMTPA id 5980D180022D;
        Fri, 20 Aug 2021 12:38:40 -0400 (EDT)
Date:   Fri, 20 Aug 2021 12:38:40 -0400 (EDT)
From:   Jordy Zomer <jordy@pwning.systems>
To:     Kees Cook <keescook@chromium.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>
Message-ID: <209705133.1285234.1629477520318@privateemail.com>
In-Reply-To: <202108200904.81ED4AA52@keescook>
References: <20210820043339.2151352-1-jordy@pwning.systems>
 <0874a50b61cfaf7c817cab7344c49c1641c1fd10.camel@HansenPartnership.com>
 <202108200904.81ED4AA52@keescook>
Subject: Re: [PATCH] mm/secretmem: use refcount_t instead of atomic_t
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev17
X-Originating-Client: open-xchange-appsuite
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi There!

Because this is a global variable, it appears to be exploitable. Either we generate a sufficient number of processes to achieve this counter, or you increase the open file limit with ulimit or sysctl. Unless the kernel has a hard restriction on the number of potential file descriptors that I'm not aware of.

In any case, it's probably a good idea to patch this to make it explicitly secure. If you discover a hard-limit in the kernel for open file descriptors, please let me know. I'm genuinely ​interested :D!

Best Regards,

Jordy

> On 08/20/2021 12:05 PM Kees Cook <keescook@chromium.org> wrote:
> 
>  
> On Fri, Aug 20, 2021 at 07:57:25AM -0700, James Bottomley wrote:
> > On Fri, 2021-08-20 at 06:33 +0200, Jordy Zomer wrote:
> > > As you can see there's an `atomic_inc` for each `memfd` that is
> > > opened in the `memfd_secret` syscall. If a local attacker succeeds to
> > > open 2^32 memfd's, the counter will wrap around to 0. This implies
> > > that you may hibernate again, even though there are still regions of
> > > this secret memory, thereby bypassing the security check.
> > 
> > This isn't a possible attack, is it?  secret memory is per process and
> > each process usually has an open fd limit of 1024.  That's not to say
> > we shouldn't have overflow protection just in case, but I think today
> > we don't have a problem.
> 
> But it's a _global_ setting, so it's still possible, though likely
> impractical today. But refcount_t mitigates it and is a trivial change.
> :)
> 
> -- 
> Kees Cook
