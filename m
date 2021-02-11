Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47BE319443
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhBKUUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:20:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230238AbhBKUSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613074637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZFSzisYdANkHoE8P+N5TJllVfdfgFXq3fSgzegh24os=;
        b=i62MccjxH4q0VPQVvHF/CCE2htd4fnaJG61uNtB1zAby+ZMgvsYEOOo92OXlbqzfle8lMC
        mPGn/rsR/nupML1IVFZ3bEnP3u8O5GT7ha9+i75FvB3+fHoJIBI7oKt1BQ5e6aU7j3AcJg
        WrNOWYAVu4G4vMxxJJzPA5alCCs7KzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-cgyrLfxPORO8V9qAJK0O8g-1; Thu, 11 Feb 2021 15:17:15 -0500
X-MC-Unique: cgyrLfxPORO8V9qAJK0O8g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 810E679EC1;
        Thu, 11 Feb 2021 20:17:14 +0000 (UTC)
Received: from treble (ovpn-120-169.rdu2.redhat.com [10.10.120.169])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF76410016F8;
        Thu, 11 Feb 2021 20:17:13 +0000 (UTC)
Date:   Thu, 11 Feb 2021 14:17:11 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v2 0/7] objtool x86 decoder fixes
Message-ID: <20210211201711.6skourx5wwmx5bff@treble>
References: <20210211173044.141215027@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210211173044.141215027@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 06:30:44PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> Since I had to look at instruction decoding for the stack swizzle thing, I
> ended up with a few more changes to the objtool x86 decoder.
> 
> These patches are lightly tested (they build defconfig and allmodconfig using
> GCC10), but older versions have seen some robot exposure and other compilers.
> 
> v2:
>  - actually Cc'ed LKML :/

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

