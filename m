Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7E13DDAD0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbhHBOVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbhHBOVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:21:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CAAC061798
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 07:04:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id x11so30158339ejj.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 07:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1RlFtOczU7bqdeC9+xI0lJWMN+h+lumUpCgvelVcrA=;
        b=sicBxFjABTilN0mVRBL8M8lqKLzZcUdNbBrYstWs/mIx4KMF7R94fbC76LVGZZxG3a
         TTyE6cLj86gVEFEMoT0QnxZeST7Ko76Dpx7Ne6Qt0UJroBr2DABQRqCTyRh/IaxmU5Wh
         gZsFgkXHMVmWx2jL7nRI+tb4Gh25KPitoZJPrRam8n9/4E/IpWACCqKX50Nhw4ylC0v1
         CDhQwzSLpMILSsEKhN4YLsr1K8sfJ6xTEkWYR+OY6Vhrawg7Ux19AZj1dDG0hIUmQgZb
         40IwzYQbe2WIraeQwxi6y3CS6nQGxYqhbe6VRIF3iiS89Q/QtmkYlI/AfeSxn6JPaloo
         6Teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1RlFtOczU7bqdeC9+xI0lJWMN+h+lumUpCgvelVcrA=;
        b=cnbFygYr28jBqdrcGdl7Ax7gGN0vb6oZPifAalgbSilPZYmWYraEoOzGEBSkhXmOYD
         /8v4y2KRD2DQsmMeaYAhwjQW7Jhoxq6XvGP7dZ9/hJS+6tvUJtuFWZYIUxLxbTdhwPBd
         40xkv/MKu+i3aogNOz9DAnyRBBZyq9juXfZeyhlwdo3vvznJbivozSKGsCvbp5Q5CT7l
         NHrPLT7+A7WNYa9enCN/vz2SBZCo4Bagav5VZ9Xtr/qYeQzyiS2Dmt5fIfe+SzOKHLvA
         c4hCqxkfBlXIp855ulC2QvW18CX4j6vV1n7ONsoDOOQD2tgTyNoyDt86byTtNQnB9Q7p
         aZtQ==
X-Gm-Message-State: AOAM530j4I+IPxQUeu+yTtQYyASC6RCyT34osAuF6wsEQklGHognWo0z
        wwpHgo1VJauvWmPsjO4E2PRw+XuCzAoTI/30Par6
X-Google-Smtp-Source: ABdhPJz3kbyxu7m8WdqExQQ8inFRy0slhdrCxzUYCW4C6yiiyhNLevqwJTeEV/T2krM+O42Zg2oj/rwLYkB+ozzVCAY=
X-Received: by 2002:a17:907:3345:: with SMTP id yr5mr15563499ejb.542.1627913073888;
 Mon, 02 Aug 2021 07:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210729031644.47679-1-xiujianfeng@huawei.com>
In-Reply-To: <20210729031644.47679-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 Aug 2021 10:04:23 -0400
Message-ID: <CAHC9VhR5LA5e7rpphu7Sg1-pGrtKMkGcU7Q6TBYWyKK_23JB8Q@mail.gmail.com>
Subject: Re: [PATCH -next, v2] selinux: correct the return value when loads
 initial sids
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 11:15 PM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> It should not return 0 when SID 0 is assigned to isids.
> This patch fixes it.
>
> v2: remove the "out" label and return directly.
>
> Fixes: e3e0b582c321a ("selinux: remove unused initial SIDs and improve handling")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/ss/policydb.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Thanks, this looks much better.  I decided this is worth sending up to
Linus as a fix for the 5.14-rcX series so I've merged it into
selinux/stable-5.14 and I'll send it up to Linus later this week.

-- 
paul moore
www.paul-moore.com
