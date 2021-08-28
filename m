Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB0C3FA69D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 17:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhH1Pze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 11:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhH1Pzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 11:55:33 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E742C061756;
        Sat, 28 Aug 2021 08:54:43 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i3-20020a056830210300b0051af5666070so12070990otc.4;
        Sat, 28 Aug 2021 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=e4TSKtefWHgQZdSiBJs6Tav40y6+gqilbiq5J43BUIw=;
        b=nFROXdNBrxSlGnuA5utpR0mhMT+0n6ucfU8Qpu1kdrBXnWscx5Ub/IQHf+92Z9WVdN
         lLS0Dnc6FtM6Z/TZRfD81m4dWXT0fArhfTw4LWhNC/SsQiyN95ZXitQ38ds2rjechkAB
         RmqpoTUa3M2vrpCXwuB5aAeWg4qlslU+jG/aGRefBXH0iXa4LHDDqNmSZFjwUHHD6Kuj
         ys3uy+OGE4tNnOiXwASLtm9rWI+NPyx5dMp3M3rkI7MIIEFky4Yc7+njJCqetwupwvLr
         3dsPYtOV8zd3tn+/b999xYgo5CSu/Y1fv17s7TxM6eUUtq6pVuCyyVMqMFNBiOiRdsjE
         7rKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=e4TSKtefWHgQZdSiBJs6Tav40y6+gqilbiq5J43BUIw=;
        b=pxPcYZUT+kB0wtOg1M0xnee0ODdxX/K6FLhbBAtnOfETCOCHljgr+l4NfOZV5xvmay
         S3YQkfL0rIq6dSm/a4PgIOR4UkueO+oy3av/Yh3hSNby6YYLUgt/+JrT5cKeeExwXl3I
         evRk1VqysEga6O+83QJ8bAkHSUeLTuWh3jmBm/GSK0DonVqjPAoX7M150c0vdkWL/fUq
         Ooni4w6sN2cfFYJhR4HJBw/t+aif3i8tz5NAiPdSCrWoLUJ+qGM0jH7f8mmGS68zXiC+
         hHJi9xPMVunhqAhEUiTI5xiSu2NweXoK4msOksYQCH1lTEKoiFv3aWoKKGPgz+/D2tKL
         whsA==
X-Gm-Message-State: AOAM530jPHJ3pKXzrtW5eu56OGB+QMQpC9Uqh7f1jUpDyjb9OsHanFOl
        BXsjosVEfLACpTQNLeTLt4hl9tgxIrk=
X-Google-Smtp-Source: ABdhPJzvfO+otutJpyPVfF9fgAPnQdVfC70ML1OfN4ahmqpyvxFnOY4dSZsijiMT/xxxqFyxyXPxng==
X-Received: by 2002:a9d:70cc:: with SMTP id w12mr12356628otj.306.1630166082642;
        Sat, 28 Aug 2021 08:54:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x4sm34010ood.2.2021.08.28.08.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 08:54:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 28 Aug 2021 08:54:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: add driver for Aquacomputer D5 Next
Message-ID: <20210828155441.GA820794@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 07:26:28AM +0200, Aleksa Savic wrote:
> This driver exposes hardware sensors of the Aquacomputer D5 Next
> watercooling pump, which communicates through a proprietary USB HID
> protocol.
> 
> Available sensors are pump and fan speed, power, voltage and current, as
> well as coolant temperature. Also available through debugfs are the serial
> number, firmware version and power-on count.
> 
> Attaching a fan is optional and allows it to be controlled using
> temperature curves directly from the pump. If it's not connected,
> the fan-related sensors will report zeroes.
> 
> The pump can be configured either through software or via its physical
> interface. Configuring the pump through this driver is not implemented,
> as it seems to require sending it a complete configuration. That
> includes addressable RGB LEDs, for which there is no standard sysfs
> interface. Thus, that task is better suited for userspace tools.
> 
> This driver has been tested on x86_64, both in-kernel and as a module.
> 
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied.

Thanks,
Guenter
