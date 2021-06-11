Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0174E3A444D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhFKOrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231244AbhFKOro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623422746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DQB6N6XL2pvcqeJiPA2ZmqiMMjPc7PLdmvPf5Fljtv8=;
        b=O0hgJKyyZAHvQMNVFsrpLysBNn9XGpTJTiW8oYevT/d1gw0+sufadIiQkbGvlX3sDtmjx1
        M0pjMvG0bQ9Optz2gvsj4rtJMySXVKRK0qfAhejrDMynkBaCXW7bt6SQjWMJ/cireDFagM
        /Sazx15iH7JI7FPWSUcR6+7RssCKF4Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-Bxn1sPe1PNO0AAQuML2v9Q-1; Fri, 11 Jun 2021 10:45:44 -0400
X-MC-Unique: Bxn1sPe1PNO0AAQuML2v9Q-1
Received: by mail-wr1-f71.google.com with SMTP id z13-20020adfec8d0000b0290114cc6b21c4so2712346wrn.22
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 07:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQB6N6XL2pvcqeJiPA2ZmqiMMjPc7PLdmvPf5Fljtv8=;
        b=m+OlB2raNnDTt4tozbtYWifk7RPKcyQWkX7jQNGzG/53Kf3kgPIP6trf0ZpropazCn
         Cy2dl/wuqOP4cp5tvWR+mpaZXmYmIRKsTSHcLMkc3fZ4ReJwn0lrnBDrWabtXziBYlcx
         ZxDn3veh1vpCPbwj/nDhSGkVEI+ZE2C7IKT2OiNoMkRNVloxkO984BQ2UcgwtLBPFKpF
         RZW543Ws/dsThQdwgaZoxd0JvE9+5Hu4DSiPyuVnS47k4k99cd471ToSqVaHTzbLwrOl
         kWYGWUyxLe93QX5U5QJp/jNqvtbWGVQECWlr6b7O+tFORJEntQ8R4lIdu8O2M+5WSBkM
         smbQ==
X-Gm-Message-State: AOAM532tS3wRdqx82dUAqFmLKbzAm2ofEUFyzyqbo3hujcPFVKdq0PZH
        mi22+MggVnKoITUT6RoZCrnbZNMMfj1VSCyEm+hOawDdWWC6GJp/LqWOPdAEzWDTUf4xB1ZLT4S
        v1WNrRPdbhntGw6Jk52/NqsvSUQniFJ/PwYbiiBew
X-Received: by 2002:a7b:cbd1:: with SMTP id n17mr4503227wmi.2.1623422743724;
        Fri, 11 Jun 2021 07:45:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvi4w2zFQuxKj3LupeXDCj8y0WDaqvCUS9Zm2BqynGzipepPCQctsQJyLR1b2t0Ex5hUJuNOln32r8IlFD4j0=
X-Received: by 2002:a7b:cbd1:: with SMTP id n17mr4503218wmi.2.1623422743591;
 Fri, 11 Jun 2021 07:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210611111231.7750bb60@canb.auug.org.au> <YMLAcExtFTEYl5Bi@zeniv-ca.linux.org.uk>
In-Reply-To: <YMLAcExtFTEYl5Bi@zeniv-ca.linux.org.uk>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 11 Jun 2021 16:45:32 +0200
Message-ID: <CAHc6FU7SZJfLAD6dRdD9V0mW1w+xZrW77REaaP+EzUBtd_uciw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the gfs2 tree with the vfs tree
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 3:46 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Jun 11, 2021 at 11:12:31AM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > Today's linux-next merge of the gfs2 tree got conflicts in:
> >
> >   Documentation/filesystems/porting.rst
> >   include/linux/uio.h
> >   lib/iov_iter.c
> >
> > between various commits from the vfs tree and the same, older version,
> > of the commits from the gfs2 tree.
> >
> > I fixed it up (I used the vfs tree versions) and can carry the fix as
> > necessary. This is now fixed as far as linux-next is concerned, but any
> > non trivial conflicts should be mentioned to your upstream maintainer
> > when your tree is submitted for merging.  You may also want to consider
> > cooperating with the maintainer of the conflicting tree to minimise any
> > particularly complex conflicts.
>
> IMO iov_iter_fault_in_writeable() is a bloody bad idea to start with...

It seems that we need a mechanism for faulting in a page in for
writing. It's ugly that iov_iter_fault_in_writeable() writes to the
page for faulting it in, and if the operation that the page was
faulted in for then fails, those writes will be visible. Would an
implementation that reads and then writes back the same value be less
bloody bad?

Thanks,
Andreas

