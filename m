Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB2832A7AF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579029AbhCBQ1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238765AbhCBN4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:56:07 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7C6C0617A9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 05:55:23 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id w1so14766861qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 05:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ms2DEUDg3w2MIQxiWCyPeHGtrqNcSJcVEZ0dLVETUxY=;
        b=Sgn/ih4RYGRBRS7rn0ARvx/WETzDS1bNWJ3KiOedTppfKE0S9XlDuM9MLEN1kVM8kE
         9s+b7gTac9NsILOMy3AClrVI2xymt8VdCNrAjnQeq70S/mD8Ldz/V1N5ugKTkN0wwlnO
         z5Rv984HM1bO9VY4yQl9pSy7Tl4P3K6t1k1Ich5FhmY1o+kN9IbE1+ec63hX/dN4Jm7h
         1JEzAHhFy29FxqO63CmxFpZaMyqo6NqPs56N6FxLn6cyZ/arYTOnrMa+QBzP6cm8C/tQ
         Vyng5yN53IpAvaduJp6m9Z3lidKge1zbJMED2HJsAnMdXYuOF2k7SVL64WsC/ex9FUFU
         0C0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ms2DEUDg3w2MIQxiWCyPeHGtrqNcSJcVEZ0dLVETUxY=;
        b=sDVqg39UkVngEksqbw0YPQeS5rKFqtmYGTiDo3gIV9UM6U0G2PJvXKqjP/HfSqHLcj
         NrR7EFu5Efvmh4scVXyRX+JR/3hnDJemzW8vJqUPtz/tj7OA6K6ZOFRO6yfv2AFZoCI2
         Xzf7WLcQkzB60mpJEf7x+4mb3h5lW1WzYE5AxnceKkcdOfCjMI3eOR66Q/TNrPMSR9N0
         stV4FbnvwSN2KP/m0H7B+ArmBE0R5GMeki7zjUivFA//CbBTsTsizVd+SKkGE0YXC4v6
         rwOaWEmqJi50RLoshQBssRyOVYYzpH2Wh3gODpSah20tJ1VCVrZs1DCLclYG5oyWxjUe
         mj6g==
X-Gm-Message-State: AOAM531gdWV6VP41yFLj/VR9NUTPumXjA7+OMP6FdZjIXeKYmWbdZWPB
        TkwF1Kdfq65Du0esoaeYrqItV5RV6N2ZNmGxM44=
X-Google-Smtp-Source: ABdhPJxC+mg+78cgGANwTeYLG/WqZOlQLlcSNCT/ApfySnvbeju8x7iJL6SDlVcY/ETvHVerROLe9dCRD1w1sDsQTLw=
X-Received: by 2002:ac8:6f01:: with SMTP id g1mr1118155qtv.214.1614693323195;
 Tue, 02 Mar 2021 05:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20210302033908.51706-1-yejune.deng@gmail.com> <alpine.DEB.2.22.394.2103021007490.860725@gentwo.de>
In-Reply-To: <alpine.DEB.2.22.394.2103021007490.860725@gentwo.de>
From:   Yejune Deng <yejune.deng@gmail.com>
Date:   Tue, 2 Mar 2021 21:55:11 +0800
Message-ID: <CABWKuGWDAfR2WaW7AXv9Tp+qnmhAqveJUxucU9tFccDhj0bLWg@mail.gmail.com>
Subject: Re: [PATCH] include/linux/slab.h: use for() and left shift to calculate
To:     Christoph Lameter <cl@gentwo.de>, willy@infradead.org
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you. I hadn't thought of that=E3=80=82

On Tue, Mar 2, 2021 at 5:09 PM Christoph Lameter <cl@gentwo.de> wrote:
>
> On Tue, 2 Mar 2021, Yejune Deng wrote:
>
> > use for() and left shift to calculate the value that compared with size=
.
>
> There is a reason for the madness...
>
> The current code was written so compilers can do proper constant folding
> and eliminate the whole function entirely.
>
> If you want this change then please verify that all compilers currently i=
n
> use with this code do proper constant folding and never generate code for
> the for loop.
