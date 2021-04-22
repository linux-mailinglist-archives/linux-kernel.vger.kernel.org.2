Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B7F367D31
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhDVJHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:07:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:58490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232896AbhDVJHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:07:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A3ABB04F;
        Thu, 22 Apr 2021 09:06:57 +0000 (UTC)
Date:   Thu, 22 Apr 2021 11:06:52 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: arch/x86/kernel/apic/x2apic_uv_x.c:106 early_get_pnodeid() warn:
 inconsistent indenting
Message-ID: <20210422090652.GB6361@zn.tnic>
References: <202104211946.vkuV39N1-lkp@intel.com>
 <84b4fbc3-0310-b7d7-f613-0eb4ae090e1e@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84b4fbc3-0310-b7d7-f613-0eb4ae090e1e@hpe.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 06:38:37PM -0700, Mike Travis wrote:
> I'm a bit confused.  I have this in my inbox that someone else has this fix.
> So will that fix be applied or should I send a separate one that is
> essentially a duplicate?

I'm not even considering that fix because I'm tired of getting some
half-baked robot mails which only resemble patches. The obnoxiousness to
not have the decency to sit down and write a proper commit message is
getting totally out of control.

Apparently some people(?) think that sending robot output to real humans
*without* even vetting that output is a good idea so off to /dev/null it
goes.

If you want this fixed, you could do a proper patch with a sensible
commit message and I'll take it.

I'm tired of dumb robots.

Thx.


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
