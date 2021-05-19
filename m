Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A31C388E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353540AbhESNHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:07:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:34422 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241090AbhESNHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:07:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621429578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbkhpI5vBR81uL1ocKfn+lLS/ohpu52DP40R54riGhg=;
        b=fPe9MAdQw7ZpB+CKxHWk2JKhOwonQ7H9YIcb8aiNyLgqvPppg0JwrY+O5cRkKXei2JVI/4
        WO41hO1S0jzcnPKuK+xJVE0fi+xfNabgyQGfKe1OAPdYG0UjytDCGHIj7M9siEe5r7ZGGe
        RM1LK3O+WcRPbwpWzCWCpVze/nh+pMA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D6351AED7;
        Wed, 19 May 2021 13:06:18 +0000 (UTC)
Date:   Wed, 19 May 2021 15:06:18 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     chenguanyou <chenguanyou9338@gmail.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        keescook@chromium.org, lukas.bulwahn@gmail.com, vbabka@suse.cz,
        gpiccoli@canonical.com, chenguanyou <chenguanyou@xiaomi.com>
Subject: Re: [PATCH] hungtask: add filter kthread/check comm
Message-ID: <YKUNSkG5saX2QXhf@dhcp22.suse.cz>
References: <20210519121325.22083-1-chenguanyou@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519121325.22083-1-chenguanyou@xiaomi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-05-21 20:13:25, chenguanyou wrote:
> Some kernel threads are always in D state, when we enable hung_task,
> it will misjudge, we should skip these to narrow the scope.

Why they are in the D state in the first place?

Also you are proposing a new user interface which would need to be
maintained for ever. This means that any such a proposal has to be very
carefully justified. Always make sure to cc linux-api mailing list in
these cases.

From the (not much) information you have provided this interface seems
more like a workaround for buggy code so far.
-- 
Michal Hocko
SUSE Labs
