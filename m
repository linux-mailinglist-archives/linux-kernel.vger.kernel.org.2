Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B546530952A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 13:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhA3Mp6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jan 2021 07:45:58 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:59078 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229498AbhA3Mp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 07:45:57 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23745921-1500050 
        for multiple; Sat, 30 Jan 2021 12:45:11 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210130123411.GB1822@llvm-development.us-central1-a.c.llvm-285123.internal>
References: <20210129181519.69963-1-viniciustinti@gmail.com> <161195375417.17568.2762721732398065240@build.alporthouse.com> <20210130123411.GB1822@llvm-development.us-central1-a.c.llvm-285123.internal>
Subject: Re: [PATCH] drm/i915: Remove unreachable code
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
To:     Vinicius Tinti <viniciustinti@gmail.com>
Date:   Sat, 30 Jan 2021 12:45:10 +0000
Message-ID: <161201071009.32035.9188382145053741268@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinicius Tinti (2021-01-30 12:34:11)
> On Fri, Jan 29, 2021 at 08:55:54PM +0000, Chris Wilson wrote:
> > Quoting Vinicius Tinti (2021-01-29 18:15:19)
> > > By enabling -Wunreachable-code-aggressive on Clang the following code
> > > paths are unreachable.
> > 
> > That code exists as commentary and, especially for sdvo, library
> > functions that we may need in future.
> 
> I would argue that this code could be removed since it is in git history.
> It can be restored when needed.
> 
> This will make the code cleaner.

It doesn't change the control flow, so no complexity argument. It
removes documentation from the code, so I have the opposite opinion.

> > The ivb-gt1 case => as we now set the gt level for ivb, should we not
> > enable the optimisation for ivb unaffected by the w/a? Just no one has
> > taken the time to see if it causes a regression.
> 
> I don't know. I just found out that the code is unreachable.
> 
> > For error state, the question remains whether we should revert to
> > uncompressed data if the compressed stream is larger than the original.
> 
> I don't know too.
> 
> In this last two cases the code could be commented and the decisions
> and problems explained in the comment section.

They already are, that is the point.
-Chris
