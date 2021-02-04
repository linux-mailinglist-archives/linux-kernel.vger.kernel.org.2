Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F29830F3AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbhBDNHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbhBDNHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:07:48 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1F6C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ePYsbz/Ln3PkjTT3PpYfNH1nViM4YQOhcoRTdWBwceE=; b=JmjcodUIScdoj1V6E/QIco7ZHN
        LPwf2oXsyFswzerSBjzhEREGzqFuNGFp69ubOQ72aRBfEXC+iFzFzHoxKLDT1BGxkKk/8IAe5hD8L
        i6UNsmv8l/FmXQ3tAype+dCDQpB2KyUUDhlPFxM8kiuJLsYueD95r443t1pJ+51hfZ3opOovTrwrW
        Lxo7SspRcSuLdy1E3D827H3y3RgVt24D6px8rqYcvnuwTiojXtAXcnRQnnbfktQnRZJmAt5ArXCu8
        UKblZ/xibAwtx3nQCAsQA0Jm89SINP4e8/IWqiuo1ZXUg2cJ4wDXw8BpnrfdWQvPwhb4XQRX+PUNF
        UuO8vVpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7eLd-0004xM-2c; Thu, 04 Feb 2021 13:07:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8336030066E;
        Thu,  4 Feb 2021 14:06:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6842B2138F7C2; Thu,  4 Feb 2021 14:06:59 +0100 (CET)
Date:   Thu, 4 Feb 2021 14:06:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Subject: Re: Process-wide watchpoints
Message-ID: <YBvxc1U/UFhrj0NW@hirez.programming.kicks-ass.net>
References: <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com>
 <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
 <CACT4Y+YeRtOTsMQ8xxZg-=nbv+yuJvYYhBErT46M8jtSHmiw6g@mail.gmail.com>
 <YBqXPmbpXf4hnlj3@hirez.programming.kicks-ass.net>
 <CACT4Y+a-9kqX0ZkNz-ygib+ERn41HVo_8Wx6oYMQmPjTC06j7g@mail.gmail.com>
 <YBqnAYVdNM4uyGny@hirez.programming.kicks-ass.net>
 <CACT4Y+btOt5QFKH9Q=81EnpDHoidJUHE2s0oZ8v65t-b__awuw@mail.gmail.com>
 <YBvAsku9OWM7KUno@hirez.programming.kicks-ass.net>
 <CACT4Y+ZLSyVMkPfh3PftEWKC1kC+o1XLxo_o6i4BiyRuPig27g@mail.gmail.com>
 <YBvj6eJR/DY2TsEB@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBvj6eJR/DY2TsEB@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 01:09:13PM +0100, Peter Zijlstra wrote:

> And I need to dig into that fcntl() crud again, see if that's capable of
> doing a SIGTRAP and if it's possible to target that to the task raising
> it, instead of doing a process wide signal delivery.

Hmm, so it might be possible to extend SETOWN_EX to allow
{F_OWNER_TID,0} to mean any current thread.

And I think SETSIG can be used to set SIGTRAP, although I don't see it
setting the fields you wanted, not entirely sure that's fixable.
