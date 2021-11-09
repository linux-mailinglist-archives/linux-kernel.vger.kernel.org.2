Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E8044B236
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 18:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbhKIRyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 12:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbhKIRyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:54:37 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC77C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 09:51:51 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id o26-20020a4abe9a000000b002b74bffdef0so7185900oop.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 09:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HW60moPJLTS0KOdgX99eOqT8CyAlaO7KO0xrDprVEMU=;
        b=lCVPYmvyv8MmjpRj49qYD77FC7FbmxGcG0sgKLXP+GjQcZJfNhKCnGRRogKsNFtBvB
         9oJ4V5Ie5hQ8BvQODZpm3cWFlV8MW+kg+Q4MMtmEioy332JBMyldO/Zaw6SKziEZfF3h
         uD3Q9kwWd986rfCoGIa20Vzc1YUhlNp20RXMacko3oyjuRi9z2cvu5H81QZmZ+XspR3E
         rcVUV/YbjlLKHkAgHtMpMKHQ6xOKmZ0OYhj8nHFFRIa4TriPXv3e56YArfvtr/2tgGgr
         0SE36GeTPVBqTQAUqE0WlxiwSu3g7kJMvFO14ZRCIaL3sodLmMQtU+M51GgqYAqUEK/T
         hIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HW60moPJLTS0KOdgX99eOqT8CyAlaO7KO0xrDprVEMU=;
        b=yjaeM7tPhJ60iS9oSuciGaUX+U3r52FXqN/Ku7ltQNWbxeB3vjXAxYJfLh1E29wquq
         oknkvwWguiQ8oDollLL4QGid/aS4GWkUMQS+/gJC9A5uj8LG0CNtqqurXhzd6aLTFaIT
         MP24u28C/m2d+DrhuuNguo9X+W8yQVzLwXRGyJ3n9zD0zdVEEtwGoOxzJg4ZWyswluOn
         QpFi50rby+EgGSH981VFck7J2/rA59qnN88MaadBx7bRxLALD5TcPfHzhHJXd38kB0uM
         khffuUvmz/2qBdY3WZ9KmRAnezT1JnaDg7ijiOEy8bkQYM+aE3DiRvcnt3XD+xxg43if
         9HOg==
X-Gm-Message-State: AOAM533oFw4lT/V/TiDhKoit8dP6JT79xUWrCm3r7KWwKXVEb6Qm0pcr
        TXu5P9JvT4ESEIma3Kc/wrDDWtN0PDxBNiRF8lDq3pMejB/FR8vf
X-Google-Smtp-Source: ABdhPJzWfWS2uYunnNJdM5fGH/UVnvHzrVOt8X61cgXXwrvUjv4GogxlISOElKUmUBRDl94eLWdh2VjtGkVX4ae3uOk=
X-Received: by 2002:a4a:e94e:: with SMTP id v14mr4702041ood.1.1636480310707;
 Tue, 09 Nov 2021 09:51:50 -0800 (PST)
MIME-Version: 1.0
References: <20211108185818.GA73382@makvihas> <YYoUYOyyP4EFYTSJ@kroah.com>
 <CAH1kMwSqfNT-jB70c6Md_Wa6Sn6GJKr2=LOunSaZwEk2TKzraA@mail.gmail.com>
 <YYpaP1fAg7jrFyhJ@kroah.com> <CAH1kMwR7BA6kpcHCmEnEQ_EPeJxFDHQ3QB9mAn0D8NzdB8LNhw@mail.gmail.com>
 <YYqWuYK/c6D9K3Xi@kroah.com>
In-Reply-To: <YYqWuYK/c6D9K3Xi@kroah.com>
From:   Vihas Mak <makvihas@gmail.com>
Date:   Tue, 9 Nov 2021 23:21:39 +0530
Message-ID: <CAH1kMwQyy5v+cNkSzORo-tAe7gUuLJA+9GDDV5kGc9QzZ-zMxQ@mail.gmail.com>
Subject: Re: [PATCH] char: ppdev: fixed a validation issue
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sudipm.mukherjee@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> And you didn't answer my question above, what happens if the mode is not
> set properly today?

It'll throw a ENOSYS if the mode is not set properly and print the following:

pr_debug("%s: Unknown mode 0x%02x\n",
             port->name, port->ieee1284.mode);


On Tue, Nov 9, 2021 at 9:11 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 09, 2021 at 09:04:57PM +0530, Vihas Mak wrote:
> > > What happens today if the mode is not set properly?  Will the code paths
> > > error out eventually, or will the call succeed?  The problem is that
> > > there might be code that is working today that would break with a change
> > > like this, as again, this is a very old driver.
> >
> > I see. So I guess this driver might be better off without any changes,
> > as new changes might break things more severely.
>
> Changes in behavior always have the ability to break things.  What other
> changes do you want to make to this old driver that might cause
> problems?
>
> And you didn't answer my question above, what happens if the mode is not
> set properly today?
>
> thanks,
>
> greg k-h
