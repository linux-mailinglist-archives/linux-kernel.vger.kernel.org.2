Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227E4322BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 14:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhBWNz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 08:55:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30307 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232651AbhBWNzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 08:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614088435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwir4Wsil0jK4OKrvTzT1wqhvatcr2vaWyMIyN42ByU=;
        b=JSh90TEyuqBtV2DIpGKGf1RZi7yhQVTjLMMLhiqu1lusQlPZkl98y5/piN/jnqt08rLbCc
        vB9mqJk17C2PU4uWpCeQPiwkm0sYUQJAGyr82L5X3/As4c0TEqwYG++Lbsy/ZBIcECvmJG
        NvONh07PGbCJ3c37Q2Wvl7pj0o1pim8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-iMIsjr5YNRG8OGk5kLQpRg-1; Tue, 23 Feb 2021 08:53:44 -0500
X-MC-Unique: iMIsjr5YNRG8OGk5kLQpRg-1
Received: by mail-wm1-f72.google.com with SMTP id o63so686421wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 05:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kwir4Wsil0jK4OKrvTzT1wqhvatcr2vaWyMIyN42ByU=;
        b=jnveZbM0fiuiaZ13RWk5ucJPnN+urxtGxPg6CEtgo9zs67Jbvv0s8hnww+VHjXw1wg
         Ti4dyjUqNATtgH301+EEbi/iMi3eyO82h762IDCFlndJE/MvJF5nCBYoL4m3aNOrbp3W
         okVQVdf0C9A4G6q2opPmQgGc6XmcyLOkh8fa3O4RPfKTUSqeNh/CwWbC6mDS3s00FmgQ
         gSKNLU4JW78WMGvFkOGwyfU4mUgfUUZpYmJx9ZYW71TmAhYwe679mBafvaufO+HNTeWO
         N/D/CSsNIJmVfdG2ETN1jilW02tCBTftUYZZkT4GBxd7ZwlYrekhfRCIGqMvGdodx7wi
         t4RA==
X-Gm-Message-State: AOAM532XuTQF8M9vZg8FGVu1DWk5Qt/0+cnVgztLeUUb3e+8RcHjG2Xo
        jsVoiO7N9561jQlBofJz8RGeCw2SrPQp4Y1UgWhxOm3ecuSAohqtv7gT2bATuR9QFIrdR1jub0h
        X5ou9S0CJ902oqdAm2YMJ+amJ
X-Received: by 2002:a5d:6281:: with SMTP id k1mr234360wru.405.1614088423227;
        Tue, 23 Feb 2021 05:53:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvqa5mYS76mtgwFOwEo0awuiMGbxRj6wFrWqOCDoWYiXdsOnm2PzYL52S+dUZeC9KAg4PB0w==
X-Received: by 2002:a5d:6281:: with SMTP id k1mr234355wru.405.1614088423062;
        Tue, 23 Feb 2021 05:53:43 -0800 (PST)
Received: from localhost.localdomain ([151.29.106.174])
        by smtp.gmail.com with ESMTPSA id w4sm2749376wmc.13.2021.02.23.05.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 05:53:42 -0800 (PST)
Date:   Tue, 23 Feb 2021 14:53:40 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RT v5.11-rt7] WARNING at include/linux/seqlock.h:271
 nft_counter_eval
Message-ID: <YDUI5M5FQLycOd33@localhost.localdomain>
References: <YDTdo+jETVr983t6@localhost.localdomain>
 <20210223110015.ybl7feu43wvtjoqu@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210223110015.ybl7feu43wvtjoqu@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/21 12:00, Sebastian Andrzej Siewior wrote:
> On 2021-02-23 11:49:07 [+0100], Juri Lelli wrote:
> > Hi,
> Hi,
> 
> > I'm seeing the following splat right after boot (or during late boot
> > phases) with v5.11-rt7 (LOCKDEP enabled).
> …
> > [   85.273588] WARNING: CPU: 5 PID: 1416 at include/linux/seqlock.h:271 nft_counter_eval+0x95/0x130 [nft_counter]
> …
> > [   85.273713] RIP: 0010:nft_counter_eval+0x95/0x130 [nft_counter]
> 
> This is a per-CPU seqcount_t in net/netfilter/nft_counter.c which is
> only protected by local_bh_disabled(). The warning expects preemption
> to be disabled which is the case on !RT but not on RT.
> 
> Not sure what to do about this. It is doing anything wrong as of now. It
> is noisy.

So, I'm a bit confused and I'm very likely missing details (still
digesting the seqprop_ magic), but write_seqcount_being() has

 if (seqprop_preemptible(s))
     preempt_disable();

which in this case (no lock associated) is defined to return false, 
while it should return true on RT (or in some occasions)? Or maybe this
is what you are saying already.

Also, the check for preemption been disabled happens before we can
actually potentially disable it, no?

Thanks for the quick reply!

Best,
Juri

