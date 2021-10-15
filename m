Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A17F42E844
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 07:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhJOFLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 01:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbhJOFLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 01:11:05 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B5BC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 22:08:59 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id z40so7568675qko.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 22:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8L8tI7fdWPVyLQWYDtFqLlsNHHScmHBHQCVqZSRnUA=;
        b=eFZkvPChLYCKGXv27qtba5UyFdqjjqownlsjEdy+4EKngt/MVChZWaXXsNpPRqtNdZ
         Uzpw6KMUk5imyPD/9a0ErDBs/mUyNpju3rXqNtXZRRYZunGxPC8MaPaIdzfix/J//PYy
         ug/ORwkTSl/NfS/h6FrpYcrn9TBQUZvtNC9lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8L8tI7fdWPVyLQWYDtFqLlsNHHScmHBHQCVqZSRnUA=;
        b=BpKoAFucRAG6nRy/f/eWhLdEFnMcNMMqrs2mLpG+ZHvb9KjzJ54Z3pOBHX54MJzBZ/
         25GBDQ1WT1HTJ2OF8OFVAU+dwok8EpKrLVsMZqfJE/8gFDSd45Pwb+EzP4/2ycJqE+nB
         SGvYdf9DIPQtAXh75uEOG/N75T3KnXD4FIH8CNlmOYq13TCDswV+oVWq7PgEuVJHABO8
         YBh19tKP0TFEIS9Dd2+HJ043q8Zy3zmNgEYeQnmDSx28vSFxsLV7F50Q3CWl7R16XqtL
         mUqemZvhQ0o4Xe36e7H3UoixEogfC3Aesrtr78uCfCGlEU54wxnrfuXUzuuMfMIiBhpP
         tPXQ==
X-Gm-Message-State: AOAM530cgShzPYe5SqbM1YS8pQ7iU9qZhoRwlsmAkWsXJLZDohzHwXYr
        TNV5PToAfL/oHBtg0/IcNwBPdWDNHMqGSznXNCepdZBo
X-Google-Smtp-Source: ABdhPJzuAMBgm8X5B5WDZpgXeLp9fa14Q/T2EoOBrzxlSLdt7SSEQHnrVDk/B8pW7JurHxpiT6HH0sn98mY2EuNrha4=
X-Received: by 2002:a05:620a:4247:: with SMTP id w7mr8273900qko.381.1634274538886;
 Thu, 14 Oct 2021 22:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210920190031.22168-1-eajames@linux.ibm.com>
In-Reply-To: <20210920190031.22168-1-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 15 Oct 2021 05:08:47 +0000
Message-ID: <CACPK8XczD=4PXxRQrZ=aGCYtZk47i4-XoFVwep04qszf3Ls6jg@mail.gmail.com>
Subject: Re: [PATCH] fsi: sbefifo: Add sysfs file indicating a timeout error
To:     Eddie James <eajames@linux.ibm.com>,
        Amitay Isaacs <amitay@ozlabs.org>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sept 2021 at 19:00, Eddie James <eajames@linux.ibm.com> wrote:
>
> The SBEFIFO timeout error requires special handling in userspace
> to do recovery operations. Add a sysfs file to indicate a timeout
> error, and notify pollers when a timeout occurs.

Should this have some documentation too?

What userspace uses this?

Looks good to me otherwise.

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/fsi/fsi-sbefifo.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> index 84cb965bfed5..b414ab4431ef 100644
> --- a/drivers/fsi/fsi-sbefifo.c
> +++ b/drivers/fsi/fsi-sbefifo.c
> @@ -124,6 +124,7 @@ struct sbefifo {
>         bool                    broken;
>         bool                    dead;
>         bool                    async_ffdc;
> +       bool                    timed_out;
>  };
>
>  struct sbefifo_user {
> @@ -136,6 +137,14 @@ struct sbefifo_user {
>
>  static DEFINE_MUTEX(sbefifo_ffdc_mutex);
>
> +static ssize_t timeout_show(struct device *dev, struct device_attribute *attr,
> +                           char *buf)
> +{
> +       struct sbefifo *sbefifo = container_of(dev, struct sbefifo, dev);
> +
> +       return sysfs_emit(buf, "%d\n", sbefifo->timed_out ? 1 : 0);
> +}
> +static DEVICE_ATTR_RO(timeout);
>
>  static void __sbefifo_dump_ffdc(struct device *dev, const __be32 *ffdc,
>                                 size_t ffdc_sz, bool internal)
> @@ -462,11 +471,14 @@ static int sbefifo_wait(struct sbefifo *sbefifo, bool up,
>                         break;
>         }
>         if (!ready) {
> +               sysfs_notify(&sbefifo->dev.kobj, NULL, dev_attr_timeout.attr.name);
> +               sbefifo->timed_out = true;
>                 dev_err(dev, "%s FIFO Timeout ! status=%08x\n", up ? "UP" : "DOWN", sts);
>                 return -ETIMEDOUT;
>         }
>         dev_vdbg(dev, "End of wait status: %08x\n", sts);
>
> +       sbefifo->timed_out = false;
>         *status = sts;
>
>         return 0;
> @@ -993,6 +1005,8 @@ static int sbefifo_probe(struct device *dev)
>                                  child_name);
>         }
>
> +       device_create_file(&sbefifo->dev, &dev_attr_timeout);
> +
>         return 0;
>   err_free_minor:
>         fsi_free_minor(sbefifo->dev.devt);
> @@ -1018,6 +1032,8 @@ static int sbefifo_remove(struct device *dev)
>
>         dev_dbg(dev, "Removing sbefifo device...\n");
>
> +       device_remove_file(&sbefifo->dev, &dev_attr_timeout);
> +
>         mutex_lock(&sbefifo->lock);
>         sbefifo->dead = true;
>         mutex_unlock(&sbefifo->lock);
> --
> 2.27.0
>
