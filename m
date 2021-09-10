Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607DD4073CA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhIJXTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:19:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234826AbhIJXTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:19:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C5D261167;
        Fri, 10 Sep 2021 23:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631315900;
        bh=HNuFXlUzzdE3O5BLAoHNZ+FVASkIymP1ujqpRkY0Rrw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=vMjSAGX3eIpKKZ/2aboK5CtMRUyJ851TY0/yJLTuynzkG56DVaLrA0/4BQnNPuSAA
         s9E3eJNRFsxeQ1g6+5CAU+W/vsRqEdaL5k+H1UFLsA09myTLjSUK5ilOvW/TKw1CaY
         zmFJLiQWOD3Ox3UVyhthYpzR2hEEjvXGe8SsUbUqMqg5ZSon32sGzkG3ZHySvwsqtP
         2SXkUNorUoCBNZVNblByQWetiBDvRdGwUTZl1egiCDnbrb1L2qJABEIA35Znsj0/ma
         4unw9gFtcb8SI3Rk7IXEivt+urmWWJLFGSJgvbTE4vDk4yY5V8+waHBNk/EKlycYl3
         3q4waikb+Y5Rg==
Date:   Fri, 10 Sep 2021 16:18:20 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Jan Beulich <jbeulich@suse.com>
cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 05/12] swiotlb-xen: suppress certain init retries
In-Reply-To: <56477481-87da-4962-9661-5e1b277efde0@suse.com>
Message-ID: <alpine.DEB.2.21.2109101617290.10523@sstabellini-ThinkPad-T480s>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com> <56477481-87da-4962-9661-5e1b277efde0@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2021, Jan Beulich wrote:
> Only on the 2nd of the paths leading to xen_swiotlb_init()'s "error"
> label it is useful to retry the allocation; the first one did already
> iterate through all possible order values.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> I'm not convinced of the (lack of) indentation of the label, but I made
> the new one matzch the existing one.
> 
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -184,7 +184,7 @@ retry:
>  		order--;
>  	}
>  	if (!start)
> -		goto error;
> +		goto exit;
>  	if (order != get_order(bytes)) {
>  		pr_warn("Warning: only able to allocate %ld MB for software IO TLB\n",
>  			(PAGE_SIZE << order) >> 20);
> @@ -214,6 +214,7 @@ error:
>  		pr_info("Lowering to %luMB\n", bytes >> 20);
>  		goto retry;
>  	}
> +exit:
>  	pr_err("%s (rc:%d)\n", xen_swiotlb_error(m_ret), rc);
>  	return rc;
>  }
> 
