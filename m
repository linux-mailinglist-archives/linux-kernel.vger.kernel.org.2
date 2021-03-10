Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23725334327
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhCJQfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhCJQfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:35:30 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9EBC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 08:35:30 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n22so7526394wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 08:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hpjSjtsTxLvJqlL//kdY1jDwuLy76fsmhvsuUd9J4S0=;
        b=QL9zSpshDLbUfH/cyRC60m9hHK4MBWIx2aCHt1v4F0/0z2ssUy5slouQ7R2a0t3doe
         rSejFOepBE+Ov4C0WW/A19UtXk7sVklJ2d37Y5EY4zdLk+RSFQivwjCAb17VQMzqXlXp
         dDo+ZUMNIOGvD/kJOZbW+9O7YWscISp3Y7WcQot329jQOonEjbMh8Tv76Honzctm5EEN
         fwx+Y08ueOb4Jci6VfJJmlhB37Dde3jLYWyxAkYDTX2s+A1P4J8wUjLEcIE3sMW+4LSK
         WQGLVPzdT7QnXIFYckzxyWww3V5UMSVFvpsOkeKHmxIVDEYQomqP7+XZPT8r9t0Vkf4Q
         Fm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hpjSjtsTxLvJqlL//kdY1jDwuLy76fsmhvsuUd9J4S0=;
        b=rzERSOakZbwkWOAS7KXsEKOcf4e4BDlnTgfBs1xNx3q5oSsvuCojs0Fh1mBf8DzyNQ
         xKynoO9ajX7XKfoMUXqWTn9JcOFlLPHi7OyDuYCtNHV3h7bXHTgG3J/OA1M1Vovv81Ym
         iyKIizSVBnDgdcZ5Rx8upKXPAARz8G2Alh2Bzl7VDpBgH8k4EoRO63r19o+T6j9hiur0
         fvK0WJWQ0Ai4bAbCqb8htT7ZyobwkR4zTgzeeNfJ8etv6eHAE60wdaweUi7yWQUrnOPd
         TSx+jzVHquf0YC99iwrqM9wwh/BMPkhsPOBJW7MZLJ4baw0FZ+H+J0MVgTQjNjb/ZK29
         GaSw==
X-Gm-Message-State: AOAM533c2NHM0e8y+9NsaFK4FdBpLkd3IfzsLkR6EGz8haAX0Xx8Bn+I
        1QlFJPJ4pgYBNr997lqMOs/HdQ==
X-Google-Smtp-Source: ABdhPJwCIH/OAKlnDRxH6PzJ+YRfZ9wcFs6IeNdsX88nG0yXi03Y5jASSedCz5hEzuAXb6A34ckthg==
X-Received: by 2002:a1c:c90c:: with SMTP id f12mr4257293wmb.98.1615394129187;
        Wed, 10 Mar 2021 08:35:29 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id n186sm58762wmn.22.2021.03.10.08.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 08:35:28 -0800 (PST)
Date:   Wed, 10 Mar 2021 16:35:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v4 0/4] Some improvement for Intel MAX 10 MFD drivers
Message-ID: <20210310163526.GR701493@dell>
References: <1615391748-1733-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1615391748-1733-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021, Xu Yilun wrote:

> This patchset is some improvements for intel-m10-bmc and its subdevs.
> 
> Main changes from v1:
> - Add a patch (#2) to simplify the definition of the legacy version reg.
> - Add a patch (#4), add entry in MAINTAINERS for intel-m10-bmc mfd driver
>   and the subdev drivers.
> 
> Main changes from v2:
> - Add Tom Rix as the reviewer for intel-m10-bmc mfd driver and the subdev
>   drivers.
> - Rebased to 5.12-rc1
> 
> Main changes from v3:
> - Improve the comments for valid version check.

Good enough.

All applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
