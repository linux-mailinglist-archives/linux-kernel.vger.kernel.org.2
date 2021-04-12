Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2140B35C886
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbhDLOUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbhDLOUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:20:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BE4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 07:19:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso7183926pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 07:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d1S/3v+7DGopxJQN5d6EIL/5xwFrAEwGqBzqd2O8Ag8=;
        b=mszDDVquosAwb+NGIw+dgY0L+B0NC5OZhXc5KuWrPOiMs2lTZKnK5A/1JDznUUu0PX
         8x5BYizeKiW6e5Rt3xy57SO8ZwanFXl84aJIdI8eFVxe3Pq0lR7wW+ZHI+HdTRVJ6Gbu
         QUmhumTs20kq/PQmPr7BF598GeZHxS3PEde+hVg/y1CKRQaWNSS49Tu+cDSHTNuBvtvj
         TzLO29C8Pn/qFimS0g3x6pJITenjjybK8WAx3LT8RWdiRashnamUHsWKtfGmIfcIrYI2
         BiALDqIuQTDDIZpRgpRxIevxlc1QdkGp/rbqhWm5o/z2MPYF2mnF0a3LAMsWp2mN3ofi
         c6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d1S/3v+7DGopxJQN5d6EIL/5xwFrAEwGqBzqd2O8Ag8=;
        b=HSgtuXwgRbxTBmvF9dBoT/FtJq54xWI9pNhXDMRi0QUANud5ES7PLp8XjWtX5BV+ve
         A89phTMQFIekDqqRIUlBvGeOeFn0jqCtzjHx0+7caFe/uPWYlA2g6k7E6qnHEr76B5NA
         Nmze3A/PBRJ+bk+WdXsiP96yhNoz4551O60xfe1gA1E2/aYCoWqPigzCK/b7Ema1VO2W
         68p1SUrbvId2zj/e7v7bNBEVi+HlhxTtdVEbUb02p9/TFpg/uLcyGb+1UtKzh5WRPSuR
         iqshUkdJUyAxs8OTzgMmuNkqrrcNXeitVpH3hYRL92BsvjQB2QEEECV3oVrrGKuS7mtn
         1dzw==
X-Gm-Message-State: AOAM533btE2joPUTgr0V7pEgv34NS+N4NJPWPjUcje3BpmcsXl6BfgLk
        LtqBtDeqHrs8B6mqGZsL4u+mo0iFVD2Xzw==
X-Google-Smtp-Source: ABdhPJy+oasDv+p5MxTT01LmiH+zY2x08n7lR4D6Jop4W+lpf0+GQ6nSfcfQ0dg4f0iwxi/b4lYNFQ==
X-Received: by 2002:a17:903:10a:b029:eb:1fd1:ca0 with SMTP id y10-20020a170903010ab02900eb1fd10ca0mr186119plc.71.1618237193095;
        Mon, 12 Apr 2021 07:19:53 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:645:c000:35:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id i66sm2212804pfg.206.2021.04.12.07.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 07:19:52 -0700 (PDT)
Date:   Mon, 12 Apr 2021 07:19:50 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        johnstul@us.ibm.com, rui.xiang@huawei.com
Subject: Re: [PATCH] time: Fix overwrite err unexpected in clock_adjtime32
Message-ID: <20210412141950.GA18311@hoboy.vegasvil.org>
References: <20210412124552.50213-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412124552.50213-1-chenjun102@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 12:45:51PM +0000, Chen Jun wrote:
> the correct error is covered by put_old_timex32.

Well, the non-negative return code (TIME_OK, TIME_INS, etc) is
clobbered by put_old_timex32().

> Fixes: f1f1d5ebd10f ("posix-timers: Introduce a syscall for clock tuning.")

This is not the correct commit for the "Fixes" tag.  Please find the
actual commit that introduced the issue.

In commit f1f1d5ebd10f the code looked like this...

	long compat_sys_clock_adjtime(clockid_t which_clock,
			struct compat_timex __user *utp)
	{
		struct timex txc;
		mm_segment_t oldfs;
		int err, ret;
	
		err = compat_get_timex(&txc, utp);
		if (err)
			return err;
	
		oldfs = get_fs();
		set_fs(KERNEL_DS);
		ret = sys_clock_adjtime(which_clock, (struct timex __user *) &txc);
		set_fs(oldfs);
	
		err = compat_put_timex(utp, &txc);
		if (err)
			return err;
	
		return ret;
	}

Thanks,
Richard



> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> ---
>  kernel/time/posix-timers.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index bf540f5a..dd5697d 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -1191,8 +1191,8 @@ SYSCALL_DEFINE2(clock_adjtime32, clockid_t, which_clock,
>  
>  	err = do_clock_adjtime(which_clock, &ktx);
>  
> -	if (err >= 0)
> -		err = put_old_timex32(utp, &ktx);
> +	if (err >= 0 && put_old_timex32(utp, &ktx))
> +		return -EFAULT;
>  
>  	return err;
>  }
> -- 
> 2.9.4
> 
