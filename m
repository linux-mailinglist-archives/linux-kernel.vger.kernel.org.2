Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6530330C09
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhCHLNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:13:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:58602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231272AbhCHLMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:12:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D845BAC54;
        Mon,  8 Mar 2021 11:12:38 +0000 (UTC)
Date:   Mon, 8 Mar 2021 12:12:39 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] scripts/decodecode: Decode 32-bit code correctly
 on x86_64
Message-ID: <20210308111239.GB12818@zn.tnic>
References: <20210305183948.37738-1-andriy.shevchenko@linux.intel.com>
 <20210305221951.GC2896@zn.tnic>
 <CAHp75VdoGShdAQFkx5PR-H6=csRA_ReaerDg6iy54AMJF+kaOg@mail.gmail.com>
 <20210308101719.GA12818@zn.tnic>
 <CAHp75Vc=AvArhekQSufNA+0OsxnsQikmignNt7=+h_t5=Ks_6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vc=AvArhekQSufNA+0OsxnsQikmignNt7=+h_t5=Ks_6Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 12:22:34PM +0200, Andy Shevchenko wrote:
> For the ARM we have to provide ARCH, for x86 a variety of all the flags.

For x86 you have to provide only AFLAGS.

If you want to make this script parse proper cmdline options like
--arch, --width and --help along with keeping the old methods
functional, I guess that would be ok.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
