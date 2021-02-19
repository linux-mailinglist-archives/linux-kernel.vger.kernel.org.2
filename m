Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF0231FA0B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 14:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhBSNnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 08:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhBSNnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 08:43:41 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE224C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 05:43:00 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o7so4286855pgl.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 05:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fF/l9GNDkFGA7iWke5utB4iGCtSkQ0+416veSvVe1Xc=;
        b=Ls+CxRRjfhhnhwhZ86f/IoT6Mf5Y2cn9JQfrMvKEjmb7DXLNUYyR0hFyMkn0nWJESz
         FF7wAVCvZJnhE4FQpxAnpCHXwHlXdVOX6BeRg4DT9zOSqqTTImxYNUd3b6A2Q7NJnowX
         oB8IEt7vf1mTCkL80bdzKw2ZQQFy3nX/1h4b/PQDF2xzgE5DqT37FgFuXVwL1oJU9+lG
         U1ddBHqIPQ8Ps+G3liJxCAN/8eFga0wPsqJfv+Bxyl/YdLs8Pc+GKss4CvYxDbvC7c31
         iBHC9Fs/gDcC9Pyw9KpyQ00/OaM+FnEZlRHa/YjZKVq4B+ePs9AIBYpqPl+LXvSmazUL
         i5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fF/l9GNDkFGA7iWke5utB4iGCtSkQ0+416veSvVe1Xc=;
        b=DmlcBmsidYwoYN0zzMDQWVSlhhk7qF7+FvGljeLiaJCXFnOvCs9W/mG2rmyn6orybu
         jcWRG/s6MR4pSbtnCfoiTIgV3VQSGmW6EmY8Sm9K4MHrXxtvmO67+U9awccTnzUaSKx/
         DTuvB3irkdTgrThKQLmrarB5SkoHC5+3xsvvrXpptoQ9TKWmEq2vof3sBMux1MMEb3Cu
         xYI2B/SsfPxSUATq58BvQAmROMVBtrS1ML063NnPgykdx4obvoJe9fnksFI+tzrzR9qw
         S6sTovO0xMgCbO2PyYAIjlAK3aVBEzW68aObHA8kBN1WBSVOpgHmW4ZNUWyxRDvTSTM+
         BraQ==
X-Gm-Message-State: AOAM533xpZAEqGXeCcqk2vgjQ12soQg2hdH0R858Q8ZGXhYlmwpsJPrN
        8leTMGuJKemaU8IC0NG0YiQ=
X-Google-Smtp-Source: ABdhPJyZcXFAu9Vo0fwlCIcLHRFiIPRLTt+cK56Il2JoY/G8Xa9b+8HCXYB7Zhv8BhkJlXTodQfAAA==
X-Received: by 2002:a65:4781:: with SMTP id e1mr8635474pgs.30.1613742180006;
        Fri, 19 Feb 2021 05:43:00 -0800 (PST)
Received: from amrit ([49.36.144.93])
        by smtp.gmail.com with ESMTPSA id w187sm9251403pfb.208.2021.02.19.05.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 05:42:59 -0800 (PST)
From:   Amrit Khera <amritkhera98@gmail.com>
X-Google-Original-From: Amrit Khera <amritk10>
Date:   Fri, 19 Feb 2021 19:10:03 +0530
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Amrit Khera <amritkhera98@gmail.com>, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        christian@brauner.io, hridya@google.com, surenb@google.com,
        dan.carpenter@oracle.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: android: Fix const keyword style issue in
 ashmem.c
Message-ID: <20210219134000.GA25666@amrit>
References: <20210219114237.5720-1-amritkhera98@gmail.com>
 <YC+rQZoFaT+mPxVL@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC+rQZoFaT+mPxVL@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 01:12:49PM +0100, Greg KH wrote:
> On Fri, Feb 19, 2021 at 05:12:38PM +0530, Amrit Khera wrote:
> > This change fixes a checkpatch warning for "struct file_operations
> > should normally be const".
> > 
> > Signed-off-by: Amrit Khera <amritkhera98@gmail.com>
> > ---
> > Changes in v2:
> >  - Wrapped the commit description
> >  - Build tested
> 
> If you tested it, what changed in the diff itself?  Looks the same to
> me...
> 

After further investigating I found that the particular kernel module
was not set in the config file. This did not build it when I built the
kernel. This was making me think that the module was building correctly.

After updating the config, the build indeed breaks. The reason is that
the const keyword cannot be applied here without changing the structure
and flow of the code as the particular variable is later being set in a
condition. Hence, I will be dropping this path for now.

Apologies for the inconvenience caused and thank you for the prompt
replies.

Best Regards,
Amrit Khera
