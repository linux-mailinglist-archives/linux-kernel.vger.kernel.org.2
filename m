Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B279438E7E0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhEXNnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232842AbhEXNnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621863709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P8w9I0NZ19BtAHbKHjXK+mlEAIIVIyeCIj2mlV4DKGQ=;
        b=S0sL2XYYaXInraNWlD2wK3AzHwb6WNJnbEfD4Qw256TApaEQspqaBUmggl2komTMzehA2G
        ZP+gjzYQn9+ROcx7orxzuI7YBtN8WhfzfFP/fbOfK/y/9dNXi1k0xAa0ksfRKPitbPpPXG
        P2+W/iiVqYmBSCkh7n3YxvYdoGvdYek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-vSVG9O50OfGs577TcG7_-A-1; Mon, 24 May 2021 09:41:47 -0400
X-MC-Unique: vSVG9O50OfGs577TcG7_-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63838101371F;
        Mon, 24 May 2021 13:41:46 +0000 (UTC)
Received: from localhost (ovpn-113-121.ams2.redhat.com [10.36.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A961210016FC;
        Mon, 24 May 2021 13:41:45 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     linux-kernel@vger.kernel.org, serge@hallyn.com, dwalsh@redhat.com,
        christian.brauner@ubuntu.com, snaipe <snaipe@arista.com>
Subject: Re: [RFC PATCH 0/3] new mode 'shadow' for /proc/PID/setgroups
References: <20210510130011.1441834-1-gscrivan@redhat.com>
        <m1o8d4xgkk.fsf@fess.ebiederm.org>
Date:   Mon, 24 May 2021 15:41:40 +0200
In-Reply-To: <m1o8d4xgkk.fsf@fess.ebiederm.org> (Eric W. Biederman's message
        of "Fri, 21 May 2021 10:16:43 -0500")
Message-ID: <87a6oknt9n.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Giuseppe Scrivano <gscrivan@redhat.com> writes:
>
>> This series is based on some old patches I've been playing with some
>> years ago, but they were never sent to lkml as I was not sure about
>> their complexity/usefulness ratio.  It was recently reported by
>> another user that these patches are still useful[1] so I am submitting
>> the last version and see what other folks think about this feature.
>>
>> Since the fix for CVE-2014-8989 in order to set a gids mapping for a
>> user namespace when the user namespace owner doesn't have CAP_SETGID
>> in its parent, it is necessary to first disable setgroups(2) through
>> /proc/PID/setgroups.
>>
>> Setting up a user namespace with multiple IDs mapped into is usually
>> done through the privileged helpers newuidmap/newgidmap.
>> Since these helpers run either as setuid or with CAP_SET[U,G]ID file
>> capabilities, it is not necessary to disable setgroups(2) in the
>> created user namespace.  The user running in the user namespace can
>> use setgroups(2) and drop the additional groups that it had initially.
>>
>> This is still an issue on systems where negative groups ACLs, i.e. the
>> group permissions are more restrictive than the entry for the other
>> categories, are used.  With such configuration, allowing setgroups(2)
>> would cause the same security vulnerability described by
>> CVE-2014-8989.
>
> Do you have any experience or any documentation about systems that are
> using groups to deny access?
>
> There are some deployments somewhere, but last I looked they were rare
> enough that the intersection between systems using groups to deny access
> and systems deploying containers could reasonably be assumed to be the
> empty set?
>
> Before we seriously consider merging a change like this I believe we
> need some references to actual deployed systems.  As adding a feature
> that is designed around a premise of a security model that people
> are not using will likely lead to poor testing, poor review and
> not enough feedback to get the rough edges off.

Snaipe (added to CC) has raised this point some weeks ago.  Snaipe, do
you have any more information to share on what systems are using user
namespaces and deny access through groups?

Giuseppe

