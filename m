Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7490E3FE8B8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 07:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhIBFdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 01:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhIBFdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 01:33:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AACC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 22:32:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u3so1534287ejz.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 22:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8zwGb32jFXjCTTE1DLnmCCv3fIxegxghKmjAnTUaGrU=;
        b=RS19rQ3k1Oo6pxKXgESwj7SfQiQeAghwOQof8XbrKhwNE9r6QeFgGT2il12wSmfJo9
         8RLJ69QqKwMCfmgCe8M/wbbEBhqhxk27tSTA860KNjxs6Dep+LCz50EZWWyTtRkLnpaG
         HHNtk7tVj3z6KzRxoS7eJZOEmrrHFm2T8M6OdF6HLsxQ448iDnbZYKDRE+L45pgmMAX0
         wL3zbL9IzEe6T8KByoXsf2bthQqrzfNltsaTJ4qpvLruEzOxx1hVvxgobQpTwfTh760c
         2yOZCMqZm9faW+ZRKR1n4FoFQ5PHujT5YaYWgeapBWM6PozMUvM8nG4mCK28njnF3mZP
         maHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8zwGb32jFXjCTTE1DLnmCCv3fIxegxghKmjAnTUaGrU=;
        b=lCJouDWwV7wE7Fw6nKqugyy6disqcM27mQn9ft6qxMVeLEkhv6Gy2/t6x7die92efN
         WQ8uIg3SicYTDQ7JqkMEbmMsao8lbZk06mxg8SvTloa/VbLy+i3fdUVySnB6ZuoVDo6n
         mLa7y42Iu0sl7HGfovfCF3+RnepqeaxRFP4uoYbVIblr99e7fYMCcpCGqPmpMYoV6guM
         OeMwKpXBCizIxeRX7HElmEb0y+uz2HzduM8pAwEScx0O9+Pzq+YBLGUELR33bCsULb1B
         KHy7nSwHAs2tH2eVvSvvf5jI/LPhfcxQRE7lRgDXryMHb0CufOHDSJFuzsm0Caee5tMZ
         ChSQ==
X-Gm-Message-State: AOAM532S3Ffxr4GJHirCB4iWupk6Rjlu7nelWo0ldTAvVGRxeqkHpi2P
        bC3jaKd4eh4BSFsYVANhXfVFLpB6E3KP43cu3nhrUw==
X-Google-Smtp-Source: ABdhPJxZFwC5NbWhR92zcxWHUA7yiRr/hOydqIOl9pEkJvL3G+5pMpY3cQSKaW1W2ZY+RQK9Gl5bBm6LDK3c2kx9+28=
X-Received: by 2002:a17:907:6297:: with SMTP id nd23mr1740993ejc.62.1630560774884;
 Wed, 01 Sep 2021 22:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210901210028.1750956-1-mcgrof@kernel.org> <20210901210028.1750956-6-mcgrof@kernel.org>
In-Reply-To: <20210901210028.1750956-6-mcgrof@kernel.org>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 2 Sep 2021 07:32:44 +0200
Message-ID: <CAMGffE=+jnKpO-ZGqW5JQnUbdH+NjQHgq7_f4XoEem2itHhe9Q@mail.gmail.com>
Subject: Re: [PATCH 05/10] rnbd: add error handling support for add_disk()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        benh@kernel.crashing.org, paulus@samba.org, jim@jtan.com,
        Haris Iqbal <haris.iqbal@ionos.com>, josh.h.morris@us.ibm.com,
        pjk1939@linux.ibm.com, Tim Waugh <tim@cyberelk.net>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-block <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 11:01 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
looks good to me.
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index bd4a41afbbfc..1ba1c868535a 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1384,8 +1384,10 @@ static void setup_request_queue(struct rnbd_clt_dev *dev)
>         blk_queue_write_cache(dev->queue, dev->wc, dev->fua);
>  }
>
> -static void rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
> +static int rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
>  {
> +       int err;
> +
>         dev->gd->major          = rnbd_client_major;
>         dev->gd->first_minor    = idx << RNBD_PART_BITS;
>         dev->gd->minors         = 1 << RNBD_PART_BITS;
> @@ -1410,7 +1412,11 @@ static void rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
>
>         if (!dev->rotational)
>                 blk_queue_flag_set(QUEUE_FLAG_NONROT, dev->queue);
> -       add_disk(dev->gd);
> +       err = add_disk(dev->gd);
> +       if (err)
> +               blk_cleanup_disk(dev->gd);
> +
> +       return err;
>  }
>
>  static int rnbd_client_setup_device(struct rnbd_clt_dev *dev)
> @@ -1426,8 +1432,7 @@ static int rnbd_client_setup_device(struct rnbd_clt_dev *dev)
>         rnbd_init_mq_hw_queues(dev);
>
>         setup_request_queue(dev);
> -       rnbd_clt_setup_gen_disk(dev, idx);
> -       return 0;
> +       return rnbd_clt_setup_gen_disk(dev, idx);
>  }
>
>  static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
> --
> 2.30.2
>
