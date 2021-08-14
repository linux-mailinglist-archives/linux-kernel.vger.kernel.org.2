Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592E63EC243
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 13:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbhHNLJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 07:09:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:53349 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238067AbhHNLJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 07:09:52 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17EB1pvM008610;
        Sat, 14 Aug 2021 06:01:51 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 17EB1o3c008609;
        Sat, 14 Aug 2021 06:01:50 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 14 Aug 2021 06:01:50 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Bill Wendling <morbo@google.com>,
        Fangrui Song <maskray@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] ppc: add "-z notext" flag to disable diagnostic
Message-ID: <20210814110150.GB1583@gate.crashing.org>
References: <20210812204951.1551782-1-morbo@google.com> <87sfzde8lk.fsf@linkitivity.dja.id.au> <CAGG=3QUz2LNgC8Hn6rU68ejjv4=J9Uidef0oH9A7=sKTs+vf7g@mail.gmail.com> <CAKwvOd=rN9s5YBtt-AMnaqXhYCsAT=6yp29_oomRvTaev6Q6zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=rN9s5YBtt-AMnaqXhYCsAT=6yp29_oomRvTaev6Q6zw@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 11:59:21AM -0700, Nick Desaulniers wrote:
> Or we can dig through why there are relocations in read only sections,
> fix those, then enable `-z text` for all linkers.  My recommendation
> would be get the thing building, then go digging time permitting.

It is not always a bug.  You can get much more efficient code if you
have text relocations than if you don't.  This "read-only" memory is
perfectly writable until after relocation, a la relro.

But you no doubt will find some non-optimalities (or even straight out
bugs) if you build with -ztext sometimes :-)


Segher
