Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FDF3AA687
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 00:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbhFPWPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 18:15:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31626 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232258AbhFPWPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 18:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623881616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ynFypKw6yaFTAwjszi5wGpSPgyHOdH7h2sszX4y3jj8=;
        b=IfXqqk5qaqrzRdlu5QqLvnvN/WViw6bq5BA+bUw0RjzLsxXPdoDKmN3jac/G/WbcEw7KHd
        fXuR7NVoEDsoHjmfEbPtLUr5p0u688UzX1aVFwuvlmf8bIcUGPOPqI/Swt+0lCdPfBWVva
        9izL68n31TlNiBTocmkhXcyPeu5huNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-sP0V_TQWNIyTTK4aNmmkdg-1; Wed, 16 Jun 2021 18:13:33 -0400
X-MC-Unique: sP0V_TQWNIyTTK4aNmmkdg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 867BA1084F41;
        Wed, 16 Jun 2021 22:13:31 +0000 (UTC)
Received: from optiplex-fbsd (unknown [10.3.128.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BB4710016F4;
        Wed, 16 Jun 2021 22:13:28 +0000 (UTC)
Date:   Wed, 16 Jun 2021 18:13:26 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Georgi Djakov <quic_c_gdjako@quicinc.com>,
        akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, djakov@kernel.org
Subject: Re: [PATCH] mm/slub: Add taint after the errors are printed
Message-ID: <YMp3htJJkyVZJglK@optiplex-fbsd>
References: <1623860738-146761-1-git-send-email-quic_c_gdjako@quicinc.com>
 <4b22baf7-582b-f1ae-a525-046a493ec85f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b22baf7-582b-f1ae-a525-046a493ec85f@suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 06:34:41PM +0200, Vlastimil Babka wrote:
> On 6/16/21 6:25 PM, Georgi Djakov wrote:
> > When running the kernel with panic_on_taint, the usual slub debug error
> > messages are not being printed when object corruption happens. That's
> > because we panic in add_taint(), which is called before printing the
> > additional information. This is a bit unfortunate as the error messages
> > are actually very useful, especially before a panic. Let's fix this by
> > moving add_taint() after the errors are printed on the console.
> > 
> > Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> 
> Makes sense.
> 
> While at it, I wonder if we should use LOCKDEP_STILL_OK instead of
> LOCKDEP_NOW_UNRELIABLE. Isn't it too pessimistic to assume that some slab's
> memory corruption hit some lock state?
>

Given there is noted corruption I don't think it's safe to assume otherwise.

