Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7133F3A43
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 12:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhHUKng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 06:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhHUKnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 06:43:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B9FC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 03:42:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j12-20020a05600c1c0c00b002e6d80c902dso7538325wms.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 03:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=kbLqnZRKHYWI/LXP7guX+yhqPeRJbgFmWn9L3bxAxt0=;
        b=DxDmNMb226dqentrpO+PDtzDmxQeuMtpoaK8OgWXXZFZ08wCpXzBXc9GChgcjWS5h7
         JVenDIF+I1xaCHuMV3Sm6jR19WtHe4hGhbT+OPd1DBv6S9aTVUkU4fh1AlABvWwWvxAs
         mG1YXW6Xva0OucwIYZSbWzdAR3rkOjvaRhVO+n0zyyHP8qyHYT9MhjmqnUjbcSM1RjX/
         vLBejuiOFgaAxIyU4JNeCbTeP3p4OHp5Ox0+4hAramtR6Fxp3EEvV837In0bO41I8eTb
         bZVqxUK4C4HW7J9tjjg2+S8nx7d9Exn/ug4vbtYbdinZ9JFymQlXus5y7IiG4w3QM6BI
         IXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kbLqnZRKHYWI/LXP7guX+yhqPeRJbgFmWn9L3bxAxt0=;
        b=qWLI9o0YuatEchBBwBqKPSoI9dqAXc4XKPwiUQs+2X+SpRDlxE/C38LgnHfvB3xjcf
         eDSl6bIDp5wlrGFu/vZtmUU36HhF7MPg9/mAjKvOKE73vJdsJ1nnWA5OV0IiOJWnr3QT
         IHR4NYKLoJtAVac7BDTcXBSjP/93efTPWrT3iBS/ZzSHX5dMyMWW6X+SXT/hDajQrh//
         gT4LlrmMEJztpBcNQ51mYafpI1BsuR0Er/qeBtjpYqcJaW0ej8QdIhJIcFhtPp7tZYMN
         2WZh0B7VZwKqavALjpfRMtNGAysQPCQZaSCfELX7Jmp9Dk6t8Dj/2kGOjwSJpTosMFHL
         2xFg==
X-Gm-Message-State: AOAM531SFw+K3O0aDtn4dIPr0mA7jW5nCvKtjydqZecsxqFqoWrbgF/W
        Bm/w9GQ8i8wTY2aDwi+1l9o+/A==
X-Google-Smtp-Source: ABdhPJz4F2GWC0oCYtm6NQgz7eJNi5Xy0pzoWniBsWqI+BTXWIIHXB0NaVPZ+eGQtSA0IZ4okD6/7A==
X-Received: by 2002:a7b:c8d9:: with SMTP id f25mr6384023wml.7.1629542571822;
        Sat, 21 Aug 2021 03:42:51 -0700 (PDT)
Received: from ?IPv6:2001:8b0:dfde:e1a0::2? (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id l2sm8462154wrx.2.2021.08.21.03.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 03:42:51 -0700 (PDT)
Message-ID: <1cd1be12f42411b7d6d72cd4839cbbbb8153d400.camel@philpotter.co.uk>
Subject: Re: [PATCH] staging: r8188eu: remove forward declaration of
 Efuse_Read1ByteFromFakeContent
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, Larry.Finger@lwfinger.net,
        gregkh@linuxfoundation.org
Date:   Sat, 21 Aug 2021 11:42:50 +0100
In-Reply-To: <b0819fe2-e7cf-b6bc-5930-a31e10da811d@gmail.com>
References: <20210821000508.79422-1-phil@philpotter.co.uk>
         <5110838.kRcMR4ARJC@localhost.localdomain>
         <b0819fe2-e7cf-b6bc-5930-a31e10da811d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-08-21 at 10:30 +0200, Michael Straube wrote:
> 
> 
> On 8/21/21 5:17 AM, Fabio M. De Francesco wrote:
> > On Saturday, August 21, 2021 2:05:08 AM CEST Phillip Potter wrote:
> > > Remove forward declaration of Efuse_Read1ByteFromFakeContent
> > > function
> > > from core/rtw_efuse.c, as the function is defined in full
> > > directly
> > > after this and therefore this forward declaration is redundant.
> > > 
> > > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > > ---
> > >   drivers/staging/r8188eu/core/rtw_efuse.c | 6 ------
> > >   1 file changed, 6 deletions(-)
> > 
> > Philip,
> > 
> > It's pretty clear that this function has only a translation unit
> > visibility.
> > Why don't you make it clear by defining it with storage class
> > "static"?
> > 
> > Thanks,
> > 
> > Fabio
> > 
> > 
> 
> Hi Phillip,
> 
> I agree with Fabio, making the function static avoids the 
> [-Wmissing-prototypes] warning and makes it clear that it is only
> used 
> in this file.
> 
> Thanks,
> 
> Michael

Dear Michael and Fabio,

You're both absolutely right, thank you for the feedback. It did occur
to me at the time that I could just make this static, and indeed the
change introduces a kernel test robot warning as it is currently, due
to -Wmissing-prototypes as mentioned. I shall rework, many thanks.

Regards,
Phil

