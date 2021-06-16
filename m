Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362BB3A9950
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhFPLcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:32:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43426 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhFPLcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:32:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 902F0219DB;
        Wed, 16 Jun 2021 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623843034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vgUXDTK2klXPLKB2Vu21NS7HhNeF6vJSVMh/1urAK+0=;
        b=mlBY3yqJmnOWDrHC9OW5VqS5cs8U061H9V0/NhSF+rF6qdOyQn0Z/pzV35Hsl4VgP8yQpq
        vLqOAPsJMCSQ/U93tCHOgLJ1NFcstin7rLI5NEui+ZEtdp+gQdkh+Faof6gtRG1Fqtbx+b
        llmFxNcirfRgR0vpmnKaR26tTqYLo8c=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 72B6EA3B88;
        Wed, 16 Jun 2021 11:30:34 +0000 (UTC)
Date:   Wed, 16 Jun 2021 13:30:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH next v3 2/2] printk: fix cpu lock ordering
Message-ID: <YMng2vvhM1/ySW5X@alley>
References: <20210615174947.32057-1-john.ogness@linutronix.de>
 <20210615174947.32057-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615174947.32057-3-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-06-15 19:55:47, John Ogness wrote:
> The cpu lock implementation uses a full memory barrier to take
> the lock, but no memory barriers when releasing the lock. This
> means that changes performed by a lock owner may not be seen by
> the next lock owner. This may have been "good enough" for use
> by dump_stack() as a serialization mechanism, but it is not
> enough to provide proper protection for a critical section.
> 
> Correct this problem by using acquire/release memory barriers
> for lock/unlock, respectively.
> 
> Note that it is not necessary for a cpu lock to disable
> interrupts. However, in upcoming work this cpu lock will be used
> for emergency tasks (for example, atomic consoles during kernel
> crashes) and any interruptions while holding the cpu lock should
> be avoided if possible.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

The patch looks good to me, except for the problems already
reported for the 1st patch.

Best Regards,
Petr
