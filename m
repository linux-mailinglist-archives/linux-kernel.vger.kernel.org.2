Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECE731173D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhBEXlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbhBEOUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:20:10 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0331CC061793
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:58:34 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id r20so5300161qtm.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fyZHi+qNcCJFhy3f12cLYE4u8DUIJvZ551G3y8KcPgQ=;
        b=oOcqz9sQcA4+vwEinnFCNUxLwxvmuqJZ3sHLgQdbD+TR9pIaAJUwFv21C5X0Ia9UW8
         zvkRXc6MmPy5rBPC2+afgNbSvfQTloAc2jr5muoRI8W1XoRnlB9So1j0zt6jn0Pn3Mhf
         ybioSruJQ+8ftb9fVvAoL/vi3KSLRTvpNUgf36UG7qlULBgyMNSg8KEMegLkMICCm8n7
         XSZW6DZ4MkWeT2Dfb8Xarkht2Bc6aM2ZjfdQAGRzsjvhqWmOmQz73EyBJiDwR0+y9lwu
         f1fIpGQ1PDqIl6VnaWRGNuv/OT1XPfR2TCqwRmH8Xg6HiwyyjTh8y6VO4bppBuXStePQ
         Feag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fyZHi+qNcCJFhy3f12cLYE4u8DUIJvZ551G3y8KcPgQ=;
        b=XiI9yWgRkXdGJI71e/tB/dGXjV3YSWyUOVJqcyO1T1eJ6uol0fOvhXVrSgYUUX1vvF
         h1ukDxkiUt+E66ysyeKqPKE5HSRFqhnUXWCrIw75JLDd6IGEdC8NzuHcx6mqsKxVvsW/
         1R+PcxO+BKFWIGyiaicPwAVFwnPfqhbOVZw77KhESaQFpIWCckxfP69sUU7aLJSGO5as
         azfLJBsf77lNywkhGwN8U3GvLrUWdDJD+4F4wXKHN1zSUXrW/VsD5rsSdMm+UydaAlBM
         Ho3CaOlGGISyAnRGpp+zkit/eJ0Q5Dex9adFOnv8Qff4ruvcIxfYCgD0e+vdLR5quiyw
         Yl5w==
X-Gm-Message-State: AOAM533ItUwZeIP1bubAhjgkxBezV85tDxikSW3y833P8/LmD4px3Aho
        fZspzU0CFoDOO2WJtWoT/DOBdDoeaN7TyQ==
X-Google-Smtp-Source: ABdhPJx+vXVYz+w8d1jPUuepDy67zXnbL7pNZG0nXJb8Lux9Rhopwszg/P5svbt7vQhYoPPshoMESg==
X-Received: by 2002:a05:620a:15d0:: with SMTP id o16mr5180121qkm.222.1612539120730;
        Fri, 05 Feb 2021 07:32:00 -0800 (PST)
Received: from ?IPv6:2601:5c0:c200:27c6:4172:c957:b7de:3481? ([2601:5c0:c200:27c6:4172:c957:b7de:3481])
        by smtp.gmail.com with ESMTPSA id q6sm9477022qkq.34.2021.02.05.07.31.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 07:32:00 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2] drm/qxl: do not run release if qxl failed to init
From:   Tong Zhang <ztong0001@gmail.com>
In-Reply-To: <20210205074330.zsb2lg5umgkxh2p3@sirius.home.kraxel.org>
Date:   Fri, 5 Feb 2021 10:31:58 -0500
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <BCB24CD0-FD0F-4202-AD93-02A7EDC229C9@gmail.com>
References: <20210204163050.1232756-1-ztong0001@gmail.com>
 <20210205074330.zsb2lg5umgkxh2p3@sirius.home.kraxel.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 5, 2021, at 2:43 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> On Thu, Feb 04, 2021 at 11:30:50AM -0500, Tong Zhang wrote:
>> if qxl_device_init() fail, drm device will not be registered,
>> in this case, do not run qxl_drm_release()
> 
> How do you trigger this?
> 

This can be triggered by changing the QXL VGA rom magic value.

In the QEMU source code ./hw/display/qxl.c
or change the QXL_ROM_MAGIC in spice header file

- Tong

> take care,
>  Gerd
> 

