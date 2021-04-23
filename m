Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC7B369A9A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhDWTEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:04:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243520AbhDWTEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:04:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4973A611C2;
        Fri, 23 Apr 2021 19:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619204614;
        bh=iyXrOdWycv6swmpRpm+N5unekMyNgmKwbiZCNOL9T2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQZw6e2J5wwlXvEYA3CJibpuOnlzFnpuVox7DWtPpUm4pza9kcKYBdsUlKY7wE4Xt
         mLT99/XkfBbPqiav8kDEb0UB9kdqZjcc4/C7/aiqXiUmNXFqIOUuiv/L9NAM2TLNo2
         WIRw9X6CJYkEHWkBXIpfgzsbLPzSGmzJKeJcfoqjOWfucse3fWn7j0+6Kb59tRtUfL
         F4wqlIMj/ELyJc25yFwcbkeLkY3U0RHqcm5ETvIAeyXDeFKY8iJ3qYwPyqriTTGlvL
         DC2+QNswMzVLPUoggOzJQZ26FB2faJFr2xhvNszZ941KkKoLNsBGKXPmkxnrHg09nw
         yOrTkpF292MGw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E0481406FA; Fri, 23 Apr 2021 16:01:33 -0300 (-03)
Date:   Fri, 23 Apr 2021 16:01:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ray Kinsella <mdr@ashroe.eu>, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, kan.liang@linux.intel.com
Subject: Re: [PATCH] perf tools: Update topdown documentation to permit rdpmc
 calls
Message-ID: <YIMZjfLVzvgRncTE@kernel.org>
References: <20210421091009.1711565-1-mdr@ashroe.eu>
 <20210421193847.GG1401198@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421193847.GG1401198@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 21, 2021 at 12:38:47PM -0700, Andi Kleen escreveu:
> On Wed, Apr 21, 2021 at 10:10:09AM +0100, Ray Kinsella wrote:
> > Update Topdown documentation to permit calls to rdpmc, and describe
> > interaction with system calls.
> > 
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > Signed-off-by: Ray Kinsella <mdr@ashroe.eu>
> 
> Looks good to me.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied.

- Arnaldo

