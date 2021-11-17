Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0336F454D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbhKQTCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 14:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhKQTCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 14:02:48 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DDEC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:59:50 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id o15-20020a9d410f000000b0055c942cc7a0so6399151ote.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Xl6cXzjW/kOqKao6cn8JUvbY4QNwp14WcaitPjDEwdQ=;
        b=KQmCu2o263jOKUaOGqvxwzr8SmYkNXLS7H/NhW183cyG2nqVnTFnGEnaiTOUTxTc/H
         KIX3Z48U3aceVVYPfwL33ICaAeB7oVyzxhGGxTdnc/J1J+IAwub3NaRSNesTNnP5phXg
         ENf+UH77dco7ht6D5ybxFkSJziLeznEaEw3So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Xl6cXzjW/kOqKao6cn8JUvbY4QNwp14WcaitPjDEwdQ=;
        b=gS92RN0Ntt1DqnHnB+p7TAcrYMkQz9hrwGvuMpOViczJA346Xu9Yky6RFOCe8Z+pAz
         ggumkDYM13T0PKPcAa3SKeNjIkmDWoU9nTbuQG0mcH0Q8IuyMOHDMx7HY8REM0DkNp3V
         bDaRqVyBjaciI+OC+MVzL5JKrlskWUWfL8EeZNe7cXRH+tSo/qa0NGS6VT1ewtTsdlQD
         bbrYbpJH0CPYRT0bpCJa6AjreqViUt0oqXzN5a3CB+Bro1v9daS90EkQchsIZpZfmqaP
         8ijqjEgZBUCJ6LXPKEXRhcOC1A2NWr6ZhA+1mYZIbGoZ5u2GH0bTKsJ4yanceaYw6aLq
         PSjg==
X-Gm-Message-State: AOAM530hSq6/nG5XdUE7Ts4Y0jRVm6jwbq4MVihuXTeQg7hjXCb6fTaw
        byIrAj+ELy76txiMHJldR+yisG2SdVbBRUJK8u/1EA==
X-Google-Smtp-Source: ABdhPJxAk1nUnipVXluouzFs/5Z2zeTeMrFH7CUdp90+0yKHCrPK4SR03aBUxIo3/j5pEXmWU0PO9CLnzo411T2P7J8=
X-Received: by 2002:a05:6830:30b7:: with SMTP id g23mr15133139ots.159.1637175589479;
 Wed, 17 Nov 2021 10:59:49 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Nov 2021 10:59:48 -0800
MIME-Version: 1.0
In-Reply-To: <20211102165137.v3.2.Ie09561c5b453a91f10ecc7e1974c602c4ff78245@changeid>
References: <20211102235147.872921-1-sujitka@chromium.org> <20211102165137.v3.2.Ie09561c5b453a91f10ecc7e1974c602c4ff78245@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 17 Nov 2021 10:59:48 -0800
Message-ID: <CAE-0n53ZKbS6sr4OEAXB+T59RTQtRpYmW+Nyr_mJ6Vd_Jtk6xA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rpmsg: glink: Update cdev add/del API in rpmsg_ctrldev_release_device()
To:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Sujit Kautkar <sujitka@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject is a little confusing. Maybe it should be "Use
cdev_device_{add,del}() instead of open coding".

Quoting Sujit Kautkar (2021-11-02 16:51:51)
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

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
