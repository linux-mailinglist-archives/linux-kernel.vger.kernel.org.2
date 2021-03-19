Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374D43420FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhCSPat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:30:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230283AbhCSPae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616167834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y3mQGrhnySMiKJo0CGMHXFdS8fwBakEcVjJHtuaRcXk=;
        b=AQkyU7mt7OBM/xU7iKP4ZOH5moMgryL442tarkA/fI63k2h3CjFkmhgxlpgcCIo3WONPzS
        H32CIGqv4QUfX9SCEiUpo3uxHK41KZTy3SHH/wfLoOb/imHE8JTJ9OGAmOCDXz2rP89lyX
        motHYpipMN2aDjU5pz+d1/HYD8bxoiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-QAD0GsJnPeiR0p8awAdsLA-1; Fri, 19 Mar 2021 11:30:32 -0400
X-MC-Unique: QAD0GsJnPeiR0p8awAdsLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B403A19251A1;
        Fri, 19 Mar 2021 15:30:30 +0000 (UTC)
Received: from treble (ovpn-119-18.rdu2.redhat.com [10.10.119.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27A0D5D72E;
        Fri, 19 Mar 2021 15:30:28 +0000 (UTC)
Date:   Fri, 19 Mar 2021 10:30:26 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <20210319153026.cfqwyy36feqyunyd@treble>
References: <20210318171103.577093939@infradead.org>
 <20210318171920.253147364@infradead.org>
 <20210319032955.zdx6ihhprem5owbc@treble>
 <YFRblERAnQu2KtZG@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFRblERAnQu2KtZG@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 09:06:44AM +0100, Peter Zijlstra wrote:
> > Also doesn't the alternative code already insert nops?
> 
> Problem is that the {call,jmp} *%\reg thing is not fixed length. They're
> 2 or 3 bytes depending on which register is picked.

Why do they need to be fixed length?  Objtool can use sym->len as the
alternative replacement length.  Then alternatives can add nops as
needed.

-- 
Josh

