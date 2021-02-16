Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CB331C481
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 01:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBPAGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 19:06:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22865 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229682AbhBPAGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 19:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613433911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ArWTZuo7XHgO1meqCclShhKJM5hHFhUPteAsH1NbKFE=;
        b=jTagQD42NIrIIC6u0qTpC6ugo64PtrMVsKCIbDzHogy6xF97lXNb1ggVPajPaf1uM881R9
        p3gG28D14rLjJiBy1lPihQxAWpS3QI+Eijjnkzh6vNhTsROoS63btsq9lqSviYNJ66EVbT
        DXrTrzMuk3Y9ub2Lp0kloWnVd9BJ+a0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-RJWmqpCWPSSX9ZeXsV8yCA-1; Mon, 15 Feb 2021 19:05:09 -0500
X-MC-Unique: RJWmqpCWPSSX9ZeXsV8yCA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1B58C283;
        Tue, 16 Feb 2021 00:05:07 +0000 (UTC)
Received: from treble (ovpn-117-118.rdu2.redhat.com [10.10.117.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB66572161;
        Tue, 16 Feb 2021 00:05:06 +0000 (UTC)
Date:   Mon, 15 Feb 2021 18:05:04 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ftrace: Do not reference symbols in sections without size
Message-ID: <20210216000504.axm3k4xho47c6drz@treble>
References: <20210215164446.530f6311@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215164446.530f6311@gandalf.local.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 04:44:46PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Starting with binutils 2.36, sections were being removed if they had weak
> functions that were optimized out. Unfortunately, these weak functions would
> leave references to mcount/fentry calls, that would make recordmcount fail
> to find the symbol that matched the call to fentry.

Binutils 2.36 isn't removing sections, just section *symbols*.

> Before returning the symbol of the section to create the mcount location,
> check if that section size is greater than zero. If it has no size, skip
> referencing that mcount call location.

How does this even work?  The .text.unlikely section isn't empty:

  # readelf -SW kernel/kexec_file.o
  
  Section Headers:
    [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
    [ 0]                   NULL            0000000000000000 000000 000000 00      0   0  0
    [ 1] .text             PROGBITS        0000000000000000 000040 001acf 00  AX  0   0  1
    [ 2] .rela.text        RELA            0000000000000000 0049e0 001b30 18   I 27   1  8
    [ 3] .data             PROGBITS        0000000000000000 001b20 000e80 00  WA  0   0 32
    [ 4] .rela.data        RELA            0000000000000000 006510 0010e0 18   I 27   3  8
    [ 5] .bss              NOBITS          0000000000000000 0029a0 000060 00  WA  0   0 32
    [ 6] .rodata           PROGBITS        0000000000000000 0029a0 000b80 00   A  0   0 32
    [ 7] .rodata.str1.1    PROGBITS        0000000000000000 003520 0001c6 01 AMS  0   0  1
    [ 8] .text.unlikely    PROGBITS        0000000000000000 0036e6 000038 00  AX  0   0  1

-- 
Josh

