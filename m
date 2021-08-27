Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089A43F97E2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 12:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244862AbhH0KOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 06:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244833AbhH0KO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 06:14:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A470C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 03:13:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 7so5267057pfl.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 03:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJ3GjTMJF6HHfcKOiMzQ4Gh4frNm5IluOSSXV4vzvdk=;
        b=P36An01IvyIMx5IOZhOjZ1ix5j85lsKQxIAI2wM+veAtK4DlrplbQADgs+Uul25IYp
         oPyXWQatnCCd2TenPCq5PXFDKi53/VxjtwJdy4Gv10U4PGg2qRG9e6bx//o7n1Rjc0QZ
         k2koh0wmmn7ZaL+UdtUun6sNoX7IneMQ9xduxPZwbv6wxVGUR9oUPtGr40FVcdZI0ZrJ
         s4+9bi/L3RN+dwHNm5PZqo/AqdrmYIMlODUMTGozDNcFhX5UoSGSDI9wtrXbO41WorQs
         94LUdoHpQKl6A9LnnUwMfQxc/LTbc+xIL9edNPQeOLVCISNGVhYMEkNv6Zv0WA836XFJ
         rwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJ3GjTMJF6HHfcKOiMzQ4Gh4frNm5IluOSSXV4vzvdk=;
        b=KqhBw7iAkZn8e91iBZ9JWjvPikC0GuDQ/3OwXr61RW8g4yq/FiledotnYdJ2kCh5ab
         98Of5Woi9QxZneCd8UtMMaECl1Lu6DCTSTgH5WM40BoSxXKAxuphcK9iA/kF1qp56cyD
         7vuj0h2Dgb2iMdxFB4E4DVox5rd3/EP6ooXP0Yp2tMfwO60Z10TchGrcYBtGV/QXcGo5
         +onrGfI4Vur4MeQXFFDKNjT+mWAiLMf0vBrRtGwvZzIVCMpiEEl03GJS/QILDuhFcQjv
         1Q/HQ/iVoPULWLxoYXHNY3Ot6BftSjp9R8ceRfX+xtdBOC5jmmnHpdEOSO/YzdboON75
         MqBQ==
X-Gm-Message-State: AOAM531D7LqfGkRQPg0fEwnTj8ZBSILNFhWMiqEdIsAat1JKU4OwLr5s
        4XIHs/WCAD33j6EFbgH7rwGuyjquizl3HJIGQu4Gvw==
X-Google-Smtp-Source: ABdhPJxSOkB9G7KoM+LMH5QcDLFKvG7lN42pVycT0E17tiw9DQtJPb3gF7CDe+tii1TgwGgzHRVVVCX0m/i1ZLGVHk8=
X-Received: by 2002:a62:5c6:0:b029:341:e0b1:a72c with SMTP id
 189-20020a6205c60000b0290341e0b1a72cmr8454901pff.71.1630059219627; Fri, 27
 Aug 2021 03:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210827100813.18610-1-fmdefrancesco@gmail.com>
In-Reply-To: <20210827100813.18610-1-fmdefrancesco@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Fri, 27 Aug 2021 11:13:28 +0100
Message-ID: <CAA=Fs0n+Xa5yeE+paeHQAWUZ8V280+tDojRm6KoKrVExJRbDWg@mail.gmail.com>
Subject: Re: [PATCH v3] staging: r8188eu: Provide a TODO file for this driver
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2021 at 11:08, Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> Provide a TODO file that lists the tasks that should be carried out in
> order to move this driver off drivers/staging.
>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>
> v2->v3: Added a task suggested by Dan Carpenter
> <dan.carpenter@oracle.com>.
> v1->v2: According to reviews by Fabio Aiuto <fabioaiuto83@gmail.com> and Greg K-H
>         <gregkh@linuxfoundation.org>, remove "[] is currently in development...",
>         indent and properly wrap the lines, remove the unnecessary last paragraph.
>
>  drivers/staging/r8188eu/TODO | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 drivers/staging/r8188eu/TODO
>
> diff --git a/drivers/staging/r8188eu/TODO b/drivers/staging/r8188eu/TODO
> new file mode 100644
> index 000000000000..98f918480990
> --- /dev/null
> +++ b/drivers/staging/r8188eu/TODO
> @@ -0,0 +1,13 @@
> +To-do list:
> +
> +* Correct the coding style according to Linux guidelines; please read the document
> +  at https://www.kernel.org/doc/html/latest/process/coding-style.html.
> +* Remove unnecessary debugging/printing macros; for those that are still needed
> +  use the proper kernel API (pr_debug(), dev_dbg(), netdev_dbg()).
> +* Remove dead code such as unusued functions, variables, fields, etc..
> +* Use in-kernel API and remove unnecessary wrappers where possible.
> +* Fix bugs due to code that sleeps in atomic context.
> +* Remove the HAL layer and migrate its functionality into the relevant parts of
> +  the driver.
> +* Switch to use LIB80211.
> +* Switch to use MAC80211.
> --
> 2.32.0
>

Looks good to me. Thanks.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
