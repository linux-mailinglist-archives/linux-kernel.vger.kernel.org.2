Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A993B0AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 18:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhFVQyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 12:54:07 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:57026 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231351AbhFVQyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:54:04 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 15MGpinG012272;
        Tue, 22 Jun 2021 18:51:44 +0200
Date:   Tue, 22 Jun 2021 18:51:44 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/nolibc: Implement msleep()
Message-ID: <20210622165144.GC11871@1wt.eu>
References: <20210512123215.42321-1-broonie@kernel.org>
 <20210512132102.GD20883@1wt.eu>
 <20210622164804.GG4574@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622164804.GG4574@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Jun 22, 2021 at 05:48:04PM +0100, Mark Brown wrote:
> On Wed, May 12, 2021 at 03:21:02PM +0200, Willy Tarreau wrote:
> > On Wed, May 12, 2021 at 01:32:15PM +0100, Mark Brown wrote:
> > > Allow users to implement shorter delays than a full second by implementing
> > > msleep().
> > > 
> > > Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> > Great, now queued, thank you Mark!
> 
> This doesn't seem to be showing up in -next, did it get missed or is the
> queue it's in not in -next?

I planned to send the two patches I have in this branch to Paul
this week, will do so ASAP.

Thanks,
Willy
