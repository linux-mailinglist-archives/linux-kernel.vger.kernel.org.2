Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D69A39DAA9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhFGLKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230194AbhFGLKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:10:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84D3C60FF2;
        Mon,  7 Jun 2021 11:08:07 +0000 (UTC)
Date:   Mon, 7 Jun 2021 13:08:04 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     ebiederm@xmission.com, "Serge E. Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] userns: automatically split user namespace extent
Message-ID: <20210607110804.qgkpxktig2upzfrk@wittgenstein>
References: <20201203150252.1229077-1-gscrivan@redhat.com>
 <20210510172351.GA19918@mail.hallyn.com>
 <20210510185715.GA20897@mail.hallyn.com>
 <87h7idbskw.fsf@redhat.com>
 <20210605130016.jdkkviwtuefocset@wittgenstein>
 <874keaaume.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874keaaume.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 11:31:37AM +0200, Giuseppe Scrivano wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
> > On Fri, Jun 04, 2021 at 04:41:19PM +0200, Giuseppe Scrivano wrote:
> >> Christian, Eric,
> >> 
> >> are you fine with this patch or is there anything more you'd like me to
> >> change?
> >
> > Before being a little bit of a party pooper thanks for your patches! I
> > appreciate the work you're doing!
> >
> > So my concern is that this may cause silent regressions/security issues
> > for tools in userspace by making this work automagically.
> >
> > For example we have a go library that calculates idmap ranges and
> > extents. Those idmappings are stored in the database and in the
> > container's config and for backups and so on.
> >
> > The calculated extents match exactly with how these lines look in
> > /proc/<pid>/*id_map.
> > If we miscalculate the extents and we try to write them to
> > /proc/<pid>/*id_map we get told to go away and immediately recognize the
> > bug.
> > With this patch however we may succeed and then we record misleading
> > extents in the db or the config.
> >
> > Turning this into a general concern, I think it is a non-trivial
> > semantic change to break up the 1:1 correspondence between mappings
> > written and mappings applied that we had for such a long time now.
> >
> > In general I'm not sure it should be the kernel that has the idmapping
> > ranges smarts.
> >
> > I'd rather see a generic userspace library that container runtimes make
> > use of that also breaks up idmapping ranges. We can certainly accomodate
> > this in
> > https://pkg.go.dev/github.com/lxc/lxd/shared/idmap
> >
> > Is that a reasonable concern?
> 
> I've ended up adding a similar logic to Podman for the same reason as
> above.
> 
> In our use case, containers are created within a user namespace that
> usually has two extents, the current unprivileged ID mapped to root,
> and any additional ID allocated to the user through /etc/sub?id mapped
> to 1.
> 
> Within this user namespace, other user namespaces can be created and we
> let users specify the mappings.  It is a common mistake to specify a
> mapping that overlaps multiple extents in the parent userns e.g:
> 0:0:IDS_AVAILABLE.
> 
> To avoid the problem we have to first parse /proc/self/?id_map and then
> split the specified extents when they overlap.
> 
> In our case this is not an issue anymore, moving the logic to the kernel
> would just avoid a open syscall.
> 
> IMHO the 1:1 mapping is just an implementation detail, that is not

With proc such details tend to have the unfortunate tendency to become
part of the api which is what makes me a bit uneasy.
For non-lxd users that use the low-level lxc library directly we allow
callers to specify the idmappings in the exact same format they will
appear in procfs. This means you can reason 1:1 about the extents used.
A change like this on the kernel level would break that assumption
meaning e.g. that container configs would suddenly start that would
otherwise fail because of miscalculated or "wrong" extents.

Since we all have solved that problem in userspace already saving a
single open system call is not a good enough win maybe.

It feels like the new libsubid library in shadow that we added should
grow that feature to split extents instead.
Potentially making new*idmap handle that case by default in newer
versions. That's easier to revert if anything breaks, allows us to see
whether this causes trouble, and users that write to new*idmap directly
aren't affected at all.

Christian
