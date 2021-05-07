Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2CB3760C1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhEGG6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:58:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:23527 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232974AbhEGG6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:58:37 -0400
IronPort-SDR: VrEl7Cyl/nql9ZtVRrJ3BdWbFAv3huDDW0qjGGq0Z0gTso1iSkw0pjWWoLfV/qF6nDg5xEmYjE
 X7hcMhImzYuQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="259941835"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="259941835"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 23:57:37 -0700
IronPort-SDR: UnRDUhXp1YJ7woWBBKXsCQlMusv9ZIYJsasX7Fo8/Ov0wrjePJAgLPUsXswZk9LXN/8OdSjgMH
 5aLf1swSJOdw==
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="469793342"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 23:57:33 -0700
Date:   Fri, 7 May 2021 15:14:38 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: 08ed4efad6: stress-ng.sigsegv.ops_per_sec -41.9% regression
Message-ID: <20210507071438.GC27263@xsang-OptiPlex-9020>
References: <7abe5ab608c61fc2363ba458bea21cf9a4a64588.1617814298.git.gladkov.alexey@gmail.com>
 <20210408083026.GE1696@xsang-OptiPlex-9020>
 <CAHk-=wigPx+MMQMQ-7EA0pq5_5+kMCNV4qFsOss-WwdCSQmb-w@mail.gmail.com>
 <m1im4wmx9g.fsf@fess.ebiederm.org>
 <20210423024722.GA13968@xsang-OptiPlex-9020>
 <20210423074431.7ob6aqasome2zjbk@example.org>
 <20210428143008.GA19916@xsang-OptiPlex-9020>
 <20210428150952.mdnvl7i4kimgwswh@example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428150952.mdnvl7i4kimgwswh@example.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Alexey,

On Wed, Apr 28, 2021 at 05:09:52PM +0200, Alexey Gladkov wrote:
> 
> Thank you very much for testing and good news for me !!!
> 
> Do you have a place where its possible to see if the patch has been tested?
> I mean test passed or not.

sorry for late.

unfortunately, we don't yet have a public place for this currently,
which is a problem for developer to know the test coverage.

