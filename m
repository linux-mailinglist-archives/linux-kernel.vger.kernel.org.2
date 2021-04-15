Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6082360977
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 14:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhDOMdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 08:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbhDOMdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:33:40 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E7AC061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 05:33:16 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id u22so1100683vsu.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 05:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cn61o3l+cQhuqA8gP7u3apjojEDo5OUcEov4kpx8ITg=;
        b=aFLAzVsGTqdAyT89VvUVPZMDzJ2TWCVoxlBxLbWtJLNY091tzshEX80XxYWSKVAgrh
         lGqNFLzcv2Gi1yEHbNedzyXs3TLXnOh+28JTUTqROTeVNytVZirmo16oFzXh8sTyHUUZ
         0wx75rkVYb0ygzgej5zNHRbo4x9Fuh2uziUVMroDwnYsW7u+TNy9zLpOMp4AUqIc0gCO
         97iwKJvtGqJZahDVUtsH8UK7MbhiRyBq04m6ovQcA7gcse5xEe3UxNKogCMelcyxq8N1
         XcV38Y9/yANrf07XhXxYxTtgBC0+G+RoXlFDSaTfOkBDBlW/qV8z95YMBLaKhVegppPH
         JXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cn61o3l+cQhuqA8gP7u3apjojEDo5OUcEov4kpx8ITg=;
        b=KQsH3bOULQ2NidiXSkkCwZDW5NBvqiiS4qYajmvV8fatVgYqESWAZnnySnQRveLf6Z
         PQg3fT4AKU4cvtvOUJ9YcLLZa1lPryxtYqgp8eee1dtzxEsHUX0c6nIzwPCFKixpIFmL
         sFufCxGTa6j0htQSzJSBzcEoKTlTkXT25DI8XAIL9cKaVCVD29Fd0aNACqRNVFGHg+ds
         uFl24/PsRT+Q77/giXjxXWWX4UTy8iVg/QGsywCMspp4V/M7qvX7oZ47J2opd9LbVE8X
         B67sYqVEBVcmDmbgFFkCNaSf/3mwgQzXAp64FBlxhtJ30CZFV/SjDDnX9iwQQ7iVr+TO
         NFzg==
X-Gm-Message-State: AOAM530wp17Lroek0gaZ7LmSAfLtLXQNDc/VFfxKt1nyEXNkJPzDnvwm
        qGnivAYgPm5GpBZX7UG+xL1bVkx3dIK4ke/UccJ6PA==
X-Google-Smtp-Source: ABdhPJyukeR2yBo7fgb1puieSQLzNGAskdjLyUz7e3Da1oSPXpu3mc9ujLE8b6uhI4Psx+RP3cDkJRevTtrSdprzwSU=
X-Received: by 2002:a67:cf41:: with SMTP id f1mr1879671vsm.42.1618489995214;
 Thu, 15 Apr 2021 05:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210401230221.12532-1-luserhker@gmail.com>
In-Reply-To: <20210401230221.12532-1-luserhker@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Apr 2021 14:32:38 +0200
Message-ID: <CAPDyKFpjTikAzDqkcbyxa1Y918OevojZYhREPsmQgeo_Sd0xgA@mail.gmail.com>
Subject: Re: [PATCH v3] Re-submit of the erase command addition plus removal
 of MMC_IOC_MULTI_CMD ifndef for erase. Author=Kimito Sakata <kimito.sakata@oracle.com>
To:     luserhker@gmail.com, Avri Altman <avri.altman@wdc.com>
Cc:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        kenny.gibbons@oracle.com, kimito.sakata@oracle.com,
        rkamdar@micron.com, linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kimito Sakata <ksakata@kimitos-mbp.hsd1.co.comcast.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Avri

On Fri, 2 Apr 2021 at 01:02, <luserhker@gmail.com> wrote:
>
> From: Kimito Sakata <kimito.sakata@oracle.com>
>
> Signed-off-by: Kimito Sakata <ksakata@Kimitos-MBP.hsd1.co.comcast.net>

This looks okay to me, but I have looped in Avri who might have some comments.

Kind regards
Uffe

