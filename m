Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEAA4117BD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbhITPEK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Sep 2021 11:04:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:9745 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231887AbhITPEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:04:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="210228951"
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="210228951"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 08:02:29 -0700
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="548820723"
Received: from msgunjal-mobl.amr.corp.intel.com (HELO localhost) ([10.249.254.154])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 08:02:24 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <YUSUb+JP+e0f+00G@hirez.programming.kicks-ass.net>
References: <96ab9cf1-250a-8f34-51ec-4a7f66a87b39@linux.intel.com> <a7e5d99d-39c4-6d27-3029-4689a2a1a17a@linux.intel.com> <YTtznr85mg5xXouP@hirez.programming.kicks-ass.net> <e8a7754e-23e7-0250-5718-101a56d008f0@linux.intel.com> <YUBGPdDDjKlxAuXJ@hirez.programming.kicks-ass.net> <205e1591-343b-fb77-cfca-9c16af1484bd@linux.intel.com> <YUCpfrbfPSZvD3Xl@phenom.ffwll.local> <a374d768-213e-58e7-d281-1c46d1c0c105@linux.intel.com> <YUNGaztoBrTzEuEG@hirez.programming.kicks-ass.net> <YUSUb+JP+e0f+00G@hirez.programming.kicks-ass.net>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/locking: Add context to ww_mutex_trylock.
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <163215014127.5950.11970655278841631448@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date:   Mon, 20 Sep 2021 18:02:21 +0300
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peter Zijlstra (2021-09-17 16:13:19)
> On Thu, Sep 16, 2021 at 03:28:11PM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 16, 2021 at 03:00:39PM +0200, Maarten Lankhorst wrote:
> > 
> > > > For merge logistics, can we pls have a stable branch? I expect that the
> > > > i915 patches will be ready for 5.16.
> > > >
> > > > Or send it in for -rc2 so that the interface change doesn't cause needless
> > > > conflicts, whatever you think is best.
> > 
> > > Yeah, some central branch drm could pull from, would make upstreaming patches that depends on it easier. :)
> > 
> > I think I'll make tip/locking/wwmutex and include that in
> > tip/locking/core, let me have a poke.
> 
> This is now so. Enjoy!

This is now merged to drm-intel-gt-next.

Regards, Joonas
