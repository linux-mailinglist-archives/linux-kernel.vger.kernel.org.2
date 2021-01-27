Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07B5306482
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhA0T46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhA0T4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:56:55 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2EEC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:56:15 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id a16so1168938uad.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65FVE3sIUI1qUS2aQ7B54EcM5lYLq0ggA4200iyt3fI=;
        b=FgSFYzCyE34qUmN13bvroMyOtKF4VyncZ+cUZ5HSu69JWJk+QTFqGb7j0O2X1eiJ8g
         UtOe3fYCKSUxh067OeTaWjsA+ydU68z/cSfkMr89AJTIqXkLOoTyT8HslXiiXcJ6Uz3p
         PrS7xdLGOgp6JzRpvL157N8nsTlhaTjvQ9B6+Oe6RB+qaRXhOfM2cyEFFCtGU9rqj2Dq
         UBMk6jH30QVUfd/ymjM7UCFYi/y7Zd6yEUBub7CNfCs/wZHom+Je6rQewERs/odcUFKf
         7mPeRblP4B4BowltsI0VvkRy/wLteLlsP5tWSVuwdOVFykB2eriH7sTmykitYLGOxwEn
         lWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65FVE3sIUI1qUS2aQ7B54EcM5lYLq0ggA4200iyt3fI=;
        b=iyQcjR1UN0rUUSryvrMcyIutPHhHnrURJ1HQ2h7YC3zRxkAbd1eGIYUj6BD/bVtaY6
         VsaWhvTsvwrVvSQI/hTn0eU2V3/jB0DeieJfIfI+0q2NE1pmCOIg5Yam2ZV/k0ZulxUh
         gle3LwzqIaFkvtRO1oGem5G6q5no0Z7ipktTtssvQ3VkmurE3glmlEMHkAGexOnsmWem
         HjlGu37q4Tsp1nKtaeIEOPesODfvyJbBKZnhIKLymBZTHa1nh7sp5iBIr8tjovlGSiC+
         d2zIDnZizIaBXYn+Zz6+nyERrNvjcuydaYxesfDO7nIyLDCXDhyk/EJkutWx6qd46/NV
         sJkg==
X-Gm-Message-State: AOAM532PvfCXYLa9lw5f/wG03iLJPISN9bjO3KdP/OUfAZYJ02QSFc9s
        /tImzIoOYeSo4iTfIBDpoF0+74ZTV2nmO5XsXVRdmoAw6HZJ/w==
X-Google-Smtp-Source: ABdhPJwbmgLT2Pit9wTfaAHoTwUiPBco/OYOYX5LOtDcT2wvl5l/tmFJHGC4A/YjhsQbpiiIy+C+9XILbO3WH7RP0pY=
X-Received: by 2002:ab0:2eb0:: with SMTP id y16mr9240152uay.123.1611777374340;
 Wed, 27 Jan 2021 11:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20210123205516.2738060-1-zenczykowski@gmail.com> <YBFu9WkVMdsfy51I@kroah.com>
In-Reply-To: <YBFu9WkVMdsfy51I@kroah.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date:   Wed, 27 Jan 2021 11:56:03 -0800
Message-ID: <CANP3RGcoXV+gDXjhYV5USYURHOyiZE=t6ptwp2hZb=vni3RP7g@mail.gmail.com>
Subject: Re: [PATCH] configfs: make directories inherit uid/gid from creator
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Currently a non-root process can create directories, but cannot
> > create stuff in the directories it creates.
>
> Isn't that on purpose?

Is it?  What's the use case of being able to create empty directories
you can't use?
Why allow their creation in the first place then?

> > +             (void)configfs_setattr(dentry, &ia);
>
> No need for (void), here, right?

Just being clear we're ignoring any potential error return.

> And this feels like a big user-visible change, what is going to break
> with this?

That I don't know, but it's unlikely to break anything, since it's virtually
impossible to use as it is now.  If non-root creates the directory, it's
currently root-owned, so can only be used by root (or something with
appropriate caps).
Something with capabilities will be able to use it even if it is no
longer owned by root.
