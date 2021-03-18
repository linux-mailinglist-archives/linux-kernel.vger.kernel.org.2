Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BDB3409CE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 17:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhCRQN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 12:13:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230425AbhCRQNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616084000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kMSvyN97t/FS7XtBv6QH+5q8tp+bklDt3LCkE++41RA=;
        b=MnXePYUvn+iP0DlwPYzkiZdARlKEZXYdP+1IjXELltrCXD76y5Q0MLLIM6h+/hw0RT/gOH
        DJzPObmV9/oGURQrRxd9DsP2WSTYqOon1mU+KcCBpb+WLEdB2CWHZN1oN0d+svQzCEVqmb
        O8G0VXwP0iggljHwbxyRSCurYdhgvV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-cskwBhpdM0CF8lw15OFqhA-1; Thu, 18 Mar 2021 12:13:16 -0400
X-MC-Unique: cskwBhpdM0CF8lw15OFqhA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E5CD81620;
        Thu, 18 Mar 2021 16:13:13 +0000 (UTC)
Received: from treble (ovpn-120-92.rdu2.redhat.com [10.10.120.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E0CF5D9CA;
        Thu, 18 Mar 2021 16:13:10 +0000 (UTC)
Date:   Thu, 18 Mar 2021 11:13:08 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org
Subject: Re: [PATCH 3/3] static_call: Fix static_call_update() sanity check
Message-ID: <20210318161308.vu3dhezp2lczch6f@treble>
References: <20210318113156.407406787@infradead.org>
 <20210318113610.739542434@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318113610.739542434@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 12:31:59PM +0100, Peter Zijlstra wrote:
>  			if (!kernel_text_address((unsigned long)site_addr)) {
> -				WARN_ONCE(1, "can't patch static call site at %pS",
> +				/*
> +				 * This skips patching __exit, which is part of
> +				 * init_section_contains() but is not part of
> +				 * kernel_text_address().
> +				 *
> +				 * Skipping __exit is fine since it will never
> +				 * be executed.
> +				 */
> +				WARN_ONCE(!static_call_is_init(site),
> +					  "can't patch static call site at %pS",
>  					  site_addr);
>  				continue;
>  			}

It might be good to clarify the situation for __exit in modules in the
comment and/or changelog, as they both seem to be implicitly talking
only about __exit in vmlinux.

For CONFIG_MODULE_UNLOAD, the code ends up in the normal text area, so
static_call_is_init() is false and kernel_text_address() is true.

For !CONFIG_MODULE_UNLOAD, the code gets discarded during module load,
so static_call_is_init() and kernel_text_address() are both false.  I
guess that will trigger a warning?

-- 
Josh

