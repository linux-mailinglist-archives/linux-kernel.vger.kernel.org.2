Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7467A392DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhE0MWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:22:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234091AbhE0MWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:22:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FA9B61378;
        Thu, 27 May 2021 12:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622118044;
        bh=HKu/HMwWXdwURReHl42wjp+0rqU0wvS5S7SxeTvFjrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QPeK3h1DpK6xOpJI0daY6S64ANC69Lm0Pawj+gEE+VfLyqcNPe5iiKrXkDUHFrFk3
         OsSqcPt3+79m6kLyLFpNQkTWfXs/a6JQBkDiPbys8zPLe74ejl94XI6nwONy72OFXu
         rcvFzcpaJ3CRDqwLXFX0e1P3nsiWBxKtp72dimyw=
Date:   Thu, 27 May 2021 14:20:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ttyprintk: remove redundant initialization of
 variable i
Message-ID: <YK+OmWBq8HmyuM5A@kroah.com>
References: <20210518182126.140978-1-colin.king@canonical.com>
 <YKeqUBZ+Zy/mvZNQ@kroah.com>
 <73809ad0-cdb0-695e-c9aa-55b6f8f3710b@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73809ad0-cdb0-695e-c9aa-55b6f8f3710b@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 09:54:37AM +0100, Colin Ian King wrote:
> On 21/05/2021 13:40, Greg Kroah-Hartman wrote:
> > On Tue, May 18, 2021 at 07:21:26PM +0100, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> The variable i is being initialized with a value that is never read,
> >> it is being updated later on.  The assignment is redundant and can be
> >> removed.
> >>
> >> Addresses-Coverity: ("Unused value")
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >> ---
> >>  drivers/char/ttyprintk.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> >> index 219fa1382396..230b2c9b3e3c 100644
> >> --- a/drivers/char/ttyprintk.c
> >> +++ b/drivers/char/ttyprintk.c
> >> @@ -52,7 +52,7 @@ static void tpk_flush(void)
> >>  
> >>  static int tpk_printk(const unsigned char *buf, int count)
> >>  {
> >> -	int i = tpk_curr;
> >> +	int i;
> >>  
> >>  	for (i = 0; i < count; i++) {
> >>  		if (tpk_curr >= TPK_STR_SIZE) {
> >> -- 
> >> 2.31.1
> >>
> > 
> > This is not ok for what is currently in linux-next :(
> 
> Hmm, it applies cleanly on today's linux-next, do you mind re-apply it?

Argh, I was looking at the wrong tree, sorry, now queued up.

thanks,

greg "I have too many different trees" k-h
