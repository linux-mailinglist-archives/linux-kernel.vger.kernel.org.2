Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB9D3FFADC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 09:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347549AbhICHLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 03:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbhICHLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 03:11:37 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE49C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 00:10:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fs6so3062111pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 00:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=drsU+WoGtlf+/Dd29/0dqw0JzgOHZQQiry+kGpJL/Q4=;
        b=ZSS7U+lPr0tsaess+Z83IBOEIgUt1JH6KiGFsnOv1wxzqat4I7F+z2LsUmLkEuM3U6
         ERT+ZWUzIID6UbvJjYmERlpaBYUmJAC0JThTkyOLaR2t1nnavnZMZ6NH4+fUCyZPVTbb
         IvQWin/dFvgH/Buht42Sh7YY/3p6OZHz3Dw+tbA4cKYVY9aFmr/mzsFOAC6OJ0DUWqf9
         XBLNBKb6b/nWDbKg/GPDhrOyUVQtfKyl3g0V8LrcFK63fFCXB81sydlv2DSk7+PwN1mN
         +jfQ6d2Gsz35ItnFAO5FSqGSDhLE1hXO6tshZ81BJEy6rsFjoTzkq0PUdbcaAKDZ7J41
         Jhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=drsU+WoGtlf+/Dd29/0dqw0JzgOHZQQiry+kGpJL/Q4=;
        b=MCNHbP/pzGl6vqe3ML8aKPTrXAsaNWbaKLZdjn00G9+FLUhJ4G6epUSha8TJjugcx7
         Dx/VWs1gYJToKU4ZXgfLfECUi1YaVx4Ky1ivFo3kWZmVFvFP3b/nKDJjcllQ52BRMkrU
         UjACJURpX/c3qO2Cibv18i3kaxaVaXweuaFyNbswzLvLC0MDFJl6390OjgOKALipIisM
         FNGk6FwJ4Wns22hxTH425C2IjXVjzP/Fed0Mw/RyuOPHLzbIHbvpZK2Yx3YM/EU8geYW
         5RXkOJlcGF8zrXjWhWyOp9Cnb60o/19+uuqHkS+x9LviFKqK+auXKgNrokh0WIyFxtDw
         J8UQ==
X-Gm-Message-State: AOAM532ZxrkgqfZeTziNodpZo2hG1DRUl830nEYqLcDKEhjm6C9qbYKN
        sfRAfgWihTmnQvnK58mQxeo=
X-Google-Smtp-Source: ABdhPJz1Ozt++aT/2k7QOaw82sAobkvtp4TBpLeIorle7XjvtPUBy2oJjILJaqSYE5Mvdx1OOyiuOw==
X-Received: by 2002:a17:902:7e4a:b0:139:fb91:a69a with SMTP id a10-20020a1709027e4a00b00139fb91a69amr1817128pln.28.1630653037707;
        Fri, 03 Sep 2021 00:10:37 -0700 (PDT)
Received: from localhost (203-219-56-12.tpgi.com.au. [203.219.56.12])
        by smtp.gmail.com with ESMTPSA id g2sm4190713pfr.35.2021.09.03.00.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 00:10:37 -0700 (PDT)
Date:   Fri, 03 Sep 2021 17:10:31 +1000
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
In-Reply-To: <YTCktV3KF9PzIACU@casper.infradead.org>
MIME-Version: 1.0
Message-Id: <1630652670.aplcvu6g23.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Matthew Wilcox's message of September 2, 2021 8:17 pm:
> On Thu, Sep 02, 2021 at 01:25:36PM +1000, Nicholas Piggin wrote:
>> > I have been thinking about this a bit; one of our internal performance
>> > teams flagged the potential performance win to me a few months ago.
>> > I don't have a concrete design for text replication yet; there have be=
en
>> > various attempts over the years, but none were particularly compelling=
.
>>=20
>> What was not compelling about it?
>=20
> It wasn't merged, so clearly it wasn't compelling enough?

Ha ha. It sounded like you had some reasons you didn't find it=20
particularly compelling :P

>=20
>> https://lists.openwall.net/linux-kernel/2007/07/27/112
>>=20
>> What are the other attempts?
>=20
> I found one from Dave Hansen in 2003:
>=20
> https://lwn.net/Articles/45082/
>=20

Huh interesting. I'd be surprised if I didn't see it go by at the time.

Thanks,
Nick
