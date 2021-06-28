Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF1B3B5DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhF1M01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232802AbhF1M00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624883040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=acP5uzFdW1Ht90PhtySU1kJQyH71L3NOJrM6+TwWOfY=;
        b=UJV4M4KS0jn+qn9DMljcfg8TZgpCFsOj8GLz0v1UpXFePkn9howxt5VAjFNnI5U8qoAzXJ
        xDZHX/8/RT6Bk5WUYx7qUx8uty5bgGIXCj5UGMTgmqbb/NPWycEfM6RkHy1cv7vt1vYFji
        2MsJ8qyFIQsgwPKSWfERZM+090RLugs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-H1Y9L_JqNA-zaE6brQ-dFQ-1; Mon, 28 Jun 2021 08:23:59 -0400
X-MC-Unique: H1Y9L_JqNA-zaE6brQ-dFQ-1
Received: by mail-wm1-f72.google.com with SMTP id j38-20020a05600c1c26b02901dbf7d18ff8so8910130wms.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=acP5uzFdW1Ht90PhtySU1kJQyH71L3NOJrM6+TwWOfY=;
        b=pPZL/xpgWStwfPgx81q5bVKuqdmlLIXgr/ngB1do5jptPLdOtvvwqVA8pl7fAQR/Xt
         LSyro1B0Lz07EDTMNUK/A/u3AbONsYgGERuUcsbFb4ut0FLJlyclkc5Uk8sHiUm18YqS
         IFZc97Gb/pyDceRgIhxs9rRy39Yo82P5Ysr/t3HkrqrR5GrhT89VtMATWBIcsi5uE7Lr
         8EZIJnA4C4+KETBmTgR427ErDfbaW3inCBPZi/ARg+L46njkzJE1FtWzVFwmrUF/Q8ve
         ezVU4qiEeUJt0T3eJ3K93LfEKEYQASOHWU5RCsDTbkReSZNosVphrqngzDn3ChtLXfyR
         UATQ==
X-Gm-Message-State: AOAM533r3PRzQoamjwh8RM1kfkCR76uiNky8xMKVFXEP+m2fxKBX2Di2
        65TijLZJaWZYaWnWnpq7+iT8P4zGkOZ8VrUNAnmiMTpLW8W8gYph/BBnx2pypSE/cpi9ccdBZXK
        s5KEoXwM/snzX/z72b9PNm//fGMITpuNz2lSNZbUH
X-Received: by 2002:a05:6000:112:: with SMTP id o18mr26070644wrx.289.1624883038193;
        Mon, 28 Jun 2021 05:23:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo/u/RlWFBnhPERyzSjcUsQzROXwkNt9wwDHWfNCBSLkyKR9WiZEYIL0/afe/zNzJ6siZ49Vs928PIyYhboMw=
X-Received: by 2002:a05:6000:112:: with SMTP id o18mr26070626wrx.289.1624883038028;
 Mon, 28 Jun 2021 05:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210628111450.194262-1-jingxiangfeng@huawei.com>
In-Reply-To: <20210628111450.194262-1-jingxiangfeng@huawei.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 28 Jun 2021 14:23:47 +0200
Message-ID: <CAHc6FU5B_bkLyU5T5KEsOr_ds0E30MVyhVdB5ck43n9tg3PRbA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix error handling in init_statfs()
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     Bob Peterson <rpeterso@redhat.com>, Abhijith Das <adas@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jing,

On Mon, Jun 28, 2021 at 1:22 PM Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:
> In an error path of init_statfs(), it calls iput to put pn which has been
> put. Jump to correct label to fix it.

thanks for your patch. This looks okay, but I'd rather set pn to NULL
after the iput instead. Since iput(NULL) is a no-op, we'll end up with
the same result.

Andreas

