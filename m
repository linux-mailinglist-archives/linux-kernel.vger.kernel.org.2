Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8440833E793
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCQDTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhCQDTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615951143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R3LWyxxEqlZOLWo+V2jtNoXYV+VANpTERQmVdl6cSTE=;
        b=hD68ZVSGSKwGdPoHAgos2nuHO55x5OTEAZI+ey4GJEbAWyO5ulAQ6LoAhpVnibRtOI86fK
        v0WF+ff2NiVmuwU1mw9j3GvX+Oz4gpcf3Xqk56KekUtnBbhuZOmHzmQJTgkdAFhiEfJNOg
        arGJO2orh8ZjBLSrPEQ36Bhcz1G/IS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-JYWAQwL4POih5oYzt-28ZA-1; Tue, 16 Mar 2021 23:18:59 -0400
X-MC-Unique: JYWAQwL4POih5oYzt-28ZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EA7E88127C;
        Wed, 17 Mar 2021 03:18:58 +0000 (UTC)
Received: from treble (ovpn-118-162.rdu2.redhat.com [10.10.118.162])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F4C95032C;
        Wed, 17 Mar 2021 03:18:56 +0000 (UTC)
Date:   Tue, 16 Mar 2021 22:18:54 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suze.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] objtool: Fix static_call list generation
Message-ID: <20210317031854.u4jje4kuu6mfeps7@treble>
References: <20210312171613.533405394@infradead.org>
 <20210312171653.588985655@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210312171653.588985655@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 06:16:17PM +0100, Peter Zijlstra wrote:
> @@ -1701,6 +1706,9 @@ static int decode_sections(struct objtoo
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * Must be before add_{jump_call}_desetination.
> +	 */

s/desetination/destination/

-- 
Josh

