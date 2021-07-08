Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500DB3BF5C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 08:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhGHGto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 02:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhGHGtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 02:49:43 -0400
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Jul 2021 23:47:02 PDT
Received: from gpm.stappers.nl (gpm.stappers.nl [IPv6:2001:981:6c6a:1::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 031ECC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 23:47:01 -0700 (PDT)
Received: by gpm.stappers.nl (Postfix, from userid 1000)
        id 6F78E3041A7; Thu,  8 Jul 2021 08:39:41 +0200 (CEST)
Date:   Thu, 8 Jul 2021 08:39:41 +0200
From:   Geert Stappers <stappers@stappers.nl>
To:     Matthew Wilcox <willy@infradead.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] Rust support, NVMe
Message-ID: <20210708063941.xkpf6pr4for7y6gj@gpm.stappers.nl>
References: <20210704202756.29107-1-ojeda@kernel.org>
 <YOVNJuA0ojmeLvKa@infradead.org>
 <CANiq72mKPFtB4CtHcc94a_y1V4bEOXXN2CwttQFvyzwXJv62kw@mail.gmail.com>
 <YOWjLmg/Z7kr2+tx@kroah.com>
 <YOW1Nj8+a2Yth2++@google.com>
 <YOXB7FRqldZik2Xn@kroah.com>
 <BFD5298D-00CD-4FEF-AE77-61E69AF78604@kloenk.dev>
 <YOZNuEtNbsLxRM0R@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOZNuEtNbsLxRM0R@casper.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 01:58:32AM +0100, Matthew Wilcox wrote:
> On Wed, Jul 07, 2021 at 10:56:57PM +0200, Finn Behrens wrote:
> > There is a more general use driver (network dummy) still in the
> > making, It is fully operational, just the documentation of the rust
> > bindings are not finished yet, so it is not merged into the rust
> > tree yet, also I have to rebase it.
> 
> Why are you so resistant to writing a real driver that deals with actual hardware?

} Why are we so resistant to writing a real driver that deals with actual hardware?

It is not dodging hardware, it is universal available.


> A simple NVMe driver is less than a thousand lines of C.
> I know the one in the kernel now is ridiculously complicated and has
> been thoroughly messed up with abstractions to support NVMeoF instead
> of having a separate driver, but it's really a simple interface at heart.

Summary of https://qemu.readthedocs.io/en/latest/system/nvme.html

  NVMe hardware is universal available.


 

Groeten
Geert Stappers
-- 
Silence is hard to parse
