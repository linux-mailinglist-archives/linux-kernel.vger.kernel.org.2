Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11069409D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347740AbhIMUCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237491AbhIMUCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:02:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4CDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:01:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t19so23551472ejr.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqdzfJryu56mJ7vaVxPWyOCuaZAdQ3500WchggJMhyk=;
        b=wFI+AudGl+mOdojLadZ26AiATdABBUYYuS2pMiWjcI/IvsQWkRK8oOm8uJKjy7iP9x
         vlJSMFMAIaHUvNg41gCRzvmOPcf151WkLqOygB4r2JXN1OEf7r9c7L9/1t0sS6OgYUaF
         Aas2ZICNLjPQmJ4t1oR8hN9I/w+6u+wIA5koJ63UGGBjTOPbKS8SQdwCdAOAxNpq7OLR
         wOXHk4jtglxQzwuP/Y4hkrT3JulcxZ35xozvHKAefUgvVHgwGNsH70ZRlSxVC8tHTDHo
         HA6dRcE3Js5TBR8y2PmNcxJ8SwVceLWxYR91Ylqt7oJYsoJY4WYGvx/lqwm4WUR6eCI0
         2xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqdzfJryu56mJ7vaVxPWyOCuaZAdQ3500WchggJMhyk=;
        b=XnJTOO8B4qGiay/ZVcM3JLPE2f0VbMJkBv4AZJuvn9hzlq+xxR7VZx89GyBwPzIaxu
         S12HkP5lMy7cDIDLwnff5oZ7NpXAciLuUoMjVbuKLDzV+55XkzL6qBr3Yw0UZ3IaGhOC
         YFWnd6b9ccXYpjCSSkpjVWLTd9r7PLRw7oB9Z5xrBaRPVm6IdOnbPAVVVvJAmbdB6geE
         hyZG+0hT4MUfw5u8B6Nved3p3WWl00xFxKSvjp9Z1tZNszRQSt5uS3YZDk5/IwEQsa5B
         cGpiDrZwBKDORUXCQA1Lb5/8RZtqiCWcEwHvavJYWDS24MfRpRSuJlm/zwH20HRPN6UH
         MhLg==
X-Gm-Message-State: AOAM531uId01z6kehhXMvu2V04EEVUi0459scCSTUjC6q/CTF+zdFG05
        Bzm6sSKYMmf2fsc5WXSqgG3U9n0C70XS0ZwkTsJ9
X-Google-Smtp-Source: ABdhPJx8J/+z8ewQ4cNgqvbrSlnYJUsTy7MjvtW4kkLwgO7QyZyFj7oK5eSo7l+0tz6aqwldYYIjcLr59nPZ34KEPf8=
X-Received: by 2002:a17:906:686:: with SMTP id u6mr14138122ejb.569.1631563287496;
 Mon, 13 Sep 2021 13:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210822021315.2045-1-caihuoqing@baidu.com>
In-Reply-To: <20210822021315.2045-1-caihuoqing@baidu.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Sep 2021 16:01:16 -0400
Message-ID: <CAHC9VhTRsMm8mJtm6uCWT8NhUUZkLy6fnb9XqTb0adsyoeqUkw@mail.gmail.com>
Subject: Re: [PATCH] audit: Convert to SPDX identifier
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 10:14 PM Cai Huoqing <caihuoqing@baidu.com> wrote:
>
> use SPDX-License-Identifier instead of a verbose license text
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  kernel/auditsc.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 8dd73a64f921..969c1613fed9 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+

It appears the current recommended token is "GPL-2.0-or-later", please
update this patch to use the preferred license identifier.

* https://spdx.org/licenses

>  /* auditsc.c -- System-call auditing support
>   * Handles all system-call specific auditing features.
>   *
> @@ -6,20 +7,6 @@
>   * Copyright (C) 2005, 2006 IBM Corporation
>   * All Rights Reserved.
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - *
>   * Written by Rickard E. (Rik) Faith <faith@redhat.com>
>   *
>   * Many of the ideas implemented here are from Stephen C. Tweedie,
> --
> 2.25.1

-- 
paul moore
www.paul-moore.com
