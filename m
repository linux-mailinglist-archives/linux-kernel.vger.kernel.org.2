Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A203F00E1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhHRJrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 05:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhHRJrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:47:37 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD659C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 02:47:02 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4GqNN35V2XzQk15;
        Wed, 18 Aug 2021 11:46:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:references:in-reply-to:message-id:from:from
        :date:date:received; s=mail20150812; t=1629280017; bh=nbNsT6v/Al
        ix4xsNOfDJifZZSf5sB+djMmUcI1ToqDw=; b=gHobhRl+v0EgEVKj3/UOIn40vn
        SJpsr9GwwCSeejwVj8IMuCzW7E9+9ppIyYTB/ZAXN2m+A24V0Dy08PV8vGQ573fW
        2tOPryREejx8fzhLkPWdkGnFLD4lL2kAGWKRYSVE/WVfhqJ61tpjLWmiXVk0ae3I
        Ns0AyE+RPbFbv0TMVmqx3lgOM9VsBKIyTAoc8820MBQ/OTuV8RR/+lXXhjW/5PAK
        geuj6LKHnqt1OGkzclj7/PDENUhuneN5Hfh6l1V7rafXbbo0V98gY/bUdPGjIvU3
        krEooFUjy9MRX4+lGjTQu9JOwVQ504+TFSr6gtPwrApJ+WDuvExYywwEfetA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1629280018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwGg9exsHXRiktj4ujuzbKb55QtZ6x42jkPu9k5wzzc=;
        b=R/HCAqOG09R1tx1WS4y/fNVHOj5BQ50uGkLFrsDZZRsnxb2NZhU3VCxufzb3m/uTrNK7QF
        wsB5hhjCS/qTfvRbf41mIDjUSHWjformy83fe104N5Qj0mn8AqFQkx6SiHGUYQMfoS6BjS
        5IDAV5OYF3lZioMwFbCDLbtl3WPOL/klAIBAPKobPdAvglv50v0GWPzQmi05GVTR/WOwjW
        LjqVFhiE3qe8G899HHkiEahfR5uLf8TlES2Pzu/JmwzdRh+qtK9GNkmYvAPwJeeJPqTI32
        R6oWt3lm2+VoDrcwJQFOv4+4kcRv9aP27Y+Jww0lKo1br8MPidUFxRyNVR3a0A==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id 2snXRikFRMiq; Wed, 18 Aug 2021 11:46:57 +0200 (CEST)
Date:   Wed, 18 Aug 2021 11:46:56 +0200 (CEST)
From:   torvic9@mailbox.org
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "graysky@archlinux.us" <graysky@archlinux.us>
Message-ID: <182968935.121092.1629280016601@office.mailbox.org>
In-Reply-To: <YRyzhWJrqcRZkYRM@infradead.org>
References: <269701460.117528.1629210189833@office.mailbox.org>
 <796036867.117557.1629210288168@office.mailbox.org>
 <YRyzhWJrqcRZkYRM@infradead.org>
Subject: Re: [PATCH 2/2] x86, Makefile: Add new generic x86-64 settings
 v2/v3/v4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: DF67F18CC
X-Rspamd-UID: da0a0f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Christoph Hellwig <hch@infradead.org> hat am 18.08.2021 09:15 geschrieben:
> 
>  
> On Tue, Aug 17, 2021 at 04:24:48PM +0200, torvic9@mailbox.org wrote:
> > +	  Generic x86-64 CPU.
> > +	  Run equally well on all x86-64 CPUs with min support of x86-64-v2.
> 
> > +	help
> > +	  Generic x86-64-v3 CPU with v3 instructions.
> > +	  Run equally well on all x86-64 CPUs with min support of x86-64-v3.
> > +
> 
> > +	help
> > +	  Generic x86-64 CPU with v4 instructions.
> > +	  Run equally well on all x86-64 CPUs with min support of x86-64-v4.
> 
> How the f&%$% is a user supposed to know what these garbage descriptions
> are supposed to mean?

I agree, will come up with something better in v2.
