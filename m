Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793433B9488
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 18:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhGAQMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 12:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhGAQMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 12:12:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D6FC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 09:10:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id df12so9202911edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KJHVWYvb3k7oZOehoarqx2Vy0pWj8RrFR/FEJGc4l1A=;
        b=dUncOJ8GCTdzk0LJjO/SqR55/4b3pByJWB18EPR8UlLceTqgSE01uQ5WsX/y7qUkHj
         CgG8dJ5PoxRfgcm1hG6WLhHi+sk1Z9GbtjPx+Pq+2nWEdnwADPzQspu9Ax/XDUbncdeI
         jQo5XD4rcyrWSwhxW1q3b56R7Ig7fTBY/9nmPXgDNERZ2dBZ3UWwf9mB5MKuVfgbVuYn
         znArPd2qGb54QfJ/ngXaBoEdd/PmsGGudQ5FFIYFvAoP9A9c+2TKXR7DJfYzj1NFR4Og
         FVxITFHWND/4k6Zl7qxEambeQzsUMtxfuSgImRKEFS9NjvE1KpOJK+h1nad8C8cR9pOQ
         3OHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJHVWYvb3k7oZOehoarqx2Vy0pWj8RrFR/FEJGc4l1A=;
        b=Bwz4oBxkLjGMi2flaBYJC84VBZRk52nfyApEW1nQyFFcluOVs5+pW9zlIqJieU2jcO
         7+D9b3fCeAhU12qOyMo7xZpWeD5k+rd9dgejb7ONpgEuov1bJqeYAk0eIMOMUacP1rfg
         5oFqpeIsapYhrqZ1V7cZ1IpoiCzSkUIFVJJ+bbCjkDREQtNdu3PnCZ2zBgyO/l5LzpPO
         AMrZOqhpraw32GLMPqhxPUW2g5CQIWp1BRvdzEfJN6XMxisYvpuENawNpK1kTSw3+xmm
         OSxipgCy1zRYqje86xNXz7qORooGnM9ZCLJVIau2idtkBODpoE+25eVoPHvaiUFPeDLj
         5fjA==
X-Gm-Message-State: AOAM532ZEZDZhFvqyHQeLYTStg18Apq3kdcqwoJtCuAYvpsh/sqICgaT
        OHwYaw3vMx/XSWoszvr/qDQ=
X-Google-Smtp-Source: ABdhPJyafyBWNMS6rfxXY8dHPzcvOaB0CVWij73xTuOjVb2ljHBwMYB5qE1/P3i+58ibozSQ2j+i5w==
X-Received: by 2002:a05:6402:35cf:: with SMTP id z15mr817962edc.208.1625155809777;
        Thu, 01 Jul 2021 09:10:09 -0700 (PDT)
Received: from linux.local (host-80-181-152-252.retail.telecomitalia.it. [80.181.152.252])
        by smtp.gmail.com with ESMTPSA id yc11sm87424ejb.109.2021.07.01.09.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:10:09 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH] staging: rtl8188eu: Replace a custom function with crc32_le()
Date:   Thu, 01 Jul 2021 18:10:08 +0200
Message-ID: <1769059.L4xhdxBWhX@linux.local>
In-Reply-To: <190cf86a4b8a40d2b672327e26cceace@AcuMS.aculab.com>
References: <20210701133809.26534-1-fmdefrancesco@gmail.com> <2058378.BL2Rai63ie@linux.local> <190cf86a4b8a40d2b672327e26cceace@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 1, 2021 5:54:49 PM CEST David Laight wrote:
> From: Fabio M. De Francesco
> 
> > Sent: 01 July 2021 16:24
> > 
> > On Thursday, July 1, 2021 4:52:08 PM CEST David Laight wrote:
> > 
> > > From: Fabio M. De Francesco
> > >
> > >
> > >
> > > > Sent: 01 July 2021 14:38
> > > >
> > > >
> > > >
> > > > Use crc32_le in place of the custom getcrc32. This change makes GCC
> > > > to warn about incorrect castings to the restricted type __le32, but
> > > > they can be safely ignored because crc32_le calculates bitwise
> > > > little-endian Ethernet AUTODIN II CRC32.
> > >
> > >
> > >
> > > ...
> > >
> > >
> > >
> > > > -					*((__le32 *)crc) =
> > 
> > getcrc32(payload, length);/* modified by Amy*/
> > 
> > > > +					*((__le32 *)crc) =
> > 
> > ~crc32_le(~0, payload, length);
> > 
> > >
> > >
> > > Haven't we been round this before?
> > >
> > >
> > 
> > No, I don't think so. At least, not you and I.
> > 
> 
> 
> That was rt1872 this is rtl8188 but I think it is the same crap.
>
Perhaps it is the same crap... However, the patch is in accordance to one of 
the two solution that Al Viro wrote about.

I think I'll leave the patch as is and wait for the final review by Greg K-H.

Thanks,

Fabio
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 
1PT, UK
> Registration No: 1397386 (Wales)




