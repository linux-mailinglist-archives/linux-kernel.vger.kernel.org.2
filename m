Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9CD39D8D1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhFGJdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230382AbhFGJde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623058302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PfOqujWFG50uWPMy3Vl/N6e7fiBUB3XX2l2izXiIL0U=;
        b=XL8LBH2lFMKovmqwpfUNYeE1aJXbBD6UuIxxN3m3ypEmiHAexGHr22fH9TdU1EvxV+MyvW
        /JSDQYNP594En2nU7zIKtWCDcdieU/FCsbWGFK5Acsp1wlKF5ust9mQ8nGdamYNzMrBuN1
        3BIMjquypx9YovW8d0CuUdbErB6bcR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-yPYEndsFNY6g7Hr6hovFtg-1; Mon, 07 Jun 2021 05:31:41 -0400
X-MC-Unique: yPYEndsFNY6g7Hr6hovFtg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CCAABBEF4;
        Mon,  7 Jun 2021 09:31:40 +0000 (UTC)
Received: from localhost (ovpn-114-205.ams2.redhat.com [10.36.114.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45CAE5B826;
        Mon,  7 Jun 2021 09:31:39 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     ebiederm@xmission.com, "Serge E. Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] userns: automatically split user namespace extent
References: <20201203150252.1229077-1-gscrivan@redhat.com>
        <20210510172351.GA19918@mail.hallyn.com>
        <20210510185715.GA20897@mail.hallyn.com> <87h7idbskw.fsf@redhat.com>
        <20210605130016.jdkkviwtuefocset@wittgenstein>
Date:   Mon, 07 Jun 2021 11:31:37 +0200
In-Reply-To: <20210605130016.jdkkviwtuefocset@wittgenstein> (Christian
        Brauner's message of "Sat, 5 Jun 2021 15:00:16 +0200")
Message-ID: <874keaaume.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Fri, Jun 04, 2021 at 04:41:19PM +0200, Giuseppe Scrivano wrote:
>> Christian, Eric,
>> 
>> are you fine with this patch or is there anything more you'd like me to
>> change?
>
> Before being a little bit of a party pooper thanks for your patches! I
> appreciate the work you're doing!
>
> So my concern is that this may cause silent regressions/security issues
> for tools in userspace by making this work automagically.
>
> For example we have a go library that calculates idmap ranges and
> extents. Those idmappings are stored in the database and in the
> container's config and for backups and so on.
>
> The calculated extents match exactly with how these lines look in
> /proc/<pid>/*id_map.
> If we miscalculate the extents and we try to write them to
> /proc/<pid>/*id_map we get told to go away and immediately recognize the
> bug.
> With this patch however we may succeed and then we record misleading
> extents in the db or the config.
>
> Turning this into a general concern, I think it is a non-trivial
> semantic change to break up the 1:1 correspondence between mappings
> written and mappings applied that we had for such a long time now.
>
> In general I'm not sure it should be the kernel that has the idmapping
> ranges smarts.
>
> I'd rather see a generic userspace library that container runtimes make
> use of that also breaks up idmapping ranges. We can certainly accomodate
> this in
> https://pkg.go.dev/github.com/lxc/lxd/shared/idmap
>
> Is that a reasonable concern?

I've ended up adding a similar logic to Podman for the same reason as
above.

In our use case, containers are created within a user namespace that
usually has two extents, the current unprivileged ID mapped to root,
and any additional ID allocated to the user through /etc/sub?id mapped
to 1.

Within this user namespace, other user namespaces can be created and we
let users specify the mappings.  It is a common mistake to specify a
mapping that overlaps multiple extents in the parent userns e.g:
0:0:IDS_AVAILABLE.

To avoid the problem we have to first parse /proc/self/?id_map and then
split the specified extents when they overlap.

In our case this is not an issue anymore, moving the logic to the kernel
would just avoid a open syscall.

IMHO the 1:1 mapping is just an implementation detail, that is not
obvious for users.  Having the split in the kernel will also avoid that
this same check is added to each container runtimes that uses nested
user namespaces.

Thanks,
Giuseppe

