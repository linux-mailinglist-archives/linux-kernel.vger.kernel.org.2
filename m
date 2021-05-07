Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C56E3764E0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 14:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhEGMHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 08:07:11 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21368 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhEGMHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 08:07:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620389165; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=UpEQCoHhDQKGv6r3fN5d01+wDAwQaB1PKZypPzxAbm+lLmM2wexZhU2ssq64TTDHEGDpi6Z7Leq9mUoWbHhPb6s9JH8lQ5uqSnKcwmyMFNpz+7dOeGyzULAYlO1YUn7RXO/OKv6fc9IpDRosMfO30LqV/Qlq85e1D0jz3vtgZZU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1620389165; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=p3Pk7bLis/jKEPW//LziYX2PKmJ0sD7MTLSUsjG64FY=; 
        b=j1ByB3WR3rZwytaAv+0v8Z/SJME8GbXvIuGCXIgrJUPYgwNnPko1mJgrRDdyEzLbN271WXWM5cujJWkQ0da8CPg5l5tB4V5Vxsk8hZVcGU9RawknpVL+R+GC21PBICc+uR7YveSA92mDa/OYdzF8OH/9vj+ESM47qXxjDAv1SEo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1620389165;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
        bh=p3Pk7bLis/jKEPW//LziYX2PKmJ0sD7MTLSUsjG64FY=;
        b=ldO7Q7pbL1ogBwqgRQXuzZQacYC8EuRrU5lnBkIuqD7DOnIy5F+KDi9Y5tWWe1ql
        oJjTvogwD9Y+Spmp90lNSzpIgIKX4Gurrcp38xyNCiyUgzHldy4BmWSTskC7uJ0OQ8R
        3unZnjdO1DZiOfDn46sxxWqHFGH6ctabQ60K9uZQ=
Received: from anirudhrb.com (49.207.210.243 [49.207.210.243]) by mx.zohomail.com
        with SMTPS id 1620389154890739.5910943620871; Fri, 7 May 2021 05:05:54 -0700 (PDT)
Date:   Fri, 7 May 2021 17:35:48 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rapidio: fix unused variable warning in rio_cm.c
Message-ID: <YJUtHCSm//0PlyYf@anirudhrb.com>
References: <20210506181837.4758-1-mail@anirudhrb.com>
 <YJTgmXwZyOgFPIHf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YJTgmXwZyOgFPIHf@kroah.com>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 08:39:21AM +0200, Greg KH wrote:
> On Thu, May 06, 2021 at 11:48:36PM +0530, Anirudh Rayabharam wrote:
> > GCC produces an unused variable warning for 'rc':
> > 
> > 	drivers/rapidio/rio_cm.c: In function ‘rio_txcq_handler’:
> > 	drivers/rapidio/rio_cm.c:673:7: warning: variable ‘rc’ set but
> > 	not used [-Wunused-but-set-variable]
> > 
> > The return value of rio_add_outb_message() is assigned to 'rc' but it
> > is never used. Fix this warning by logging an error if 'rc' is non-zero.
> > 
> > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > ---
> > 
> > Changes in v2:
> > Log an error instead of just removing 'rc'.
> > 
> > v1: https://lore.kernel.org/lkml/20210501055018.9244-1-mail@anirudhrb.com/
> > 
> > ---
> >  drivers/rapidio/rio_cm.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
> > index 50ec53d67a4c..971a36f1a23a 100644
> > --- a/drivers/rapidio/rio_cm.c
> > +++ b/drivers/rapidio/rio_cm.c
> > @@ -677,6 +677,11 @@ static void rio_txcq_handler(struct cm_dev *cm, int slot)
> >  			cm->tx_buf[cm->tx_slot] = req->buffer;
> >  			rc = rio_add_outb_message(cm->mport, req->rdev, cmbox,
> >  						  req->buffer, req->len);
> > +			if (rc) {
> > +				riocm_error("Failed to add msg to tx queue (err=%d)",
> > +						rc);
> 
> That's pretty pointless (and no need for {}).

The point is that this fixes the compiler warning.

I used the {} because I had to split the statement into two lines and
thought it is more readable with the {}. checkpatch didn't complain
about it either.

> 
> If an error happens, properly recover from it, don't just punt and tell
> the user something bad happened and then ignore it.

The primary motivation behind this patch is to fix the compiler warning.
This error is ignored even in the current tree. My patch at least logs it
so that people know that it's happening. And once they know that it's
happening and someone wants to propagate the error code to userspace or
handle it differently they can write a patch to do so.

Thanks!

	- Anirudh.
