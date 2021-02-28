Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E537327458
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 21:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhB1UOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 15:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhB1UOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 15:14:19 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C04C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 12:13:39 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id e45so14419422ote.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 12:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7gZfPgzWrN7aQrhLlhRVvvza5A8VMSV9ZBHx3+Axvf4=;
        b=QfSxGlGrSq1Iu6x88NNp2rtebfgHneFmQV2+uI/P4vzWNfxSs8do0KM8NboHnhA7eK
         f6w0lfR4ER8rmesPimn12dl5dcP10KFq2WHqKLkNbPdBRKbiBp/f69Xmr39XB40jm83/
         Ijfte7rU4iDdJBcuWclr/AGMzyLPtE7x/zqFiXa39U08tqWoMHVqdwWnCZSDGA274Ua8
         zb3pLKelz/MVDkPt9jQSr8n28WFJCY7UUtRa1skXQvywKMY9ZJTdNmbClBfTX0ifCGii
         ST+ohB7pmI7+zJwQIDhi5/unD186PoOGGjIeYw1sqtd3HsPAZoph/2dCb24+ZqQslDTU
         xfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7gZfPgzWrN7aQrhLlhRVvvza5A8VMSV9ZBHx3+Axvf4=;
        b=UGaMcP2StA/iyXrivJw6ZQqquARkGuIVwbwYS/IX1w/DKGAv8KV/VX0uT+JXUDYsoH
         QVUsbFiLPbg3zdpdzAruAmsEyGD2D5m1i1ONl7fyBZQQGybiQknkbnrFKeAAHFlISvWf
         e6/2qv1MXXLGCjarYS2NV/o0PfoFYAZS6fQwHplDVeF3Ec7kE74ET1B/GnRRED25Z0p0
         fH7Ho3wi1pzhbRy85oZzOeGJAhZMyuey9kQIGKaLl8ytC4Ak8ZFVnQL2hcR930SpCkSw
         /T0TiRJggC8ah4H2D8IKqGq+kR8ofKgZCJ6rgR4MXtrLGxJ/55p4A7mNh0dvcJev3VEo
         uE6g==
X-Gm-Message-State: AOAM533hXKY5QZDP4DKn2bU2VNbzNEyFCjhbS8L0U5VrVbjeIfWHlQTl
        2+1GPRsgdAPJQ9gYD1o2/3JUHYJvS6HDeY1qtL4QTJCDowE=
X-Google-Smtp-Source: ABdhPJzjlov4TsqLPLJG7am3dHdlNYN83ZWl4xsANjiZU07fGY3M5yMaYkDSmHYQH+PMuq35Q0rrsm4Yx183BRTwJHU=
X-Received: by 2002:a9d:6382:: with SMTP id w2mr10979738otk.145.1614543218450;
 Sun, 28 Feb 2021 12:13:38 -0800 (PST)
MIME-Version: 1.0
References: <1614071544-130951-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1614071544-130951-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 28 Feb 2021 22:13:11 +0200
Message-ID: <CAFCwf12mapgw=dFkqHr__P4ur6R3D=fyCVW2KSzMLL0qu0t3HQ@mail.gmail.com>
Subject: Re: [PATCH] banalabs: Switch to using the new API kobj_to_dev()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 11:12 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> fixed the following coccicheck:
> ./drivers/misc/habanalabs/common/sysfs.c:347:60-61: WARNING opportunity
> for kobj_to_dev()
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/misc/habanalabs/common/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
> index 4366d8f..79c1ddf 100644
> --- a/drivers/misc/habanalabs/common/sysfs.c
> +++ b/drivers/misc/habanalabs/common/sysfs.c
> @@ -344,7 +344,7 @@ static ssize_t eeprom_read_handler(struct file *filp, struct kobject *kobj,
>                         struct bin_attribute *attr, char *buf, loff_t offset,
>                         size_t max_size)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct hl_device *hdev = dev_get_drvdata(dev);
>         char *data;
>         int rc;
> --
> 1.8.3.1
>

Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next.

Thanks,
Oded
