Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D80035CA8A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 17:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243102AbhDLP6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 11:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbhDLP6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:58:53 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3987C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:58:33 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id p12so9731869pgj.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EqY30hCVvDaBDbmcUjghiUhWfwV2vxPBdlesVfu4UZo=;
        b=tQJ9ftWycbwQz290baKtWaFG5BCzORlE8gpZ17zq6uGBykYV+wp8UPXBq9KvdFqqbV
         /+uE0WbAZ8t6UB+QvIg/z1V+j4K6ronYnv8lMQ/j0lt5r6Vp6zL6AKM8V8T9YEhwoeL8
         IsIgism1AcaM+GHKEvWAwD2FZNw3wQOYUQb2LR+qYzGBVKxY+TtR2WekHRWSd1NbkaI+
         mRNVPmF5A3pUaxHwifjiwkqdOVKqk/5oHtt8CbLfq+YyuAqlwtF5vCngk/x7IeRGJY/x
         yv3tPDjMS0Nb5VMYnO5nvKHDXvFWLxLfH4vxL6VgWhEjC3jgk9QNd+lmrngOa192V9QR
         LiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EqY30hCVvDaBDbmcUjghiUhWfwV2vxPBdlesVfu4UZo=;
        b=nGtKyfLLUgGIHqPvFfhc9Qxs2ts/zNvrci+oqPd/KBHmSxaJGFIRQgMfBqkrPt+z/y
         OreuCg/In3S8wsV+EtH5busCP62aBd4Sjp1yJ6JJJvwCDI8S5W0okN9IIzIWeDIxRvng
         ZrSNpSDZ5y5EblCcvP1j1S5+GduLpKIrxCbWrCT4XQywsm1J9okTL1JZ8tn1T4egIopv
         hJWBirmPMALNRHfTNud7hT0HtwKEYSBOLwRpvD3jYRO9Njyk6EfilgEayuWD/Z9f0tAR
         LVZK0VE0CPB5u/r9UJumG96eJpXB3Kob6PeWqq4v1mu1xiuN2QREI6St+E3vfUe6Fdaa
         hi/Q==
X-Gm-Message-State: AOAM533axb28V13/uEvjMLSGnG8T51aWHGiVq79WdluH2/DFdELMc3SO
        LkFIOfYeBrGU6y+8CVwCaxa1sKUOYG6GZA==
X-Google-Smtp-Source: ABdhPJy0ZzkmsDyEdMUpMw4F5rCejUZRWLInZdOC8kd/cTvtwlXJSSEEYvUwZSTfIvOTMME4+Mz1iA==
X-Received: by 2002:a63:6a84:: with SMTP id f126mr27137072pgc.352.1618243113429;
        Mon, 12 Apr 2021 08:58:33 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:645:c000:35:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id b21sm11483159pji.39.2021.04.12.08.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 08:58:32 -0700 (PDT)
Date:   Mon, 12 Apr 2021 08:58:30 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     "chenjun (AM)" <chenjun102@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>, john.stultz@linaro.org,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>
Subject: Re: [PATCH] time: Fix overwrite err unexpected in clock_adjtime32
Message-ID: <20210412155830.GA19589@hoboy.vegasvil.org>
References: <20210412124552.50213-1-chenjun102@huawei.com>
 <20210412141950.GA18311@hoboy.vegasvil.org>
 <0aacd0e17515458483653f570b1efd2d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0aacd0e17515458483653f570b1efd2d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 02:52:11PM +0000, chenjun (AM) wrote:
> 在 2021/4/12 22:20, Richard Cochran 写道:
> > On Mon, Apr 12, 2021 at 12:45:51PM +0000, Chen Jun wrote:
> >> the correct error is covered by put_old_timex32.
> > 
> > Well, the non-negative return code (TIME_OK, TIME_INS, etc) is
> > clobbered by put_old_timex32().
> > 
> >> Fixes: f1f1d5ebd10f ("posix-timers: Introduce a syscall for clock tuning.")
> > 
> > This is not the correct commit for the "Fixes" tag.  Please find the
> > actual commit that introduced the issue.
> > 
> > In commit f1f1d5ebd10f the code looked like this...
> > 
> > 	long compat_sys_clock_adjtime(clockid_t which_clock,
> > 			struct compat_timex __user *utp)
> > 	{
> > 		struct timex txc;
> > 		mm_segment_t oldfs;
> > 		int err, ret;
> > 	
> > 		err = compat_get_timex(&txc, utp);
> > 		if (err)
> > 			return err;
> > 	
> > 		oldfs = get_fs();
> > 		set_fs(KERNEL_DS);
> > 		ret = sys_clock_adjtime(which_clock, (struct timex __user *) &txc);
> > 		set_fs(oldfs);
> > 	
> > 		err = compat_put_timex(utp, &txc);
> > 		if (err)
> > 			return err;
> > 	
> > 		return ret;
> > 	}

Look at the code ^^^

> The implement of clock_adjtime32 is similar to compat_sys_clock_adjtime. 
> And I think f1f1d5ebd10 introduced the problem actually.

See how 'ret' and 'err' are two separate variables?  It makes a difference.

Thanks,
Richard
