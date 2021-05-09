Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F183778A7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 23:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhEIVTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 17:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhEIVTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 17:19:11 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CA4C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 14:18:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z6-20020a17090a1706b0290155e8a752d8so8899785pjd.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 14:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rbwIn0tWgSdNhdH5lPly7AWTzAvikcCRK3NlmDTHFjU=;
        b=Q2P/aJfZKZWxPibdU09rZbB0qLe+e0iNJq86pTd1bKHjeOHHyWyVq99HdnUtYBLmu4
         /eeN3qr0F+bFjntQ+WXlA5Ppb6Vs/LYlw9bKtBGotJZ77IJuAlJX4VXb7by1EcS5Qwy4
         vE+FR8UPqt4LEym7SUih26vGJupRoih6Ukwv7ZHQL9qJGSAwgJVmvwdZwIUQ/aGfXvkh
         XAbUG5tQ6kwSrD19/qzjnJQWtLcmQBStf9jqk+Mb9h0Okkw3ds66bpMPFKFTsQSAs9vL
         TxLdISFQfy2OzN/Xou9kXQdrIUoOQ43RdyeDlXtrw1CofwTOnuZkBr4N/TJt7aWKwlvB
         7kEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rbwIn0tWgSdNhdH5lPly7AWTzAvikcCRK3NlmDTHFjU=;
        b=biEXseTiKHgbzTMtMScUOV014Et1HwXF3reqmOYKMkq2LSuj9JJEc4wDoUAgNnznh1
         hLrYtAbTechYkZuiBsOF+EcvJtjecuu2WZnySPfDdfXiWUxyEa2fS8Jg6mC51Q2djS+l
         L+9BN1+fTAmlBkMFf+4YuU4beAf1TxhyCN/9SYXulz+BjYZZmFcADN8yqjvYgrfPLpBx
         zXsnhFVIWJV8A1cOhOxvgKCRoyysIrLAHfExd5O0OcuYlgg5APnqgAfR9A6m9sTu3sTe
         /G+c+Ss8BU1pno/l1oQj50lkt6nk5YVsErQBKtt9jYPQRQd1EDFDKX9neYzvf2EyOc+Z
         YZ+A==
X-Gm-Message-State: AOAM532CcVdxbQMBVcSoegIkRoeiYrAPQRzR/NcV57NDd0IssZY7vVXt
        AELJVf20zJnk3tSLUADnKTY=
X-Google-Smtp-Source: ABdhPJwVYtPv05PhD6q9QfU7ekFxHIsmxearWyimhPp8Ae96Q8Ri5OE5fDR9tnS/UcWV413cw//76Q==
X-Received: by 2002:a17:902:7281:b029:ea:afe2:b356 with SMTP id d1-20020a1709027281b02900eaafe2b356mr21766956pll.16.1620595087712;
        Sun, 09 May 2021 14:18:07 -0700 (PDT)
Received: from localhost (g1.222-224-229.ppp.wakwak.ne.jp. [222.224.229.1])
        by smtp.gmail.com with ESMTPSA id r32sm9486424pgm.49.2021.05.09.14.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 14:18:07 -0700 (PDT)
Date:   Mon, 10 May 2021 06:18:05 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mike Rapoport <rppt@linux.ibm.com>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] openrisc: mm/init.c: remove unused variable 'end' in
 paging_init()
Message-ID: <YJhRjTPdJbjI5iyj@antec>
References: <20210509091103.7985-1-rppt@kernel.org>
 <20210509091103.7985-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210509091103.7985-3-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2021 at 12:11:03PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> A build with W=1 enabled produces the following warning:
> 
>   CC      arch/openrisc/mm/init.o
> arch/openrisc/mm/init.c: In function 'paging_init':
> arch/openrisc/mm/init.c:131:16: warning: variable 'end' set but not used [-Wunused-but-set-variable]
>   131 |  unsigned long end;
>       |                ^~~
> 
> Remove the unused variable 'end'.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/openrisc/mm/init.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index f3fa02b8838a..6e38ec96cab8 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -128,7 +128,6 @@ void __init paging_init(void)
>  {
>  	extern void tlb_init(void);
>  
> -	unsigned long end;
>  	int i;
>  
>  	printk(KERN_INFO "Setting up paging and PTEs.\n");
> @@ -144,8 +143,6 @@ void __init paging_init(void)
>  	 */
>  	current_pgd[smp_processor_id()] = init_mm.pgd;
>  
> -	end = (unsigned long)__va(max_low_pfn * PAGE_SIZE);
> -
>  	map_ram();
>  
>  	zone_sizes_init();

Thanks, I will queue this in the openrisc fixes queue.

-Stafford
