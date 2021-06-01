Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAB8397C66
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 00:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhFAW3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:29:07 -0400
Received: from ms.lwn.net ([45.79.88.28]:45438 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234799AbhFAW3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:29:02 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B02586E2;
        Tue,  1 Jun 2021 22:27:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B02586E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622586433; bh=dSoDMMpAp0sDWnPw9PwD/bCdqpPgr2iplSwiHsPTuiw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AMgJ7VoNwKp3EjYIsBsWGwX1Ph5AisSpZYPvSIfSpQFhiFYoAmN4nha/Mwz8Azw7t
         Jl4NzEnKzXfUjdjJ7fOt4R9+mjVuuhvEZGhbtBIrte+DaB0/kdS11q42o1zIYOW9uz
         0UNjeg/CpyHfqrYGloiLL22EucJsDAjGeMEsfBGelZMbixd2Q3rDml+nVsosop1l+y
         Hcu0nmOGOHqmgMdUd9ebKjkmooudaCZ0oDG5JZT7wPZMBAeRn1IcfMouQ2PomepmRJ
         ltUTjG1Zj5ZUeUWPmQ1igiInw4wYvNzFnISvwVNl1aQdXlr1VNYYulSeozDtYoCYA6
         UOXXg5/YrmzrQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/submitting-patches: Document RESEND tag
 on patches
In-Reply-To: <YLT0MjAIO/8u4cjY@zn.tnic>
References: <20201217183756.GE23634@zn.tnic>
 <20210413113834.GE16519@zn.tnic> <87pmyxsxsy.fsf@meer.lwn.net>
 <20210415060505.GC6318@zn.tnic> <YLT0MjAIO/8u4cjY@zn.tnic>
Date:   Tue, 01 Jun 2021 16:27:13 -0600
Message-ID: <87zgw98blq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> Wow, time flies. :-\
>
> A month and a half later, Jon, how about it?

Oops...somehow I missed the fact that there was something there for me
to look at and respond to, sorry.

I've just read it through...  if it were me, I would find a way to
reduce its bulk in the hope that people would actually read it; much of
what's there is in coding-style.rst (or should be).  But it's not me,
and if you want to keep it I won't whine (much).  Except about reverse
fir tree, perhaps, but nobody listens to me on that...:)  I'd say
package it up as a maintainer-guide entry and go for it.

Thanks,

jon
