Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091AC40F5D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242517AbhIQKYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:24:32 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:53267 "EHLO mail.acc.umu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242482AbhIQKYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:24:25 -0400
X-Greylist: delayed 520 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Sep 2021 06:24:25 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by amavisd-new (Postfix) with ESMTP id 8B11444B93;
        Fri, 17 Sep 2021 12:14:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=acc.umu.se; s=mail1;
        t=1631873660; bh=KztPZmU+5xTMHtUa0iCgg32W0diJaeLOK5SO08JfWFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pFMxG27sGuPuviTQE11SXg1E9HF3VeSypxrjvnv2+ak8OO4GhgSCC29tedujcHtmH
         s3GhpqWq/ItBmJ4dgRVqkjFQEUE9R0Uo3yap9TlMcmvBSweNpp7w9wWeQmI923cOrr
         Aif6XmQwmOCTQLYwMNNcGpOME+U/nbmxjHuOMDF8ncO75CvHRHRL5d5Utu70Q5kTDb
         k5HB4RmsFViFqOgndKOLTuuL2j9hvN10mJv5Kja3rtY1DV8CPMF+/rxaFIaiTsPZ/M
         ifGhgctMZYzL881unYl5mmp8kBWhSAknHEH2ebEvjJlZaWI32M27GYjImNIOj/aj84
         20mgVeo6T1HuQ==
Received: by mail.acc.umu.se (Postfix, from userid 24471)
        id 246C344B97; Fri, 17 Sep 2021 12:14:20 +0200 (CEST)
Date:   Fri, 17 Sep 2021 12:14:19 +0200
From:   Anton Lundin <glance@acc.umu.se>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Issue with panic handling and ipmi
Message-ID: <20210917101419.GE108031@montezuma.acc.umu.se>
References: <20210916145300.GD108031@montezuma.acc.umu.se>
 <20210916163945.GY545073@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210916163945.GY545073@minyard.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 September, 2021 - Corey Minyard wrote:

> On Thu, Sep 16, 2021 at 04:53:00PM +0200, Anton Lundin wrote:
> > Hi.
> > 
> > I've just done a upgrade of the kernel we're using in a product from
> > 4.19 to 5.10 and I noted a issue.
> > 
> > It started that with that we didn't get panic and oops dumps in our erst
> > backed pstore, and when debugging that I noted that the reboot on panic
> > timer didn't work either.
> > 
> > I've bisected it down to 2033f6858970 ("ipmi: Free receive messages when
> > in an oops").
> 
> Hmm.  Unfortunately removing that will break other things.  Can you try
> the following patch?  It's a good idea, in general, to do as little as
> possible in the panic path, this should cover a multitude of issues.
> 
> Thanks for the report.
> 

I'm sorry to report that the patch didn't solve the issue, and the
machine locked up in the panic path as before.


//Anton
