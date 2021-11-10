Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4686644BCFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhKJIki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhKJIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:40:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2E3C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:37:50 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u18so2594921wrg.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H7Vc7XNyNbkqjKSmCjItkCOSg0ZtD84mXD0KHvoFUw0=;
        b=7cLAsKy3QeIVbTxafPd6kC2tqAUBVxDCISQ8AHlnrN57S0Nyc7VuBHQwswnR3lpyRL
         En38PjZLEkEfiyPjFjj7EWU232WL9oeLMU+DOSW9BESDaPHZuzMaHtRpvAnd4jsKmY1c
         WQkU7saP2pSJ7Y+Mb5fuHh5v7im2u4I7kfIebbjdQp42/VOJ1Q1c6Q40itoQuP45VDjZ
         CtoQvMZnfAKX8CQfrT6hxgUPeARL0sNHGTenPlkZE56BwTQOXCnJqbKpm4tFw4Xk8YFw
         2zgBih4uQV6081hoIGfyKmuagAYy5fYByi/wzsIo+LEsiVXxRtNgg0C3h9RDP5FEQ99/
         t7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H7Vc7XNyNbkqjKSmCjItkCOSg0ZtD84mXD0KHvoFUw0=;
        b=JMWChdMY6hKDCjdShjCeIV8ghbhrcN22JJjyT35xD/A1uqw33VzE/YiXXrw6oKwKH5
         eIbsvk+i+qKGeSPgTLU9KHylh+wnzJL2U92RXN2bsZ7x2U8AmjWvrgGV+hoNaY87l5HD
         29ZZILVatNSxn6U7SnF7UTMd0JkdkV8RbP3VeumWFFcjuDfl3lQp1fuMGUSi6P84Mjs4
         s/+JUfQN5Y6QU/rXkCyM/qQEYdC8yJ5OCtrD/FMeFpbr7R/HmmjtrNzdeOSUsbzYMlCB
         HKn35DqjEna4jNKBVtagZ+9OwWWSZVG8HdCFxps98mzAT+yaC4GuCzs/relRrVPyqBkE
         Z12A==
X-Gm-Message-State: AOAM532f5saVXVTsQ3tIbkujeKpf/kJh0PyjDTyOlVDi7Bz2crv4nhSJ
        TcVv342jluU5c5CKjCTeO5FU9hiMyC+wtc9baIl0LA==
X-Google-Smtp-Source: ABdhPJzWLBKVnO0a8pRvd2xV5whwSSl3WLj+dBzm5SNa+SPegUKT6L/NgohxHTj3kd+lfMrpzmzK39oNUb43RkDMI3A=
X-Received: by 2002:adf:dd0d:: with SMTP id a13mr16636436wrm.259.1636533468553;
 Wed, 10 Nov 2021 00:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20211109000130.42361-1-hans-gert.dahmen@immu.ne>
 <YYoSPjF3M05dR0PX@kroah.com> <42cea157-55a2-bd12-335b-6348f0ff6525@immu.ne>
 <YYpNOMtp7Kwf0fho@kroah.com> <CAHifhD4f676jiQ52siiKQTjUFXFm6Sto8pQjF07w5y+gqrUvFQ@mail.gmail.com>
 <YYpsq/umygfTb8mM@kroah.com> <CAHifhD6K5hbpHS-X+2L=pfUe+7OpyTbB7uyh8WGbdaeBMwoYPg@mail.gmail.com>
 <CAHp75VfbYsyC=7Ncnex1f_jiwrZhExDF7iy4oSGZgS1cHmsN0Q@mail.gmail.com>
In-Reply-To: <CAHp75VfbYsyC=7Ncnex1f_jiwrZhExDF7iy4oSGZgS1cHmsN0Q@mail.gmail.com>
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Date:   Wed, 10 Nov 2021 09:37:36 +0100
Message-ID: <CAHifhD5V9vwJenRLcPRH5ZMeLa_JnjZKfdcFZw1CjceBtC6=Ew@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi., 10. Nov. 2021 um 07:35 Uhr schrieb Andy Shevchenko
<andy.shevchenko@gmail.com>:
>
>
>
> On Tuesday, November 9, 2021, Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>=
 wrote:
>>
>> Am Di., 9. Nov. 2021 um 13:42 Uhr schrieb Greg KH <gregkh@linuxfoundatio=
n.org>:
>> > ...
>> >
>> > Do you have a pointer to these complex and buggy drivers anywhere?
>>
>> I am talking about the linux-mtd intel-spi driver for example, but I
>> feel that this gets the discussion in the wrong direction.
>
>
>
> This is the driver that covers all BIOSes on modern x86\64. What=E2=80=99=
s wrong with it? Why do you need this?!
>
> If it=E2=80=99s buggy, where is the bug reports from you or somebody else=
?
>

Please see Mauro's mail in this thread from yesterday below:

On Tuesday, November 9, 2021 Mauro Lima <mauro.lima@eclypsium.com> wrote:
> Sorry, I forgot the links
>
> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1734147/+index?c=
omments=3Dall
> [2] https://lore.kernel.org/linux-mtd/20210910211348.642103-1-mauro.lima@=
eclypsium.com/
>
> Thanks
