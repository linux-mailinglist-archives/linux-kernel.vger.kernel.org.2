Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698AB438F85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhJYGcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhJYGcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:32:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C216F60C4A;
        Mon, 25 Oct 2021 06:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635143385;
        bh=BN1cngPxgf6pNckB5yfeW0VtZExwVPhHyz+0ku2Gb/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A+hyKG34GAdfp7K2SFGzPjp6Vm3KwF61QL5bBpyb0CY7Qc0NV89oYJ2YI9pdL5B3M
         iUA9QTL7dfe4pjxJUQ72Ahf19cMomTA1ePhafUWegB8y5EB44r33yf3bHyzOJ2Oght
         GErn7bf3WnYANACiO3wCo2iuhViBSha+Mo+pE/8+MYEjIMBiv3LfZAPskcWwIlR9Wa
         733uII9E1Ie1hPKKQuY0zRh0twnFYBCu8rq5oBmBTKN8UgBT2fqmixZPMU2+WCacCh
         qdByrZc6Sj+POPB6//xRksjSnnkkOxBq1HMBnypTLaExjz6UpZV9P9gO9awfiLTIjd
         pa2Ep/TT27ycA==
Date:   Mon, 25 Oct 2021 15:29:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, corbet@lwn.net, ananth@in.ibm.com,
        akpm@linux-foundation.org, randy.dunlap@oracle.com,
        mathieu.desnoyers@polymtl.ca, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] docs, kprobes: Remove invalid URL and add new
 reference
Message-Id: <20211025152941.02d219a7a48a31a6ece7f149@kernel.org>
In-Reply-To: <1635132660-5038-3-git-send-email-yangtiezhu@loongson.cn>
References: <1635132660-5038-1-git-send-email-yangtiezhu@loongson.cn>
        <1635132660-5038-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 11:30:58 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> The following reference is invalid, remove it.
> https://www.ibm.com/developerworks/library/l-kprobes/index.html
> 
> Add the following new reference "An introduction to KProbes":
> https://lwn.net/Articles/132196/

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  Documentation/trace/kprobes.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/kprobes.rst b/Documentation/trace/kprobes.rst
> index 998149c..f318bce 100644
> --- a/Documentation/trace/kprobes.rst
> +++ b/Documentation/trace/kprobes.rst
> @@ -784,6 +784,6 @@ References
>  
>  For additional information on Kprobes, refer to the following URLs:
>  
> -- https://www.ibm.com/developerworks/library/l-kprobes/index.html
> +- https://lwn.net/Articles/132196/
>  - https://www.kernel.org/doc/ols/2006/ols2006v2-pages-109-124.pdf
>  
> -- 
> 2.1.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
