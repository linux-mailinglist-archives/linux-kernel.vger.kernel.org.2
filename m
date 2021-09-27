Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AE641A039
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbhI0UiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbhI0UiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:38:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12340C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:36:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id kn18so362827pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KwntqUtVsNq0eUFSV1/o/nRAcymM++4zNUK+VLfzUDE=;
        b=qwIUO+3oC6laZ/gJKGvYxv3lflTfsHoCZozQwFOCCG93M44AOCtYwoSK4+BlxN6uMM
         xXIRst5Jp1b1D8GLGaK3cgg7QCm8wwMGodWCT3Yzt0Hb2ZWkJJT7jIWqZ/eBpR6P6oPs
         Ho3XAgMKKCBgJzgylh3jmiM5/KdLQdltQcC/ntQwQe8mPYrQ+iD9NWtQO94KwnTHmbcT
         7ZMTHwRVTvo2Quxwo/TTRWC0MatJPUwxXLv4szstzuXPvM3ApWzeEiUHlgJXIR1tmX1u
         B/+dg7r7cJ44YMKuJ8Ct0BdcdzI1qAy/4DHMqaETzhldsUmSe91/m+Y+IbkStrwJZ2/z
         RHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KwntqUtVsNq0eUFSV1/o/nRAcymM++4zNUK+VLfzUDE=;
        b=QQ2ThxeeEcDTRknakQU6ztYWjldiHem2wc3Q52aNXCgP84qzkSJ7niUP53LP+ewJab
         sE5c0dC5ayzc+ldmBnccaazJOpd7XWAtOSDBHpZ0CoQZSiJi+YQkLHbJpwbe1VxzKJ1g
         mG9lV7zzVJ5h7LtoofsWMD3BAsXZd1sPW01mpSVgy4ZQ505Fl0KblCQqzFaTElRlE4rN
         klAHaNI8Lre+aBjmQkzK0DdL6k6ugtH3g4WOARcWb3auEiyk1AAN8a9dBYdZGhu2Ckub
         wgEWCUQaXE4lo06Ulv09rVf3hvasdJR8GShq7ckI3QzKYO/lDYSm0FNOA2ysXn9bh/2V
         XPTQ==
X-Gm-Message-State: AOAM532+qZt984dRfMM6/bGxyZujhoTi/5deHGvHptSNwyYkMWiGE7Bz
        +ygyCPQihwx+O9oMPUXt5qQ=
X-Google-Smtp-Source: ABdhPJx6HFSHqBc+6nLSQK9verGhJtcB06qeQUgeN64cmC/mCUE1BD8FuJyvGrZIKjQ3gJHVjxsQ7Q==
X-Received: by 2002:a17:90a:17e1:: with SMTP id q88mr1113946pja.99.1632774982476;
        Mon, 27 Sep 2021 13:36:22 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id y24sm10396984pfo.69.2021.09.27.13.36.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Sep 2021 13:36:22 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 4/8] mm/madvise: define madvise behavior in a struct
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20210927121449.kac5g25aejbwvylf@box>
Date:   Mon, 27 Sep 2021 13:36:20 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB2E02DB-0675-4053-B223-06D4BF26641C@gmail.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <20210926161259.238054-5-namit@vmware.com>
 <20210927093103.g3cszw75gfctwtzk@box.shutemov.name>
 <48D4E700-0005-46D4-8EAA-B839D8449C66@gmail.com>
 <20210927121449.kac5g25aejbwvylf@box>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 27, 2021, at 5:14 AM, Kirill A. Shutemov <kirill@shutemov.name> =
wrote:
>=20
> On Mon, Sep 27, 2021 at 03:31:21AM -0700, Nadav Amit wrote:
>>=20
>>=20
>>> On Sep 27, 2021, at 2:31 AM, Kirill A. Shutemov =
<kirill@shutemov.name> wrote:
>>>=20
>>> On Sun, Sep 26, 2021 at 09:12:55AM -0700, Nadav Amit wrote:
>>>> From: Nadav Amit <namit@vmware.com>
>>>>=20
>>>> The different behaviors of madvise are different in several ways, =
which
>>>> are distributed across several functions. Use the design pattern =
from
>>>> iouring in order to define the actions that are required for each
>>>> behavior.
>>>>=20
>>>> The next patches will get rid of old helper functions that are =
modified
>>>> in this patch and the redundant use of array_index_nospec(). The =
next
>>>> patches will add more actions for each leaf into the new struct.
>>>=20

[ snip ]

>>> MADV_SOFT_OFFLINE+1 smells bad.
>>=20
>> I can set another constant instead and let the compiler shout if =
anything
>> outside the array is initialized.
>=20
> I would rather introduce a function that would return struct =
madvise_info
> for a given behavior. The function would have a switch inside. The =
default:
> may have BUILD_BUG() or something.

Sounds better than my solution. I will do so.=
