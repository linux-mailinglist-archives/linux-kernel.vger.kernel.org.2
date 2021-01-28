Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34486307B25
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 17:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhA1QkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 11:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhA1QkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:40:08 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2A7C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 08:39:27 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id j13so3052405qvu.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 08:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8KhEqGW5wN5Td9vK5uZoT6N/X15K6vpba0aY7AqDhCI=;
        b=KcsEFP98m9uOKvOMdpi6cweQH3V80dVe4pc23GwK4TbUEkCzbHjCpJZu/f7e4ByBb2
         yoeoLyStAnyl3UzgjK3kx7OfC2EcChqVdFbM0DYkF4lXHnKw0HBAt7J5YffY4D7EkoAQ
         a4MzCH7Ne5hlpB2w7Uk0tPjKmhcNukKIVrFutnjeZ+PiI0bW5J3+/y9x9sPBS1Svh4z/
         ch/+bMcPXb5wT25z9x08370MwcB+ZVQwzOQH/MxgSVJY0Ac25DJXZ22wHYdZ68v429zD
         2SyTdbikwpVw5EeLnablw0kPzlcrJe7dHDhsiJWlH5fyUNzi77nA2bU8A47HlduhfGOD
         z4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8KhEqGW5wN5Td9vK5uZoT6N/X15K6vpba0aY7AqDhCI=;
        b=hHs8vnPCtziDXyzoY2nDnhjUPLWsKu6gMah5vXy7I2IC9Fc4KmxE/v9Nt9CRrXUe0u
         ma2+bHXTPo9fyvjtAlWDN5UmZ2nwCqEA4so+zkvyZR5ASx76fCqXZeUdgcg5c2PFtFYG
         djYD6ivne0n7pJsoySW7uHGfDqVM7q501i1O4PPsUPJroGYkTbWPR2C1XlUweP74DNKA
         4aetqt2Yn8vvuNJ/WIVp7NcgmaMuj4ingucmMhUMc6DPGF5nAXGyILtPo3P+wi+LtpuS
         xEjM+VBv+p53f13y6sz4tquwc0kpZOI5cWwpLgNLhag77XYXlq9qhkcHsCXDpL2eghhl
         tHJQ==
X-Gm-Message-State: AOAM5313Kb9uo1Bpkm3KpHZakYtFycp03kYl+U9ExCJkHSWwQG/Cfm6M
        GE0apztH/lFPIU653ANpgX4=
X-Google-Smtp-Source: ABdhPJxKP53iGnBS1AN0HcV/NxFdLkjastVIlb3CqpDlFiGEoe1dfZt4s1D1QIyJvYLHTpTmUlkcVQ==
X-Received: by 2002:a05:6214:913:: with SMTP id dj19mr341517qvb.33.1611851966403;
        Thu, 28 Jan 2021 08:39:26 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id z132sm3767839qka.131.2021.01.28.08.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 08:39:25 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 28 Jan 2021 11:39:23 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Abaci Team <abaci-bugfix@linux.alibaba.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: Remove redundant code
Message-ID: <YBLou2KO4DQ6rjtf@slm.duckdns.org>
References: <1611822332-124549-1-git-send-email-abaci-bugfix@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611822332-124549-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 04:25:32PM +0800, Abaci Team wrote:
> Fix the following coccicheck warnings:
> 
> ./fs/kernfs/file.c:647:1-3: WARNING: possible condition with no effect
> (if == else).
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Suggested-by: Jiapeng Zhong <oswb@linux.alibaba.com>
> Signed-off-by: Abaci Team <abaci-bugfix@linux.alibaba.com>
> ---
>  fs/kernfs/file.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index c757193..9a74c9d 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -644,11 +644,7 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
>  	 * Both paths of the branch look the same.  They're supposed to
>  	 * look that way and give @of->mutex different static lockdep keys.

Please read the comment right above.

Thanks.

-- 
tejun
