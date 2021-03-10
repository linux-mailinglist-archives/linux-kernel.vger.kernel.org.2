Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DDD333614
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhCJG76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 01:59:58 -0500
Received: from vmi485042.contaboserver.net ([161.97.139.209]:54908 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhCJG7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 01:59:53 -0500
Received: by gentwo.de (Postfix, from userid 1001)
        id D6410B005CF; Wed, 10 Mar 2021 07:59:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id D3C5EB0058D;
        Wed, 10 Mar 2021 07:59:51 +0100 (CET)
Date:   Wed, 10 Mar 2021 07:59:51 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     kernel test robot <oliver.sang@intel.com>,
        Jann Horn <jannh@google.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com
Subject: Re: [mm, slub] 8ff60eb052: stress-ng.rawpkt.ops_per_sec -47.9%
 regression
In-Reply-To: <CAHk-=wh+RFzJqa51aO2zgGFhgV7=WjTs82B2wFfCMEHPs4B49g@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2103100757530.128125@gentwo.de>
References: <20210301080404.GF12822@xsang-OptiPlex-9020> <CAHk-=wh+RFzJqa51aO2zgGFhgV7=WjTs82B2wFfCMEHPs4B49g@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2021, Linus Torvalds wrote:

> So when you wrote:
>
>     However, the current code accidentally stops looking at the partial list
>     completely in that case.  Especially on kernels without CONFIG_NUMA set,
>     this means that get_partial() fails and new_slab_objects() falls back to
>     new_slab(), allocating new pages.  This could lead to an unnecessary
>     increase in memory fragmentation.
>
> it really looks like this might well have been very intentional
> indeed. Or at least very beneficial for _some_ loads.
>
> Comments?

Yes the thought was that adding an additional page when contention is
there on the page objects will increase possible concurrency while
avoiding locks and increase the ability to allocate / free concurrently
from a multitude of objects.

