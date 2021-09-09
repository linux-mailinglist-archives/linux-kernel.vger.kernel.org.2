Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7072405D1C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 21:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbhIITFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 15:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhIITFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 15:05:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4D8C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OB/ri+5nMc+/kwsdyuBrXNBolEn6RKdR9eJ2jCAvTgU=; b=D61iquw0nDX4HMNsroySTwxs48
        bZ3M7u0ECkMl8rVYe/CWvrRN2BszuxAik9NjvvvlBMC698QepqzoAYNTyQlv3sO9Cy5bQQ4mgC3ny
        AKcCQfZUQbJxUjEawOZK6yCuX/vbtSfbxfJYP5AM4l1e8wHGRdpDJaSNRl0dERv3pVHKze6VyquYE
        jLo6kv+gUfMoqsuZxxRjAu+rowqEeM39hp1I9Rt4T49HpfhxZltr0vXrynin6GlaLAYgiUKdVb9K6
        v9rKBCsksb0u3dbaUvjWcRv0R+n39jUMqZL64sJsvt1a3DmfCNhAIlAniiIILToEabkdwcPUzKbig
        4E7MfwWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOPKr-001vzK-CN; Thu, 09 Sep 2021 19:03:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 740BE98627A; Thu,  9 Sep 2021 21:03:42 +0200 (CEST)
Date:   Thu, 9 Sep 2021 21:03:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com,
        atrajeev@linux.vnet.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH v1 01/13] perf/core: add union to struct perf_branch_entry
Message-ID: <20210909190342.GE4323@worktop.programming.kicks-ass.net>
References: <20210909075700.4025355-1-eranian@google.com>
 <20210909075700.4025355-2-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909075700.4025355-2-eranian@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 12:56:48AM -0700, Stephane Eranian wrote:
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index f92880a15645..eb11f383f4be 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1329,13 +1329,18 @@ union perf_mem_data_src {
>  struct perf_branch_entry {
>  	__u64	from;
>  	__u64	to;
> -	__u64	mispred:1,  /* target mispredicted */
> -		predicted:1,/* target predicted */
> -		in_tx:1,    /* in transaction */
> -		abort:1,    /* transaction abort */
> -		cycles:16,  /* cycle count to last branch */
> -		type:4,     /* branch type */
> -		reserved:40;
> +	union {
> +		__u64	val;	    /* to make it easier to clear all fields */
> +		struct {
> +			__u64	mispred:1,  /* target mispredicted */
> +				predicted:1,/* target predicted */
> +				in_tx:1,    /* in transaction */
> +				abort:1,    /* transaction abort */
> +				cycles:16,  /* cycle count to last branch */
> +				type:4,     /* branch type */
> +				reserved:40;
> +		};
> +	};
>  };


Hurpmh... all other bitfields have ENDIAN_BITFIELD things except this
one. Power folks, could you please have a look?
