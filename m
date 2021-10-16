Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD5B430466
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 20:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240670AbhJPS44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 14:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhJPS4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 14:56:55 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C2FC061765
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 11:54:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i20so51271957edj.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 11:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LWHTjs02qVue1BD0sar168IOoQPslMqFnvyeq5J9m0=;
        b=kyijQi2zmPeabDpYhQ8d13bW04yV81cVc8XQYuTO12gUUTA3Oq/Aet2Lq37QUMDKFH
         husRdDt6KR42q0wR/qFW831UOyNOH10e2lVEcajkJF2UIOCAwXdz7Fbw+m5+qiIxesgz
         ictAau0x6PljMHyhrg+I36RBfmGQLHx0BNlgaqkfVJaBfojWbrewvj8uuU97374ALiq8
         77Ov/R1p7elt84okyNrhIaS5pimq07GGxlJBwf8KTvDImDTM3bdnESOAb4JzzKbkW2sQ
         4iM9w/1Oe7uM8oaStTzm44r/Hn6BXpFFMGUYeCInGjpi5RM+UNxVaLROqwEZforWaAPi
         UlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LWHTjs02qVue1BD0sar168IOoQPslMqFnvyeq5J9m0=;
        b=pXkMH2fxjigE3H2aiMkP0lXEZGkxt+wy2KGfb4FLihLtKG0Lojew0R5rq2tNDcSY36
         b7ilmscDM4PdS04S/iDg0LvKkcsjuIcxXbek2TwQp8EfT/WhvRM7qkQ5n9fsuUmkS9+/
         NIg52EEeKAZQb8mheOhrwBp47SP12HEG61kC578sL4Lgy0OET7gprDq/N933mgdidFxF
         xRBJHb+DMoYv5eWh177zveCMVM9FHRjhIh3zPXbmwAyygvpvLOFCk7Hal8T8/4j3ddAS
         bVakhIuMfZuS6Vqvyyba9bwOynmYXYKAnECX8NJ1+e/3quj1HpWbfdCljebwJr2EkijJ
         hGbg==
X-Gm-Message-State: AOAM532RKMCfMPGSq9/x+Yz+/IOmUp8IJHdik8OGmHReAwHxDxtrHJDG
        MHoEwVJxMXdfaLmmJ44JTtI=
X-Google-Smtp-Source: ABdhPJyRcjkcAEZQyOXj0p3uMsLWVSD/OcJq04wc5X3mLT0WgA/Vzf8XPH/vBltxEyIT0g4kD6tqbA==
X-Received: by 2002:a17:906:e2d3:: with SMTP id gr19mr16517608ejb.483.1634410486097;
        Sat, 16 Oct 2021 11:54:46 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id s24sm7267824edy.38.2021.10.16.11.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 11:54:45 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH 1/3] staging: r8188eu: res_to_status is unused
Date:   Sat, 16 Oct 2021 20:54:44 +0200
Message-ID: <1651786.cOo8FRdMVi@localhost.localdomain>
In-Reply-To: <20211016181343.3686-2-martin@kaiser.cx>
References: <20211016181343.3686-1-martin@kaiser.cx> <20211016181343.3686-2-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, October 16, 2021 8:13:41 PM CEST Martin Kaiser wrote:
> The function res_to_status is not used. Remove it.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/include/osdep_service.h | 5 -----
>  1 file changed, 5 deletions(-)

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Regards,

Fabio



