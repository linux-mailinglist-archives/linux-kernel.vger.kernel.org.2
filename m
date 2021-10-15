Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9180242F809
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241260AbhJOQZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:25:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:5041 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241225AbhJOQZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:25:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="225406966"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="225406966"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 09:23:02 -0700
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="492623169"
Received: from liminghu-mobl.ccr.corp.intel.com (HELO [10.212.23.213]) ([10.212.23.213])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 09:23:01 -0700
Subject: Re: [RFC PATCH v3 05/13] ASoC: soc-pcm: align BE 'atomicity' with
 that of the FE
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, vkoul@kernel.org,
        broonie@kernel.org, Gyeongtaek Lee <gt82.lee@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
References: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
 <20211013143050.244444-6-pierre-louis.bossart@linux.intel.com>
 <2847a6d1-d97f-4161-c8b6-03672cf6645c@nvidia.com>
 <s5hmtnavisi.wl-tiwai@suse.de>
 <e2a79095-b8ce-9dd4-3e6d-00f8dda99f30@linux.intel.com>
 <s5h1r4muwlj.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8aa4fa07-2b55-3927-f482-c2fd2b01a22e@linux.intel.com>
Date:   Fri, 15 Oct 2021 11:22:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <s5h1r4muwlj.wl-tiwai@suse.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The FE stream locks are necessary only two points: at adding and
> deleting the BE in the link.  We used dpcm_lock in other places, but
> those are superfluous or would make problem if converted to a FE
> stream lock.

I must be missing a fundamental concept here - possibly a set of concepts...

It is my understanding that the FE-BE connection can be updated
dynamically without any relationship to the usual ALSA steps, e.g. as a
result of a control being changed by a user.

So if you only protect the addition/removal, isn't there a case where
the for_each_dpcm_be() loop would either miss a BE or point to an
invalid one?

In other words, don't we need the *same* lock to be used
a) before changing and
b) walking through the list?

I also don't get what would happen if the dpcm_lock was converted to an
FE stream lock. It works fine in my tests, so if there's limitation I
didn't see it.

>>> In addition, a lock around dpcm_show_state() might be needed to be
>>> replaced with card->pcm_mutex, and we may need to revisit whether all
>>> other paths take card->pcm_mutex.
>>
>> What happens if we show the state while a trigger happens? That's my
>> main concern with using two separate locks (pcm_mutex and FE stream
>> lock) to protect the same list, there are still windows of time where
>> the list is not protected.
> 
> With the proper use of mutex, the list itself is protected.
> If we need to protect the concurrent access to each BE in the show
> method, an additional BE lock is needed in that part.  But that's a
> subtle issue, as the link traversal itself is protected by the mutex.

If I look at your patch2, dpcm_be_disconnect() protects the list removal
with the fe stream lock, but the show state is protected by both the
pcm_mutex and the fe stream lock.

I have not been able to figure out when you need
a) the pcm_mutex only
b) the fe stream lock only
c) both pcm_mutex and fe stream lock

