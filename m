Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2878243A959
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 02:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbhJZAmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 20:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbhJZAmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 20:42:19 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EB9C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:39:56 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id l186so5919798pge.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YzYDFlVO4yRtUtstyuZjtTCfaHeLtxBbXFUEMFl50gE=;
        b=I4eh9zJO0VLnLMuN830zfiQzAYRDYtuGSr1IieUbZQMbcEFUavGlzVO73hgMCovAH/
         WFeFD67omMoSYxzPgBhVZ3e4GFYFyzm5+MxSGqr2aq8+5EKGRaIoglIyx4KddyGuE+ou
         Ebv5lhIXDPzE+xnOSZv0cxvYh7FUIfrZmcghA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YzYDFlVO4yRtUtstyuZjtTCfaHeLtxBbXFUEMFl50gE=;
        b=Osg9m05KVIovP0MGT1dftWSxC9iK0q/C0kN+6tK+FNrjfk8v9t3L3mc/rcwhPoB0iw
         t/SpZajVu4aNr5IAV4ph3KTiL2u74lUObBMWFsu7lNK35gPgI0rrmof2H/rhf2NTIL9c
         b/tejpPucYtX0S8glVYQdKq8pq3Ei2WkgbyyeUGKk+RbGCY4lOSKcU3qfBBqxddPt358
         VTArsxIgHiMqiGawxNVfIqXW6uM1LmC+dINeDGqiQ2uniEXyKj+nVJiN7ierNen6f1WD
         Jwt3NcrgPqD943Mn2iA4x71oS3nDj07W53zLa3NH/rYvqIbSgHfAzxt4afpU1CQ7heh9
         xO0A==
X-Gm-Message-State: AOAM530IZDQtOaMLsrgJvwPs0mJebLikNu11dF6aAiPEXBYXxmUmBc2x
        9aIv08DlwUxEjtqBGw07Ug2vqg==
X-Google-Smtp-Source: ABdhPJxNGQkKAn0VvFUMEC9gGI3s88Scz933Ih3dJHUfyERI4UGSRzlq/cWVGxOHVMAcydKqNeBoeg==
X-Received: by 2002:a05:6a00:2443:b0:44e:ec:f388 with SMTP id d3-20020a056a00244300b0044e00ecf388mr21933464pfj.7.1635208795789;
        Mon, 25 Oct 2021 17:39:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:5822:765c:9f84:e1b3])
        by smtp.gmail.com with UTF8SMTPSA id np17sm24814905pjb.7.2021.10.25.17.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 17:39:55 -0700 (PDT)
Date:   Mon, 25 Oct 2021 17:39:54 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sujit Kautkar <sujitka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rpmsg: glink: Update cdev add/del API in
 rpmsg_ctrldev_release_device()
Message-ID: <YXdOWrY3xcAaI9Ih@google.com>
References: <20211025233751.1777479-1-sujitka@chromium.org>
 <20211025163739.v2.2.I507c5cea0cf97db4cedfa0e47029e711e7edd0df@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211025163739.v2.2.I507c5cea0cf97db4cedfa0e47029e711e7edd0df@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 04:37:54PM -0700, Sujit Kautkar wrote:
