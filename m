Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CB354366
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 17:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbhDEPZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 11:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232714AbhDEPZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 11:25:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC57461246;
        Mon,  5 Apr 2021 15:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617636338;
        bh=K8oLH+hkZZK9SdfoxJQAz6hEEmqRVdqrNQTW/bype2o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bvaROPCYT3JYUmZbr5mdy0tiaE1f2MU2XZ47qQS8adQxB2YmleOE0tgGf0ZzG18El
         FwwARJYPJbRXWR48NDpfMkrc+rUH6hu3fqtFMrU7xyIg9CwblmFqxwydxaFvJ2LgaZ
         4p3Z9OdSca0hSe3FYGjsCMQUlG7xs7YiQjI1dLvN0tYUwR86YCuj2JiSqdSn5JwZmp
         TENsdLI3rHPqDVNRskZe/8uN5yCvDM6rJaBVWSnEHVQUeom29jvE7bxxyrGfpzAc6D
         kckm5wwtfaUZ089dMkwjFhso0yfHdNiJ7rufW/GkDcM66EnmZVj8T15FJUSYIXtTZq
         gFX/ZbliBC+Cw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A199E35225D5; Mon,  5 Apr 2021 08:25:38 -0700 (PDT)
Date:   Mon, 5 Apr 2021 08:25:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] torture: Correctly fetch CPUs for kvm-build.sh with all
 native language
Message-ID: <20210405152538.GG2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210401132602.116352-1-frederic@kernel.org>
 <20210401185116.GH2696@paulmck-ThinkPad-P72>
 <20210401203112.GA116405@lothringen>
 <20210401204022.GI2696@paulmck-ThinkPad-P72>
 <20210401204113.GB116405@lothringen>
 <20210401210253.GJ2696@paulmck-ThinkPad-P72>
 <20210401210802.GC116405@lothringen>
 <20210401223329.GK2696@paulmck-ThinkPad-P72>
 <442f7b5-6a6e-f2f6-3980-add12adbdb1e@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442f7b5-6a6e-f2f6-3980-add12adbdb1e@trent.utfs.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 04:23:09PM +0200, Christian Kujau wrote:
> On Thu, 1 Apr 2021, Paul E. McKenney wrote:
> > +# This script knows only English.
> > +LANG=en_US.UTF-8; export LANG
> 
> This, too, will only work if en_US.UTF-8 is installed . Check with "locale 
> -a" if it is. Also, Perl will complain loudly if the language is not 
> installed (try: "LANG=en_US.UTF-9 perl"), a nice way to test if LANG works 
> as expected.
> 
> So, wouldn't LANG=C be a more conservative fallback here?

If it works for Frederic, I am good with it.  And yes, we do need to
have a least-common-denominator solution.

> </bikeshed>

Plaid!!!  We must paint the bikeshed plaid!  ;-)

							Thanx, Paul
