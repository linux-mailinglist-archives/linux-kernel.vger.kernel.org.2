Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285383C6FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 13:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbhGMLqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 07:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235803AbhGMLqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626176627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/PhPn0HsWdt3/if9m4dksmO9/1fk5RdagIKiaocN3ws=;
        b=Nhr9Cs67GFe18Y+yL+q/lGw9wRks4FPO7fZxVKA8C3YIU6YTxqqDhQlmlprEViFttsp3ly
        /LQ/tVtlEfs+aEZYGI6rjJE3RDnvlfwcYV42b2AI6A4BkRO26hnoVGJDMgAVceaE0QE1Fp
        KviosKhyD6Myzngi4vMjmjDPGLED9wQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-mXR0SX6AOxmjgQ5j1nOkJw-1; Tue, 13 Jul 2021 07:43:45 -0400
X-MC-Unique: mXR0SX6AOxmjgQ5j1nOkJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D40B91082261;
        Tue, 13 Jul 2021 11:43:43 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD08760583;
        Tue, 13 Jul 2021 11:43:43 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 16DBhgbj018767;
        Tue, 13 Jul 2021 07:43:42 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 16DBhgRV018764;
        Tue, 13 Jul 2021 07:43:42 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 13 Jul 2021 07:43:42 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Nico Schottelius <nico.schottelius@ungleich.ch>
cc:     Nico Schottelius <nico-linuxsetlocalversion@schottelius.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scripts/setlocalversion: fix a bug when LOCALVERSION
 is empty
In-Reply-To: <87r1g2h92y.fsf@ungleich.ch>
Message-ID: <alpine.LRH.2.02.2107130738340.18452@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2107120957300.14207@file01.intranet.prod.int.rdu2.redhat.com> <YOyGrUvA4LjydcP3@kroah.com> <alpine.LRH.2.02.2107121502380.8445@file01.intranet.prod.int.rdu2.redhat.com> <YOyVH3qD9O3qsNUL@kroah.com>
 <alpine.LRH.2.02.2107121528270.11724@file01.intranet.prod.int.rdu2.redhat.com> <87tukzgrkg.fsf@ungleich.ch> <alpine.LRH.2.02.2107130454430.3795@file01.intranet.prod.int.rdu2.redhat.com> <87r1g2h92y.fsf@ungleich.ch>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Jul 2021, Nico Schottelius wrote:

> 
> 
> Mikulas Patocka <mpatocka@redhat.com> writes:
> > I set LOCALVERSION to an empty string (with "export LOCALVERSION="). This
> > prevented the kernel from adding a "+" sign to the kernel version. Since
> > the commit 042da426f8eb, it no longer works and the kernel adds a "+" sign
> > if LOCALVERSION is set and empty.
> >
> > If you don't like "if [ "${LOCALVERSION+set}" != "set" ]", then please
> > provide some other way how to test if the variable is set.
> 
> I fail to see the problem you are solving, as that case works exactly
> like I wrote in my last mail:

The problem is this - I have a few patches applied to the kernel and I 
don't want the plus sign in the kernel version. So, I set
"export LOCALVERSION=". In the kernel 5.13 and previous versions, there is 
no plus sign at the end of version string. With the version 5.14-rc1, 
there is a plus sign.because of the patch 042da426f8eb.

> [11:09:03] nb3:~$ export LOCALVERSION=; [ -z "${LOCALVERSION}" ] && echo unset
> unset
> [11:09:27] nb3:~$ echo $BASH_VERSION
> 5.1.8(1)-release
> 
> Did you try that in your environment?

I tried and it and it doesn't work - the plus sign is present in the 
kernel version because [ -z "${LOCALVERSION}" ] return true.

Mikulas

