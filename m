Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D576394652
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 19:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbhE1RVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 13:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhE1RVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 13:21:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB30AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:19:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622222379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0OyJWpXtdEE/1aJpzC8z0vyowN1eCXtwmZnV55hFPyA=;
        b=dOJFTXmN05nywmwcIMWLMCZ5TKIL8l+H4Esw/v3AcAy8LPSHq0/xKJJqoRG46Gby9c3QL+
        KRKXLNPj8IvEzwwBWdIiutH2l+xnLCb4sRsOihqYUAlkHc+Ve3PR1LCDrKRkhLZKb9cvhd
        dJDJFMdafa5bSSrElcLPXxpCNcOKumItBzZkzFxU3aukdUWnkO0bP7x508WXdgA6ma4D1C
        uMhn4gXactqza4Qw3oytaWY+Bc8h8Zd/BKR7JmWMRrzMLvMZ8tokf+aQJVjTiYL5QfoW8b
        b1DRsqOj6MHaSJTTC6wvxKIS3uxBQuSHxURCTApi5vRP23wuKSlR9sbqsO9Zwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622222379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0OyJWpXtdEE/1aJpzC8z0vyowN1eCXtwmZnV55hFPyA=;
        b=S6yFH7DPFtdpHsQJjAkQFOugeho/YX7wQB7+I7fXDpGFRxFFQdQUsjGN+3MmyY4/gt3low
        VsoZeRlClygksLAQ==
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>, shuah@kernel.org,
        Babu Moger <babu.moger@amd.com>, dave.kleikamp@oracle.com,
        linuxram@us.ibm.com, bauerman@linux.ibm.com
Subject: Re: [PATCH 0/5] x86/pkeys: PKRU manipulation bug fixes and cleanups
In-Reply-To: <3781d3ec-6d1b-4d04-8bed-19985115153d@www.fastmail.com>
References: <20210527235109.B2A9F45F@viggo.jf.intel.com> <87eedq7u2b.ffs@nanos.tec.linutronix.de> <4c3bfc27-a542-8e91-7ccf-4be8b1e6c844@intel.com> <3781d3ec-6d1b-4d04-8bed-19985115153d@www.fastmail.com>
Date:   Fri, 28 May 2021 19:19:38 +0200
Message-ID: <875yz27p3p.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28 2021 at 10:13, Andy Lutomirski wrote:
> On Fri, May 28, 2021, at 9:11 AM, Dave Hansen wrote:
>> I have a few concerns about moving away from XSAVE management, though.
>> I'm not nixing the whole idea, but there are some things we need to resolve.
>> 
>> First is that there _may_ be ABI concerns.  
>
> I tend to think that, for -stable, we should fix the bug without an ABI change.

See my other mail. It's trivial enough to do.
