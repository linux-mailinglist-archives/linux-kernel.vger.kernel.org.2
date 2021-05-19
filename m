Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3D5389524
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 20:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhESSRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 14:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhESSR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 14:17:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D04C06175F;
        Wed, 19 May 2021 11:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=5FdxU9zm+SIRDYbXNZiqO0mZs+wcSKYPXIoKeNN8++c=; b=4dmPDumNKrYZRNLuokjZTXjnab
        CfglcPNTl/9nIrnXy4v1ma0dQaS56+S5OVSntvlu23rNFb3Oy4eCFtTkX9ga9dFVwrIMKuQvIPFrs
        3Otfs+1mzbp6TPF8P/i4xn6WRrvr3ehZnHRuzZalNAPnA0T064vfUXjlpxqze43TuQUqr0fgBgm74
        tU407A/Zm76qAdMGMokY/qom2AcemmCq+G/GgmEqTCmBt+l6rx78aOKIAU/aUfuX8/2VdAYhCa0Ng
        TNZLsxTiugxA3VTmOTXzyBqsrtyvv1D6776UVcE2Gk9vKr5XXVgR+RBeDF/IDmAuhuMBEmSKviQDA
        /wy7HtyQ==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljQjm-00Fgkn-6z; Wed, 19 May 2021 18:16:06 +0000
Subject: Re: [RFC PATCH 11/16] rv/monitors: wwnr instrumentation and
 Makefile/Kconfig entries
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>, linux-doc@vger.kernel.org
References: <cover.1621414942.git.bristot@redhat.com>
 <879c2e3f03baefcda72e5923d9a16f340edeccca.1621414942.git.bristot@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6bbb99e6-e940-0bd1-70e4-f96f8bdd5e17@infradead.org>
Date:   Wed, 19 May 2021 11:16:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <879c2e3f03baefcda72e5923d9a16f340edeccca.1621414942.git.bristot@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 4:36 AM, Daniel Bristot de Oliveira wrote:
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 4a1088c5ba68..612b36b97663 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -21,6 +21,13 @@ config RV_MON_WIP
>  	  Enable WIP sample monitor, this is a sample monitor that
>  	  illustrates the usage of per-cpu monitors.
>  
> +config RV_MON_WWNR
> +	tristate "WWNR monitor"
> +	help
> +	  Enable WWNR sample monitor, this is a sample monitor that

	                     monitor. This is

> +	  illustrates the usage of per-task monitor. The model is
> +	  broken on purpose: it serves to test reactors.

and please tell the user what WWNR means, either in the prompt
or in the help text.

-- 
~Randy

