Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA0F34299C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 02:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhCTB1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 21:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCTB1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 21:27:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4FDC061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 18:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kwBENxH4tArmiYMn84RwrXrfwMvKePUNkTzlUlB3DZ8=; b=Q0MEyiazHtZSFsuH+HOonJHGTt
        dk607nFH6ZwkYLk0najUZzznNdD8+9Ak4Kyt7gWqeQTxGuncmMIwSbckVNlAdvfC+qVRtTqvBN+8h
        Sw4s8a+iF3AAoNQWHj+tR7F34CnwCDmCGI78zv6dj0FcsQHWU8XaV5b79Yw6d3XIZeN9xhwbBbNDJ
        kEdKnxdXl08E7G8bu7vcO164Y+PBZ+tVMMUzWLAfiMz7a+HeQOlgYY9hkUNONGLTklld5Kz4bUWq0
        Y/SF/8+/yd9lS01QNjCl98Rn0UEhfn8se2tycgcYhAXr7MHyQY+by64fl1x1UfkVKkMOKcE/ZybOq
        bklMx2Bg==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNQOS-001dwh-Vi; Sat, 20 Mar 2021 01:27:10 +0000
Date:   Fri, 19 Mar 2021 18:27:08 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/builtin-c2c.c: Fix a punctuation
In-Reply-To: <20210319232824.742-1-unixbhaskar@gmail.com>
Message-ID: <abe5f7c8-8d51-61a2-8e4c-89a569822ba8@bombadil.infradead.org>
References: <20210319232824.742-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_182709_043334_CB1DAFB8 
X-CRM114-Status: GOOD (  12.10  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote: > > s/dont/don\'t/
    > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by: Randy
    Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/dont/don\'t/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> tools/perf/builtin-c2c.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index e3b9d63077ef..af1c1b89e769 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -1813,7 +1813,7 @@ static int hpp_list__parse(struct perf_hpp_list *hpp_list,
> 	perf_hpp__setup_output_field(hpp_list);
>
> 	/*
> -	 * We dont need other sorting keys other than those
> +	 * We don't need other sorting keys other than those
> 	 * we already specified. It also really slows down
> 	 * the processing a lot with big number of output
> 	 * fields, so switching this off for c2c.
> --
> 2.26.2
>
>