> ---
>  mmc.c      |   8 ++++
>  mmc.h      |  13 +++++-
>  mmc_cmds.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |   1 +
>  4 files changed, 150 insertions(+), 1 deletion(-)
>
> diff --git a/mmc.c b/mmc.c
> index f3d724b..eb2638b 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -229,6 +229,14 @@ static struct Command commands[] = {
>                 "Run Field Firmware Update with <image name> on <device>.\n",
>           NULL
>         },
> +       { do_erase, -4,
> +       "erase", "<type> " "<start address> " "<end address> " "<device>\n"
> +               "Send Erase CMD38 with specific argument to the <device>\n\n"
> +               "NOTE!: This will delete all user data in the specified region of the device\n"
> +               "<type> must be: legacy | discard | secure-erase | "
> +               "secure-trim1 | secure-trim2 | trim \n",
> +       NULL
> +       },
>         { 0, 0, 0, 0 }
>  };
>
> diff --git a/mmc.h b/mmc.h
> index 5754a9d..e9766d7 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -35,7 +35,15 @@
>  #define MMC_SET_WRITE_PROT     28    /* ac   [31:0] data addr   R1b */
>  #define MMC_CLEAR_WRITE_PROT   29    /* ac   [31:0] data addr   R1b */
>  #define MMC_SEND_WRITE_PROT_TYPE 31   /* ac   [31:0] data addr   R1  */
> -
> +#define MMC_ERASE_GROUP_START  35    /* ac   [31:0] data addr   R1  */
> +#define MMC_ERASE_GROUP_END    36    /* ac   [31:0] data addr   R1  */
> +#define MMC_ERASE              38    /* ac   [31] Secure request
> +                                             [30:16] set to 0
> +                                             [15] Force Garbage Collect request
> +                                             [14:2] set to 0
> +                                             [1] Discard Enable
> +                                             [0] Identify Write Blocks for
> +                                             Erase (or TRIM Enable)  R1b */
>  /*
>   * EXT_CSD fields
>   */
> @@ -62,6 +70,7 @@
>  #define EXT_CSD_CACHE_SIZE_2           251
>  #define EXT_CSD_CACHE_SIZE_1           250
>  #define EXT_CSD_CACHE_SIZE_0           249
> +#define EXT_CSD_SEC_FEATURE_SUPPORT    231
>  #define EXT_CSD_BOOT_INFO              228     /* R/W */
>  #define EXT_CSD_HC_ERASE_GRP_SIZE      224
>  #define EXT_CSD_HC_WP_GRP_SIZE         221
> @@ -190,6 +199,8 @@
>  #define EXT_CSD_REV_V4_2               2
>  #define EXT_CSD_REV_V4_1               1
>  #define EXT_CSD_REV_V4_0               0
> +#define EXT_CSD_SEC_GB_CL_EN           (1<<4)
> +#define EXT_CSD_SEC_ER_EN              (1<<0)
>
>
>  /* From kernel linux/mmc/core.h */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 6c24cea..3e36ff2 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2514,6 +2514,135 @@ int do_cache_dis(int nargs, char **argv)
>         return do_cache_ctrl(0, nargs, argv);
>  }
>
> +static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
> +{
> +       int ret = 0;
> +       struct mmc_ioc_multi_cmd *multi_cmd;
> +
> +       multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> +                          3 * sizeof(struct mmc_ioc_cmd));
> +       if (!multi_cmd) {
> +               perror("Failed to allocate memory");
> +               return -ENOMEM;
> +       }
> +
> +       multi_cmd->num_of_cmds = 3;
> +       /* Set erase start address */
> +       multi_cmd->cmds[0].opcode = MMC_ERASE_GROUP_START;
> +       multi_cmd->cmds[0].arg = start;
> +       multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> +       multi_cmd->cmds[0].write_flag = 1;
> +
> +       /* Set erase end address */
> +       multi_cmd->cmds[1].opcode = MMC_ERASE_GROUP_END;
> +       multi_cmd->cmds[1].arg = end;
> +       multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> +       multi_cmd->cmds[1].write_flag = 1;
> +
> +       /* Send Erase Command */
> +       multi_cmd->cmds[2].opcode = MMC_ERASE;
> +       multi_cmd->cmds[2].arg = argin;
> +       multi_cmd->cmds[2].cmd_timeout_ms = 300*255*255;
> +       multi_cmd->cmds[2].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> +       multi_cmd->cmds[2].write_flag = 1;
> +
> +       /* send erase cmd with multi-cmd */
> +       ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> +       if (ret)
> +               perror("Erase multi-cmd ioctl");
> +
> +       free(multi_cmd);
> +       return ret;
> +}
> +
> +int do_erase(int nargs, char **argv)
> +{
> +       int dev_fd, ret;
> +       char *print_str;
> +       char **eptr = NULL;
> +       __u8 ext_csd[512], checkup_mask = 0;
> +       __u32 arg, start, end;
> +
> +       if (nargs != 5) {
> +               fprintf(stderr, "Usage: erase <type> <start addr> <end addr> </path/to/mmcblkX>\n");
> +               exit(1);
> +       }
> +
> +       if (strstr(argv[2], "0x") || strstr(argv[2], "0X"))
> +               start = strtol(argv[2], eptr, 16);
> +       else
> +               start = strtol(argv[2], eptr, 10);
> +
> +       if (strstr(argv[3], "0x") || strstr(argv[3], "0X"))
> +               end = strtol(argv[3], eptr, 16);
> +       else
> +               end = strtol(argv[3], eptr, 10);
> +
> +       if (end < start) {
> +               fprintf(stderr, "erase start [0x%08x] > erase end [0x%08x]\n",
> +                       start, end);
> +               exit(1);
> +       }
> +
> +       if (strcmp(argv[1], "legacy") == 0) {
> +               arg = 0x00000000;
> +               print_str = "Legacy Erase";
> +       } else if (strcmp(argv[1], "discard") == 0) {
> +               arg = 0x00000003;
> +               print_str = "Discard";
> +       } else if (strcmp(argv[1], "secure-erase") == 0) {
> +               print_str = "Secure Erase";
> +               checkup_mask = EXT_CSD_SEC_ER_EN;
> +               arg = 0x80000000;
> +       } else if (strcmp(argv[1], "secure-trim1") == 0) {
> +               print_str = "Secure Trim Step 1";
> +               checkup_mask = EXT_CSD_SEC_ER_EN | EXT_CSD_SEC_GB_CL_EN;
> +               arg = 0x80000001;
> +       } else if (strcmp(argv[1], "secure-trim2") == 0) {
> +               print_str = "Secure Trim Step 2";
> +               checkup_mask = EXT_CSD_SEC_ER_EN | EXT_CSD_SEC_GB_CL_EN;
> +               arg = 0x80008000;
> +       } else if (strcmp(argv[1], "trim") == 0) {
> +               print_str = "Trim";
> +               checkup_mask = EXT_CSD_SEC_GB_CL_EN;
> +               arg = 0x00000001;
> +       } else {
> +               fprintf(stderr, "Unknown erase type: %s\n", argv[1]);
> +               exit(1);
> +       }
> +
> +       dev_fd = open(argv[4], O_RDWR);
> +       if (dev_fd < 0) {
> +               perror(argv[4]);
> +               exit(1);
> +       }
> +
> +       if (checkup_mask) {
> +               ret = read_extcsd(dev_fd, ext_csd);
> +               if (ret) {
> +                       fprintf(stderr, "Could not read EXT_CSD from %s\n",
> +                               argv[4]);
> +                       goto out;
> +               }
> +               if ((checkup_mask & ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT]) !=
> +                                                               checkup_mask) {
> +                       fprintf(stderr, "%s is not supported in %s\n",
> +                               print_str, argv[4]);
> +                       ret = -ENOTSUP;
> +                       goto out;
> +               }
> +
> +       }
> +       printf("Executing %s from 0x%08x to 0x%08x\n", print_str, start, end);
> +
> +       ret = erase(dev_fd, arg, start, end);
> +out:
> +       printf(" %s %s!\n\n", print_str, ret ? "Failed" : "Succeed");
> +       close(dev_fd);
> +       return ret;
> +}
> +
> +
>  int do_ffu(int nargs, char **argv)
>  {
>  #ifndef MMC_IOC_MULTI_CMD
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 9d3246c..8331ab2 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -45,3 +45,4 @@ int do_ffu(int nargs, char **argv);
>  int do_read_scr(int argc, char **argv);
>  int do_read_cid(int argc, char **argv);
>  int do_read_csd(int argc, char **argv);
> +int do_erase(int nargs, char **argv);
> --
> 2.24.1 (Apple Git-126)
>
