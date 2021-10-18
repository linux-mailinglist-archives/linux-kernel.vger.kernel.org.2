Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDE3432A59
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 01:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhJRXcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 19:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRXcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 19:32:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CF9C061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 16:29:50 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id y3so44388875wrl.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 16:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q2HqoAznjZz6Gt/PPPdORC0kvm0GuUIVTKfy6U+h6fw=;
        b=OiaeXwwgRkPHwFwf3hurVsuxhC+WgdaX4nGx9JjkPPFKlxGo/WB/A9lwrfd6yELoMa
         gFQyKaigAKjQYDTG6mMGD4hq0hqKswisLev1zvXqxA7R36ktSlK9MD5KGpt/cJAzRAMa
         b6RotCkjz7injUtTDKznVxT+vVln2C9YLJXLKDWIi+De2nyjMFP4r6xyax8Ehv+fG+hb
         iCAqvy9n/nE9sXxSI4YGtL56E76+iefkX4VytwHSxCTLc6Cda77pe6FWUw3rnnqqJTeH
         6240gKKXkvA9Y8GR0KHoVNzn+r0AgVurneW6e8mUhD498CE6wIUztVtnZ6z8xkAYD2zS
         OCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q2HqoAznjZz6Gt/PPPdORC0kvm0GuUIVTKfy6U+h6fw=;
        b=rfwY8VX9GArjiaWCYxappvore5wqurQ+pQCbwfYs+MKvJXsNUw6soHoJdWgUcGzq8r
         22z35qTsD/G14qlnPWS9CMVNBlIB3Zg9Q7DY1y8cndYONaBMaB36uXuWAvLFY0kIV8uU
         6gbepcy9tCW02R3VpW0SKcoh3b5OSJWZOfUnUQpdHYLnEPW8Qhsqoe4fpj1tG3ca5n/E
         FVfE0/8CWpx7vCp3/0eGshp+1EKmubEhmJoaHP/CnEXohqecs8bCTnInhFvTyy0A6ScM
         V0rIUDTqZKgQr2efDeeJer8U0Peg7/zwQv08Ojeju7fz+HaDIZPaMF5+mX1uSNQO+dk9
         dMWw==
X-Gm-Message-State: AOAM532nEpif+midpzCuroQzTIOQnbSgl6OTfHcrIAKi8vKd/F88XfZl
        gPM1Rv1vI8fOKgYx2zdll0T1Ew==
X-Google-Smtp-Source: ABdhPJykyuN14JObwI2jP0AhXr3otAMVC8QKNGsov1lkfYScg+E0miAz4pkPnlEZ/2rCvQ8u04Jh3g==
X-Received: by 2002:adf:a415:: with SMTP id d21mr41045431wra.236.1634599789549;
        Mon, 18 Oct 2021 16:29:49 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id f10sm253306wri.84.2021.10.18.16.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 16:29:48 -0700 (PDT)
Date:   Tue, 19 Oct 2021 00:29:46 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     luo penghao <cgel.zte@gmail.com>
Cc:     linux-kernel@vger.kernel.org, penghao luo <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, linux-block@vger.kernel.org
Subject: Re: [PATCH linux-next] cdrom: Remove redundant variable and its
 assignment.
Message-ID: <YW4C4A5S+mjHzKN2@KernelVM>
References: <20211018090834.856992-1-luo.penghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211018090834.856992-1-luo.penghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 09:08:34AM +0000, luo penghao wrote:
> From: penghao luo <luo.penghao@zte.com.cn>
> 
> Variable is not used in functions, and its assignment is redundant too.
> So it should be deleted.
> 
> The clang_analyzer complains as follows:
> 
> drivers/cdrom/cdrom.c:877: warning:
> 
> Although the value stored to 'ret' is used in the enclosing expression,
> the value is never actually read from 'retâ€™.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: penghao luo <luo.penghao@zte.com.cn>
> ---

Dear Penghao,

Thank you for the patch, looks good, but please could I ask for a small
tweak:

>  drivers/cdrom/cdrom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 89a6845..393acf4 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -871,7 +871,7 @@ static void cdrom_mmc3_profile(struct cdrom_device_info *cdi)
>  {
>  	struct packet_command cgc;
>  	char buffer[32];
> -	int ret, mmc3_profile;
> +	int mmc3_profile;
>  
>  	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
>  
> @@ -881,7 +881,7 @@ static void cdrom_mmc3_profile(struct cdrom_device_info *cdi)
>  	cgc.cmd[8] = sizeof(buffer);		/* Allocation Length */
>  	cgc.quiet = 1;
>  
> -	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
> +	if ((cdi->ops->generic_packet(cdi, &cgc)))

We no longer need the inner-most set of parentheses now, as we are
checking the result of the expression:
cdi->ops->generic_packet(cdi, &cgc)

rather than the result of the assignment expression:
(ret = cdi->ops->generic_packet(cdi, &cgc))

Please resubmit with this change and I'd be happy to approve the patch.
Many thanks.

Regards,
Phil
