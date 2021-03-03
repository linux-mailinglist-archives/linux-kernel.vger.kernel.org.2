Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB5432B744
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhCCKwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:52:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54804 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237206AbhCCAbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614731408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oIW1UUoohR1QuczsNWhRM/IDSw0DDkYly5HtZk10NNs=;
        b=BpMIRnnIc806A5XZYK++mj1b1hT79g0P6EV7Z8arTV+LwBoUBGXBM4jm+mm1iA/Yoqv40T
        wzs9Qa1V/6sC4+NP5mvibD0CDStvQQSwi/LZmI1l5t25RkVZP9AZIDpbD0BAw6rdYLvg0X
        R2PTlyRzv5cg1P1bGp4Sj0Gn+luwKiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-CY9zo1dTNgirk9qDHWLlBA-1; Tue, 02 Mar 2021 19:30:04 -0500
X-MC-Unique: CY9zo1dTNgirk9qDHWLlBA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 524E81005501;
        Wed,  3 Mar 2021 00:30:03 +0000 (UTC)
Received: from treble (ovpn-117-7.rdu2.redhat.com [10.10.117.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E47E85C626;
        Wed,  3 Mar 2021 00:30:01 +0000 (UTC)
Date:   Tue, 2 Mar 2021 18:29:59 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     bp@alien8.de, mbenes@suse.cz, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 0/3] objtool: OBJTOOL_ARGS and --backup
Message-ID: <20210303002959.eorxpmjytyrfchvp@treble>
References: <20210226105742.844988140@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210226105742.844988140@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 11:57:42AM +0100, Peter Zijlstra wrote:
> Boris asked for an environment variable to have objtool preserve the original
> object file so that it becomes trivial to inspect what actually changed.

I might bikeshed the suffix ".o.orig" instead of ".obj".

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

