Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699433EC2C4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 15:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbhHNNGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 09:06:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:45632 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhHNNGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 09:06:04 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17ECwEDi013900;
        Sat, 14 Aug 2021 07:58:14 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 17ECwCY0013899;
        Sat, 14 Aug 2021 07:58:12 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 14 Aug 2021 07:58:12 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Daniel Axtens <dja@axtens.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux@googlegroups.com,
        Paul Mackerras <paulus@samba.org>,
        Bill Wendling <morbo@google.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ppc: add "-z notext" flag to disable diagnostic
Message-ID: <20210814125812.GC1583@gate.crashing.org>
References: <20210812204951.1551782-1-morbo@google.com> <87sfzde8lk.fsf@linkitivity.dja.id.au> <20210813200508.7bqehxgd6ruerds5@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813200508.7bqehxgd6ruerds5@google.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 01:05:08PM -0700, Fangrui Song wrote:
> Text relocations are considered very awful by linker developers.

By very few linker developers.

> binutils 2.35 added --enable-textrel-check={no,warn,error}
> https://sourceware.org/bugzilla/show_bug.cgi?id=20824

Yes, some people wanted the default to be configurable.  So now we have
a default default that is sane, so most people get to reap the benefits
of having defaults at all, but we also allow other people to shoot
themselves (and people who have to deal with them) in the foot.
"Progress".  Changing the defaults should be a one-time event, only done
when the benefits strongly outweigh the costs.  Defaults should never be
configurable (by the user).

> I can imagine that in the future some Linux distributions (especially those
> focusing on security) will default their binutils to use
> --enable-textrel-check={no,warn,error}.

How would this be a benefit to security?

> In -no-pie links, R_PPC64_ADDR64 relocations are link-time constants.

Where "link" includes dynamic links as well.  There are no constants.

> There are no text relocations, therefore no need for -z notext.

This is a choice by the compiler, nothing more.  It saves some process
startup time, and allows slightly more maps to be shared by processes
that run the same images.  But it is a tradeoff, so it might change; and
of course it is not an ABI requirement.


Segher
