Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4484B306A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 02:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhA1BYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 20:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhA1BX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:23:58 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0E6C061574;
        Wed, 27 Jan 2021 17:23:17 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id f2so4366947ljp.11;
        Wed, 27 Jan 2021 17:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRE95trqB4FwG+o0AC+VFmG51xcWnnjNWWRbJ2+m+4o=;
        b=XWnN3xek8sPxdM2T3x8Wj+pVQD42MXnmCxAbhf+8q9hWJNZMYH5W3p0ZysYcKEOGl1
         JPeYFbAacDk5zibW2AKPxWZyhRJWViyFazuu3ytHhrJjCjxuH4m9jMM4qGGwM3YW/XrY
         4HPDaZ5/0s+FOkRJXEpCIBnRAZMopPDankXTlgFyEEiJ9LgphYZlyld2TOyRu8P2DLI2
         NNy9dxrIKB1yDcw1ELOH2l0qAYHcP5vYLYXnpxDtUq4KzWTswNkgFsFaNHm2gq5PFxkE
         2uEwIT1NA5cCBqihbbuGQigLJN/EU5cjtiJlTLcpIs+tofiCUQ73OGPX8R0BNo3bnyMi
         oz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRE95trqB4FwG+o0AC+VFmG51xcWnnjNWWRbJ2+m+4o=;
        b=OBaAGgFHg7MqP6znTRVejpQkrnDBx2Y3/s+XvX88uXdhqr09uKiSG3ROeGEqODqeKi
         gutuatsUbxPKWRSG6CCCUiFfUT0NJeRQpdkP3S2ZTZKScJ+M5PsMa45odFy5e5dxLnO8
         R7Bs3eHJJ+HaGEC634N6ycK08mYo/Edcr6svgcjd66MD9PW1+qO+duInN8d3tALv0tqs
         NutF1P0cyZ3zpkKYqtAzacIgWp+ETKBaMe3tnu9V8eBxzMt+kA3FhuvmkC/ZfFuQexDa
         IkFUWKYFhnogLPWnSADyZ0iagWt6q4Ja8kpRPAMiZ+Q5Dp0HpXUb1oAtTebB0SlPuPNb
         JKBg==
X-Gm-Message-State: AOAM533UAkkWpXF8C8GxEJFQRDyWRdNNHwB3ZUoVRxNWZCHgRTlWSNsw
        NjPCdoof+yjx1N8uI3FPAzVYTGdSjPqEbj0twBU=
X-Google-Smtp-Source: ABdhPJwfwNYIvW0Y0XM9IfRSJrCg9c/xSWvyMyWVTmfwMYXIE50kJsAc7NqoZagKXYt9uOEPcksuE/yiFB4Yed5W5mA=
X-Received: by 2002:a2e:9047:: with SMTP id n7mr1997482ljg.405.1611796995742;
 Wed, 27 Jan 2021 17:23:15 -0800 (PST)
MIME-Version: 1.0
References: <20210126072443.33066-1-foxhlchen@gmail.com> <20210126133141.27eb1c9d@lwn.net>
In-Reply-To: <20210126133141.27eb1c9d@lwn.net>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Thu, 28 Jan 2021 09:23:03 +0800
Message-ID: <CAC2o3DJZL7QNcm7c=ijNbTWjHg+8k-mT_LK_d9Ctg8-LjC-A0g@mail.gmail.com>
Subject: Re: [PATCH 00/12] docs: path-lookup: Update pathlookup docs
To:     Neil Brown <neilb@suse.de>
Cc:     vegard.nossum@oracle.com, Al Viro <viro@zeniv.linux.org.uk>,
        rdunlap@infradead.org, Jonathan Corbet <corbet@lwn.net>,
        grandmaster@al2klimov.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 4:31 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Tue, 26 Jan 2021 15:24:31 +0800
> Fox Chen <foxhlchen@gmail.com> wrote:
>
> > The Path lookup is a very complex subject in VFS. The path-lookup
> > document provides a very detailed guidance to help people understand
> > how path lookup works in the kernel.This document was originally
> > written based on three lwn articles five years ago. As times goes by,
> > some of the content was outdated. This patchset is intended to update
> > the document to make it more relevant to current codebase.
> >
> >
> > Fox Chen (12):
> >   docs: path-lookup: update follow_managed() part
> >   docs: path-lookup: update path_to_nameidata() parth
> >   docs: path-lookup: update path_mountpoint() part
> >   docs: path-lookup: update do_last() part
> >   docs: path-lookup: remove filename_mountpoint
> >   docs: path-lookup: Add macro name to symlink limit description
> >   docs: path-lookup: i_op->follow_link replaced with i_op->get_link
> >   docs: path-lookup: update i_op->put_link and cookie description
> >   docs: path-lookup: no get_link()
> >   docs: path-lookup: update WALK_GET, WALK_PUT desc
> >   docs: path-lookup: update get_link() ->follow_link description
> >   docs: path-lookup: update symlink description
> >
> >  Documentation/filesystems/path-lookup.rst | 146 ++++++++++------------
> >  1 file changed, 63 insertions(+), 83 deletions(-)
>
> Neil Brown (copied) is the original author of this document; I'd really
> like his feedback on these changes.  Neil, the full set is at:
>
>         https://lore.kernel.org/lkml/20210126072443.33066-1-foxhlchen@gmail.com/
>
> Thanks,
>
> jon


FYI, To help review the patches I marked & annotated all the places
I've changed.

you can check the link:
https://hyp.is/go?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Flatest%2Ffilesystems%2Fpath-lookup.html&group=__world__


thanks,
fox
