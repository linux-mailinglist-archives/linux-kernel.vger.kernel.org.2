Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7AD40085E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 01:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350733AbhICXnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 19:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhICXnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 19:43:08 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69B2C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 16:42:07 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 7so691454pfl.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 16:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=RbmyCxovg1DLvfcJ/FSqFRVxSV6Zui9nsoD/b3owWjc=;
        b=gp3HM/UaZFcDgZFLttHcNoTPJ8WQGsp0TqMxEXvTviJj+kLkfmazp0t9rSp/tlfBil
         LilpCq5EfyguTDLk9drAXfb0Ii+8McxJJMyaE+vrk/0V6w0OP3+pri3WKvXGYdj8eBIg
         t/sCaCKq30+Pje1Pv0Gu/pQQXmkiwkq2+UggEfVKhHHPbYAZIXb6Ug69fzrGoHnW28WD
         Qx81fh8ArLnKNw8Q9oZRLmjAPGOFGvN8TLvz8HzMp+VQa3bzEFaEwTzU7/xeuRFtPv9h
         EEbJ0lqV5sWdb/rTkUqOnkpngiPpcCQ7ZmBVJ4UIp/B0t+n0TABSNlY+2+N8mUXAG2Ni
         O7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=RbmyCxovg1DLvfcJ/FSqFRVxSV6Zui9nsoD/b3owWjc=;
        b=eapD0x8RhWaMcWNsZBopNhPQZ0bvJ5HxaKWfCeAQy+SkTTFrRLxNA4BMb3EQS9/TYB
         TBBYbdqm+WgHNnTQc6K0pCOmwUgyarDQK26SippE5KIRpQNPMMJmqI7uENkN0gdidftI
         It/tRGpC50jHKGOhZ204Xew9nlkFMBKoFRIHa7464DTS0k40jMGvpi0NqvGHa/hHrZXB
         oF4aQl9LEGxKVbJsupXQ2iDR32vNeeXvXOusYEyAy7ml7Cr/wCp1aQ91eruiuygfISx3
         EKUlFKDc5IzaP/igID14qE2yj6ZqyMUWDenG89j2dC3AEcHWgrfaev8nGYHwT+A6Po94
         bSsQ==
X-Gm-Message-State: AOAM53389wiTOMr2UhoM8xRezeIb+vhM+o7B+cDtVrmyWfAEIBuveAgs
        LxIGUuqEhZMVpiy42FNO2xzlfWlpmTY=
X-Google-Smtp-Source: ABdhPJwzvFqJO1HdxqofZWVyERIxJIv9nnL9AKDMjxH9L00pSAPQxNgPM5a4wmxZRjze/AeIO+UAFg==
X-Received: by 2002:a63:6dc6:: with SMTP id i189mr1267977pgc.458.1630712527245;
        Fri, 03 Sep 2021 16:42:07 -0700 (PDT)
Received: from localhost (203-219-56-12.tpgi.com.au. [203.219.56.12])
        by smtp.gmail.com with ESMTPSA id x189sm421549pfx.30.2021.09.03.16.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 16:42:06 -0700 (PDT)
Date:   Sat, 04 Sep 2021 09:42:00 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Is it possible to implement the per-node page cache for
 programs/libraries?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        song.bao.hua@hisilicon.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, Frank Wang <zwang@amperecomputing.com>
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
        <YS7yjcqA6txFHd99@casper.infradead.org>
        <1630552995.2mupnzoqzs.astroid@bobo.none>
        <YTCktV3KF9PzIACU@casper.infradead.org>
        <1630652670.aplcvu6g23.astroid@bobo.none>
        <YTJxFgD0kKPs51dz@casper.infradead.org>
In-Reply-To: <YTJxFgD0kKPs51dz@casper.infradead.org>
MIME-Version: 1.0
Message-Id: <1630712371.zxj5zdhheu.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Matthew Wilcox's message of September 4, 2021 5:01 am:
> On Fri, Sep 03, 2021 at 05:10:31PM +1000, Nicholas Piggin wrote:
>> Excerpts from Matthew Wilcox's message of September 2, 2021 8:17 pm:
>> > On Thu, Sep 02, 2021 at 01:25:36PM +1000, Nicholas Piggin wrote:
>> >> > I have been thinking about this a bit; one of our internal performa=
nce
>> >> > teams flagged the potential performance win to me a few months ago.
>> >> > I don't have a concrete design for text replication yet; there have=
 been
>> >> > various attempts over the years, but none were particularly compell=
ing.
>> >>=20
>> >> What was not compelling about it?
>> >=20
>> > It wasn't merged, so clearly it wasn't compelling enough?
>>=20
>> Ha ha. It sounded like you had some reasons you didn't find it=20
>> particularly compelling :P
>=20
> I haven't studied it in detail, but it seems to me that your patch (from
> 2007!) chooses whether to store pages or pcache_desc pointers in i_pages.
> Was there a reason you chose to do it that way instead of having per-node
> i_mapping pointers?

What Linus said. The patch was obviously mechanism only and more=20
heuristics would need to be done (in that case you could have per inode=20
hints or whatever).

> (And which way would you choose to do it now, given
> the infrastructure we have now?)

I'm not aware of anything new that would change it fundamentally.

Thanks,
Nick
