Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AB33D9390
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhG1Qtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhG1Qt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:49:28 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832ABC061757;
        Wed, 28 Jul 2021 09:49:26 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x3so2844554qkl.6;
        Wed, 28 Jul 2021 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LeWyV5Hvjaj4WOnnvngdvVRWMOHLBfih9OtkOnTI1z8=;
        b=m6pv6jW/27Q3dD+d92ObHIKtmjZeqyQ2c/7m7Bk6dRtN2oEYjl+9tLoxIYD/VE2EAz
         AGc6RND3GdY7tDhPDTEN8gyZveNVuqLTMNgnFsNEG0+SFzpV66qKkIB4WQmCnE4UFHC+
         rHn3aGQLiSfDvjElh16L9NKZeOv+W7IlRo257PP+ZgY3mnJYQAOX90Rvz3fA3xWFkcH/
         WFOj1pplHshep4uLnOj4w2SjYSC8SXXquAcA0tszz8EqBF66BGhcsMXIwVvO38Vrj6wn
         +7b5RrnF8IzOG6Q12uis5AJFKKXMt201zKe9qPNmHd6kugr2t0zpR3Gx2VLqaCl6Fpgp
         oDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LeWyV5Hvjaj4WOnnvngdvVRWMOHLBfih9OtkOnTI1z8=;
        b=r76lz6PCTEg3oNbHobH2sjQ7+ICzJYdu/uPRCUXz6GYHOhFmAI0cwT6gIuUWOnZs0Q
         a0mLugvm2G6Y0yUqa0Vx8yPGUIzslOlKTR6IoVY2HA2Gl9cJYKm8PvGDdogMoybIm6au
         wnHEt0EYe30hpr+UOxN0h9l+T8Y28ULXNkBq/dia/pWIoWa0NWAONxfgFzGdHbOphLR/
         +OjKrrDNN1UScky7RzFUWTv1TUiDaJY7/cDidzrzNzVNAR0m/KFvTo0lYshBNHpGoYBn
         J5kNwHxTO4EVHpZhll/hnkNqHLOFf7M+JyO+S76lmCQbb7c0xULR4k5biPVNdGz7Clrr
         7Bbg==
X-Gm-Message-State: AOAM533wMcU/WhJPJg25QxaJUyevsZreMHqKLJjddIXBvcQtHng0/OFX
        gkG78HqEPK8Xej5EwSWbuVs=
X-Google-Smtp-Source: ABdhPJySjYSARMewUPhmoEjLk/WUz2g0xxHATHGntoq6omxh909G00JlSe0G+vHbIYKnZIV3fJoVIg==
X-Received: by 2002:ae9:ebd5:: with SMTP id b204mr572143qkg.183.1627490965712;
        Wed, 28 Jul 2021 09:49:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j24sm161387qtr.52.2021.07.28.09.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:49:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 28 Jul 2021 09:49:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: sht4x: update Documentation for Malformed table
Message-ID: <20210728164923.GA1084966@roeck-us.net>
References: <20210727232054.7426-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727232054.7426-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 04:20:54PM -0700, Randy Dunlap wrote:
> Make top and bottom border lines match.
> 
> Documentation/hwmon/sht4x.rst:42: WARNING: Malformed table.
> Text in column margin in table line 4.
> 
> Fixes: 505c2549373f ("hwmon: Add sht4x Temperature and Humidity Sensor Driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Navin Sankar Velliangiri <navin@linumiz.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: linux-hwmon@vger.kernel.org
> ---

Applied.

Thanks,
Guenter

> Applies to mainline.
> 
>  Documentation/hwmon/sht4x.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linext-20210727.orig/Documentation/hwmon/sht4x.rst
> +++ linext-20210727/Documentation/hwmon/sht4x.rst
> @@ -42,4 +42,4 @@ humidity1_input Measured humidity in %H
>  update_interval The minimum interval for polling the sensor,
>                  in milliseconds. Writable. Must be at least
>                  2000.
> -============== =============================================
> +=============== ============================================
