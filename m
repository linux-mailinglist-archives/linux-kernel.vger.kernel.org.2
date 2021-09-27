Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BA741925A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhI0KnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbhI0Km6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:42:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A37C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:41:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id w14so15454618pfu.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k9dfhVa8WXGArQxd4uC/otj1zB4dJvIcYzxwUa5C/4E=;
        b=QoT3ZFF4ugQruiwS7E5XFSORyz5Nmov5GuWG9OVsPNrkuuqeUaqV7m145MWFi4/BLa
         U0885TlxBLnajthlt9guvH4SM1UUE0D0CDJRp7++csUMgtDJFVjEObXcLDzuX1gPOQ0k
         MwxjEFZ5CDiIlBiHTL3I9f/5pTZARLnslWVeAi+LRUzZBuK7H4syUSwUm1cyrHhBNNfl
         3/aWn/leiUtxd+xOwIFmChYEnzf30MwhrrQK5WFtwjXKOMyUGrjRkdWoJPvEH3/UQBbT
         aHdKIGg40nuqiVO+rNBYfKbUSyjWTkBsLWR0TMeWFt80OK9ByLyfW2h7Y77lLD1HoAUS
         jRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k9dfhVa8WXGArQxd4uC/otj1zB4dJvIcYzxwUa5C/4E=;
        b=M8vbuiBd4tHQgMoPlVZrY0BjeiTvomGydnPwHhKVgo4XWqtgdrG2N5ZfWPZ3VHRwly
         xsM978s3U0XXsQztfp0OTN+rsYIdUE9ClBAUu5kVtOeWPU8Crpvz2kGsBbnyH8d6FOet
         QA+Gx/fXXQpntoewdm5CSf1Lkyh45i0O5fOdQf+PV4U2Z+MhCyZ3rxAiiAtUi6d40GVe
         gzqmjcoersr7IqPlhjcdTfd8howJq4sap0fPboX18K4yeafQMsGC8zx/BAiN2USu+F98
         oNEs5sC5VZ3K2eAI8RHI6YZD+XX2FDsUUfmCL+3Ah5aNxaZ6E+bkpC/nJtJ8nAlolD1C
         uhDA==
X-Gm-Message-State: AOAM530KhFXjnp5ByzKAhwBIfKRAEaFwRPKGNJGyA0CNGgxzUh1vQmIx
        7f0m8ItVO0Cqv0E1G3P9ig8=
X-Google-Smtp-Source: ABdhPJzQf6NRl42y9fS/bj1j4AdFeAX4xhGcRWLrwBaZo4mBNoKiBgoChczpGErUH0r0xOxD3+I8MQ==
X-Received: by 2002:a63:e446:: with SMTP id i6mr16239207pgk.288.1632739280717;
        Mon, 27 Sep 2021 03:41:20 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id r5sm15326341pjd.13.2021.09.27.03.41.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Sep 2021 03:41:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 0/8] mm/madvise: support
 process_madvise(MADV_DONTNEED)
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <7ce823c8-cfbf-cc59-9fc7-9aa3a79740c3@redhat.com>
Date:   Mon, 27 Sep 2021 03:41:18 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E8A03DD-175F-4A21-BCD7-383D61344521@gmail.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <7ce823c8-cfbf-cc59-9fc7-9aa3a79740c3@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 27, 2021, at 2:24 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 26.09.21 18:12, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>> The goal of these patches is to add support for
>> process_madvise(MADV_DONTNEED). Yet, in the process some (arguably)
>> useful cleanups, a bug fix and performance enhancements are =
performed.
>> The patches try to consolidate the logic across different behaviors, =
and
>> to a certain extent overlap/conflict with an outstanding patch that =
does
>> something similar [1]. This consolidation however is mostly =
orthogonal
>> to the aforementioned one and done in order to clarify what is done =
in
>> respect to locks and TLB for each behavior and to batch these =
operations
>> more efficiently on process_madvise().
>> process_madvise(MADV_DONTNEED) is useful for two reasons: (a) it =
allows
>> userfaultfd monitors to unmap memory from monitored processes; and =
(b)
>> it is more efficient than madvise() since it is vectored and batches =
TLB
>> flushes more aggressively.
>=20
> MADV_DONTNEED on MAP_PRIVATE memory is a target-visible operation; =
this is very different to all the other process_madvise() calls we =
allow, which are merely hints, but the target cannot be broken . I don't =
think this is acceptable.

This is a fair point, which I expected, but did not address properly.

I guess an additional capability, such as CAP_SYS_PTRACE needs to be
required in this case. Would that ease your mind?

