Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2570319502
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 22:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhBKVRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 16:17:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:32882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhBKVQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 16:16:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D4E964E42;
        Thu, 11 Feb 2021 21:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613078135;
        bh=mbO6m5llbJrdfaMuY6zxtVJV9r6hd1bdzVwoMOtD6Z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VA5DdiTcfSgEMmDyYeGx0pSQvzGaaLHV+2gti5MCGRqpdZEBDZyQ7ceU3qi5DMNqc
         qiZkVbUbIQZLrQTQU69ndl0vqcb/yifok5Yx15MwAUghKNYCQ1a3FQkwV51PlSuZtP
         xabUFiqXo9xwwJPG2FwXkiPOTXFeJqnHmQyzlr0c=
Date:   Thu, 11 Feb 2021 22:15:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pritthijit Nath <pritthijit.nath@icloud.com>
Cc:     tvboxspy@gmail.com, devel@driverdev.osuosl.org,
        oscar.carter@gmx.com, forest@alittletooquiet.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Fixed issue with alignment in rf.c
Message-ID: <YCWecqogEBTcRlZo@kroah.com>
References: <20210211152426.10008-1-pritthijit.nath@icloud.com>
 <YCWTlWj4KHT6Okq/@kroah.com>
 <141aa6fe-972c-a9a2-f321-65a98ebccc41@icloud.com>
 <YCWXH1MZy0cbDB3G@kroah.com>
 <a94be58e-b503-1fcf-7c5c-158ce7e2d188@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a94be58e-b503-1fcf-7c5c-158ce7e2d188@icloud.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 02:32:51AM +0530, Pritthijit Nath wrote:
> On 12/02/21 2:14 am, Greg KH wrote:
> > On Fri, Feb 12, 2021 at 02:07:50AM +0530, Pritthijit Nath wrote:
> >> On 12/02/21 1:59 am, Greg KH wrote:
> >>> On Thu, Feb 11, 2021 at 08:54:26PM +0530, Pritthijit Nath wrote:
> >>>> This change fixes a checkpatch CHECK style issue for "Alignment should match open parenthesis".
> >>>>
> >>>> Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
> >>>> ---
> >>>>  drivers/staging/vt6656/rf.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
> >>>> index 5b8da06e3916..bcd4d467e03a 100644
> >>>> --- a/drivers/staging/vt6656/rf.c
> >>>> +++ b/drivers/staging/vt6656/rf.c
> >>>> @@ -687,7 +687,7 @@ static int vnt_rf_set_txpower(struct vnt_private *priv, u8 power,
> >>>>  
> >>>>  			if (hw_value < ARRAY_SIZE(vt3226d0_lo_current_table)) {
> >>>>  				ret = vnt_rf_write_embedded(priv,
> >>>> -					vt3226d0_lo_current_table[hw_value]);
> >>>> +							    vt3226d0_lo_current_table[hw_value]);
> >>>>  				if (ret)
> >>>>  					return ret;
> >>>>  			}
> >>>> -- 
> >>>> 2.25.1
> >>>
> >>> Please run this change, with the changelog above, through
> >>> checkpatch.pl, fix that, and resend.
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>>
> >>
> >> This change fixes a checkpatch CHECK style issue for "Alignment should 
> >> match open parenthesis".
> >>
> >> Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
> >> ---
> >>  drivers/staging/vt6656/rf.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
> >> index 5b8da06e3916..bcd4d467e03a 100644
> >> --- a/drivers/staging/vt6656/rf.c
> >> +++ b/drivers/staging/vt6656/rf.c
> >> @@ -687,7 +687,7 @@ static int vnt_rf_set_txpower(struct vnt_private *priv, u8 power,
> >>  
> >>  			if (hw_value < ARRAY_SIZE(vt3226d0_lo_current_table)) {
> >>  				ret = vnt_rf_write_embedded(priv,
> >> -					vt3226d0_lo_current_table[hw_value]);
> >> +							    vt3226d0_lo_current_table[hw_value]);
> >>  				if (ret)
> >>  					return ret;
> >>  			}
> > 
> > I can't take this type of submission, do you see other patches submitted
> > this way on the mailing list?
> Actually I am having a hard time since this one's my first. I would really appreciate if you could be a little clear. Should I resend the entire patch as a new thread?

Of course, the kernel documentation says to do this, correct?

Look at the patches on the list for examples of how this works.

thanks,

greg k-h
