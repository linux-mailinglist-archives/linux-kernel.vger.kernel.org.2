Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D5038C020
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 08:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhEUG5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 02:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhEUG46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 02:56:58 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74A3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 23:55:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b7so6296191plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 23:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sGftOaEMxAoYeBKooh8f+t1rZ93tjBzFcXOOUrUF3hc=;
        b=LvIPfyFY37mZfyjLZ0WxsgIv4TtcDWISXAc/FqL7SoFKxBM7gSHSofLSnDWUs2aDPb
         61FFh8P1OPi874NqarRGsIBXzwYgfgVkgNYnz5y6l1DWVA5VYCe3/wJ/x3yVHNlfiO/1
         lUeRfLpanMX/jbkyVBDKBx3puP3JdbL/KQMgBut6qxhgHZURlpd7MK+x+ODu9bQl9lpt
         Prgm2V2+8gPmo58a8IcEruDb9IX3TgteKK+R+7mB0RHWrGg/OCFELJrBZgF0I8/fZsJ7
         QF297DqV8PTt0luGt5bocpXVNIzKzouLjkfgZPPCIFQJ/Ksp4PDOJb8/Hwk/UpmeWbgS
         Fjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sGftOaEMxAoYeBKooh8f+t1rZ93tjBzFcXOOUrUF3hc=;
        b=muDvG/1I3sjMMHZemOug7cK/uSf0z2FdI8n8ithYdpyCY7wV+KGDcgLNCLu+vhjuC4
         k+W8sEWYF7kQHUhysIoK5cA6rsh3dJdUcpWNBcokUhkp5MwIRQ6quT2b0lpQhmmAm3b1
         oBzAsdr0dCFtjd63fVPy16GNXq22y8MipwSdeCpSK4mkonu9K6BNuKODfDUeNo1PAQUD
         VtGuMgw9DqDhfHajgLv4HHUwK5D5NBqQRKbvoSVXTi1ZMD5CdTI0LUyuisyXo9mcvFNg
         etV2J9wgSVXOKpiWCMmNPLhXI8qM/FEZuNx4+XQxpFkkyfdM1hOxAdIDIb+pJc9qNlFG
         UMsw==
X-Gm-Message-State: AOAM5331xhTezG008G9vjaa4nsnRKOVn9tcGpivB5w9OXQDoLWL2aLFK
        DTQh6fZEm28GlGLmTlZ9c0jws8h/y3Q/16S03/s=
X-Google-Smtp-Source: ABdhPJwg+ge+8h91ygHZcQG0IWbYNvlkKsz5qePK3xDDkglzD69jmx3qJkFmjyVKin69eeREh0cqoKY23HPKbNIHVhM=
X-Received: by 2002:a17:90b:4ac2:: with SMTP id mh2mr9725466pjb.33.1621580135214;
 Thu, 20 May 2021 23:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210521025525.GA1379@raspberrypi> <YKc5jLVhw8+Oy165@kroah.com>
In-Reply-To: <YKc5jLVhw8+Oy165@kroah.com>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Fri, 21 May 2021 15:55:23 +0900
Message-ID: <CADLLry5J5GqB_Rw7n0aKcWgYPJZDOQP89mvyWT-GnB8KAiQrBA@mail.gmail.com>
Subject: Re: [PATCH] kernfs: move return value check after kmalloc()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tj@kernel.org, neilb@suse.de, linux-kernel@vger.kernel.org,
        =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021=EB=85=84 5=EC=9B=94 21=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 1:39, G=
reg KH <gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, May 21, 2021 at 03:55:25AM +0100, Austin Kim wrote:
> > With 414985ae23c0 ("sysfs, kernfs: move file core code to fs/kernfs/fil=
e.c"),
> > 'return -ENOMEM' is executed when kmalloc() returns NULL.
> >
> > Since 'commit 4ef67a8c95f3 ("sysfs/kernfs: make read requests on pre-al=
loc
> > files use the buffer.")', 'return -ENOMEM' statement is not properly lo=
cated.
> >
> > Fix it by moving 'return -ENOMEM' after return from kmalloc().
> >
> > Fixes: 4ef67a8c95f3 ("sysfs/kernfs: make read requests on pre-alloc fil=
es use the buffer.")
> > Signed-off-by: Austin Kim <austindh.kim@gmail.com>
[...]
>
> Like Neil said, I don't see the "bug" you are fixing here.  What is
> currently wrong with the existing code?

I just found something to improve a little, which has nothing to do with 'B=
ug'.
(of->prealloc_buf is allocated ahead of kernfs_file_read_iter().)

Should be cautious of adding 'Fixes' tag.

Thanks

>
> thanks,
>
> greg k-h
