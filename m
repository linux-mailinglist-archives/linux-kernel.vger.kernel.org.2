Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E9539A1F9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhFCNRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:17:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53350 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhFCNRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:17:10 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4C46A1FD3D;
        Thu,  3 Jun 2021 13:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622726125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=in/G7fzdUcdCv5ZvDLh1mBytHpj8YQlTgchvITKLgrI=;
        b=s2HVubBUAFMVIIBjzD6M5Q/51LKPRFDNTX+TTbtibiMCt35kBNIuyO8UTr91ktRk6WvVrg
        YUozOtp8nzkqaAWHnmIdwXvE/+KbqCVhfJqKoVvLJ+12M5gUE/Rg/qrXlMDhnHrMQ6vOuG
        nUTUy6G7nHvpT3jxMX9wAubNQ0SlcCk=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C6390A3B8B;
        Thu,  3 Jun 2021 13:15:24 +0000 (UTC)
Date:   Thu, 3 Jun 2021 15:15:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 4/4] slub: Force on no_hash_pointers when slub_debug
 is enabled
Message-ID: <YLjV7JLb2lmegRW9@alley>
References: <20210601182202.3011020-1-swboyd@chromium.org>
 <20210601182202.3011020-5-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601182202.3011020-5-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-06-01 11:22:02, Stephen Boyd wrote:
> Obscuring the pointers that slub shows when debugging makes for some
> confusing slub debug messages:
> 
>  Padding overwritten. 0x0000000079f0674a-0x000000000d4dce17
> 
> Those addresses are hashed for kernel security reasons. If we're trying
> to be secure with slub_debug on the commandline we have some big
> problems given that we dump whole chunks of kernel memory to the kernel
> logs. Let's force on the no_hash_pointers commandline flag when
> slub_debug is on the commandline. This makes slub debug messages more
> meaningful and if by chance a kernel address is in some slub debug
> object dump we will have a better chance of figuring out what went
> wrong.
> 
> Note that we don't use %px in the slub code because we want to reduce
> the number of places that %px is used in the kernel. This also nicely
> prints a big fat warning at kernel boot if slub_debug is on the
> commandline so that we know that this kernel shouldn't be used on
> production systems.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
