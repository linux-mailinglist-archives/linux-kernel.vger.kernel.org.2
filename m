Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FDF3B819C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhF3MG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:06:56 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51060 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234387AbhF3MGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:06:55 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lyYwv-0000wZ-7n; Wed, 30 Jun 2021 20:04:13 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lyYwi-0006Yr-SZ; Wed, 30 Jun 2021 20:04:00 +0800
Date:   Wed, 30 Jun 2021 20:04:00 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        syzbot <syzbot+5d1bad8042a8f0e8117a@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jpa@git.mail.kapsi.fi,
        kan.liang@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in
 __fdget_pos
Message-ID: <20210630120400.GA25168@gondor.apana.org.au>
References: <000000000000f3e94a05c5d8686f@google.com>
 <b7f0725f-2731-24af-f15d-1054d6398749@intel.com>
 <CAMj1kXGTV+U-oy=wyHf2KmuzjmaaPJaLBY4mx09tWjL6gCC=rQ@mail.gmail.com>
 <20210630080934.GA24186@gondor.apana.org.au>
 <CAMj1kXFyJ9C4aqq9+DxOMCPOxQUApQK+Oa3V8F0H39wwoK9wxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFyJ9C4aqq9+DxOMCPOxQUApQK+Oa3V8F0H39wwoK9wxA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 11:13:00AM +0200, Ard Biesheuvel wrote:
>
> So something like this, I suppose?

Yes this should work.  Ideally I think it should only call the
walker once instead of potentially three times but I can live
with that :)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
