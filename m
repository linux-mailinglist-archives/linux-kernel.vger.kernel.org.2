Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F5942DBDC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhJNOjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 10:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhJNOjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:39:11 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CDDC061570;
        Thu, 14 Oct 2021 07:37:06 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id k3so3762628ilu.2;
        Thu, 14 Oct 2021 07:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6TILiM3jzDjbrj3vsrVLxeVOCIYLc6j8cTUj5GZITRA=;
        b=HILhJGvMsvMb+FcdhJNze2EnyOJDnn1FjmHxk7rIOuj/QEE6gSglc8WiYjvFk2yCFk
         sjj7/dzn3DwgLgE1zDI8oJHUu090U40zwpD59iLQCv+1Gv/qYgOwQqG5O1WN+6Rc2+bo
         tmyNvDVx1V9Cu1gpM5svD7GQAt2JIdTLRxrxetJMZ48qjBpBvb2XGC+yPMpUKcn8OfUY
         8pgVHkMrYS3yUUxQ7fJODgpVYmaXZaQ9MclO3zsiZ8eJubKs8f3TiaWaZjQMZ9aMm2Sn
         trSmH5h1PJTCl0aQyt/Ld9G/DmABRx5/dAnwPZhgmNiGLUBIcPPXojj5SlyNvHasX09m
         agZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TILiM3jzDjbrj3vsrVLxeVOCIYLc6j8cTUj5GZITRA=;
        b=sqBtrRgXucfUD2bXZbWR5HCuMfSyaiBMZcI9kC0Q1SIFTMIFGWeWVFcstEcshqTKX5
         KMNsQPcM8psyvjlMODyMnKuOMszf3QTw8MQ/8TpwjdXpKABOHvpFvzWWi/BXZ78bzBjI
         ZYfesQpVBcAqp+0rHPaFbuupisv4bknc9s7ufCgIHsTQMqNVo/t5FNpzyozsKeXHHNjY
         xSRkpoGBwYNuF4zgejUuK4LuG/5eGRqhomej4weI64hOdpiaNyNifB8Nyn0hZ+8i1Pxg
         cVmmly9ffwSof0mAMlsbUwDEakRqkWOX31WwvDCycQy3zvsFLzH+GOZTWbjCXbCbq8yM
         ZRgg==
X-Gm-Message-State: AOAM533VBBY8NiNpq5yMVTCbzVZvlNqTb6HUC9FT43Gtm0GVHNMeSNSU
        +qRrTXfIB0WJGbo2/DpntE1zvk3RqCe4pyNOEN4=
X-Google-Smtp-Source: ABdhPJxLl41BUqpTzCO9cy/h/ZOB/3FmCOXeWonczhPTVAprvE1eXl9iX1rEHaFIeVfvNbYdm+7ZymlRc/xgq5EMXSI=
X-Received: by 2002:a05:6e02:8a7:: with SMTP id a7mr2838801ilt.246.1634222226261;
 Thu, 14 Oct 2021 07:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211014072537.190816-1-pauk.denis@gmail.com> <20211014072537.190816-2-pauk.denis@gmail.com>
 <CAB95QAQQC6KJcbd-WhexBm=jusyoFkkB_a69RizMHpjSEbrqgA@mail.gmail.com> <e1a141d4-20e7-62c4-fae3-11166b8d0a66@roeck-us.net>
In-Reply-To: <e1a141d4-20e7-62c4-fae3-11166b8d0a66@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 14 Oct 2021 16:36:54 +0200
Message-ID: <CAB95QAT44kyBR19cu6sP0kFJwFtVnmULqMzTQPArL94x2oxGkQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Denis Pauk <pauk.denis@gmail.com>, andy.shevchenko@gmail.com,
        platform-driver-x86@vger.kernel.org, Tor Vic <torvic9@mailbox.org>,
        kernel test robot <lkp@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The compiler aligns the data nicely anyway (it will just leave
> a 1-byte hole where needed), so the packing is really irrelevant.
> Apart of that, does the above suggest that some information/
> code is now missing from the driver ?

It is perhaps an unnecessary removal which will need to be undone
anyway when I (or others) add the south bridge voltage sensor.
Everything is OK with that change now, but since the size of the
address struct or union is 32 bits anyway, I would not remove that
field.

Eugene
