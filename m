Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B82332D4C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhCIRbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:31:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45599 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231601AbhCIRbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615311080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RfuvjK56r1jb/GXkEE1ziYzIM1eNfefBc1/KtDHMOcM=;
        b=iRpd51tOTRAaJbar3w0S8UpV5GdlvrX+pnB3Jz8LvQY+vqVPAToiaL1rfEg7xySOoMAyM2
        nWgKJxGy/E0855ItdR06KW4i9q+rFqjngVuonozvOKXFG6GQBiDxPxfDGZLpFt2kJHRnnQ
        e8OM0TbTlyQNV7wnwLuNMnu6GlldEH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-wUqIGL6NNPuOWGsmiEQOmA-1; Tue, 09 Mar 2021 12:31:17 -0500
X-MC-Unique: wUqIGL6NNPuOWGsmiEQOmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EE6483DD20;
        Tue,  9 Mar 2021 17:31:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EA9F60C17;
        Tue,  9 Mar 2021 17:31:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CACT4Y+aH0MrQu2c3fQfm8CD1sXzA5DhHKXLAqbPCjGKQjEoVJQ@mail.gmail.com>
References: <CACT4Y+aH0MrQu2c3fQfm8CD1sXzA5DhHKXLAqbPCjGKQjEoVJQ@mail.gmail.com> <1399790.1602853614@warthog.procyon.org.uk> <000000000000b9732805b1c970f5@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+459a5dce0b4cb70fd076@syzkaller.appspotmail.com>,
        Hillf Danton <hdanton@sina.com>, linux-afs@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in strncasecmp
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <180418.1615311074.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 09 Mar 2021 17:31:14 +0000
Message-ID: <180419.1615311074@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> wrote:

> Not sure if you are still interesting in this or not, but fwiw tabs
> should be supported now:
> https://github.com/google/syzkaller/commit/26967e354e030f6a022b7a60a7c98=
99ec25923aa

Not right this minute, but thanks for letting me know!

David

