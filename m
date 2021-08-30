Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0157D3FBA32
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbhH3Qcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233637AbhH3Qcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630341096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QX9GU0hH1TRwqyfkU4USdjocCp7nMp76pC0eH/XEt0A=;
        b=H6M4GRGKtUyzvpgEIkZogK71FBv02+0dnr3e37AtQUNOgdCCwzIqDdCUj7LniKJl/xyZW0
        fGak7VRPhnFCBt+c5mr7SRlWvZaVuu6XcZHF7BzlOp/qo1ntbHIzqrrvxe9ouSzk0S6vW9
        oUUKNE2BCHo7233JS/gmCQZWjudqjzk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-g4pGmAUCOtez8uv4HCe71Q-1; Mon, 30 Aug 2021 12:31:35 -0400
X-MC-Unique: g4pGmAUCOtez8uv4HCe71Q-1
Received: by mail-pg1-f197.google.com with SMTP id 1-20020a630e41000000b002528846c9f2so2015537pgo.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QX9GU0hH1TRwqyfkU4USdjocCp7nMp76pC0eH/XEt0A=;
        b=j5cF1Rb7SktWPU6voLSsM+ij+4ndcd+cK/6RiIO/kPhI505YmONRyGcLCZimTx+Oqx
         DPUcpxTePd09vibi321eLi2X588nbJY0puIIHrGyWnSRhFhZ2xqyB9gSXmxeX+ttcxqG
         9xGpWa/BbcriDngOhbSLsQ+x+FRW2dgM0kXBmxIgLZBbDVMwlHyKGKzI7QcmbbhQ0RAH
         BTCb6RbZmyhJ3ntab2eMueU8x1aaXZFfFiQDqxywVYCvWveAczV/vhohu6homj/9AyXq
         AhVEdhmqrV27QNuAt9q1w7r45bzMUuIiW20bskaobsE2MJJHTgUd3A5Mt1PawMZXaSXh
         fEXQ==
X-Gm-Message-State: AOAM530ozEpowgoJfbOtVWrIRCuCrz7Jx+coTwn0e0JSUtEiEgsmeTrm
        WWePppLKAoPmhD2tJcVwYSxJ0vxu6msM6dM6Mg4jU7i/Th+kvOiUVlxC24gzCvseNPbiLYt4YeG
        +BIZbA3r57IJ7jyq/pu6mJ1gGWZN2k1MSGIV9h3/y
X-Received: by 2002:a17:902:da8d:b0:135:d4a1:bc25 with SMTP id j13-20020a170902da8d00b00135d4a1bc25mr446068plx.41.1630341094432;
        Mon, 30 Aug 2021 09:31:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsfUc0NrQJSBO5s1PQvVJbSaXwuj8CLgAUF3cdiQwV74fkRhpEV4xYpMdYLQmn5JWjkbapCd2JNKKwqwLYZWI=
X-Received: by 2002:a17:902:da8d:b0:135:d4a1:bc25 with SMTP id
 j13-20020a170902da8d00b00135d4a1bc25mr446052plx.41.1630341094159; Mon, 30 Aug
 2021 09:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210816130059.3yxtdvu2r7wo4uu3@lion.mk-sys.cz>
 <20210816143856.GA121345@rowland.harvard.edu> <20210816191249.7g2mk5thwpio7cfc@lion.mk-sys.cz>
 <1954573.0n35tlyJVE@natalenko.name> <20210830160743.GB332514@rowland.harvard.edu>
In-Reply-To: <20210830160743.GB332514@rowland.harvard.edu>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 30 Aug 2021 18:31:23 +0200
Message-ID: <CAO-hwJ+QL9O_m8NFXeAWhJ5B7ipYeNC=9RjU1HamMisdVhXEwA@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] flood of "hid-generic ... control queue
 full" since v5.14-rc1
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Michal Kubecek <mkubecek@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 6:14 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, Aug 30, 2021 at 05:48:09PM +0200, Oleksandr Natalenko wrote:
> > Hello.
> ...
> > Any luck with moving this forward please? I've got a similar issue with APC
> > UPS and v5.14 kernel, and this patch also solves the connectivity issue for
> > me.
>
> I've been waiting to hear back from Benjamin to see if testing revealed
> any problems with the latest version of the patch.
>

Sorry, things have been complex last week while I was on vacation.
Nothing scary, the usual "not enough hours in a day to be able to sit
in front of a computer".
I'm back at work today, but got a lot of urgent things to do. I should
be able to do the testing tomorrow.

Cheers,
Benjamin

