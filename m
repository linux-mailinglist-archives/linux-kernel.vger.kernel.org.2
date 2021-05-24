Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD8138E57F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhEXLdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:33:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:39516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232050AbhEXLdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:33:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621855933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l4+YR55d73GMIRIIlhwxLCsLisFSGbrwblla1Qo1l+U=;
        b=HC/MwSOYsmtSMg+sZk4b9YxGLPj9SzNWvf6WXi+952zumYJshJGJaqKgk9p4bd5VnmEb90
        RtGn5D4y3BNZQP3ywjsnqmUUTa4hoz1V3Bl0nzMu45nF2MaCkKOD5ciF2ZhgxQG+bo8ma/
        OdRyaifMK23g+QrvhVyVSEkyGWa60ao=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 86CF6AD8A;
        Mon, 24 May 2021 11:32:13 +0000 (UTC)
Date:   Mon, 24 May 2021 13:32:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] slub: Print raw pointer addresses when debugging
Message-ID: <20210524113213.h33k3t2exr5rlwin@pathway.suse.cz>
References: <20210520013539.3733631-1-swboyd@chromium.org>
 <20210520013539.3733631-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520013539.3733631-3-swboyd@chromium.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-05-19 18:35:38, Stephen Boyd wrote:
> Obscuring the pointers that slub shows when debugging makes for some
> confusing slub debug messages:
> 
>  Padding overwritten. 0x0000000079f0674a-0x000000000d4dce17
> 
> Those addresses are hashed for kernel security reasons. If we're trying
> to be secure with slub_debug on the commandline we have some big
> problems given that we dump whole chunks of kernel memory to the kernel
> logs. Let's use %px here and dump buffers with the actual address for
> the buffer instead of the hashed version so that the logs are
> meaningful. This also helps if a kernel address is in some slub debug
> report so we can figure out that the object is referencing itself.

Please, do not do this!

Use "no_hash_pointers" commandling option when you want to see
raw pointers. It will make it clear when the kernel logs are save
and when not.

If "slub_debug" is useless with hashed pointers then it might enable
"no_hash_pointers". But make sure that it prints the fat warning.

This patch is the worst approach. We have to keep the number of "%px"
callers at minimum to keep it maintainable. The only safe use-case is
when the system is in panic() [*]. If the pointers might be printed
at any time then users should be warned by the fat message printed
by "no_hash_pointers".


[*] Raw pointers are currently printed also by Oops/WARN messages.
    It is from historic reasons. Anyway, they are fat warnings
    on its own. The system often need to get reported anyway.


Best Regards,
Petr
