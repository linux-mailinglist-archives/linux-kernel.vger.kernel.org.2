Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93DC359C68
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhDIKza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232087AbhDIKz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617965715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iRvExO2u4w6AmWe5Y0tb/mvT3i84fkN17wDJxZJ/hLs=;
        b=Ip3vCyi0qopT6pWKemIRJEmL3wLyYWEAPHo6rW0QZp1cOshj60vCAx765fdCow0SBjFyze
        Zbn+9G/4XV/xqwD44mnyjuX1r19IeXxy3EJ+8x/Rravhf7yvzfBFpf/d9orN3AsSjsocLJ
        XwV+E1AKMozSjOWtOpRt/WQQ5YuviYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-NBpmevU0PbymDv5HEKTygA-1; Fri, 09 Apr 2021 06:55:12 -0400
X-MC-Unique: NBpmevU0PbymDv5HEKTygA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2BBD9126D;
        Fri,  9 Apr 2021 10:55:11 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1C5219C95;
        Fri,  9 Apr 2021 10:55:09 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: static_branch/jump_label vs branch merging
References: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
        <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com>
Date:   Fri, 09 Apr 2021 12:55:18 +0200
In-Reply-To: <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com>
        (Ard Biesheuvel's message of "Fri, 9 Apr 2021 11:57:22 +0200")
Message-ID: <877dlbzq09.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ard Biesheuvel:

> Wouldn't that require the compiler to interpret the contents of the
> asm() block?

Yes and no.  It would require proper toolchain support, so in this case
a new ELF relocation type, with compiler, assembler, and linker support
to generate those relocations and process them.  As far as I understand
it, the kernel doesn't do things this way.

Thanks,
Florian

