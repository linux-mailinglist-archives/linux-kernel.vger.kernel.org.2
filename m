Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B9D441D97
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhKAP5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhKAP5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:57:47 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0B4C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 08:55:13 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so233083wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 08:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E8Lha7INYy+OIBEKFbSkPguyiICrTHAY0jRQJffJHBI=;
        b=LoluX0lwTgGnDJ2tphDyPpt1N+5iYeM4+8SWtaLYXO/5BRCdapADoYlD/mdnQTG6+L
         KCHALsOpIl7OZMpVVidkRYIIn+rKD438VDLzq/Khc2u0p46t6cUNyUvI2McE2rpQO0Mx
         aGZAKclcApp9cI4BXxpvHxWCr8lbNz0CQgzSgUEzHxqYfBA9eXUrAw3PUbgHwCI0t1/a
         omxefoDmfWaNl0pAE0q06ckP/W+eYTcLhMFfLR+WDFdsualHP0uM1QuxXwwfm+N3ztqp
         0uIef8jf8dlViSKTJqkn0jWSn/XzjwRv53lzB8kuJCAyoSuJT+HunVhUAU295Nh8HXrk
         knjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E8Lha7INYy+OIBEKFbSkPguyiICrTHAY0jRQJffJHBI=;
        b=CKWRi3Pnzzcm29+HO2/6KUi4QiXAupssCrZgvDxJ01EREgKQI8+ZNfCbTC55SKSHFu
         YrpeeHaSRqZOc3/eNN/6M5+wXjRqWb4b+segGDeXgWqgweyXzH55ChUznohe0lXzCFsZ
         gP9JXehwgFzEVPJ2hf6uZRsQlkeXCia0xrcO73ZPxzgmqloLlK2hgAEAh+FtLn2Z+/rC
         DfdjYjPko6z0voL7h5XoiogkRpi5GUKTsPsM2aijSgB9R7zGldHO3OGObyydCIefEC7k
         LyG2zqShRdM+u1frmXhU+diBmXFieqTWfTffc8xB+tkNfoMauvC5dNTyotd+W3Ap31TX
         oTQw==
X-Gm-Message-State: AOAM532TyjRQZqjVORYE1u3LEKrwiVwFbVWGBYyjzELWy4QOZdjR3dRW
        OQ3zlO/hznbGXQf2UbdI65I3h1AnGuXgX0FCYc0=
X-Google-Smtp-Source: ABdhPJxPeVHXkYrPS6qJHLb/O2EZX6eheK+hkU3KzYaAyPdROpxd+rui+UGQPrH4VwD0/Nc+CWCG4/v7UkBYIvaWlnY=
X-Received: by 2002:a05:600c:104b:: with SMTP id 11mr3616208wmx.54.1635782112219;
 Mon, 01 Nov 2021 08:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211101150759.617943-1-xiehuan09@gmail.com> <20211101111214.1710bfb3@gandalf.local.home>
In-Reply-To: <20211101111214.1710bfb3@gandalf.local.home>
From:   Huan Xie <xiehuan09@gmail.com>
Date:   Mon, 1 Nov 2021 23:55:02 +0800
Message-ID: <CAEr6+EBLeTKRDVzZnrkRf-L+NU_krdZHY7CvJ9kAgJM2dod8Dg@mail.gmail.com>
Subject: Re: [RFC][PATCH v4 1/2] trace: Add trace any kernel object
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 11:12 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon,  1 Nov 2021 23:07:59 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > Introduce a method based on function tracer to trace any object and get
> > the value of the object dynamically. the object can from the dynamic ev=
ent
> > (kprobe_event/uprobe_event) or the static event(tracepoint).
> >
> > Usage:
> > When using the kprobe event, only need to set the objtrace(a new trigge=
r),
> > we can get the value of the object. The object is from the setting of t=
he
> > kprobe event.
>
> Hi Jeff,
>
> I just wanted to let you know that because the merge window just opened
> (Linus released 5.15 and is now accepting changes for 5.16), I most likel=
y
> wont have any time to review your changes while the merge window is open
> (for the next two weeks).
>
> Please do not take my lack of responses during this time as ignoring you.
> I'm just going to be overwhelmed with getting things right, and this merg=
e
> window is going to be a bit tougher for me than other merge windows.
>
> Thanks,
>
> -- Steve

I=E2=80=99m very glad you can explain this and let me know. because the
previous patch[PATCH V3] lacks some functions.
Just update it.

Thanks.
---
JeffXie
