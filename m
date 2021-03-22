Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AB1344DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhCVR6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231249AbhCVR6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616435914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DxP0GIfbRmVMNqia/UkYOYfywTCnzVTGK716pBxi6aM=;
        b=MC98qlx6SLXJnPotvdFsscJRN7gDq5rDr/0xNUkojbK2oXRrCaCQDaiApqmdy/WT17Kfx2
        fdsV2KS/0nMdCEYN/v4qI8M64HJDM5YBS0cYsXYyT0zPhxxuM1btJ3N6RSRkt0pTJTfRDK
        34fB1V/GsN4agxFNwdmyxJm68+wuK4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-8yY8mH_kM86_phDvTxLw9w-1; Mon, 22 Mar 2021 13:58:32 -0400
X-MC-Unique: 8yY8mH_kM86_phDvTxLw9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F00C38030D6;
        Mon, 22 Mar 2021 17:58:30 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32BC11002388;
        Mon, 22 Mar 2021 17:58:24 +0000 (UTC)
Date:   Mon, 22 Mar 2021 13:58:21 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Jules Irenge <jbi.octave@gmail.com>, linux-audit@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: avoid -Wempty-body warning
Message-ID: <20210322175821.GO3141668@madcap2.tricolour.ca>
References: <20210322114536.3517661-1-arnd@kernel.org>
 <20210322143344.GN3141668@madcap2.tricolour.ca>
 <CAK8P3a2NkB7COUetdq65cSNjVe7-96c44=4JE5BXkBwXG-5nyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2NkB7COUetdq65cSNjVe7-96c44=4JE5BXkBwXG-5nyQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-22 17:28, Arnd Bergmann wrote:
> On Mon, Mar 22, 2021 at 3:33 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > Change the macros to use the usual "do { } while (0)" instead, and change a
> > > few more that were (void)0, for consistency.
> >
> > So what about audit_put_watch() and audit_get_watch() which are set to
> > {}?   (And all of include/linux/audit.h that uses the latter...)  Does
> > this only matter if they are the only action called in an if or loop?
> 
> I missed those, thanks for pointing it out. I sent a v2 patch now.

Ok, cool, that looks more consistent.  Can you answer my question about
include/linux/audit.h and exactly what conditions require
"do { } while (0)" over "{ }"?

>          Arnd

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

