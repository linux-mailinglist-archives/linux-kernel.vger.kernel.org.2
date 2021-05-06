Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD8337536A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 14:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbhEFMG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 08:06:29 -0400
Received: from verein.lst.de ([213.95.11.211]:47473 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231560AbhEFMG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 08:06:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 883BC68AFE; Thu,  6 May 2021 14:05:26 +0200 (CEST)
Date:   Thu, 6 May 2021 14:05:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Andy Lutomirski' <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Christoph Hellwig <hch@lst.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 3/4] x86/uaccess: Use pointer masking to limit
 uaccess speculation
Message-ID: <20210506120526.GA1124@lst.de>
References: <cover.1620186182.git.jpoimboe@redhat.com> <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com> <CALCETrWQrMkeP+=pkNVNvSs9q3ZhhLq_ceHJ-N72Urp2KBrUfQ@mail.gmail.com> <986301bcdc7c488d86dd5f11c988bf87@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986301bcdc7c488d86dd5f11c988bf87@AcuMS.aculab.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 08:36:08AM +0000, David Laight wrote:
> 	uaddr = access_ok(uaddr, size)

access_ok as a public API is not interesting.  There are very few
valid uses cases for ever calling access_ok outside the usual
uaccess helper.  So leave access_ok alone, there is not point in
touching all the callers except for removing most of them.  If OTOH
we can micro-optimize get_user and put_user by using a different
variant of access_ok that seems fair game and actually useful.
