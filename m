Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B07E45573A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 09:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244915AbhKRIpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 03:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244794AbhKRInm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:43:42 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C889C061570
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:40:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t30so9948015wra.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=j/DuPpTx0y19xWlQC0LNOlRnoFhz98CJWMukn+hcoIA=;
        b=zZ9IRo0ZS3FCosck7V4SqznrhkM/lxfJpVUWX4fR6SfMAzzPXkmkF3JG2IrCml9hf/
         yy98eP62MRQc2AdwY44l3KJNslAKW+ARxO1I3Y7Yk9IUH3VaPSPtDp/qjEcQxO/EMTpb
         eltz/Exb2y7GEvGP2UifuFQWcQU4ugFuKFl1i+Dkodf1cMLxDQMgW7/1TA3Bs5laGbCf
         uu+8nwC3gHcpX/t39tG2giCByPhzzp6TR1K+mxNILERt20Jy0ujxSUIMTZHvL6zeW0Ok
         KQowzga6+TPCimUJg/CRxRxa+mqpfufRZCBDMdHgQqsum93uC5inQcmUtc2BbWtEJXQV
         8fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j/DuPpTx0y19xWlQC0LNOlRnoFhz98CJWMukn+hcoIA=;
        b=3VstkzMka3zs2O+2qRbY0hgPXJfWvnBsVPQ2WKnmF4xUuruchIzPxhMeb2iPdkYAyK
         E5exUAOnswLSYfc2tSstVgS1Pxf4+BLOXftPDJcWOf7mPcfFbxlPEJ3Koxj5ZQLZq22l
         Ohfa79SaLq3wNYmX1w237E/+cdbbkx8xybzJrBtoWHkHWsC6bQXZwAdhdHVy11kh8Wif
         BfgDTFkzmm1gpX712nkdm7va+4wHMsxvzpSJFX8jj2W3BoxpxvAqMH8fdHeLSjpomew/
         SHrmVd3ngBbf+lYrsKKuvCDe96CUXfS6MRT9BafsVfeyz1GM/0LvVpyIZtLgvbZcnPu3
         KiIw==
X-Gm-Message-State: AOAM533Y0YjSVWRMgiKZQJo5SMxn8a5CmOBuEFkcUrZEf+yMBDZpDTrO
        HWMcJF/EABDhS1balKu/Mv5UJQ==
X-Google-Smtp-Source: ABdhPJwqviZ5J/sMzn8kdaEU5+ArWaMu6n+gRx9lmYQMQTrXiNAXZQ82uhKMMZZe1x7iSmpKbwpr2Q==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr29103130wre.140.1637224840949;
        Thu, 18 Nov 2021 00:40:40 -0800 (PST)
Received: from google.com ([95.148.6.231])
        by smtp.gmail.com with ESMTPSA id a1sm3056164wri.89.2021.11.18.00.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 00:40:40 -0800 (PST)
Date:   Thu, 18 Nov 2021 08:40:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCH v2 1/1] mfd: intel-lpss: Fix too early PM enablement in
 the ACPI ->probe()
Message-ID: <YZYRhjtUiMPb4Pyt@google.com>
References: <20211101190008.86473-1-andriy.shevchenko@linux.intel.com>
 <54F23B0A-9DB9-439A-B3BA-E1141703E91D@live.com>
 <YZI4FnCvAws2FLDA@smile.fi.intel.com>
 <PN2PR01MB44118FFB624CD71D6C3F0FF5B8989@PN2PR01MB4411.INDPRD01.PROD.OUTLOOK.COM>
 <YZPT8YfVXlNlBpY9@google.com>
 <258423E3-A0D4-4E24-BCD1-42F7ED25BB88@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <258423E3-A0D4-4E24-BCD1-42F7ED25BB88@live.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021, Aditya Garg wrote:

> 
> 
> On 16-Nov-2021, at 9:23 PM, Lee Jones <lee.jones@linaro.org<mailto:lee.jones@linaro.org>> wrote:
> 
> On Mon, 15 Nov 2021, Aditya Garg wrote:
> 
> 
> ________________________________
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com<mailto:andriy.shevchenko@linux.intel.com>>
> Sent: Monday, November 15, 2021 4:06 PM
> To: Aditya Garg
> Cc: Lee Jones; linux-kernel@vger.kernel.org<mailto:linux-kernel@vger.kernel.org>; Orlando Chamberlain
> Subject: Re: [PATCH v2 1/1] mfd: intel-lpss: Fix too early PM enablement in the ACPI ->probe()
> 
> On Tue, Nov 02, 2021 at 05:42:35AM +0000, Aditya Garg wrote:
> On 02-Nov-2021, at 12:30 AM, Andy Shevchenko <andriy.shevchenko@linux.intel.com<mailto:andriy.shevchenko@linux.intel.com>> wrote:
> 
> The runtime PM callback may be called as soon as the runtime PM facility
> is enabled and activated. It means that ->suspend() may be called before
> we finish probing the device in the ACPI case. Hence, NULL pointer
> dereference:
> 
> intel-lpss INT34BA:00: IRQ index 0 not found
> BUG: kernel NULL pointer dereference, address: 0000000000000030
> ...
> Workqueue: pm pm_runtime_work
> RIP: 0010:intel_lpss_suspend+0xb/0x40 [intel_lpss]
> 
> To fix this, first try to register the device and only after that enable
> runtime PM facility.
> 
> Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> Reported-by: Orlando Chamberlain <redecorating@protonmail.com<mailto:redecorating@protonmail.com>>
> Reported-by: Aditya Garg <gargaditya08@live.com<mailto:gargaditya08@live.com>>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com<mailto:andriy.shevchenko@linux.intel.com>>
> Tested-by: Aditya Garg <gargaditya08@live.com<mailto:gargaditya08@live.com>>
> ---
> v2: added tag (Aditya), returned 0 explicitly at the end of ->probe()
> 
> It works
> 
> Thanks for testing again!
> 
> Lee, can we have this as a fix material for v5.16-rcX?
> 
> Generally not, no.
> 
> We usually only push patches for the -rcs if they fix something that
> was broken during the merge window.  Not 6+ years ago. :)
> 
> However, if other valid fixes appear, I'll shove it into the PR too.
> 
> I would like to have it backported to stable 5.15 too.
> 
> Yes, once it's merged into mainline, it will be back-ported as far
> back as it applies cleanly.
> 
> If you have a specific kernel in mind, you should indicate it on the
> end of the Fixes line.
> No specific kernel in mind. The issue was observed since 5.15.

That was really hard to read!

Please fix your mailer to set previous replies as quotes.

Not only did you not quote the mail you were replying to, you also
stripped out *all* previous quotes too.  I didn't even know you could
do that!

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
