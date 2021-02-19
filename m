Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD01320113
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 23:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBSWAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 17:00:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230020AbhBSV5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613771738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KVG0whDdlMFBJekRHUR7N55fu1AUMWMhyCg/ZyhU7g8=;
        b=MUiYkHmdRTd5CQ0xwZe2jk54pu0NyJbWMBDPJHM5lTJg2bg30iE5vmNCNm03Z+QUrY0eet
        OcjYy0RCO1E2a7S2eZTFKXrO4ACMjbdbYHfv3Ej6LhPeHH38scOx6PNENByzU2DsAwOhqm
        MHGRWGJOWD1THdXt4w5PayjtTypq5Pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-tvU_WTcTNyq2-_WMheOehg-1; Fri, 19 Feb 2021 16:55:36 -0500
X-MC-Unique: tvU_WTcTNyq2-_WMheOehg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DB7F1020C22;
        Fri, 19 Feb 2021 21:55:34 +0000 (UTC)
Received: from treble (ovpn-115-143.rdu2.redhat.com [10.10.115.143])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 792131971E;
        Fri, 19 Feb 2021 21:55:32 +0000 (UTC)
Date:   Fri, 19 Feb 2021 15:55:30 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, pjt@google.com, mbenes@suze.cz, jgross@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 6/6] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <20210219215530.ivzzv3oavhuip6un@treble>
References: <20210219204300.749932493@infradead.org>
 <20210219210535.492733466@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219210535.492733466@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 09:43:06PM +0100, Peter Zijlstra wrote:
> Arguably it would be simpler to do the other way around, but
> unfortunately alternatives don't work that way, we cannot say:
> 
> 	ALTERNATIVE "call __x86_indirect_thunk_\reg",
> 		    "call *%reg", ~X86_FEATURE_RETPOLINE
> 
> That is, there is no negative form of alternatives.

X86_FEATURE_NO_RETPOLINE?

-- 
Josh

