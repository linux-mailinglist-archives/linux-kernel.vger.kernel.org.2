Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A75533C74E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 21:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhCOUBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 16:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbhCOUA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:00:28 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD9FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 13:00:27 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id p10so10556349ils.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 13:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SaSOoIxes03bHpWUooj+6+ewuXi/Vmtw63TM+HLF9L8=;
        b=eS7HTA1CDl8ccn1pHkFmhPOk8/AlrZMfGwncoeCi7AQIQVOd79gAx9m6kj3QYnUb47
         MxlkV2rY2JMLdkoIdm6yz4mCVdgGgetyBtzMRVAis1d1g73dH5hjfofSB1CR5qCKLvJo
         8TfKD/SIC92DISesqp7OPW25vs9bXG6kB+vHRLoZ4u6MO5JhIyCxwu/3ntQp4DB3KcY9
         yRKoTRYgguy5FukC/xT47rA0l5Se1jhjRTH91kzkMwMnCGiqwVsDtZYpZ9pRPOzF80yh
         vugMKOjJHGWs/UcaarhoQpq1ZKnHzeFvik4XQlwrat8noWxZP5ZfA0mSZdFjFFFPEvn5
         0D1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SaSOoIxes03bHpWUooj+6+ewuXi/Vmtw63TM+HLF9L8=;
        b=jAyOdXTJALNZERQa/5niYLUo2t8OGZ0+81XYwA+tSUkEA2REKGb+Rt51YNGmdHxpqy
         1F1/kpfTBEm2ikcE67V5YK1aldqIKdTG0N68qv7ZxPb+irEiJhAZAkln1F+6G7vGQvmZ
         ASInO1SF/wH//glY7X4HfqhlgVb5oUIRx1K6FrgVBcHxH3ETRwYbZJmpoGLdWRPQLw4v
         bWpodT/lNhvWtZOo++RBUYfQnQCs0dtvTMd001k5GKf/6a9QJ5xnXOE7flTPbpToahUD
         bE0GksJkfOcf2PG95tLqygSFzyWgnbGgqmhAw0D25On+e2upOaTBqgpogMWJ0glWoO5v
         ANtA==
X-Gm-Message-State: AOAM5330GanGAWpOlDFhqa7eTzdimXqem3zpYvqn2EsmabfugxMsnjic
        b8CA7cD6+ds8uqVM05Uwp5/WnGUU4iMhfAw2DYk=
X-Google-Smtp-Source: ABdhPJypLcpbSKR4xnoaFP9F3f6VMO35r0f7ds36bijQO3NVnMxR3QAoAM5VGva8qRnVO5/aYWJWaZoKjg1/sdQSXEE=
X-Received: by 2002:a92:740c:: with SMTP id p12mr1052065ilc.9.1615838427364;
 Mon, 15 Mar 2021 13:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210314035757.2740146-1-ztong0001@gmail.com> <5d7a5e1c-35ab-58cb-ebcd-da5b280c802e@mev.co.uk>
 <858341a6-c105-1440-aa4d-ea0217f2ec89@mev.co.uk>
In-Reply-To: <858341a6-c105-1440-aa4d-ea0217f2ec89@mev.co.uk>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Mon, 15 Mar 2021 16:00:16 -0400
Message-ID: <CAA5qM4AJRYndkXSiW5Y4OCFcH97mf6UiiEEox+TQs8-N957mJA@mail.gmail.com>
Subject: Re: [PATCH] staging: comedi: replace slash in name
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        devel@driverdev.osuosl.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Ian,
I have submitted a v2 patch based on your suggestions.
Thanks,
- Tong

On Mon, Mar 15, 2021 at 6:48 AM Ian Abbott <abbotti@mev.co.uk> wrote:
>
> On 15/03/2021 10:44, Ian Abbott wrote:
> > On 14/03/2021 03:57, Tong Zhang wrote:
> >> request_irq() wont accept a name which contains slash so we need to
> >> repalce it with something else -- otherwise it will trigger a warning
> >> and the entry in /proc/irq/ will not be created
> >>
> >> [    1.565966] name 'pci-das6402/16'
> >> [    1.566149] WARNING: CPU: 0 PID: 184 at fs/proc/generic.c:180 __xlate_proc_name+0x93/0xb0
> >> [    1.568923] RIP: 0010:__xlate_proc_name+0x93/0xb0
> >> [    1.574200] Call Trace:
> >> [    1.574722]  proc_mkdir+0x18/0x20
> >> [    1.576629]  request_threaded_irq+0xfe/0x160
> >> [    1.576859]  auto_attach+0x60a/0xc40 [cb_pcidas64]
> >>
> >> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> [snip]
> > Userspace applications can use these strings to determine the board
> > type, so changing the strings would break those applications.
> >
> > I suggest passing the comedi driver name "cb_pcidas" to request_irq()
> > for now.
>
> Oops, I meant "cb_pcidas64".  But you could reach that via
> dev->driver->driver_name if you want (where dev is the struct
> comedi_device * parameter).
>
> --
> -=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
> -=( registered in England & Wales.  Regd. number: 02862268.  )=-
> -=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
> -=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
