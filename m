Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321D03C6CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhGMJC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 05:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58741 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234121AbhGMJCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 05:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626166775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1jbljAuxlCrSmymVFLKpgjR864vr/cvdzhGXW1LdC7k=;
        b=iaDttx2WOxGUDGaYvacj4Cf3BRIqSv0wA474PUjlJLI46GrP94giU2HYveIdCyD3taUQgp
        UH7N2VACr53F1y9VIJcAp999VGAaIcA49kBbJKZKQJq6spveVBVXgll5QEZYiyDnEJn3wS
        gymOqMWRFXQB/o3MACDtyH/1Yk9PtxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-Yq_e_LiaP8SoSh_JJgsn8g-1; Tue, 13 Jul 2021 04:59:32 -0400
X-MC-Unique: Yq_e_LiaP8SoSh_JJgsn8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 123378189D5;
        Tue, 13 Jul 2021 08:59:31 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D66EF5DA60;
        Tue, 13 Jul 2021 08:59:30 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 16D8xU3q004057;
        Tue, 13 Jul 2021 04:59:30 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 16D8xUNi004054;
        Tue, 13 Jul 2021 04:59:30 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 13 Jul 2021 04:59:30 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Nico Schottelius <nico-linuxsetlocalversion@schottelius.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scripts/setlocalversion: fix a bug when LOCALVERSION
 is empty
In-Reply-To: <87tukzgrkg.fsf@ungleich.ch>
Message-ID: <alpine.LRH.2.02.2107130454430.3795@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2107120957300.14207@file01.intranet.prod.int.rdu2.redhat.com> <YOyGrUvA4LjydcP3@kroah.com> <alpine.LRH.2.02.2107121502380.8445@file01.intranet.prod.int.rdu2.redhat.com> <YOyVH3qD9O3qsNUL@kroah.com>
 <alpine.LRH.2.02.2107121528270.11724@file01.intranet.prod.int.rdu2.redhat.com> <87tukzgrkg.fsf@ungleich.ch>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Jul 2021, Nico Schottelius wrote:

> 
> Sorry to say, but I am not convinced by the patch.
> 
> While yes, we might have changed the behaviour slightly, reading
> something on the line of
> 
> if [ -z ... ]
> 
> is significantly more simple, elegant and easier to maintain, than
> a rather atypical special case for setting a variable to empty,
> using
> 
> if [ "${LOCALVERSION+set}" != "set" ] ..
> 
> *and* because it is so atypical, adding a long comment for it, too.
> 
> Additonally, -z should be correct if the variable *is* truly empty. I
> assume it actually isn't and contains whitespace, which is not the same
> as being set and empty.
> 
> Instead of re-adding complexity, could you consider changing the build
> flow so that LOCALVERSION is either unset or empty?
> 
> Nico

I set LOCALVERSION to an empty string (with "export LOCALVERSION="). This 
prevented the kernel from adding a "+" sign to the kernel version. Since 
the commit 042da426f8eb, it no longer works and the kernel adds a "+" sign 
if LOCALVERSION is set and empty.

If you don't like "if [ "${LOCALVERSION+set}" != "set" ]", then please 
provide some other way how to test if the variable is set.

Mikulas

