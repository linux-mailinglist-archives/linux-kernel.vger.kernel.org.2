Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D4833FC12
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 01:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCRACd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 20:02:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229994AbhCRACX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 20:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616025742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fIBduZVqJpIAz+UmbB5T+h+sCu84YvjhxSSRnUH9gxs=;
        b=i0cnPVJxlH9ytEcW4LPZT/tGAr3pVZAqbHNoMuu30taU9gYU/DCYNZO1wxnd9E4IfF2pgv
        Z4kVnNRUOlb/DMg/aDGCVl4lfDpBbe3wMlr/0XTPlU8kVdVr3OTWS6O8m04HwQuzcgjWNe
        fyTEdSgaeZoSEo53farxqwFhoCj1Xtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-PfD8_gOjNDC4IFSv4dkpUw-1; Wed, 17 Mar 2021 20:02:20 -0400
X-MC-Unique: PfD8_gOjNDC4IFSv4dkpUw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FD22100746C;
        Thu, 18 Mar 2021 00:02:18 +0000 (UTC)
Received: from treble (ovpn-112-220.rdu2.redhat.com [10.10.112.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BAD2C5D9C0;
        Thu, 18 Mar 2021 00:02:15 +0000 (UTC)
Date:   Wed, 17 Mar 2021 19:02:12 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Oliver Sang <oliver.sang@intel.com>, jbaron@akamai.com,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool,static_call: Don't emit static_call_site for
 .exit.text
Message-ID: <20210318000212.l2fdz5vjhuq64yh6@treble>
References: <20210315142345.GB4401@xsang-OptiPlex-9020>
 <CAFA6WYNMHAqqmNfncmJm3+BUYCktXouRtV_udSxQb7eifPmX+Q@mail.gmail.com>
 <20210317030101.GB22345@xsang-OptiPlex-9020>
 <CAFA6WYMb-C2L7DmGnhWgxjuuvP=qxPA4-s4q+knxH+iWXypHmw@mail.gmail.com>
 <YFHAsgNhe8c3ZHQN@hirez.programming.kicks-ass.net>
 <YFHE9CjanDAD4l5M@hirez.programming.kicks-ass.net>
 <YFHFjarVo7HAP7pg@hirez.programming.kicks-ass.net>
 <CAFA6WYNs-rQLUGPMwc-p0q_KRvR16rm-x55gDqw828c7-C1qeA@mail.gmail.com>
 <YFH6BR61b5GK8ITo@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFH6BR61b5GK8ITo@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 01:45:57PM +0100, Peter Zijlstra wrote:
> arguably it simply isn't a good idea to use static_call() in __exit
> code anyway, since module unload is never a performance critical path.

Couldn't you make the same argument about __init functions, which are
allowed to do static calls?

We might consider a STATIC_CALL_SITE_EXIT flag, but I suppose we've run
out of flag space.

-- 
Josh

