Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B92330AF8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhCHKRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:17:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:42654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhCHKRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:17:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6F57AD87;
        Mon,  8 Mar 2021 10:17:23 +0000 (UTC)
Date:   Mon, 8 Mar 2021 11:17:19 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] scripts/decodecode: Decode 32-bit code correctly
 on x86_64
Message-ID: <20210308101719.GA12818@zn.tnic>
References: <20210305183948.37738-1-andriy.shevchenko@linux.intel.com>
 <20210305221951.GC2896@zn.tnic>
 <CAHp75VdoGShdAQFkx5PR-H6=csRA_ReaerDg6iy54AMJF+kaOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdoGShdAQFkx5PR-H6=csRA_ReaerDg6iy54AMJF+kaOg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 11:59:34AM +0200, Andy Shevchenko wrote:
> It works, but... The question here is why the script behaviour depends
> so much on the architecture in question (by environment). ARM stuff is
> using traditional ARCH (and that's what I have expected to work),
> while x86 has a set of other variables.
> So, I have to rephrase the commit message then and do actually an
> alias when ARCH is set in a certain way, Would it be better?

No, I have no clue what you're trying to accomplish. You wanted to
supply ARCH when decoding a 32-bit oops because you expected ARCH to
work...?

AFLAGS has always been there, ARM folks added ARCH AFAIR. Also, you need
AFLAGS to compile the snippet in the correct bitsize.

And there's a usage note at the beginning of the script and I always
read it to make sure I'm using it right.

So what's the problem again?

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
