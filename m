Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0411E3AE539
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFUItb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhFUItQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:49:16 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95C2C061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:47:01 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id l7so3564245vkk.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXtdpap2XWVQM3NEM8tHgG7IZgx4gfDzJ3mSSoym7bQ=;
        b=hQnIxvAO+GKOw5DtQZRyn+Ht3RUiPiiUOc1AEuz4qtakU0ufowvZk69wobzde8tdu5
         dus5DWnhFKzZS7vlwyU6eqSvLLxil8zxsfTp2E3RgbxDdL6R4kLwzXE6mdccdtu8Jffu
         NS+ObbYojD8PrU+HsVCoZt8VTFQesY0GbloQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXtdpap2XWVQM3NEM8tHgG7IZgx4gfDzJ3mSSoym7bQ=;
        b=pe/eLZIKO4vbGmiYNgkEUBr+Lh4y+UpwyzAmN78yb37alWEGgvOSuoYgG3V5Uj0JrM
         7x1X26TnFNGDH4IVApIoUaSXgSw4+aHgCmhFCqNU4INoSehUAHqwj0Xt76gxlwFuBAOA
         YIygbZ8Z22OnXezVQZ+ozW/fVgzSBSB5Vlhf7BX+ZoXL4Sb2cteu+z8zNDTIZRe4nXhf
         hKWor06pNy3FgZc8RV+PBmalOvQm3lj8CV4g4GoNCXZrJqpZNdZA/GcMYr3Hhr3/7P+3
         hfv9q59BX1BwUnwh+QJVicOY0pBCpOdnU9hHbqmE+94kDG55191Y5D4OAmPFs3w335+C
         E5lg==
X-Gm-Message-State: AOAM533JuoodI6OCuddZLrTH0qSJqMCZof3QHnU1hmN9xs7PVGpwgJQl
        BJz/cIvNxNT8+pct3lCOMhrT2R4rCNVgwUVX/U0MGg==
X-Google-Smtp-Source: ABdhPJwl4UkjpqNWthBeTMv582+Ok4ondhv7QW6U8UxWLSXdoFi3E/5c/bQdoRsRfek0HDgKz3lwTrf9YFBlSzfXnD8=
X-Received: by 2002:ac5:c5c9:: with SMTP id g9mr4609680vkl.11.1624265220845;
 Mon, 21 Jun 2021 01:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210523065152.29632-1-yuehaibing@huawei.com>
In-Reply-To: <20210523065152.29632-1-yuehaibing@huawei.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Jun 2021 10:46:49 +0200
Message-ID: <CAJfpegvE8hFMyMuc8TmhojYihknmH+xuB0=3vAGHsakSavtm6A@mail.gmail.com>
Subject: Re: [PATCH -next] cuse: use DEVICE_ATTR_*() macros
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2021 at 08:52, YueHaibing <yuehaibing@huawei.com> wrote:
>
> Use DEVICE_ATTR_*() helper instead of plain DEVICE_ATTR,
> which makes the code a bit shorter and easier to read.

Sorry, I don't see really see the cleanup value of this patch.

Thanks,
Miklos
