Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11EB33478C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 20:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhCJTHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 14:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbhCJTHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:07:23 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D1BC061761
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 11:07:23 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id ba1so8968205plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 11:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mtUh+1sY9yiSBBmzwlwbQ9ceAe2QJiHtCFrNBHA9JkU=;
        b=dfzK2ZdoM7CRHVzNahJRTL2gabq/t2fh2XQNTX+IdHNBedVJ8pDkN/CB6se+t+8Zjk
         uysy1+ksydCkiArtdKAKpNdClx28I1GgcakoKLUInDbte1w8hK6je9FjyDwh8MeVLELl
         AHcGGmdIwZkE1POqdVWY02de/cMBL8oUtbya0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mtUh+1sY9yiSBBmzwlwbQ9ceAe2QJiHtCFrNBHA9JkU=;
        b=bikL9vrRyykR0mOkkSz2HsUPxCGdrLBu7Mdq2hvyv0S1u7nwu4M15lY6va1EvnHvPt
         YiMqTdUMaEJqMEvQbyG6Y6X+jrClBi2PcNgVgPcCCmC4EyYb0Oysp607n/TawfS+zXE3
         7MTJNyoFAjxSqIT7ucjWsRQHg4XjzOSo+ohwB1GoPt+ZtqNJ7dAdjD2jAbbbB2tgijUi
         gw53FpAmYs5DbAaz+q/nRgtXFwl2zQ+svV0jNQXf/3NYYOb2GbjySjhtyjgfc/xKHCU0
         kWf1NarUGr6UxCOQBQPy+O1PywyEHCghpdATHFQfM0QNrikVFaEtu4JMHrxsW5JFu62E
         7TSA==
X-Gm-Message-State: AOAM531HqjBhIWubC/RCFtoPMsUZwY01rBOwulnoemf9gdGMFKgTcyjX
        hkKZTtGYjpT7VKoa6ydYCHmk0asAyQaJ2g==
X-Google-Smtp-Source: ABdhPJxZ4NyurVBSdt6V1+osruyWQ7xqIYqDmUu36xzplEsA59nkcdEJpYMqs7xHkZIjNJl3hjvPfQ==
X-Received: by 2002:a17:902:76c7:b029:e6:508a:7b8d with SMTP id j7-20020a17090276c7b02900e6508a7b8dmr4273688plt.18.1615403243199;
        Wed, 10 Mar 2021 11:07:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q25sm241185pff.104.2021.03.10.11.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:07:22 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:07:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] scsi: mpt3sas: Replace one-element array with
 flexible-array in struct _MPI2_CONFIG_PAGE_IO_UNIT_3
Message-ID: <202103101058.16ED27BE3@keescook>
References: <20210202235118.GA314410@embeddedor>
 <20210308193237.GA212624@embeddedor>
 <88d9dda39a70df25b48e72247b9752d3dc5e2e8d.camel@linux.ibm.com>
 <20210308204129.GA214076@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308204129.GA214076@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 02:41:29PM -0600, Gustavo A. R. Silva wrote:
