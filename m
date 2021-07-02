Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F403BA0A7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhGBMsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbhGBMsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:48:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C4FC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 05:45:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t6so2417480wrm.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=o9hxKcljcEc8mK0WPY7OkaX/O7ztkSKsIrvpvocYgJs=;
        b=QMjSQis3AESqBrm6YWqjmOPOxSr5Rleq3V7ypk/TtxVMUreLcBxAIRlFoWkzzxn5Ng
         aqtSUpVV8XyP4WM1ku3k94qOit2M+CwPveFR1xpok3nZgtWp5pbiF4DHZs3Efq1uF+ou
         G6x7VrsdI6lz1dQD7Cud1oQ/npoQRKvW5faqMeIDdziyF33nSviB9bkispGW1pJf4xc0
         ibuSqcpumEliA8RiS0Y9EhN1gBwT2M7fp2oqq9nNdB75D2b7YnPv8uTzvBZXH2HXZn21
         /AgnBO6YV3N/KzrMeZqye7HQnVTzotAk1fE4DnSkLq6IwvwrhBWhq5P7TW5UkTMb8FZ+
         V63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o9hxKcljcEc8mK0WPY7OkaX/O7ztkSKsIrvpvocYgJs=;
        b=E4KcmBTTrwmjW8moEtlQWE+TcVcGs4OpirpX15UD78iC5s1UA31NO4eNKL6RWlCzJ3
         x9hM7jvYb2oNWnJI22LD0gecukC2dpFp6Jii3KSzi6I9vPw60y/6s2zjOtvDofcyNoXs
         H1HQvN1EPiCcQxv0vdJtcDOahggXX0yGZ41KtKlkTKzUI5NURUj9WjvVcQDySKzVfzTp
         7a6qZIAsS0gB08LARSd3LgRTWxjjDPjZwmTwNsNb75ebHRac1AjtH/XabHDsXqTp4Ncz
         r9imHJbFzKvzS0BnzXbePTK110HH04rxupg+czCPOibf09fFtLX0LZk3WVLxcFZECuac
         v1GA==
X-Gm-Message-State: AOAM5301eWTyM2MQqZ0e6zJD+47KbYzKESsjNyj8C2E6PPBswuFRHGgD
        3ssGIa3eD8YW9T5/LVl8BGgUOw==
X-Google-Smtp-Source: ABdhPJyAjnQA0OjBxKvOIM34pqgQn8w/StgryNytJIDMDiDME1D58QP4ltt+ygA6hU+d9Vnu48rFBw==
X-Received: by 2002:a5d:508b:: with SMTP id a11mr5591720wrt.280.1625229940621;
        Fri, 02 Jul 2021 05:45:40 -0700 (PDT)
Received: from dell ([109.180.115.218])
        by smtp.gmail.com with ESMTPSA id m7sm3315491wrv.35.2021.07.02.05.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 05:45:40 -0700 (PDT)
Date:   Fri, 2 Jul 2021 13:45:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Chris <chrisrblake93@gmail.com>
Cc:     ptyser@xes-inc.com, linux-kernel@vger.kernel.org,
        Christian Lamparter <chunkeey@gmail.com>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3] mfd: lpc_ich: Enable GPIO driver for DH89xxCC
Message-ID: <YN8Kcp9p58Th/JTM@dell>
References: <20210607233535.4198-1-chrisrblake93@gmail.com>
 <CALpBJjqfgQ2HfbF2qzGBjoGkq-TiK5rKUvs=cMwaUL7NtkoRrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALpBJjqfgQ2HfbF2qzGBjoGkq-TiK5rKUvs=cMwaUL7NtkoRrw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jul 2021, Chris wrote:

> On Mon, Jun 7, 2021 at 6:35 PM Chris Blake <chrisrblake93@gmail.com> wrote:
> >
> > Based on the Intel Datasheet for the DH89xxCC PCH, the GPIO driver
> > is the same as ICH_v5_GPIO, minus the fact the DH89xxCC also has
> > blink support. However, blink support isn't supported by the GPIO
> > driver so we should use ICH_v5_GPIO. Tested and working on a Meraki
> > MX100-HW.
> >
> > Signed-off-by: Chris Blake <chrisrblake93@gmail.com>
> > Co-developed-by: Christian Lamparter <chunkeey@gmail.com>
> > ---
> >
> > Changelog:
> > V3: Update commit message format and update contributor message.
> > V2: Updated commit message, and added Christian Lamparter as a
> > contributor.
> > V1: Initial Patch
> >
> >  drivers/mfd/lpc_ich.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
> > index 3bbb29a7e7a5..f10e53187f67 100644
> > --- a/drivers/mfd/lpc_ich.c
> > +++ b/drivers/mfd/lpc_ich.c
> > @@ -489,6 +489,7 @@ static struct lpc_ich_info lpc_chipset_info[] = {
> >         [LPC_DH89XXCC] = {
> >                 .name = "DH89xxCC",
> >                 .iTCO_version = 2,
> > +               .gpio_version = ICH_V5_GPIO,
> >         },
> >         [LPC_PPT] = {
> >                 .name = "Panther Point",
> >
> 
> Hello,
> 
> Just curious if there's anything I can do to help get this reviewed
> for merge, thanks.

Apologies, this had slipped through the gaps.

Looks simple enough.  I'll review it for v5.15 once -rc1 is out.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
