Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9725326A4B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 00:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhBZXDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 18:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhBZXDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 18:03:06 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3433C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 15:02:25 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c6so12946406ede.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 15:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XNDlWTFublH5EeUthosYKPH7n+mTnvqUe7fMkdEsekk=;
        b=jMCyDAYFTr+2j47FB2nKCLULOhjOj6OBIhUWPbP+3D4ZT8+NS0p9//vX7n2OIhcPii
         w/bbsZo5LX8e3meWFtsKrL5ticoPBkslwEcV43mihbLlyAbLZ50rW7/Sf3LnBePkL1Q4
         IUeCK+x61dVW9JId8yiMzp2718cgS4pzsE477TvQr9jWT3WHf9YSxrvoxGkEFI165+fc
         m/uNmdC+4TPqHhLAqwBmd6S8awkysoGcuchwPVoQgC3ZxI/owXqcUkL0jaUzqEBrFVf+
         qnk/YUfSHb84FoUOVa6ZH01Jv2PutaqOIO/Hd9i2sSOomXkfFo9sSQQ+xSMeW9KkqtEB
         7/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XNDlWTFublH5EeUthosYKPH7n+mTnvqUe7fMkdEsekk=;
        b=MmSFFVYGsMBX1RZhy1L8yHlbodXNFyjZ1E4qikcsQ9GQ2ZUFDxFRSK50FWsT8Jcass
         NbsbxgIwgkkJetXQVG+2vSWhfxQ/LiZlUzci9g+wb2JHto6CbYSXHqSI/X6WV1so7+s7
         rgv5vaVgOXRycU4P3Jm6ze4aq0T2G12NZ6qmmotO9KiluepLNCph+dUu9pymcoaVEAYP
         TeCBeiMKlqraJPeAJ6ydQuklcSlQ8CakmOWB2IlQoagMeK5MnQdD+4drKDo1d9E64VzU
         40s37zCBYust6IpGHfUKRShLKNcD+5lGUdiHS+vzEUc3fzUA1mHJLuonVkQL7jGDbXxZ
         irFA==
X-Gm-Message-State: AOAM532HHMA0uCzQ01/neyH9ezRa7XuWtFRXIzJgkzTXPVdFReEUPbMm
        H6bydW1wxGh8i6CYYsc0Q2jOodmvbw==
X-Google-Smtp-Source: ABdhPJywJssP5i37LwfIf+GAjozsPViinJAIJDfGEmdViW1/pdyUjWW1ex6LeCF6gDxjdyYRAc1vgA==
X-Received: by 2002:a50:9ea7:: with SMTP id a36mr5976597edf.174.1614380543519;
        Fri, 26 Feb 2021 15:02:23 -0800 (PST)
Received: from localhost.localdomain ([46.53.254.221])
        by smtp.gmail.com with ESMTPSA id v9sm6278324ejd.92.2021.02.26.15.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 15:02:23 -0800 (PST)
Date:   Sat, 27 Feb 2021 02:02:21 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: #pragma once (was Re: incoming)
Message-ID: <YDl9/QU8EsCOPyuf@localhost.localdomain>
References: <YDlXWHkYntoO4fk0@localhost.localdomain>
 <CAHk-=wjZJPqmPE_gzvzPtPsojxw-Xg8QTBCn+Oi-ca2s0818NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjZJPqmPE_gzvzPtPsojxw-Xg8QTBCn+Oi-ca2s0818NA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 01:53:48PM -0800, Linus Torvalds wrote:
> On Fri, Feb 26, 2021 at 12:17 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > I want to sent treewide "#pragma once" conversion:
> 
> Are there *any* advantages to it?
> 
> It's non-standard,

It is effectively standard:
https://en.wikipedia.org/wiki/Pragma_once#Portability

and I'll spare UAPI headers from conversion.

> and the historical argument for it ("it can reduce
> compile times because the preprocessor doesn't open the file twice" is
> pure and utter hogwash. Any preprocessor worth its salt does the same
> thing for the standard and traditional #ifndef/#define guard sequence.
> 
> Honestly, "#pragma once" was always a hack for bad preprocessors that
> weren't smart enough to just figure it out from the regular guarding
> macros.
> 
> I can't imagine that any preprocessor that incompetent exists any
> more, and if i does, we sure shouldn't be using it.
> 
> So #pragma once seems to have no actual advantages.

The advantage is removing busywork that is include guards.

There are rules and schemes about how to create guard macro.

Should it be prefixed by underscore?
Should it be prefixed by two underscores?
Should it be full path uppercased or just last path component?
Should the guard macro be lowercased?
Should it be changed when header is moved?
Should trailing #endif contain comment?
Should #define be just #define or "#define FOO 1"?

I've even seen advice (or an IDE doing that) that is should contain
timestamp of a header creation time to minimise collisions (implying
collisions could happen as could typos as could broken guards)

All this zoo of styles and made up mental work is completely avoided
by using #pragma once:

	1) put #pragma once on the first line
	
		or

	2) put #pragma once on the second line after SPDX banner

and that's it.

No fuss, no filled up preprocessor hashtables, no implicit arguing
about styles. And way less LOC:

	18092 files changed, 18883 insertions(+), 99841 deletions(-)

Now if old school header guard is necessary it can be used like in
good old times.

Nobody would miss include guards.
