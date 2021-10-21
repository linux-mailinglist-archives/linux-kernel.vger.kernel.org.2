Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C44436505
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhJUPH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 11:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhJUPHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:07:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907B3C0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:05:08 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y12so52425eda.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qUgdsQvKs/J/n4GClXSY/xHOp3sHP7aorbkL9o6rHvs=;
        b=lImqozNFtHlYTR/oRgIfBiOTJ0lCA5oYHJboLhB7sS6kKvV/4ZWe5revZWtdd8guYo
         5tUF46kjVknnqHQmtM7WkOI3ZqUCbrLg0Gu0sHMBGO67nWH8i4xRftgqPWUfXyOsjeww
         NyyDG7xrOQ5F2CJgR6wzziDuEYq8NyleWKr6YxhVs/Qv3CxSeShYr52CfxxCZUO7/l4b
         Kh86RP6yb1LWybPs/ERzUVyMGuJ0nozQo4XRBVONHqQwtYrbXEhAU130Jd7uk6RjLjgM
         6suelOJv8mtJX7mnWVBOhmDSAOL3FQulIrkrpGWOHf9oQyADJw1Ws8tnukXtkzMlUooS
         XjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qUgdsQvKs/J/n4GClXSY/xHOp3sHP7aorbkL9o6rHvs=;
        b=jMm5qmggnkSa2dpLv9MixKKe6UqipSmqehJIMgfWpG45rEJ08/OhmEzj4VXH/9VUit
         Ws+bzqDwSTZQID96LSdr4LXoLj+GvOvuv0EuRoeGJ5JP1v3LCkRP5txRX7OcnfsGcqFa
         rUfQz6yfSNdyt/lqATfBgrf4J5kESLQiuMHeEskeCpa/YUoiyJVy5sG2KPKbWfXsb+al
         gBhZ2iNxW8fnX8YgsULUc0ffAlOExfvf7J46nLzn/YHSXf/70Dt2j6O4+juDP3jyH3Rr
         o+c7YraIOg85AACoZ3T+hxgTXdZd00purkudQRHT/wSqCO5TVXeWrB/4AaxkM1gknWsa
         wnoA==
X-Gm-Message-State: AOAM531fogVKgkG6TbPxV/3+1I49d4Wvc9fy48qY4btW38s7BFcZoqtq
        u1DsZQuZJ2G5nha+5LuW8QQYYAkvC/JLIBbDNInFcg==
X-Google-Smtp-Source: ABdhPJxwU3X5NrZg5XDJgUXQnCleKcm1yCgswyQjrpLx62hGi4bKCMdqa2uEGum+WpUWT0czKZltvvZrt3/l9ey7kNE=
X-Received: by 2002:aa7:c359:: with SMTP id j25mr8360708edr.348.1634828705043;
 Thu, 21 Oct 2021 08:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211021063210.52503-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20211021063210.52503-1-u.kleine-koenig@pengutronix.de>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 21 Oct 2021 08:04:53 -0700
Message-ID: <CABXOdTc_VqKtrbwWAsmkAADd2zz8N2Kqk3OcRUmGpuDvVApZ=A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Chrome: Drop Enric Balletbo i Serra
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Benson Leung <bleung@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 11:32 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Sending a patch to the chrome people resulted in a message by
> Collabora's mailer daemon:
>
>         550 5.1.1 <enric.balletbo@collabora.com>: Recipient address rejec=
ted: User unknown in local recipient table (in reply to RCPT TO command)
>
> So remove Eric from all maintainer entries.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  MAINTAINERS | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d118d7957d2..b6ff67394b78 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4413,14 +4413,12 @@ F:      drivers/input/touchscreen/chipone_icn8505=
.c
>
>  CHROME HARDWARE PLATFORM SUPPORT
>  M:     Benson Leung <bleung@chromium.org>
> -M:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
>  S:     Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform=
/linux.git
>  F:     drivers/platform/chrome/
>
>  CHROMEOS EC CODEC DRIVER
>  M:     Cheng-Yi Chiang <cychiang@chromium.org>
> -R:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
>  R:     Guenter Roeck <groeck@chromium.org>
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
> @@ -4428,7 +4426,6 @@ F:        sound/soc/codecs/cros_ec_codec.*
>
>  CHROMEOS EC SUBDRIVERS
>  M:     Benson Leung <bleung@chromium.org>
> -M:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
>  R:     Guenter Roeck <groeck@chromium.org>
>  S:     Maintained
>  F:     drivers/power/supply/cros_usbpd-charger.c
> --
> 2.30.2
>
