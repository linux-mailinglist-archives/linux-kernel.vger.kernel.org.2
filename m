Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDC73A31AB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 19:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhFJRGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 13:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229895AbhFJRGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 13:06:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2004B613DD;
        Thu, 10 Jun 2021 17:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623344676;
        bh=XK8ZV/P/FXmDo57oE98G1FSZMrwBePkO66V8H3l/9jA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=YOSOhpDkT1zNFJfMh4d3NmA3T1fi9fXbh6twcKJeLyAa+phi+0k6djpFb59sCfufW
         5VJEo8zbyOqHHfk1juWuMWfrI4Qo/S4iSUR6YY6xueFzwz4BH41hCCJNWe5loPzBbx
         ZW1s5bS8fZQOUzzJ2/O1uOQ1b0lSGgzVNJiQNIatvq94mvJqavIdOiG3XhYjZy5vL/
         Nu+s9f097VgGoMehI1lSHOVE1a3fxxM/5qNzzdIAN9W/gs1U6HGg7d5xSyIZmFmbcY
         6FGSae2g9Xif4rRAVXin+ugXk0u05jq3VgsYZJ1uV++ByjOORPA5e/+LuhXkPjJHiT
         UgI3a86TDaOvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D62125C0611; Thu, 10 Jun 2021 10:04:35 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:04:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Question about a8ea6fc9b089 ("sched: Stop PF_NO_SETAFFINITY from
 being inherited by various init system threads")
Message-ID: <20210610170435.GA2187550@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Frederic,

This commit works well, but has the unfortunate side-effect of making
smp_processor_id() complain when used in a preemptible region even
though the kthread has been pinned onto a single CPU by a call to
set_cpus_allowed_ptr().  (Which did return success.)

This isn't a big deal -- I can easily switch to raw_smp_processor_id(),
which is arguably a better choice anyway because it prevents the
complaints from flooding out any real warnings due to error returns
from set_cpus_allowed_ptr() or something else unpinning the kthread.
Which I am in the process of doing:

516e52e9f5ec ("scftorture: Avoid excess warnings")
475d6d49f21d ("refscale: Avoid excess warnings in ref_scale_reader()")

But I figured that I should check to see if this change was in fact
intentional.

							Thanx, Paul
