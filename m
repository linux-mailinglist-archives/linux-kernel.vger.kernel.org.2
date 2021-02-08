Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03ED93132D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhBHM6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:58:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230184AbhBHM6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612789024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mlx2QrIxat+f3xVBHwBJupZMEshhECpMGCDjBF0L/0U=;
        b=cYHLi4hmkUUEI5l+Wh4vK4HCZDnXa65BLeAjoXxddJPVo2L3+e9E3lbwXiLh4h40BAgEjV
        mh6t/5S3BIsdniysD+3y8vZnX1RA+53ey8bEfxNMpzZQ9HQNMODFEUv1QDxq4q4gw8ncMC
        lKrd7jgrIauojNYgSWOOqBBjiM2J/L0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-C5FGhgQvNrueAgzPIQttpQ-1; Mon, 08 Feb 2021 07:57:03 -0500
X-MC-Unique: C5FGhgQvNrueAgzPIQttpQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AEA891133;
        Mon,  8 Feb 2021 12:57:01 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-112-116.ams2.redhat.com [10.36.112.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C32E5C1D0;
        Mon,  8 Feb 2021 12:56:59 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
Subject: Re: Linux 4.9.256
References: <1612535085125226@kroah.com>
Date:   Mon, 08 Feb 2021 13:57:12 +0100
In-Reply-To: <1612535085125226@kroah.com> (Greg Kroah-Hartman's message of
        "Fri, 5 Feb 2021 15:26:18 +0100")
Message-ID: <87czxa3efr.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman:

> I'm announcing the release of the 4.9.256 kernel.
>
> This, and the 4.4.256 release are a little bit "different" than normal.
>
> This contains only 1 patch, just the version bump from .255 to .256 which ends
> up causing the userspace-visable LINUX_VERSION_CODE to behave a bit differently
> than normal due to the "overflow".
>
> With this release, KERNEL_VERSION(4, 9, 256) is the same as KERNEL_VERSION(4, 10, 0).
>
> Nothing in the kernel build itself breaks with this change, but given
> that this is a userspace visible change, and some crazy tools (like
> glibc and gcc) have logic that checks the kernel version for different
> reasons, I wanted to do this release as an "empty" release to ensure
> that everything still works properly.

I'm looking at this from a glibc perspective.  glibc took the
KERNEL_VERSION definition and embedded the bit layout into the
/etc/ld.so.cache, as part of the file format.  Exact impact is still
unclear at this point.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

