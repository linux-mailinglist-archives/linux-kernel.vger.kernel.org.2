Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2773A23CC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 07:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFJFWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 01:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJFWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 01:22:06 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19776C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 22:20:11 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id d196so21025699qkg.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 22:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RMv/inGF5mZwHd9fpItN4+o8PIOc1E96HiChzX2Nyn0=;
        b=CzyJOuVHLRIK0wvN44LBiE2401fffi6c7bgTy3PHVmuIADwCLuE5KDktrBn/AxCBX/
         NnnuuIr0MiKQUaJuxfA6yQKntggWqg5+wwdT+61ZaKBLM6tlJP+bNA+K25Of84rOGemj
         08omiXkgCjZEWekF9THrqEuiHnQIOfzpc7oS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RMv/inGF5mZwHd9fpItN4+o8PIOc1E96HiChzX2Nyn0=;
        b=R13dHVTj6hMPkL2hxvCdEhfmYTIrqJzIvaks+4ISvWS1LnsGp1cmdz+Gst1yQKZsbZ
         CmWt1RTCj127LT/U0epUGGhJoaMV9eSyFqTN4BvUHHsUgiV4GzcqOt86Gb2LOU9tISx9
         g5ydwS5Qi5w69PcdMKfiILm9yRnR7t8mFV+VJN170nJplCEAAjIpoPijGbqjJ71QjNFm
         kTiyccglZM2fQTSoYq/aHI9DKB/V7XNyYizuVuRmd9wNd4IEG9B2xywAhfHX2r2drx+t
         PrSI+eluJ0mcj5yY1EBW9RWTyN69rsqzAm3+Jlv2OMvznqKlUfmYVGKgoWGpLXqSEFs+
         9JVw==
X-Gm-Message-State: AOAM532oVvbreSUcfpmGYvT/8OKhnK3Uinq8bNovLA/0DmaKpmm7JH9e
        hz57eT2FdsUfHZRczmEmgcZQFfAWIS8DkTmGCnY=
X-Google-Smtp-Source: ABdhPJx8wTJMKGo6/PzF4m60kslZ+RDHn9ESeIREeh+SDHyD5IqbbINExtS6E092jSxRwjfqSnAPT6ZsyUVMx+36Jng=
X-Received: by 2002:a37:b404:: with SMTP id d4mr3074521qkf.465.1623302410093;
 Wed, 09 Jun 2021 22:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <CACPK8XencP__O6v28e+v0PD8wOTpfRRu_oyV-rin0tA64kdP7A@mail.gmail.com>
In-Reply-To: <CACPK8XencP__O6v28e+v0PD8wOTpfRRu_oyV-rin0tA64kdP7A@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 10 Jun 2021 05:19:57 +0000
Message-ID: <CACPK8Xd8QoG1+tNZzY2NsYB-14-dbp8t5XEgd=T7cdt=mjZYug@mail.gmail.com>
Subject: Re: [GIT PULL] fsi changes for v5.14
To:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Jeffery <andrewrjeffery@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 at 05:01, Joel Stanley <joel@jms.id.au> wrote:
>
> Hello Greg,
>
> Here are some FSI changes that I'd like you to take through the driver
> tree for v5.14.

I should have mentioned that there are two hwmon patches included in
this series. Guneter has acked them and said that he expected them to
go through the FSI tree.

Guneter, that was a little while back. Let me know if you have any objections.

Cheers,

Joel

>
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
>
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-v5.14
>
> for you to fetch changes up to 9ab1428dfe2c66b51e0b41337cd0164da0ab6080:
>
>   fsi/sbefifo: Fix reset timeout (2021-06-04 16:06:57 +0930)
>
> ----------------------------------------------------------------
> FSI changes for v5.14
>
>  - Bug fixes for the OCC, SCOM and SBEFIFO drivers
>
>  - Performance fix for aspeed fsi master
>
>  - Small fixes from the mailing lists
>
> ----------------------------------------------------------------
> Colin Ian King (1):
>       fsi: core: Fix return of error values on failures
>
> Eddie James (6):
>       fsi: scom: Reset the FSI2PIB engine for any error
>       fsi: occ: Don't accept response from un-initialized OCC
>       fsi: occ: Log error for checksum failure
>       hwmon: (occ) Start sequence number at one
>       hwmon: (occ) Print response status in first poll error message
>       fsi: Aspeed: Reduce poll timeout
>
> Joachim Fenkes (2):
>       fsi/sbefifo: Clean up correct FIFO when receiving reset request from SBE
>       fsi/sbefifo: Fix reset timeout
>
> Joel Stanley (2):
>       fsi: aspeed: Emit fewer barriers in opb operations
>       fsi: scom: Remove retries
>
> Yangtao Li (1):
>       fsi: aspeed: convert to devm_platform_ioremap_resource
>
> Zhen Lei (1):
>       fsi: master-ast-cf: Remove redundant error printing in
> fsi_master_acf_probe()
>
> Zou Wei (1):
>       fsi: Add missing MODULE_DEVICE_TABLE
>
>  drivers/fsi/fsi-core.c          |   4 +-
>  drivers/fsi/fsi-master-aspeed.c |  33 ++++++++-----
>  drivers/fsi/fsi-master-ast-cf.c |   2 +-
>  drivers/fsi/fsi-master-gpio.c   |   1 +
>  drivers/fsi/fsi-occ.c           |  12 +++--
>  drivers/fsi/fsi-sbefifo.c       |  10 ++--
>  drivers/fsi/fsi-scom.c          | 105 +++++++++++++++-------------------------
>  drivers/hwmon/occ/common.c      |   7 ++-
>  8 files changed, 82 insertions(+), 92 deletions(-)
