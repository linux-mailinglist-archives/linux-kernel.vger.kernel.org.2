Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEA33C7659
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 20:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhGMSUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 14:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhGMSUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 14:20:17 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9BEC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 11:17:27 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t143so10399849oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFrqYhL05Vy05BtALwYpKWHwESItGNqrbz0D2wIZh/8=;
        b=XKet3qSvQzAW0CYQ3Mv8rPqZlV08oQkiC38RlWJHjAry3NDC8WoR8OMxyNlLndBKPU
         xEjG+MGOcde5tFKKGogCbkauPLTs6mnu5TbBwREyudcUzQIPotLM/s4yXFA8zm12b925
         0Q1WZYEgez1rxHz/7dcdE+zcnI5+JeUIYW4KN+d+1eBm9O/IrxeywcZBpCh5VQqmu4XV
         ub3oPEnNTFh/9GeKUkZr/c0i2L0X91uyimpnC/eFyYarU/x81XtWFXyxQGIxZtUVFmy3
         Mjkky6SkypdJbOusvor35ECe2A8k8N9OnN77L6AvHKew0jXKyHPylSeF4WYOkLpGGbxc
         BRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFrqYhL05Vy05BtALwYpKWHwESItGNqrbz0D2wIZh/8=;
        b=Gc7uLkwT1ferFW7cUfZzBDlen2E6MISn2eNC+d1IFX8p2JwBbvH2DP54S/z254ITko
         X4XYmjprV55MUjkyN568G3/5ie3JlqOv1fUSYMahXNUqiXqh5QGpw0PDKhrDORcf9awi
         BObpF8Z4l+KDJ6q2uZ71GyGWw5VQr17Jzw4u15F+sqKKKzUT/2Gh/ODPRNiWkjhkmrfP
         CE2zEFTjP52MYKewxtEYowUByqtYuywYz2U12VJ/+MR7BCcQm314rvkx9ayRC9Nx3JUo
         ugEbFDaKX5dDn4Vn32UXNfmQ00n2bF178qAf3hgg8Q2EOG9X2Yku0bk5u16VskGlTYZJ
         z0aA==
X-Gm-Message-State: AOAM532au/gZL2l04EUMMbNB9lULuyBrHCk/EX7aQAf16c9vdx7EAD4z
        Mf8t6l5fwmGTPQ+rseXeqqKc/SolWRBSpBhScQ05Dw==
X-Google-Smtp-Source: ABdhPJw/miWyaTCWv3dN7r5q8Ey8ctzHNqRBDij00bssaHzcW39TXaUcVynU8RTvsMsQNppRYTOJcl9FNFhtX5yRSR8=
X-Received: by 2002:aca:4dc6:: with SMTP id a189mr4077592oib.166.1626200245878;
 Tue, 13 Jul 2021 11:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210713093438.3173-1-peter.ujfalusi@linux.intel.com>
In-Reply-To: <20210713093438.3173-1-peter.ujfalusi@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 13 Jul 2021 11:17:15 -0700
Message-ID: <CAPcyv4ipa7LBA6ewTqot4nxdKdFNTswQT9pkNKydv9ChQ2Hcpw@mail.gmail.com>
Subject: Re: [PATCH] driver core: auxiliary bus: Fix memory leak when
 driver_register() fail
To:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David M Ertman <david.m.ertman@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 2:34 AM Peter Ujfalusi
<peter.ujfalusi@linux.intel.com> wrote:
>
> If driver_register() returns with error we need to free the memory
> allocated for auxdrv->driver.name before returning from
> __auxiliary_driver_register()
>
> Fixes: 7de3697e9cbd4 ("Add auxiliary bus support")
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Good catch,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
