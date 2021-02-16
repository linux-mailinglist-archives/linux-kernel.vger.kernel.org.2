Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B47F31D104
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 20:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBPTen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 14:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBPTef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 14:34:35 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E40C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 11:33:55 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id b16so7589865otq.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 11:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kyTL9DcUkDn4o1XkAGL0trz+DnDzPw6zn/MWQREUxt0=;
        b=TPDkx9zR33Op7l3FJtwgRMuEMju1GkjtnnOwjuqYfNbgh6p+RQmNygrmiEHGfxJqZT
         aHQ6qU+z8osz9T0sLsCjkzCqW9Mu7pr5I5f0Igo2+7X0wvI3fqUOCSVc0ghBV8xop0Ii
         qmGZvQFEsUUaTHumaKjL1DPL38I97ObHToj1gOqE/FY92t94efAfSgIqKR+WDivO2IqO
         nRRbKeRWU1PVJ9eALZ6GKjYkBjwLbxOY9KIkm/8hJ8PLg/SqLUYnjB4YmD7cd4d+aB1y
         QYaDBFKPJrpZgW4g8jxqbZYlnyOncXXWrzvvLkHbc2h8SYlJQnrbUH9Bj1kdVL8UFAsQ
         I8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kyTL9DcUkDn4o1XkAGL0trz+DnDzPw6zn/MWQREUxt0=;
        b=QgA9pUP13l4MZ9PUfTvz0TF+8+eQLuGevre9IoB00VQ1BGH6fArDKUepyFZn6UcgYN
         8z5Y+1gcjiFOLI9DO2xs5PkGM9StHHcWfJpCKlycJWlPvjm9k65MPEm2GgYGirXQ1idr
         mN6kvcwO3b07E4KGQ8oR1n7thxA77Vi3IlxrkbFgZkD1BFLP72dL350kTDjAKmhNoxU+
         RnieWwaNU77PosG1zA1OKtlqZ7cdOI2fvzqDxh7zo6E9XvZoAqkwyZoMY9ODHPdzH/Oq
         OgQv/FG3Z1wAy/IhajetSVfP8EycQvslt8i6JC2KHLx/1O19rnfjGJZuo2McBdc7EAtK
         o6Zg==
X-Gm-Message-State: AOAM530+bInoUQJWLU5Yk1Gh1SmuSmK1mG0lRq8ctCd3wy8R1QQSpoMG
        rYw+LniMDkezFnnSxOreXEtDATBZvwn11N9t2ac=
X-Google-Smtp-Source: ABdhPJy6AYe/w3+O3bu+PVMYZzfvBd1envl/lZ6ytK6IW3zMqVYGCHu7+uPjHghFmRdODZbE9guOn/JQU2dQeYUqmHA=
X-Received: by 2002:a9d:77d6:: with SMTP id w22mr15885399otl.145.1613504034321;
 Tue, 16 Feb 2021 11:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20210216150828.3855810-1-gregkh@linuxfoundation.org>
In-Reply-To: <20210216150828.3855810-1-gregkh@linuxfoundation.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 16 Feb 2021 21:33:27 +0200
Message-ID: <CAFCwf11b5e8b4=07TxQvCAaYHjBujFrCobuM=keavE0UMQBR7w@mail.gmail.com>
Subject: Re: [PATCH] drivers: habanalabs: remove unused dentry pointer for
 debugfs files
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Tomer Tayar <ttayar@habana.ai>,
        Moti Haimovski <mhaimovski@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 5:08 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The dentry for the created debugfs file was being saved, but never used
> anywhere.  As the pointer isn't needed for anything, and the debugfs
> files are being properly removed by removing the parent directory,
> remove the saved pointer as well, saving a tiny bit of memory and logic.
>
> Cc: Oded Gabbay <ogabbay@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Tomer Tayar <ttayar@habana.ai>
> Cc: Moti Haimovski <mhaimovski@habana.ai>
> Cc: Omer Shpigelman <oshpigelman@habana.ai>
> Cc: Ofir Bitton <obitton@habana.ai>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/misc/habanalabs/common/debugfs.c    | 5 +----
>  drivers/misc/habanalabs/common/habanalabs.h | 2 --
>  2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
> index cef716643979..770b0131397d 100644
> --- a/drivers/misc/habanalabs/common/debugfs.c
> +++ b/drivers/misc/habanalabs/common/debugfs.c
> @@ -965,7 +965,6 @@ void hl_debugfs_add_device(struct hl_device *hdev)
>         struct hl_dbg_device_entry *dev_entry = &hdev->hl_debugfs;
>         int count = ARRAY_SIZE(hl_debugfs_list);
>         struct hl_debugfs_entry *entry;
> -       struct dentry *ent;
>         int i;
>
>         dev_entry->hdev = hdev;
> @@ -1072,13 +1071,11 @@ void hl_debugfs_add_device(struct hl_device *hdev)
>                                 &hl_stop_on_err_fops);
>
>         for (i = 0, entry = dev_entry->entry_arr ; i < count ; i++, entry++) {
> -
> -               ent = debugfs_create_file(hl_debugfs_list[i].name,
> +               debugfs_create_file(hl_debugfs_list[i].name,
>                                         0444,
>                                         dev_entry->root,
>                                         entry,
>                                         &hl_debugfs_fops);
> -               entry->dent = ent;
>                 entry->info_ent = &hl_debugfs_list[i];
>                 entry->dev_entry = dev_entry;
>         }
> diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
> index 60e16dc4bcac..48937e9eed83 100644
> --- a/drivers/misc/habanalabs/common/habanalabs.h
> +++ b/drivers/misc/habanalabs/common/habanalabs.h
> @@ -1393,12 +1393,10 @@ struct hl_info_list {
>
>  /**
>   * struct hl_debugfs_entry - debugfs dentry wrapper.
> - * @dent: base debugfs entry structure.
>   * @info_ent: dentry realted ops.
>   * @dev_entry: ASIC specific debugfs manager.
>   */
>  struct hl_debugfs_entry {
> -       struct dentry                   *dent;
>         const struct hl_info_list       *info_ent;
>         struct hl_dbg_device_entry      *dev_entry;
>  };
> --
> 2.30.1
>

This patch is:
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>

Thanks,
Oded
