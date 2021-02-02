Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340B130CE93
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhBBWNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:13:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50313 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233881AbhBBWM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612303888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VpgWM/abuu0TQrIRbjQU0gPGa4Gz1AqWL2PjDpQS6SU=;
        b=Pp8rJhwCttizwYg4JapspQrGK+NknQgcSTuj6NDRMOlerNESeRQNb2GcNPvfangsmZfTv5
        0j0HtuFs88joc1Q11yavv+vkibhg7/hU3lkBRyb6Rb2BVM5qbjG5oRU2uAZPOFDOprxKng
        Xu+bxuXbHvHDb4thAEP81/2pJA0Q//0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-sRyKq4FUPamPGOdz3tGQuA-1; Tue, 02 Feb 2021 17:11:26 -0500
X-MC-Unique: sRyKq4FUPamPGOdz3tGQuA-1
Received: by mail-lf1-f69.google.com with SMTP id k5so4995880lfo.19
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 14:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VpgWM/abuu0TQrIRbjQU0gPGa4Gz1AqWL2PjDpQS6SU=;
        b=ZIj1vM4TcfC5QLhSf9jTsCQVmd33PyWqdb5oTPIPP8sJrt6Xj+sbHRQ77yrJXI60Yq
         Ec4A2ExKD9tLiFbaSoYZw7r9ybvEXmsk8QKVdnTwAfv/BHSWtFSQlZ5TbeTncOWiD44K
         CKQZNXcEG/rlkIAhMrGcRAlyo6C31uzJDcIC3gQ1ZVuOOQZGKHz7sIDO3ABEvqOsuGq4
         blML1GTMZvdFOwDbU5QT00cjH3MKgRCnbbzaAq5MQy2oLTTGmyrtCs8KzKoatrSLGLFc
         Ez1sOkllV9uFiC5g3ewa2gC1vOMHVtSHyDsJ1kLOSe+WBtko1FShuJcFKrDNnbOFbpgD
         8aaA==
X-Gm-Message-State: AOAM530zf41XZFhN4HMoyFN3e/hEOodT7cLtNOOwxsGouB5lPpKDWZyx
        fxzGYOCAoLVNCGhU3wsy8W794J6vCSFG+wq9Ky+1ViufmwQXQtXXmdvEkHkxoPrUntYd0uwo/lc
        YUUrseeIhV9BH9UcPKP4gotVnOvJICv7Xe1zW6eOG
X-Received: by 2002:a19:7403:: with SMTP id v3mr28324lfe.67.1612303885022;
        Tue, 02 Feb 2021 14:11:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxG2tuetzkIl/9/aGTkkG1GCcsDk3ZS+fx56+MYmsFDp8xUqUXyNP/1lCpSUkhjchhEL7K5ygz/gh7N0JwmERQ=
X-Received: by 2002:a19:7403:: with SMTP id v3mr28269lfe.67.1612303883741;
 Tue, 02 Feb 2021 14:11:23 -0800 (PST)
MIME-Version: 1.0
References: <20210202212930.18845-1-danielwa@cisco.com> <CAHC9VhShkEJHWmuE2C_RLQy-Z3CpvAhTj68ki22v=AKF5hfvrQ@mail.gmail.com>
 <20210202214357.GD3710@zorba> <CAHC9VhSVBV=_pBnj7sxwJu0siXx5P7JrsYSz1_vW3j6WmTw+6w@mail.gmail.com>
In-Reply-To: <CAHC9VhSVBV=_pBnj7sxwJu0siXx5P7JrsYSz1_vW3j6WmTw+6w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 2 Feb 2021 23:11:12 +0100
Message-ID: <CAFqZXNtRYNQNTfTM_QkeS__YFYSVgkvkZW0EWD=t7KacEeE4Jw@mail.gmail.com>
Subject: Re: [PATCH 1/2] audit: show user land backtrace as part of audit
 context messages
To:     Paul Moore <paul@paul-moore.com>
Cc:     "Daniel Walker (danielwa)" <danielwa@cisco.com>,
        "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        "Ruslan Bilovol -X (rbilovol - GLOBALLOGIC INC at Cisco)" 
        <rbilovol@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 10:46 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Feb 2, 2021 at 4:44 PM Daniel Walker (danielwa)
> <danielwa@cisco.com> wrote:
> > On Tue, Feb 02, 2021 at 04:35:42PM -0500, Paul Moore wrote:
> > > On Tue, Feb 2, 2021 at 4:29 PM Daniel Walker <danielwa@cisco.com> wrote:
> > > > From: Victor Kamensky <kamensky@cisco.com>
> > > >
> > > > To efficiently find out where SELinux AVC denial is comming from
> > > > take backtrace of user land process and display it as type=UBACKTRACE
> > > > message that comes as audit context for SELinux AVC and other audit
> > > > messages ...
> > >
> > > Have you tried the new perf tracepoint for SELinux AVC decisions that
> > > trigger an audit event?  It's a new feature for v5.10 and looks to
> > > accomplish most of what you are looking for with this patch.
> > >
> > > * https://www.paul-moore.com/blog/d/2020/12/linux_v510.html
> >
> > We haven't tried it, but I can look into it. We're not using v5.10 extensively
> > yet.
>
> Let us know if that works for you, and if it doesn't, let us know what
> might be missing.  I hate seeing the kernel grow multiple features
> which do the same thing.

I agree - I played around with this new tracepoint recently and you
can use it to achieve what you want quite easily:

# collect traces for denials (just interrupt/kill the sleep process
when done) - will create a perf.data file you can analyze later
perf record -a -e avc:selinux_audited -g --call-graph=dwarf sleep infinity
# dump all collected backtraces from the perf.data file
perf script

It's a bit complicated if you want to have it running in the
background permanently as a service (you need to tell perf to dump the
recorded data before you can read it), but perf already has some
command-line options to help with that use case.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

