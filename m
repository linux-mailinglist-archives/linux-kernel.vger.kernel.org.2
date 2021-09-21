Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921144135AE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbhIUO5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbhIUO5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:57:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5553DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:56:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t7so6828172wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Uy/6vpAUKhCQrg81XG5Al3uBoXiNf0Mz5dJc/PJ/1Oo=;
        b=inwX55DyAUgJ5+/69FFQ5BYIFwpAEpPaNG5iUXLgI9Xx2QUcCzH3GiU03HfEj2LI0e
         qULLRtnz8pRXEtVEGBeiKj9+uiTYiTUFXpLcis2a9BBM01JdTgCa/ERr9ANh+2AY5m5/
         e8ZCbXtASjaNOpOkLp94OMpaFrrvdWD+B1REo6iIAjHq5DvhQn9fx/Oi2Ny0gGl1IqhZ
         oA8omaGlRrNw7uY44M1ZGwm6nSWSXZvx45U8dYvauqZ8gu3qSmpYzWZFTWY6clpmDTWo
         4RhKh65OdHy6+OkNXArCmGdvTOQZmLpi5VZd9JEuOhL82m7pMpORjtL+91x+bhe6oQnM
         +pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Uy/6vpAUKhCQrg81XG5Al3uBoXiNf0Mz5dJc/PJ/1Oo=;
        b=X6DPKE9bfV9R1BlS/TrIcPcd9PfOJMcJFHMb5QRfnsmRY+npnTGEMgDsXGfUbOHNy2
         zIrr6Aj2e9y7WHrBlFePmkXv1hNyU1pNHaMOTx1ZCRCNcb4g/a1rE4Og4Z2nnbsGfmbU
         ot6/cEgQ7MTIY0ApVBwYLQ7G3MUWwWEc8WirLCI67WurYBIkEdmCAO8SsNlR0ztdSQKy
         cEL5IILoyS5B0IVB85aQWiVi9kudOUKCeG92lDTstTRLuk/xclENS4swxRD+ajzpWiiU
         00E986ODxGcet5An52T12oXqLzBDI0uIaPiMw5q4U6LG5rwRf0d8yqWgtGCTG9bK5058
         mKlg==
X-Gm-Message-State: AOAM530QmhqE74NEWtDyamYKskZe2Ij/bYnKHAUF+cClPVJ7QUe4WlnH
        h4rVVjwijUsMp/ZYsro5gAlwOQ==
X-Google-Smtp-Source: ABdhPJxwyJfqbv3VS2qWqfkrpeWNt0/HGXMc8xJMgFLQyg5ZWJYmS0L9SbXC8wwBEt/xh1Dd4Dt+5w==
X-Received: by 2002:adf:e390:: with SMTP id e16mr35385598wrm.217.1632236175859;
        Tue, 21 Sep 2021 07:56:15 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id 135sm3191822wma.32.2021.09.21.07.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 07:56:15 -0700 (PDT)
Date:   Tue, 21 Sep 2021 15:56:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: propagate errors from get_brightness()
Message-ID: <YUnyjSdhJt5nK5Kd@google.com>
References: <20210907124751.6404-1-linux@weissschuh.net>
 <b25975d3-f417-4cba-92d1-35c93d37e1e6@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b25975d3-f417-4cba-92d1-35c93d37e1e6@t-8ch.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2021, Thomas Weißschuh wrote:

> On 2021-09-07T14:47+0200, Thomas Weißschuh wrote:
> > backlight.h documents "struct backlight_ops->get_brightness()" to return
> > a negative errno on failure.
> > So far these errors have not been handled in the backlight core.
> > This leads to negative values being exposed through sysfs although only
> > positive values are documented to be reported.
> 
> > [..]
> 
> Friendly ping.

Don't do that.  If you think the submission has been forgotten about
(it hasn't), then please submit a [RESEND].  As it happens, this is on
my TOREVEW list.  I just need to get around to it post-vacation.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
