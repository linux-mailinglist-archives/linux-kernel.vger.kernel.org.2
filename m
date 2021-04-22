Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08763688C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 23:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhDVV47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 17:56:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:38862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232844AbhDVV47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 17:56:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05D7CB01E;
        Thu, 22 Apr 2021 21:56:23 +0000 (UTC)
Date:   Thu, 22 Apr 2021 23:56:15 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: arch/x86/kernel/apic/x2apic_uv_x.c:106 early_get_pnodeid() warn:
 inconsistent indenting
Message-ID: <20210422215615.GE6361@zn.tnic>
References: <202104211946.vkuV39N1-lkp@intel.com>
 <84b4fbc3-0310-b7d7-f613-0eb4ae090e1e@hpe.com>
 <20210422090652.GB6361@zn.tnic>
 <e2e957f1-06f4-29b5-b268-7fd77db25529@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2e957f1-06f4-29b5-b268-7fd77db25529@hpe.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 02:50:27PM -0700, Mike Travis wrote:
> Thanks Boris, I do have a clean up patch to remove more dead code coming,
> I'll put this patch in that if that's okay?

Yes, better, thanks.

Btw, please do not top-post. I think I asked you already.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
