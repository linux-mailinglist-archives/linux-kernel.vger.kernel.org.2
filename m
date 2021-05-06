Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407AD374D3B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 04:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhEFCCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 22:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhEFCCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 22:02:14 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABC0C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 19:01:17 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w4so5008824ljw.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 19:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bdTXCNCJehL6L2FUf8dVXHKc7By/gl2K5wPWDUG3aHQ=;
        b=npobrFmjY3F/BH+4xzy01aYi8zEKzmvijsn8BvArbMYGIHjuVw12soYgAUuljvq437
         ijinaGUa2nwrdIX6K0US0d8kCc8WaqMpFWp/SvGxO0J9t7zlL5aglEGTqJFF8zYq7+4C
         JcPrxUw08b+nKEgEIV9SF0F5gBROZjIfYFmAqw3mpa0TEFSXrlgDhwoyRp/EXQE3bNZZ
         IQlOv8v0JRXs3HODzvEykjvqSaxKbh/qsQs08y/s3Z28PjfG7bMZ3xvVcaAWfPgSCdOH
         uGLi1Zc/gWf4hzXTB4v1LHXTDoZnvXVU+7i/OPaG+ZfwRuuhqyvB6e90+GZCD33QU+50
         IMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bdTXCNCJehL6L2FUf8dVXHKc7By/gl2K5wPWDUG3aHQ=;
        b=Yy/mAC03LSIOlsf+0x5XF7rPIp4YxbXF6jeqm3HWkmbQq/LCWPTCyTzng6ELVkwBGM
         lxf3rCUSB3ljHg122+akZaceA5u0Egm+2PARXcMGaEHSvWMYx9R5fcnItMeThLfHPSEF
         D6NTGfDZ4bzkPYjVcOT0EzpP2UzICJVOzehmp/mRGkvnI1iSNz+5nYSWbrKZhCsmW1Bf
         uTkQ2d/sBM48coG4larA2pPyTfnU/jDuaiTRLj9FqlVpfPZgF2M8M/N94ZfekwKneJ2I
         m7nbwnhH8FFGzKp45T+KKeoyV7/zNj8DhNTI4vSR70dAtXh+jiYzl5a8+YDoShJeVjqr
         eM8w==
X-Gm-Message-State: AOAM531wckTkluBITsVfZRxf9Fi3rRSkZGJiuY1sRVmPp15hpFyLrA9M
        VEt1Ntgx7W1fHPR8vPoP2u1irSxz5HZxhXD+n0u2DA==
X-Google-Smtp-Source: ABdhPJzuud5nGxGBZKvJcULbXiIs/DImEdzGgjgMpVJb4t+vKkxZ5/hCS6RKqUESMVNkt//sfbFh2OWHgfIJ5t7gADI=
X-Received: by 2002:a2e:b4c3:: with SMTP id r3mr1283898ljm.232.1620266475764;
 Wed, 05 May 2021 19:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210506004423.345199-1-saravanak@google.com>
In-Reply-To: <20210506004423.345199-1-saravanak@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 5 May 2021 19:01:04 -0700
Message-ID: <CALAqxLU+Uf6OSDLG8OC_gHY9-VVHPgu0_bXxJcO8B4peFugtqw@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpm: Don't block probing of consumers of
 "connector" nodes
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 5:44 PM Saravana Kannan <saravanak@google.com> wrote:
>
> fw_devlink expects DT device nodes with "compatible" property to have
> struct devices created for them. Since the connector node might not be
> populated as a device, mark it as such so that fw_devlink knows not to
> wait on this fwnode being populated as a struct device.
>
> Without this patch, USB functionality can be broken on some boards.
>
> Fixes: f7514a663016 ("of: property: fw_devlink: Add support for remote-endpoint")
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Tested-by: John Stultz <john.stultz@linaro.org>

Thanks so much for this fix! HiKey960 is back to booting properly!
-john
