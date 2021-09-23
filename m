Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8059416034
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241350AbhIWNpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhIWNpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:45:03 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C858FC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 06:43:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u18so17380589wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4vvUL3e0KnaoXbHygff1j5G+RP+eVvUFadYzHbYM5yg=;
        b=bJ/9dqxYZ+yDeJTQt2kNS4H2m8IPsSvr9qIFTk33V/6+ygT7/5ahVdLEEZZSShC60o
         MiOTpF9eTEClXfv+gm+DVrZ0z+iec6EG+gat7i0Pq0zMXe54QqEzadUAZpOxEV9nqCOu
         gHIQ0ZGhiDk5ccIVm07xCff/D6+VdOO2mBmy7KHNqBcXdnHEk0HhkUyH+MgTJGhBcSOU
         hX/HkVPy1WmOzUtMSV8N1MdYMMEfYPQhqvXj0BJMBRU91ov0UAkO20oemTFKzBw0UhvV
         CctiqQi+Pr4MKa4Nq3NFkHA+ozl5LK8uqW4szRAzXmP2B44jyAurEvNnQvsbpmnGZnoi
         MzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4vvUL3e0KnaoXbHygff1j5G+RP+eVvUFadYzHbYM5yg=;
        b=1tLFAo5+rVUIJ4AlkEzFSLZJVsxcZ6pmHc7ryOPJHe5ueOTUiMU/KQHEy0V9mQNel+
         6J3nyUq77inRgTY//Gj9R4ccSx+/Y+9WgSQJG57S6l0DZ38jiV5XhKcrlni+VP6Rmc82
         VcmazvPi9tCUk8YV6zmWdHP5C8V7FkR9Sof1yWQzjNcrcBw3Nv2dpnZUTwayX3eRFmNR
         FB9NbggXOvudlqo3ltz9rKhnXrc+BUg9qZIT2N02Wp07Za02Y5bns/qK4TXPcnoQvP/u
         BlxQholiyceN2JQF95K5U1saxVDqsT+oPRBRqe+vx4DLUFAGc/6ES/j6l/kyp24UYiz6
         CIHQ==
X-Gm-Message-State: AOAM531mpDyNAYmH2ShCSIG1wG5N2na9ga0FkamzykWpywNR8xeuErZI
        KerkbMVmKas8hfBpgMzJTyJP0w==
X-Google-Smtp-Source: ABdhPJyi3UZLScn4v2Ctypt2vtJmPaKpW9SI96CZeGRqpPXO1oNgQczRmKbml0MnljOLuNSCK8caQA==
X-Received: by 2002:a5d:5042:: with SMTP id h2mr5145969wrt.57.1632404607073;
        Thu, 23 Sep 2021 06:43:27 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id a3sm5435583wrt.28.2021.09.23.06.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 06:43:26 -0700 (PDT)
Date:   Thu, 23 Sep 2021 14:43:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: propagate errors from get_brightness()
Message-ID: <YUyEfDJZT0hr5nI4@google.com>
References: <20210907124751.6404-1-linux@weissschuh.net>
 <YUxNczBccLQeQGA5@google.com>
 <4bb3051e-2550-43c3-afed-d4b00850126e@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bb3051e-2550-43c3-afed-d4b00850126e@t-8ch.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021, Thomas Weißschuh wrote:

> On 2021-09-23T10:48+0100, Lee Jones wrote:
> > On Tue, 07 Sep 2021, Thomas Weißschuh wrote:
> > 
> > > backlight.h documents "struct backlight_ops->get_brightness()" to return
> > > a negative errno on failure.
> > > So far these errors have not been handled in the backlight core.
> > > This leads to negative values being exposed through sysfs although only
> > > positive values are documented to be reported.
> > > 
> > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > ---
> > > 
> > > v1: https://lore.kernel.org/dri-devel/20210906215525.15418-1-linux@weissschuh.net/
> > > 
> > > v1 -> v2:
> > > * use dev_err() instead of dev_warn() (Daniel Thompson)
> > > * Finish logging format string with newline (Daniel Thompson)
> > > * Log errno via dedicated error pointer format (Daniel Thompson)
> > > 
> > >  drivers/video/backlight/backlight.c | 22 +++++++++++++++++-----
> > >  1 file changed, 17 insertions(+), 5 deletions(-)
> > 
> > Applied, thanks.
> 
> Hi Lee,
> 
> thanks!
> 
> Also I'm sorry about my nagging before.

No worries.

> I was not aware you were on vacation and saw you respond to other mails.

They were in the queue before this one.

I had hundreds of emails to get through on my return!

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