> On Mon, Mar 08, 2021 at 12:12:59PM -0800, James Bottomley wrote:
> > On Mon, 2021-03-08 at 13:32 -0600, Gustavo A. R. Silva wrote:
> > > Hi all,
> > > 
> > > Friendly ping: who can review/take this, please?
> > 
> > Well, before embarking on a huge dynamic update, let's ask Broadcom the
> > simpler question of why isn't MPI2_IO_UNIT_PAGE_3_GPIO_VAL_MAX simply
> > set to 36?  There's no dynamic allocation of anything in the current
> > code ... it's all hard coded to allocate 36 entries.  If there's no
> > need for anything dynamic then the kzalloc could become 
> 
> Yeah; and if that is the case, then there is no even need for kzalloc()
> at all, and it can be replaced by memset():
> 
> diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
> index 43a3bf8ff428..d00431f553e1 100644
> --- a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
> +++ b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
> @@ -992,7 +992,7 @@ typedef struct _MPI2_CONFIG_PAGE_IO_UNIT_1 {
>   *one and check the value returned for GPIOCount at runtime.
>   */
>  #ifndef MPI2_IO_UNIT_PAGE_3_GPIO_VAL_MAX
> -#define MPI2_IO_UNIT_PAGE_3_GPIO_VAL_MAX    (1)
> +#define MPI2_IO_UNIT_PAGE_3_GPIO_VAL_MAX    (36)
>  #endif
> 
>  typedef struct _MPI2_CONFIG_PAGE_IO_UNIT_3 {
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> index 44f9a05db94e..23fcf29bfd67 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
> @@ -3203,7 +3203,7 @@ BRM_status_show(struct device *cdev, struct device_attribute *attr,
>  {
>         struct Scsi_Host *shost = class_to_shost(cdev);
>         struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
> -       Mpi2IOUnitPage3_t *io_unit_pg3 = NULL;
> +       Mpi2IOUnitPage3_t io_unit_pg3;
>         Mpi2ConfigReply_t mpi_reply;
>         u16 backup_rail_monitor_status = 0;
>         u16 ioc_status;
> @@ -3221,16 +3221,10 @@ BRM_status_show(struct device *cdev, struct device_attribute *attr,
>                 goto out;
> 
>         /* allocate upto GPIOVal 36 entries */
> -       sz = offsetof(Mpi2IOUnitPage3_t, GPIOVal) + (sizeof(u16) * 36);
> -       io_unit_pg3 = kzalloc(sz, GFP_KERNEL);
> -       if (!io_unit_pg3) {
> -               rc = -ENOMEM;
> -               ioc_err(ioc, "%s: failed allocating memory for iounit_pg3: (%d) bytes\n",
> -                       __func__, sz);
> -               goto out;
> -       }
> +       sz = sizeof(io_unit_pg3);
> +       memset(&io_unit_pg3, 0, sz);

I like this a lot. It makes the code way simpler.

Putting this on the stack makes it faster, and it's less than 100 bytes,
which seems entirely reasonable.

> 
> -       if (mpt3sas_config_get_iounit_pg3(ioc, &mpi_reply, io_unit_pg3, sz) !=
> +       if (mpt3sas_config_get_iounit_pg3(ioc, &mpi_reply, &io_unit_pg3, sz) !=

The only thing I can imagine is if this ends up doing DMA, which isn't
allowed on the stack. However, in looking down through the call path,
it's _copied_ into DMA memory, so this appears entirely safe.
 
Can you send this as a "normal" patch? Feel free to include:

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

>             0) {
>                 ioc_err(ioc, "%s: failed reading iounit_pg3\n",
>                         __func__);
> @@ -3246,19 +3240,18 @@ BRM_status_show(struct device *cdev, struct device_attribute *attr,
>                 goto out;
>         }
> 
> -       if (io_unit_pg3->GPIOCount < 25) {
> -               ioc_err(ioc, "%s: iounit_pg3->GPIOCount less than 25 entries, detected (%d) entries\n",
> -                       __func__, io_unit_pg3->GPIOCount);
> +       if (io_unit_pg3.GPIOCount < 25) {
> +               ioc_err(ioc, "%s: iounit_pg3.GPIOCount less than 25 entries, detected (%d) entries\n",
> +                       __func__, io_unit_pg3.GPIOCount);
>                 rc = -EINVAL;
>                 goto out;
>         }
> 
>         /* BRM status is in bit zero of GPIOVal[24] */
> -       backup_rail_monitor_status = le16_to_cpu(io_unit_pg3->GPIOVal[24]);
> +       backup_rail_monitor_status = le16_to_cpu(io_unit_pg3.GPIOVal[24]);
>         rc = snprintf(buf, PAGE_SIZE, "%d\n", (backup_rail_monitor_status & 1));
> 
>   out:
> -       kfree(io_unit_pg3);
>         mutex_unlock(&ioc->pci_access_mutex);
>         return rc;
>  }
> 
> > 
> > 	io_unit_pg3 = kzalloc(sizeof(*io_unit_pg3), GFP_KERNEL);
> >
> 
> Thanks
> --
> Gustavo

-- 
Kees Cook
