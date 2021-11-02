Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879A6442DC6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 13:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhKBM0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 08:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhKBM0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:26:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C7DC061766
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 05:23:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y196so6247956wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 05:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RG4XcfFl99SNeOBcyKQqC0Bs57QgpcfzeSgdEVPV+9Y=;
        b=mXwkh6J03uhB0jI3X/g34Yn8qJcznjAuxyRXzam4PahlNmGvY4U+jVYqX1FYtByfhc
         dN2+I2a6nIy6n884Vpz17p0FkYssBNKjblOSwI0mG1r9Xbuqs7kuOh5EjwqAlzHhNsnp
         S7+6QtUdjAaGXJFZuAuKtsOsDjhRvcqVT7AeEQQlyNTZXH5687WEB9JbrLZ+2USq8pEW
         ZDBEctXEkV21IK08rd/dGQvvFa6j5dS24pkXLhdav/DQFfXJNpqPh0j61oFu5Xsfk//q
         kB6hGiKYEkzKlVI69+tlka+TrivhXGFGDVNNtdnfR8tV7J79IePTogU7bhBiI/FdahRy
         Kayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RG4XcfFl99SNeOBcyKQqC0Bs57QgpcfzeSgdEVPV+9Y=;
        b=0C+cCutFpTO0yv4AFe5vpVAfxyB/vlirnxxxCrl4rkTcOtdzx+v6KFcieKhZd2WrSC
         wXQJvKzHGQihMWRrEqsnTTq202IG/9RWpz0gTFxiPfHtOkkvLZ5cEKSRFBW2X6bKglRB
         P8OiBZhRSXC0DKwOcR42F78/jMwF2h1qz7sYIiGf2xqad3FIEUAJXzKCn8nz1hAiTIp+
         kfmovgOxDMfW8LqbV+tJvzSJ+kqhDswEgmyscBJUBTql+De/i4X6s2PEA8NI92WoJ9nd
         QN9A/SGozEsrlfAQ3IIal8l/UZ9sdK1AWML3aAnLqy8fmsq3K8+yQv26HBFsIbseER8C
         Zfbg==
X-Gm-Message-State: AOAM533JCTtEYJxQpHbiia074GchwWDACCI97/9ScWE0Ae04xnLEP7S0
        lDvJUPYTCV2wIZuEXgCjZv1DsWyC9SmwqaaH
X-Google-Smtp-Source: ABdhPJxsDgM5ZPLfLVKJTJI3JP/w+5g7Z8xe4XK5UcWEFMmoP5kETUDrLTCVO9wue0MqXhVDKU2HKQ==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr6509614wmc.19.1635855814619;
        Tue, 02 Nov 2021 05:23:34 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m35sm3061260wms.2.2021.11.02.05.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 05:23:34 -0700 (PDT)
Date:   Tue, 2 Nov 2021 12:23:31 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] backlight: lp855x: Add dev helper variable to
 lp855x_probe()
Message-ID: <20211102122331.2dzhskz26ean74oq@maple.lan>
References: <20211101185518.306728-1-hdegoede@redhat.com>
 <20211101185518.306728-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101185518.306728-2-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 07:55:16PM +0100, Hans de Goede wrote:
> Add a dev local variable to the lp855x_probe(), to replace "&cl->dev"
> and "lp->dev" in various places.
> 
> Also switch to dev_err_probe() in one case which takes care of not
> printing -EPROBE_DEFER errors for us.
> 
> This is mostly a preparation for adding ACPI enumeration support which
> will use the new "dev" variable more.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
