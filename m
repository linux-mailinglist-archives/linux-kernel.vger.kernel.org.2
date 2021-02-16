Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E48D31CC1C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhBPOhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:37:08 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:36007 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhBPOfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:35:20 -0500
Received: by mail-ot1-f50.google.com with SMTP id 100so9157756otg.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 06:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ulc9T4keax3RdIwjOA8Ri+T8QG6EZVWA4lJbu2SYYk=;
        b=ZnjB9gwOux2XLaqoVdcTlSgDE1sMHCr8WgPUELfZSyGxBsi6YDB30VIqQnBRIeISx6
         U9fw2zGrRzEyYRcNEj+hqMgM4vXTRtTg+4Mv3DBgWmjE6baytgifZdH691iAhUeqMpLC
         FfDAgXM2slZkSRAs4d/xnViQxYbZAJDsRRJ6Ji7mv3BVdVj4DSPwMGY5LvC9dF/8lKJj
         Yv6PLdF6cKnze4d6ExpE11ovjHqszVcbGqvpCaa5RHWIzAf18UkCcvWQLSssBCZT/NM/
         DLoYe7xNgzJJMA1jfdfhuVSTS6zjdkts787y23+/Zr6BwI9Q3+/mUjR/t3xHye6H1ooO
         ZwVQ==
X-Gm-Message-State: AOAM532UHegfqpDC9iacOrQzmUyCcWZuJBStyIdZD0tDq8Xtli8Mq06H
        oSlHnx1JVuFaWoNiW15XJ668jXLyhoZYGZxga9CJwJJwkX8=
X-Google-Smtp-Source: ABdhPJwkpYb2YyYLxgQiz4XzQAXJI+cu+blfyYL5ypf6nh9uQodQa5o6BH5yhNVTpCL7/7hB9/9v8tvACvYHdjTnRJI=
X-Received: by 2002:a9d:a2d:: with SMTP id 42mr15338632otg.321.1613486079396;
 Tue, 16 Feb 2021 06:34:39 -0800 (PST)
MIME-Version: 1.0
References: <20210216142400.3759099-1-gregkh@linuxfoundation.org> <20210216142400.3759099-2-gregkh@linuxfoundation.org>
In-Reply-To: <20210216142400.3759099-2-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Feb 2021 15:34:27 +0100
Message-ID: <CAJZ5v0jeGgVv8vLZnimJXcRWZNf926Ff61mT4o4kGQ48FzyYCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver core: dd: remove deferred_devices variable
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 3:24 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> No need to save the debugfs dentry for the "devices_deferred" debugfs
> file (gotta love the juxtaposition), if we need to remove it we can look
> it up from debugfs itself.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/dd.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9179825ff646..66c31cda5462 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -55,7 +55,6 @@ static DEFINE_MUTEX(deferred_probe_mutex);
>  static LIST_HEAD(deferred_probe_pending_list);
>  static LIST_HEAD(deferred_probe_active_list);
>  static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
> -static struct dentry *deferred_devices;
>  static bool initcalls_done;
>
>  /* Save the async probe drivers' name from kernel cmdline */
> @@ -310,8 +309,8 @@ static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_
>   */
>  static int deferred_probe_initcall(void)
>  {
> -       deferred_devices = debugfs_create_file("devices_deferred", 0444, NULL,
> -                                              NULL, &deferred_devs_fops);
> +       debugfs_create_file("devices_deferred", 0444, NULL, NULL,
> +                           &deferred_devs_fops);
>
>         driver_deferred_probe_enable = true;
>         driver_deferred_probe_trigger();
> @@ -336,7 +335,7 @@ late_initcall(deferred_probe_initcall);
>
>  static void __exit deferred_probe_exit(void)
>  {
> -       debugfs_remove_recursive(deferred_devices);
> +       debugfs_remove_recursive(debugfs_lookup("devices_deferred", NULL));
>  }
>  __exitcall(deferred_probe_exit);
>
> --
> 2.30.1
>
