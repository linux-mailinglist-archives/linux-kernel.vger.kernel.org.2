Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4474308EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 21:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhA2U4x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Jan 2021 15:56:53 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:54778 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233055AbhA2U4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:56:49 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23741559-1500050 
        for multiple; Fri, 29 Jan 2021 20:55:55 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210129181519.69963-1-viniciustinti@gmail.com>
References: <20210129181519.69963-1-viniciustinti@gmail.com>
Subject: Re: [PATCH] drm/i915: Remove unreachable code
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vinicius Tinti <viniciustinti@gmail.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vinicius Tinti <viniciustinti@gmail.com>
Date:   Fri, 29 Jan 2021 20:55:54 +0000
Message-ID: <161195375417.17568.2762721732398065240@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinicius Tinti (2021-01-29 18:15:19)
> By enabling -Wunreachable-code-aggressive on Clang the following code
> paths are unreachable.

That code exists as commentary and, especially for sdvo, library
functions that we may need in future.

The ivb-gt1 case => as we now set the gt level for ivb, should we not
enable the optimisation for ivb unaffected by the w/a? Just no one has
taken the time to see if it causes a regression.

For error state, the question remains whether we should revert to
uncompressed data if the compressed stream is larger than the original.
-Chris
