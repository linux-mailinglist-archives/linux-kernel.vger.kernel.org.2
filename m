Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B6430BB05
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhBBJdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbhBBJdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:33:21 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F9AC061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 01:32:40 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id m6so13955007pfk.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 01:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I6VyjYXqgNN+3MmwLFfTkapimK/jefKPU0R++/QtqlE=;
        b=I9GPSKm9FBou+ntipP2BJopyUreu4a3xgl7eUvQ/v4zvSrpKjlEDlCLyQGy/zn87nZ
         0j0tgQYTvIb0fzdkpetGn3XcK9bJ7tmpTEmTD70UDVkjCDeGw0v9BR9KgaS5wTgo+MZy
         ax2tOrd40kdqt2AWh63qS0QwO2jL2x2GJ66m83+2WR49tNIEXUxrfoQZzaw/6rzznt/A
         xpzHUkpcuXGiiB7eSvccZR/Wgq+Hss6fM3zn8dAsbfB6mC+EE4S8TBvF8VuZ6AT7s5xf
         g+kXCq9i0DuhbuTMzxHYT1h9jjAhzE06hqPXxGTMDYeC2fyuUHvZrXZsY3LPkOXXohsE
         1Xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I6VyjYXqgNN+3MmwLFfTkapimK/jefKPU0R++/QtqlE=;
        b=I0LKdCaDtkzHnE/40jZZXnVqvscIgIBfnCbF5/3atCpa3Thngq+Vp1cfoN540XQgPm
         /8U/MXoOX+FDmUnvHZVI8eDSA8/dyayyiwwalpagmzC4fVXvrrF1OEtxhwUWJfKGkeRn
         FGnTL1aqxp0tuDHjRB4WXnPiJtvLj3IEvhNrlAPoECuau6k0IbMUJJW09yrLPcy/QSP3
         UJ0JnV8FLEDNPgILWGw2JlmRrdW3LCql6TXRqCkBwZPybfDE9EvSzf0uHTQ1ggElakMo
         wGqSkia9V4zbPT4M+pPSqyhDp9aSiHvTJjJKRMnn8oiABUYFYuz0Rfc3swA7lZ/728En
         +bmA==
X-Gm-Message-State: AOAM531U503X3Vohz85FwnrYxzXoETJBhKTtxTWPBWw1Jbw/BNsC1tV8
        C7mMHFdtXE9XRQvF9nkkX0I=
X-Google-Smtp-Source: ABdhPJxD5pAkv3IeMPr6iygtcNX0o9mS3PHGYxoGP2NnJxLPjrzUvyt7qEj+SWrTXQjtDfD2b5fKVQ==
X-Received: by 2002:a62:7c49:0:b029:1b9:c512:dfbb with SMTP id x70-20020a627c490000b02901b9c512dfbbmr21083991pfc.21.1612258360202;
        Tue, 02 Feb 2021 01:32:40 -0800 (PST)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id 21sm20721737pfu.136.2021.02.02.01.32.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2021 01:32:38 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC 01/20] mm/tlb: fix fullmm semantics
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YBfntzMgNlMDOP9s@hirez.programming.kicks-ass.net>
Date:   Tue, 2 Feb 2021 01:32:36 -0800
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <52673507-2C30-4AC6-8EBC-B5A313827FB0@gmail.com>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-2-namit@vmware.com>
 <YBfntzMgNlMDOP9s@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 1, 2021, at 3:36 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
>=20
> https://lkml.kernel.org/r/20210127235347.1402-1-will@kernel.org

I have seen this series, and applied my patches on it.

Despite Will=E2=80=99s patches, there were still inconsistencies between =
fullmm
and need_flush_all.

Am I missing something?=
