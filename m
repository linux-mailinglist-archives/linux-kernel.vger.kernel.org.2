Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A09635D316
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 00:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343733AbhDLW30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 18:29:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:60963 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242505AbhDLW3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:29:24 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13CMLi6p013457;
        Mon, 12 Apr 2021 17:21:44 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 13CMLhsf013456;
        Mon, 12 Apr 2021 17:21:43 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 12 Apr 2021 17:21:43 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Leonardo Bras <leobras.c@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, brking@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] powerpc/iommu: Enable remaining IOMMU Pagesizes present in LoPAR
Message-ID: <20210412222143.GO26583@gate.crashing.org>
References: <20210407195613.131140-1-leobras.c@gmail.com> <87im4xe3pk.fsf@mpe.ellerman.id.au> <8e1ce7e9-415b-92ea-0437-a4331ed3c7f9@ozlabs.ru> <87ft01du50.fsf@mpe.ellerman.id.au> <21407a96-5b20-3fae-f1c8-895973b655ef@ozlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21407a96-5b20-3fae-f1c8-895973b655ef@ozlabs.ru>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 02:36:16PM +1000, Alexey Kardashevskiy wrote:
> On 08/04/2021 19:04, Michael Ellerman wrote:
> >>>>+#define QUERY_DDW_PGSIZE_4K	0x01
> >>>>+#define QUERY_DDW_PGSIZE_64K	0x02
> >>>>+#define QUERY_DDW_PGSIZE_16M	0x04
> >>>>+#define QUERY_DDW_PGSIZE_32M	0x08
> >>>>+#define QUERY_DDW_PGSIZE_64M	0x10
> >>>>+#define QUERY_DDW_PGSIZE_128M	0x20
> >>>>+#define QUERY_DDW_PGSIZE_256M	0x40
> >>>>+#define QUERY_DDW_PGSIZE_16G	0x80
> >>>
> >>>I'm not sure the #defines really gain us much vs just putting the
> >>>literal values in the array below?
> >>
> >>Then someone says "uuuuu magic values" :) I do not mind either way. 
> >>Thanks,
> >
> >Yeah that's true. But #defining them doesn't make them less magic, if
> >you only use them in one place :)
> 
> Defining them with "QUERY_DDW" in the names kinda tells where they are 
> from. Can also grep QEMU using these to see how the other side handles 
> it. Dunno.

And *not* defining anything reduces the mental load a lot.  You can add
a comment at the single spot you use them, explaining what this is, in a
much better way!

Comments are *good*.


Segher
