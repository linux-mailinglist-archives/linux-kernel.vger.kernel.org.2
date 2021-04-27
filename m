Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C1936C832
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbhD0PBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:01:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236144AbhD0PBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:01:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C505961040;
        Tue, 27 Apr 2021 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619535665;
        bh=OC4/qlmmod8S1lp4PDb7I6TD9Zf4cbEBS/O+ifD0CFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3ZJQ/B5fBrjM7stmhRy3sKAI7pPXzCGfphXxuM91qf8WP88jPmGCo9wC/Yiq2Ywc
         8Qfv75UYGgTKww4mPmPx1Dxp/jlSkd+tPFlkYaTcADVKOxITL5t1VYTQDF8DY2Qqpb
         APTB1w+nNUnTVWdfsq8pEllfc3CiGcSI+C7F5QGQZNKesmTC41Ei89BwP5gS/kTnYk
         jpu3a8zip71uxCdcF0GgrCFOcM/LJq9bBq0/A7oBdwU63u7waEcRiodWNXGLHjQ3CL
         BlBNvWeSZRpXO4z7ziDX3BKsEL72DPc0Va9egV7OnEsON3tFPebZCozZpqUgKefNNS
         AAuk6w1w8USgA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lbPDC-0002xR-Na; Tue, 27 Apr 2021 17:01:19 +0200
Date:   Tue, 27 Apr 2021 17:01:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coccinelle: api: semantic patch to use
 pm_runtime_resume_and_get
Message-ID: <YIgnPkx3NEsOITZH@hovoldconsulting.com>
References: <20210426185404.2466195-1-Julia.Lawall@inria.fr>
 <YIgPNRiaz2Jup+PT@hovoldconsulting.com>
 <alpine.DEB.2.22.394.2104271542170.5173@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2104271542170.5173@hadrien>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 03:44:25PM +0200, Julia Lawall wrote:
> On Tue, 27 Apr 2021, Johan Hovold wrote:
> 
> > On Mon, Apr 26, 2021 at 08:54:04PM +0200, Julia Lawall wrote:
> > > pm_runtime_get_sync keeps a reference count on failure, which can lead
> > > to leaks.  pm_runtime_resume_and_get drops the reference count in the
> > > failure case.  This rule very conservatively follows the definition of
> > > pm_runtime_resume_and_get to address the cases where the reference
> > > count is unlikely to be needed in the failure case.
> > >
> > > pm_runtime_resume_and_get was introduced in
> > > commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
> > > deal with usage counter")
> > >
> > > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> >
> > As I've said elsewhere, not sure trying to do a mass conversion of this
> > is a good idea. People may not be used to the interface, but it is
> > consistent and has its use. The recent flurry of conversions show that
> > those also risk introducing new bugs in code that is currently tested
> > and correct.
> 
> I looked some of the patches you commented on, and this rule would not
> have transformed those cases.  This rule is very restricted to ensure that
> the transformed code follows the behavior of the new function.

Ah, ok. I didn't look too closely at the semantic patch itself and
wrongly associated it with the all-or-nothing media subsystem
conversions.

Thanks for clarifying further in v3 too.

Still a bit worried that this will push the cleanup crew to send more
broken patches since it sends a signal that pm_runtime_get_sync() is
always wrong. But guess there's not much to do about that now after
having added pm_runtime_resume_and_get() in the first place.

Johan
