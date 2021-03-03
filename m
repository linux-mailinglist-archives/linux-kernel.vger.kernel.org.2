Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC8B32B728
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378379AbhCCKuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:50:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236509AbhCCAKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:10:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80B7164F3A;
        Wed,  3 Mar 2021 00:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614730177;
        bh=qeeUDwfr0PBVRlyvaVguj6Rn4ftKSnuJ4NgKsaLBjj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h8Zty9OGTW+xWJkfMq0rDhs48CXMNkTvekzj4VA+qTY3L/J6zK10uc5jswUTSIBnN
         bSdgD0qFvGWoJKd0dE8xGUphznMVVYhS9cB+lKeBIImD1C6JBIvtOohSGf3ZAEI9T7
         GTMjT36srToi6cqQF3qhFBAV8gTGLaZ1XmbV0RUA=
Date:   Tue, 2 Mar 2021 16:09:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Cleanup and fixups for vmemmap handling
Message-Id: <20210302160935.eb91809c253d1caa7d0e896d@linux-foundation.org>
In-Reply-To: <20210301083230.30924-1-osalvador@suse.de>
References: <20210301083230.30924-1-osalvador@suse.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Mar 2021 09:32:27 +0100 Oscar Salvador <osalvador@suse.de> wrote:

> Hi Andrew,
> 
> Now that 5.12-rc1 is out, and as discussed, here there is a new version on top
> of it.
> Please, consider picking up the series.
>

I grabbed them, but...

> 
>  arch/x86/mm/init_64.c | 189 +++++++++++++++++++++++++++++++-------------------

Perhaps a better route would be via an x86 tree.