> Replace cdev add/del APIs with cdev_device_add/cdev_device_del to avoid
> below kernel warning. This correctly takes a reference to the parent
> device so the parent will not get released until all references to the
> cdev are released.
> 
> | ODEBUG: free active (active state 0) object type: timer_list hint: delayed_work_timer_fn+0x0/0x7c
> | WARNING: CPU: 7 PID: 19892 at lib/debugobjects.c:488 debug_print_object+0x13c/0x1b0
> | CPU: 7 PID: 19892 Comm: kworker/7:4 Tainted: G        W         5.4.147-lockdep #1
> | ==================================================================
> | Hardware name: Google CoachZ (rev1 - 2) with LTE (DT)
> | Workqueue: events kobject_delayed_cleanup
> | pstate: 60c00009 (nZCv daif +PAN +UAO)
> | pc : debug_print_object+0x13c/0x1b0
> | lr : debug_print_object+0x13c/0x1b0
> | sp : ffffff83b2ec7970
> | x29: ffffff83b2ec7970 x28: dfffffd000000000
> | x27: ffffff83d674f000 x26: dfffffd000000000
> | x25: ffffffd06b8fa660 x24: dfffffd000000000
> | x23: 0000000000000000 x22: ffffffd06b7c5108
> | x21: ffffffd06d597860 x20: ffffffd06e2c21c0
> | x19: ffffffd06d5974c0 x18: 000000000001dad8
> | x17: 0000000000000000 x16: dfffffd000000000
> | BUG: KASAN: use-after-free in qcom_glink_rpdev_release+0x54/0x70
> | x15: ffffffffffffffff x14: 79616c6564203a74
> | x13: 0000000000000000 x12: 0000000000000080
> | Write of size 8 at addr ffffff83d95768d0 by task kworker/3:1/150
> | x11: 0000000000000001 x10: 0000000000000000
> | x9 : fc9e8edec0ad0300 x8 : fc9e8edec0ad0300
> |
> | x7 : 0000000000000000 x6 : 0000000000000000
> | x5 : 0000000000000080 x4 : 0000000000000000
> | CPU: 3 PID: 150 Comm: kworker/3:1 Tainted: G        W         5.4.147-lockdep #1
> | x3 : ffffffd06c149574 x2 : ffffff83f77f7498
> | x1 : ffffffd06d596f60 x0 : 0000000000000061
> | Hardware name: Google CoachZ (rev1 - 2) with LTE (DT)
> | Call trace:
> |  debug_print_object+0x13c/0x1b0
> | Workqueue: events kobject_delayed_cleanup
> |  __debug_check_no_obj_freed+0x25c/0x3c0
> |  debug_check_no_obj_freed+0x18/0x20
> | Call trace:
> |  slab_free_freelist_hook+0xb4/0x1bc
> |  kfree+0xe8/0x2d8
> |  dump_backtrace+0x0/0x27c
> |  rpmsg_ctrldev_release_device+0x78/0xb8
> |  device_release+0x68/0x14c
> |  show_stack+0x20/0x2c
> |  kobject_cleanup+0x12c/0x298
> |  kobject_delayed_cleanup+0x10/0x18
> |  dump_stack+0xe0/0x19c
> |  process_one_work+0x578/0x92c
> |  worker_thread+0x804/0xcf8
> |  print_address_description+0x3c/0x4a8
> |  kthread+0x2a8/0x314
> |  ret_from_fork+0x10/0x18
> |  __kasan_report+0x100/0x124
> 
> Signed-off-by: Sujit Kautkar <sujitka@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  drivers/rpmsg/rpmsg_char.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 876ce43df732b..b63a5c396da57 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -458,7 +458,7 @@ static void rpmsg_ctrldev_release_device(struct device *dev)
>  
>  	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
>  	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
> -	cdev_del(&ctrldev->cdev);
> +	cdev_device_del(&ctrldev->cdev, &ctrldev->dev);
>  	kfree(ctrldev);
>  }
>  
> @@ -493,14 +493,13 @@ static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
>  	dev->id = ret;
>  	dev_set_name(&ctrldev->dev, "rpmsg_ctrl%d", ret);
>  
> -	ret = cdev_add(&ctrldev->cdev, dev->devt, 1);
> +	ret = cdev_device_add(&ctrldev->cdev, &ctrldev->dev);
>  	if (ret)
>  		goto free_ctrl_ida;
>  
>  	/* We can now rely on the release function for cleanup */
>  	dev->release = rpmsg_ctrldev_release_device;
>  
> -	ret = device_add(dev);
>  	if (ret) {
>  		dev_err(&rpdev->dev, "device_add failed: %d\n", ret);
>  		put_device(dev);

Also remove the error check? There is already a check above for the
status of 'cdev_device_add'.
