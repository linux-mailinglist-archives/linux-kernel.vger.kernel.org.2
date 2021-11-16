Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6E6452BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 08:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhKPHp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 02:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhKPHpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 02:45:23 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F4CC061746
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 23:42:26 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 131so54859648ybc.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 23:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/403usa2qPXJuWuTJ+2ECrIYe8wmx/A5m8sB3XJBUhg=;
        b=38f+p+5jAxF+2Vn+yPpQupSewmEGSxjj6L3/RdOKgo0oNXVuJ0uZi1G8xiafAwpS/Z
         1oWy9EmUM1zyWUhwf9bCI6A30hnMD3gTaFVOkz9dVDrZGOwjW8n8xzT6yWkaTnIuA3aG
         M2DKrjwobfTyTy9PiVNrDveoGydhZ0/eN+jxTu4P13dgtE7eTduKRh+BFS/d4eYQdYoQ
         Zqb3Um8V7St03k7NkNFYr4uKcMq+zqquDNEPNFOVbPQaGTbW7AWxBO/DSxgQq/pnNM1w
         5lcnVl1e9f2BTOmnnE4XODPv+jph41h4deNDM6JHxqoIMXqKiMIMxfG+A5/Rb3QM6tv0
         iiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/403usa2qPXJuWuTJ+2ECrIYe8wmx/A5m8sB3XJBUhg=;
        b=w/hXikmzW6lued0sDOEdyzr/MJJG+/KOa2WQg1fmUMVSwH4plPSyVrcW5GF/Cfulw8
         zY/nd4P/D6sCkkC4ttwPaSJRo5/fTACbHIxk6P6sZ+9HiUT6DwKm5f9i2luPOGhcQwwO
         erSuPh/zAGsysJVXKZ2rJn+XZNvUfHZhEMSfZA24DnHGIOE90dW7rQMNg6Q9+b74M12+
         aVRjScibY2fV9/mKMerkTlojDes9WOQXnB37UQ485O6AIxKlG16pRIg8wexzuRIJlqvq
         r+meHFBx0WWUoMqL8lQCf1Z1yIRGeDDPoeEFGW4IMXHJpqi71mzuB4nq3Lvauxn0VSYC
         xLNw==
X-Gm-Message-State: AOAM532KvLfZoXHHS4hanreTUREySRMcVj8fkwwN+gVODrwFUP/Ae4l7
        X3Lovgxtqa3SMcaIyYu3gaA/kP9T0RzuZv16d6zFEA==
X-Google-Smtp-Source: ABdhPJxKUgq418SOGaeoyAUz9+0oatLbKuctux+kxFuu+v+vwdpBLskKGam4yEE77+/ksz07h5j33q5EI4wchisgQkc=
X-Received: by 2002:a5b:b92:: with SMTP id l18mr6183244ybq.10.1637048545324;
 Mon, 15 Nov 2021 23:42:25 -0800 (PST)
MIME-Version: 1.0
References: <2a313cc6de53c492db10e29c6444d8e6f2529689.1636735696.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <2a313cc6de53c492db10e29c6444d8e6f2529689.1636735696.git.christophe.jaillet@wanadoo.fr>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Tue, 16 Nov 2021 09:42:11 +0200
Message-ID: <CAOtvUMcQONyqJ=MaprVLyDyc_z+5_HwCdjgaNVcOLMFV6i3FPA@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree - remove redundant 'flush_workqueue()' calls
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 6:49 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
>
> Remove the redundant 'flush_workqueue()' calls.
>
> This was generated with coccinelle:
>
> @@
> expression E;
> @@
> -       flush_workqueue(E);
>         destroy_workqueue(E);
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/crypto/ccree/cc_request_mgr.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/crypto/ccree/cc_request_mgr.c b/drivers/crypto/ccree=
/cc_request_mgr.c
> index 33fb27745d52..887162df50f9 100644
> --- a/drivers/crypto/ccree/cc_request_mgr.c
> +++ b/drivers/crypto/ccree/cc_request_mgr.c
> @@ -101,7 +101,6 @@ void cc_req_mgr_fini(struct cc_drvdata *drvdata)
>         dev_dbg(dev, "max_used_sw_slots=3D%d\n", req_mgr_h->max_used_sw_s=
lots);
>
>  #ifdef COMP_IN_WQ
> -       flush_workqueue(req_mgr_h->workq);
>         destroy_workqueue(req_mgr_h->workq);
>  #else
>         /* Kill tasklet */
> --
> 2.30.2
>

Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>

Thank you for finding ths.

Also, this triggers me to revisit why the workqueue code is there at
all. I think we don't actually use it, so double thanks.

Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
