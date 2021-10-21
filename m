Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0358F436375
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhJUNzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230390AbhJUNzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634824380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uRKlQVP5q9wu9q0KFDh68sx4zgVOkV7V7+M/iuIu2a0=;
        b=cKSYADJ68lrlU40/LLhuj24v6XzJL1FghGlDo1tXhaS+DZisaBXqAeX7DCtxaAPWTPBTgb
        +mhF9ys/0ITHLRyNy/VklS69kuXouH9Pd4E4fEPGzqKfLkxMy4oKxdQjm089cJlomu2XEK
        h7cvTUWm8iKeb76Bz7JgiykS7Q1Hvv0=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-82zrNFDMMqOW6K2PkbTosA-1; Thu, 21 Oct 2021 09:52:59 -0400
X-MC-Unique: 82zrNFDMMqOW6K2PkbTosA-1
Received: by mail-io1-f71.google.com with SMTP id l17-20020a05660227d100b005d6609eb90eso462894ios.16
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uRKlQVP5q9wu9q0KFDh68sx4zgVOkV7V7+M/iuIu2a0=;
        b=YnfearEY75Cxtgb+NMBZh3XArpGS4rkUverRgEJhDGO32rq4FQaGEyCZTTKS9AXcLg
         fEXo4pFbU+romA3Jjzpywm/3xZFbiQTJcZhVVT7aGyanEz7gkBlm7jtF92btnpfaW2rq
         rDXd/NUYZxMNmJB9ADnQFhqZP3s7aMPeZ8nw77e5OPKeTzjXygdVRXokggWm3vXbL0vX
         cjt3OVGb/muBFNNKF0t8hz5RVFpeNbPCXuNpj1GOu6E+1l1YJdh10L9er+Sf0PoYMzTB
         TXFmY87GoOWXe5kmYOKIac8JJCvBON9tygFUrcTqQ4l/FtkkG9jmQ6A38n9TCgdt1pvu
         CcZA==
X-Gm-Message-State: AOAM533DsjORMeKfC0cgQ8slBhtiex/arrBV5jiqjiBPvMbjQIq/w41J
        NjDjZ+ye264YqDGBfn7z0jfAED/eGOQekZstzM5zr+/BCUkE3BfEla83CGugJwBfa+q4SKd2e1p
        J73ewXoyT7yxMSsh5ajRw/UvB5PcWUeGW10/CW0Fe
X-Received: by 2002:a05:6e02:120f:: with SMTP id a15mr3766392ilq.109.1634824378754;
        Thu, 21 Oct 2021 06:52:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlO0Zg7XO8nAok+S0+ufULgmQ4M5Q86Wtwg/BpzuD1JY6B5rC8mn9n7PHA/LoD/pAaNX8TKUI6I5aT0avhZjw=
X-Received: by 2002:a05:6e02:120f:: with SMTP id a15mr3766386ilq.109.1634824378574;
 Thu, 21 Oct 2021 06:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211020143708.14728-1-lhenriques@suse.de> <34e379f9dec1cbdf09fffd8207f6ef7f4e1a6841.camel@kernel.org>
In-Reply-To: <34e379f9dec1cbdf09fffd8207f6ef7f4e1a6841.camel@kernel.org>
From:   Patrick Donnelly <pdonnell@redhat.com>
Date:   Thu, 21 Oct 2021 09:52:32 -0400
Message-ID: <CA+2bHPbqeH_rmmxcnQ9gq0K8gqtE4q69a8cFnherSJCxSwXV5Q@mail.gmail.com>
Subject: Re: [RFC PATCH] ceph: add remote object copy counter to fs client
To:     Jeff Layton <jlayton@kernel.org>
Cc:     =?UTF-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:27 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Wed, 2021-10-20 at 15:37 +0100, Lu=C3=ADs Henriques wrote:
> > This counter will keep track of the number of remote object copies done=
 on
> > copy_file_range syscalls.  This counter will be filesystem per-client, =
and
> > can be accessed from the client debugfs directory.
> >
> > Cc: Patrick Donnelly <pdonnell@redhat.com>
> > Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
> > ---
> > This is an RFC to reply to Patrick's request in [0].  Note that I'm not
> > 100% sure about the usefulness of this patch, or if this is the best wa=
y
> > to provide the functionality Patrick requested.  Anyway, this is just t=
o
> > get some feedback, hence the RFC.
> >
> > Cheers,
> > --
> > Lu=C3=ADs
> >
> > [0] https://github.com/ceph/ceph/pull/42720
> >
>
> I think this would be better integrated into the stats infrastructure.
>
> Maybe you could add a new set of "copy" stats to struct
> ceph_client_metric that tracks the total copy operations done, their
> size and latency (similar to read and write ops)?

I think it's a good idea to integrate this into "stats" but I think a
local debugfs file for some counters is still useful. The "stats"
module is immature at this time and I'd rather not build any qa tests
(yet) that rely on it.

Can we generalize this patch-set to a file named "op_counters" or
similar and additionally add other OSD ops performed by the kclient?

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Principal Software Engineer
Red Hat, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D

