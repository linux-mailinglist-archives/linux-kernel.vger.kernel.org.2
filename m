Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33203D182E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhGUTxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhGUTxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:53:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A24361003;
        Wed, 21 Jul 2021 20:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626899629;
        bh=HGW9P5rDF0FNLmwvEm5vgK5A2289qfyqH5xqCSY5fF4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=tbmRbVK+eDC8G8iXO6Y5jm5CNLGCe0+N0gILT39ZCVuajmInUcq/8zP+d8OGLzD5M
         BmJGfWxXxqTOFbTjod1Nbr+rj2vsST8sFOF6SkWhtxMYDZqzHVDrAk6CMErdelS11/
         g2IF1WDvpCPw2gmR6cMLZgL//vPXcYo1UzgG7v8cO15yae2dms48RmBqvzLNmUub3g
         xwnOgjPaNsxgCW4uhwSW7350ecUWGxhGF9bCpoaYsV80yhPboq/JsKx/GrqQuXmCgr
         Q+t0jFXfIor1lui1EkXGQMvnput/TaPtiD2IXibnMgH+skDVXWI7orMkZG8yh10j5r
         6iaCRh5LE01Ig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 10C985C09A4; Wed, 21 Jul 2021 13:33:49 -0700 (PDT)
Date:   Wed, 21 Jul 2021 13:33:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     broonie@kernel.org
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org
Subject: nolibc and __attribute__((__unused__))
Message-ID: <20210721203349.GA3209274@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

My guess is that I should ignore the following checkpatch complaint on
the assumption that checkpatch doesn't realize that this is not built
as part of the Linux kernel.  But if my guess is incorrect, please let
me know, as it is a trivial change to make.

							Thanx, Paul

------------------------------------------------------------------------

-------------------------------------------------
/tmp/rcu/0002-tools-nolibc-Implement-msleep.patch
-------------------------------------------------
WARNING: __always_unused or __maybe_unused is preferred over __attribute__((__unused__))
#24: FILE: tools/include/nolibc/nolibc.h:2246:
+static __attribute__((unused))

total: 0 errors, 1 warnings, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/tmp/rcu/0002-tools-nolibc-Implement-msleep.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
