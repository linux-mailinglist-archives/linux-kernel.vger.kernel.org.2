Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46078359528
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhDIGI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbhDIGI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:08:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29A6C061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 23:08:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u21so6763914ejo.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 23:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YKwXD8N1JHHBcf4wI9nAzA8eJamXKsw4F6yNcr3o4hA=;
        b=bVr769uTZK4fThAkfr8e8lrTPnJwtRsjFympwJ8co6ncLkEUZYYEQbvfhErkO2thlj
         98R+1RNbKeNAmbCfGEtUcd+QGKQKmkuRMKljSMlplhpx6hDxNKQrcbFdaMvSw//uZLyD
         AVAcWFP74H/hggcsU+yrFYmf1vdGFtvkkfm/ezhgS8MeSmRoCwdWshvXT7GcQo+efdFl
         MQssEnn/CgyPwvUsKSpNSFe+LZ3GKMyfgEpKD3AMPbyDkGjpmrvkyMVGCJfzdQp++3Tz
         RPAaAf2c9ie3MbXkS/4DDdu+53W7AG1PBYvktPQbtdYsR6RIpStb8V3e5RNxXT7ZF5X3
         Q2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YKwXD8N1JHHBcf4wI9nAzA8eJamXKsw4F6yNcr3o4hA=;
        b=l+GsxjgyHFgFsWfyrLXQau9yM7LUoqj5lrFr5fvGrZ6P49bA6MuB+dPD8XJg5Ov6Y/
         kI4anD/JyKzncTzbklIsknhAf5EK3wV5zgppM/SdQvz6O2EMSyUm3Bwxyi7kDdtNIvGd
         7MmIy33zN2vR9zGU/d3WjrR9nQ9ZYQB7UI09xm7LEe1mz6JKlaJqEjk5A+7I71LITVrf
         w3Pj7vK9H7QZiwssdH4e7nhe1/FMZUsodpkw5N5CnUIf4CEvWFRbtojf4AG/Dlj9kz61
         jrP1U7GhK90oSZa0ICbelsJ3+VFoI/SYZzg+jdhEFyC9G/3s5/QaA+pspFqh/2glv+T3
         Tx+Q==
X-Gm-Message-State: AOAM532DRUDwhsGh42Fl1JBz3NtlJ1MS2dumvqLFTh59I65htK5tMSnp
        tt1KW67xaowlgEpWChmGnqyLKF18LU9PdIPRwG9qnQ==
X-Google-Smtp-Source: ABdhPJwnkFmrR8dR4SnKVRk3onb9JUegkIADTZT7f1q0ZMFLoVRKdKDpcKYs/qyAxsXlZWagh/KGYdYuNR1vf9DfOdU=
X-Received: by 2002:a17:906:935a:: with SMTP id p26mr11084596ejw.521.1617948493461;
 Thu, 08 Apr 2021 23:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <1617886593-36421-1-git-send-email-luojiaxing@huawei.com> <1617886593-36421-3-git-send-email-luojiaxing@huawei.com>
In-Reply-To: <1617886593-36421-3-git-send-email-luojiaxing@huawei.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 9 Apr 2021 08:08:02 +0200
Message-ID: <CAMGffEkc-aYgLR_UWZGoT51hvHaAOG2T-9FK=1ttjWMKUaLJ_Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] scsi: pm8001: clean up for open brace
To:     Luo Jiaxing <luojiaxing@huawei.com>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 2:56 PM Luo Jiaxing <luojiaxing@huawei.com> wrote:
>
> There are few error about open brace is reported by checkpatch.pl:
>
> ERROR: that open brace { should be on the previous line
> +static struct error_fw flash_error_table[] =
> +{
>
> So fix them all.
>
> Signed-off-by: Jianqin Xie <xiejianqin@hisilicon.com>
> Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
looks good to me, thx!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_ctl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
> index 90b816f..8c253b0 100644
> --- a/drivers/scsi/pm8001/pm8001_ctl.c
> +++ b/drivers/scsi/pm8001/pm8001_ctl.c
> @@ -645,8 +645,7 @@ struct flash_command {
>       int     code;
>  };
>
> -static struct flash_command flash_command_table[] =
> -{
> +static const struct flash_command flash_command_table[] = {
>       {"set_nvmd",    FLASH_CMD_SET_NVMD},
>       {"update",      FLASH_CMD_UPDATE},
>       {"",            FLASH_CMD_NONE} /* Last entry should be NULL. */
> @@ -657,8 +656,7 @@ struct error_fw {
>       int     err_code;
>  };
>
> -static struct error_fw flash_error_table[] =
> -{
> +static const struct error_fw flash_error_table[] = {
>       {"Failed to open fw image file",  FAIL_OPEN_BIOS_FILE},
>       {"image header mismatch",         FLASH_UPDATE_HDR_ERR},
>       {"image offset mismatch",         FLASH_UPDATE_OFFSET_ERR},
> --
> 2.7.4
>
