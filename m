Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A164A44654A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 15:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhKEO7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 10:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233278AbhKEO7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 10:59:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F0896120E;
        Fri,  5 Nov 2021 14:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636124185;
        bh=o/e3Kg4XQetn+fV8ykmX1Wv4U8T/q0l5MdvRDWYx79g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0VMZWrHUHHqJINgGjRtwz6b9NlqlkxOTYeTvEXgxgPF50k491UbCwZPePjrehBcY
         LvB7IQTZefNIDSJhpyXy80uuxPEQft2ho7QazhOOkExulyRntyQN+wMS8ExQPviMwi
         LLXK4WACNA+nM2IjZk4Xyfl6X6zMMpHGurq6C4pdiCij49ftRC9wi9SA59yAHKAYYi
         TO03gV5Df4Yso7q2bVju4clQdqP+Glim1OsCF97pv0HOsHcHuZkUkhC92qb24kkbUL
         ofQ0t20/JYa9BJGkrdRGrQRS00SQHOQQXApjWOmuzDmKl3Rzev7cEYu6kqyXJCTpZN
         /l1bp9mJl/VhA==
Date:   Fri, 5 Nov 2021 07:56:17 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     John Keeping <john@metanate.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] usb: dwc2: hcd_queue: Fix use of floating point literal
Message-ID: <YYVGEVass1f5El8C@archlinux-ax161>
References: <20211104215923.719785-1-nathan@kernel.org>
 <YYUs4PME9QizsPTt@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYUs4PME9QizsPTt@donbot>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 01:08:48PM +0000, John Keeping wrote:
> On Thu, Nov 04, 2021 at 02:59:23PM -0700, Nathan Chancellor wrote:
> > A new commit in LLVM causes an error on the use of 'long double' when
> > '-mno-x87' is used, which the kernel does through an alias,
> > '-mno-80387' (see the LLVM commit below for more details around why it
> > does this).
> > 
> >  drivers/usb/dwc2/hcd_queue.c:1744:25: error: expression requires  'long double' type support, but target 'x86_64-unknown-linux-gnu' does not support it
> >                          delay = ktime_set(0, DWC2_RETRY_WAIT_DELAY);
> >                                              ^
> >  drivers/usb/dwc2/hcd_queue.c:62:34: note: expanded from macro 'DWC2_RETRY_WAIT_DELAY'
> >  #define DWC2_RETRY_WAIT_DELAY (1 * 1E6L)
> >                                  ^
> >  1 error generated.
> > 
> > This happens due to the use of a 'long double' literal. The 'E6' part of
> > '1E6L' causes the literal to be a 'double' then the 'L' suffix promotes
> > it to 'long double'.
> > 
> > There is no visible reason for a floating point value in this driver, as
> > the value is only used as a parameter to a function that expects an
> > integer type.  Use USEC_PER_SEC, which is the same integer value as
> > '1E6L', to avoid changing functionality but fix the error.
> > 
> > Fixes: 6ed30a7d8ec2 ("usb: dwc2: host: use hrtimer for NAK retries")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1497
> > Link: https://github.com/llvm/llvm-project/commit/a8083d42b1c346e21623a1d36d1f0cadd7801d83
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  drivers/usb/dwc2/hcd_queue.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
> > index 89a788326c56..bdf1927e1be1 100644
> > --- a/drivers/usb/dwc2/hcd_queue.c
> > +++ b/drivers/usb/dwc2/hcd_queue.c
> > @@ -59,7 +59,7 @@
> >  #define DWC2_UNRESERVE_DELAY (msecs_to_jiffies(5))
> >  
> >  /* If we get a NAK, wait this long before retrying */
> > -#define DWC2_RETRY_WAIT_DELAY (1 * 1E6L)
> > +#define DWC2_RETRY_WAIT_DELAY (1 * USEC_PER_SEC)
> 
> Using USEC_PER_SEC here seems quite weird.  This is used as:
> 
> 	delay = ktime_set(0, DWC2_RETRY_WAIT_DELAY);
> 
> so the units are nanoseconds.
> 
> Maybe NSEC_PER_MSEC would better indicate the intent here?

Yes, that seems reasonable. I will send a v2.

Cheers,
Nathan
