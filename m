Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1703F83BD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 10:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240545AbhHZI2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 04:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240509AbhHZI2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 04:28:44 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DF9C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 01:27:57 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l18so3611593lji.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 01:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I22BlDdo9NBLaeRFYeqy8S3iIoOV2ys2CHWtpTY2vK0=;
        b=li7MxxlaeaAuPlGb+aX1Mw9qv6/EFfwBgzndlcYeoHKE/P8eMm84cE0oHjDqWZi7ra
         soDt7TZRJaj20HcOeLWPGkwEUwmSw4Q5Zg9AlEsB9g+vdd0d2RD4DUCaK0WS5/ICtknO
         itlYU18B4aHZ8mjCt64FSW6V25Q602xyfTBgvrAnqyLv2MiFsyxz7oa63MKAUVuOWxmN
         1AinWfR8nZU+DQs739jUH3og3WzKESLnZh1aMEXBQbaSc/psy2yhpzPjnZ317miSnI8w
         IdQl2zgMwqYCb+TGGixEloZcxj5zlSaTVJ+bl37JsVJS27019j6rkaL34xldC/ORJMP0
         +duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I22BlDdo9NBLaeRFYeqy8S3iIoOV2ys2CHWtpTY2vK0=;
        b=ohBubNN/VCINqjXqMRqc2NxFy1du6CWBrRi+72iulFxu73xE4BS5sjzpwg1g/9z/4l
         CVNFsFTKyR2OX7qdB5JngLp6AXOdIGx+HMngrj+jID25AVutz+Qybrvx22C6rtcqy3ff
         aBDT8ySAsKveFI00JyFTRvSV+OeG06dxbGYYuUUHY+VsNonXOEbkt7gNxMSA+80t/I/m
         55AuHqFW+dti/ZiS44THASBo+QEEfsSga8TqWdPQAgnnOObjLknnf4p03Xlld1S/027y
         vaO4TrYbdoEgnk55IlsCvke255kZGPXfBkjxg0GrCUtg58fseDE7R+6uIcRrg1HC4XPh
         g41g==
X-Gm-Message-State: AOAM532457CmY9Us3+muHn5dWKnREIC++nY4UQlhD7RHT2W8ow2h8xq1
        kLOaVfD418FHUsXPIBE1kF8=
X-Google-Smtp-Source: ABdhPJwIR+pepFHSiCyZ8FTBE3x/BdC/ROe0egZQukYZ4cngEkUqotMG/CVHVGW24WZ5+65PdPYA3Q==
X-Received: by 2002:a2e:a4ad:: with SMTP id g13mr2000903ljm.391.1629966475289;
        Thu, 26 Aug 2021 01:27:55 -0700 (PDT)
Received: from localhost.localdomain ([46.61.204.60])
        by smtp.gmail.com with ESMTPSA id w27sm245479lfa.308.2021.08.26.01.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 01:27:55 -0700 (PDT)
Date:   Thu, 26 Aug 2021 11:27:45 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "straube.linux@gmail.com" <straube.linux@gmail.com>,
        "fmdefrancesco@gmail.com" <fmdefrancesco@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] staging: r8188eu: add error handling of
 rtw_read8
Message-ID: <20210826112745.5e1421ed@gmail.com>
In-Reply-To: <f5c20e0f1b934e04ad11a3627d71f5db@AcuMS.aculab.com>
References: <cover.1629789580.git.paskripkin@gmail.com>
        <c59d5d850bf9aab208704182c83086609289cb9c.1629789580.git.paskripkin@gmail.com>
        <f5c20e0f1b934e04ad11a3627d71f5db@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.8git77 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2021 08:21:34 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Pavel Skripkin
> > Sent: 24 August 2021 08:27
> > 
> > _rtw_read8 function can fail in case of usb transfer failure. But
> > previous function prototype wasn't designed to return an error to
> > caller. It can cause a lot uninit value bugs all across the driver
> > code, since rtw_read8() returns local stack variable to caller.
> > 
> > Fix it by changing the prototype of this function. Now it returns an
> > int: 0 on success, negative error value on failure and callers
> > should pass the pointer to storage location for register value.
> 
> ...
> > +		len += snprintf(page + len, count - len,
> > "rtw_read8(0x%x)=0x%x\n",
> > +				proc_get_read_addr, (u8) tmp);
> 
> That is broken.
> 

Don't get it, sorry. Previous code did exactly the same thing, but
didn't check if read() was successful.





With regards,
Pavel Skripkin


