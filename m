Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0DD4192B9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbhI0LH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbhI0LH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:07:28 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986FCC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 04:05:50 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s11so17424077pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 04:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L/js/+QIAeCH/e3oDGYGUuW3olbH7OQ+NYutC4UOl0Y=;
        b=PMc1sKOeGmB+O66/la6pC7P/0/IoeFQ1HY5bLSqnJbEP5r3KwxVoWqM9/Dz+iKJ77M
         tegUs/+E16t4p++UWJQ3I1PpOHiQ40+XF0JkQb0dvpaX7rv3MCHuzBseeRIEQ4f7kUXa
         GGRlwenK8R24PGD80cuJc05Hfga9KeIScZrWDotmdttB54jele21oBUS6svPtu9+MaOp
         a186aGU8NUePIlefKL+O44ozpQMRdmJjfuhBOAmXYrMUjYo4DSjNtbSb2qde5QX6MKLS
         S21RxHx5i43r7z2pXfnT8q/fjKwwwr8wZjWzo94vzRTVBdzqS4RWwFkIHXhBi9K26zbn
         L1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L/js/+QIAeCH/e3oDGYGUuW3olbH7OQ+NYutC4UOl0Y=;
        b=d5k6sSBIoeRpMSIoo0FQBggZe8pNwjPB4SCnev7BcyVmbj+JkxiYZBk3YxjA5kK9ID
         yDmlxfXOq7Q9XWqtjDE5SECC+vweATqvNFf5QiWiuDisf1nQn4BBvv/7I9zLJRKYKB53
         AhNWarRHFA9l4i3fPX5MfjYpCW/VpW56bji58+Vwx0HEgVRY/HcTpDjHdUGlVfvxJBQq
         OCjgy0InfGzL8h3aQ2+1AwmNM8cwRsA61COfjdgUSrA3Janx8bjyWjfwNezaCiiMrrRS
         7P4gIZb0pS79Hl3xB+AnLlQQjlij1znmd6tKTTAno6S2Dg08jeJysytzYb/ItHpyCVhO
         33ug==
X-Gm-Message-State: AOAM531FJLp4C/R9aGtchWf+BY3tzEdoj7cSk6ycCy64eY1LhPROnhmd
        YfifqN80WdKvZWdz4TR37p4=
X-Google-Smtp-Source: ABdhPJy/1CsOZhw9V9Hi0MqFMmcVeQjk9bYbkOoZVDtlFRb6X6fmqYBTtL5dUhBSY/14YW80ALlmsQ==
X-Received: by 2002:a63:33cb:: with SMTP id z194mr16254012pgz.380.1632740749950;
        Mon, 27 Sep 2021 04:05:49 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id z202sm17093973pfc.40.2021.09.27.04.05.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Sep 2021 04:05:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 2/8] mm/madvise: remove unnecessary check on
 madvise_dontneed_free()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20210927091143.tn6ediykqycu6rtu@box.shutemov.name>
Date:   Mon, 27 Sep 2021 04:05:47 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DD025444-B1A2-4470-9069-0072A59427A5@gmail.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <20210926161259.238054-3-namit@vmware.com>
 <20210927091143.tn6ediykqycu6rtu@box.shutemov.name>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 27, 2021, at 2:11 AM, Kirill A. Shutemov <kirill@shutemov.name> =
wrote:
>=20
> On Sun, Sep 26, 2021 at 09:12:53AM -0700, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> madvise_dontneed_free() is called only from madvise_vma() and the
>> behavior is always either MADV_FREE or MADV_DONTNEED. There is no =
need
>> to check again in madvise_dontneed_free() if the behavior is any
>> different.
>=20
> So what. The check is free. Compiler should be clever enough to =
eliminate
> the additional check. If there's a new MADV_DONTNEED flavour, the =
change
> would have to be effectively reverted.
>=20
> NAK.

I hate bikeshedding, but I will take the bait, since I see no
reason for this NAK.

I do not know what future change you have in mind in which quietly
failing in madvise_dontneed_free() would be the right behavior.

If the current code is presumed to be more =E2=80=9Crobust=E2=80=9D =
against future
changes since there is an additional check, I would argue that this
is not the case: failing silently on a code-path that should never
run is not the right thing to do.

Having redundant checks that are not documented as such do not make
the code more readable or maintainable.

Having said that, if you want, I can turn this condition into
WARN_ON_ONCE() or VM_BUG_ON(), although I really see no reason to
do so.

[ You might just as well add a default statement to the switch in
madvise_behavior(), which BTW would have been much more reasonable,
but only if it does not fail silently as the one we discuss. ]

Note that I made this change not out of boredom, but because I
needed to change this piece of code later for TLB batching. I
did not want to sneak this change in another patch or to leave
this confusing code. Anyhow, I wasted enough time on this
trivial patch.

