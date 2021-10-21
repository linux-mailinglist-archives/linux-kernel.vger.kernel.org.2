Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336A5436778
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhJUQVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:21:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231206AbhJUQVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634833136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T6yUHXDCJ1C4bwIVBI0pS677wtC3A8dJIjgudbpVBfQ=;
        b=UjLEtjy3TB0ptcoQC8SzWxyPtWxnVenx+3mjMgl5v6FVVGeX1YksHNjGdeubfi6CroxDx0
        Fw7nz5pEazMl+FvRx0yZH9DyeGKqLqN+sUIvVYLfayVPqGAebQkr0XKvb9q+PJwxsw5+q5
        UzHyHWkEYf8yszwT01rurO7IJZUDCwQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-8nD9ofdQNEOE3TFFIDpYfg-1; Thu, 21 Oct 2021 12:18:55 -0400
X-MC-Unique: 8nD9ofdQNEOE3TFFIDpYfg-1
Received: by mail-io1-f69.google.com with SMTP id c10-20020a5e8f0a000000b005ddce46973cso804442iok.15
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T6yUHXDCJ1C4bwIVBI0pS677wtC3A8dJIjgudbpVBfQ=;
        b=dqXcVXaqk69p790zuKO6aLClntJcr0hF6JpTBDy2v5dOifhCubozq/eJDbIr4zdyiD
         8N7kNR+9hWLZ+NS1tn/aq+Yrj6Jhz9/cA7PADLCY778PX4lcp965FOkd6+D6w1gLskBD
         GJKp9/SrMxUGR70Qy3n8pS5QFI/4pC+SYbA58AhniQpNt0DVsutzP4OwVOPqm1Oo52NI
         ohBEJqRxxDNIZHICmVYZcyXp3qXjqu7aua+4oXeRNaZio3gi53Ha4iSyvyCQs6WNnD75
         iuNiTQsn1AK9kDotYunlkRAhjgkZDeMlUGOj/j0fCU/i8eJ9WXeo1jm26uiVTLNx/pZ7
         bJLA==
X-Gm-Message-State: AOAM533tqInsTpwrth03W4b0sOEfcqkY9aFquuAvUU8Hl3kcOFX6vDA4
        IFwNZNY9ifsgwN5MMJ3sWeIgCGJ4nK5xnWoaSciYUiSeQ4+bZElxkMZ8KG96FG5oWaQ2cSl5Ycl
        5PSvr40T0y4OmE9XyvEeg+37SyObaGSZyDcR+gPWo
X-Received: by 2002:a05:6e02:1b88:: with SMTP id h8mr4249364ili.200.1634833134396;
        Thu, 21 Oct 2021 09:18:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5y9j7z3dJn9Glj8ooQ1Y//DehvKlW+RX8Ejsk0RiCAUP4d4N+GvEQQX2Jmru5XQiMXq9WTCoSUsp4sYgnr5I=
X-Received: by 2002:a05:6e02:1b88:: with SMTP id h8mr4249352ili.200.1634833134229;
 Thu, 21 Oct 2021 09:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211020143708.14728-1-lhenriques@suse.de> <34e379f9dec1cbdf09fffd8207f6ef7f4e1a6841.camel@kernel.org>
 <CA+2bHPbqeH_rmmxcnQ9gq0K8gqtE4q69a8cFnherSJCxSwXV5Q@mail.gmail.com> <99209198dd9d8634245f153a90e4091851635a16.camel@kernel.org>
In-Reply-To: <99209198dd9d8634245f153a90e4091851635a16.camel@kernel.org>
From:   Patrick Donnelly <pdonnell@redhat.com>
Date:   Thu, 21 Oct 2021 12:18:28 -0400
Message-ID: <CA+2bHPZTazVGtZygdbthQ-AWiC3AN_hsYouhVVs=PDo5iowgTw@mail.gmail.com>
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

On Thu, Oct 21, 2021 at 11:44 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Thu, 2021-10-21 at 09:52 -0400, Patrick Donnelly wrote:
> > On Wed, Oct 20, 2021 at 12:27 PM Jeff Layton <jlayton@kernel.org> wrote=
:
> > >
> > > On Wed, 2021-10-20 at 15:37 +0100, Lu=C3=ADs Henriques wrote:
> > > > This counter will keep track of the number of remote object copies =
done on
> > > > copy_file_range syscalls.  This counter will be filesystem per-clie=
nt, and
> > > > can be accessed from the client debugfs directory.
> > > >
> > > > Cc: Patrick Donnelly <pdonnell@redhat.com>
> > > > Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
> > > > ---
> > > > This is an RFC to reply to Patrick's request in [0].  Note that I'm=
 not
> > > > 100% sure about the usefulness of this patch, or if this is the bes=
t way
> > > > to provide the functionality Patrick requested.  Anyway, this is ju=
st to
> > > > get some feedback, hence the RFC.
> > > >
> > > > Cheers,
> > > > --
> > > > Lu=C3=ADs
> > > >
> > > > [0] https://github.com/ceph/ceph/pull/42720
> > > >
> > >
> > > I think this would be better integrated into the stats infrastructure=
.
> > >
> > > Maybe you could add a new set of "copy" stats to struct
> > > ceph_client_metric that tracks the total copy operations done, their
> > > size and latency (similar to read and write ops)?
> >
> > I think it's a good idea to integrate this into "stats" but I think a
> > local debugfs file for some counters is still useful. The "stats"
> > module is immature at this time and I'd rather not build any qa tests
> > (yet) that rely on it.
> >
> > Can we generalize this patch-set to a file named "op_counters" or
> > similar and additionally add other OSD ops performed by the kclient?
> >
>
>
> Tracking this sort of thing is the main purpose of the stats code. I'm
> really not keen on adding a whole separate set of files for reporting
> this.

Maybe I'm confused. Is there some "file" which is already used for
this type of debugging information? Or do you mean the code for
sending stats to the MDS to support cephfs-top?

> What's the specific problem with relying on the data in debugfs
> "metrics" file?

Maybe no problem? I wasn't aware of a "metrics" file.

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Principal Software Engineer
Red Hat, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D

