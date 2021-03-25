Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF4734914F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhCYLzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhCYLzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:55:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6555C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 04:55:02 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k10so2495296ejg.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 04:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rZWmRs5uiiZzbSAbUlT9DJTNuhGAA3GeDnT628NrQ7w=;
        b=BxdtSvV+EZJHW2fk1eKvc8Ht075HnGSovHXfOkT72rSYHXnpbVRQrV3XFwBk5Uz0Ia
         YPTOHsrEV+C/SX8mBa3JTdHvS8+eSGyrq0/hH3s5l1LynwopCgPQznL28ypq95ledDHo
         dU/p7If9ZAEkOdVed9XtTJTg5PESS8Z7xb/xIeziSsGUWraA6H/jNPuB02PNJ03HYtgc
         TdTXg2EHDQQfOEcfw9Q65vrgKdO+atqRmtyT2Ry244nIbWtsg7OOF8J093kK3a3xYflS
         rV1kvTTLdB2kxFQQw+x3Rn69le1RwGPiZFhpBiRqWntzBi5KZmrpQefhTlBQb35DSoQV
         zrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rZWmRs5uiiZzbSAbUlT9DJTNuhGAA3GeDnT628NrQ7w=;
        b=pZXNPl3gQe7W265U7iLGUWkOR2iYZ8jyo9NbT6hvUMfmV/Gyz+ntC4jOcIY4RJwFTY
         ElUP3z6P1MEpsLMS1Qfv1z5/BFmh6mzbxDV3kABDhJmf9SlFP/ZoVPzQN37jzNHmtkSe
         /cQkU/OFU8MkjE5RMKM8eZYxKLNSNFRT4Mvkx2LAEjlJoJWtegGYrx9GsfwQITxVz6oI
         u/J1JvJbnFNHErIM7LqRRJBzOliecvu3t38AtfWXsVgVEbpxB70J5NTHEaFuU0AE56xm
         UUsb54kf2vaudyGUeGUZopGhXF7ge6BrD7T/SkzE/iIEcXWTdsDNyH0455IVi4HkUyxB
         HJLQ==
X-Gm-Message-State: AOAM531J8Qn1jgSRTzYr/N8iGw8KyDZD/VWSP17WMbIpT6ShD+dUMAgV
        Qx/AbixTt/EUrc4oAYfKJDv1Rw==
X-Google-Smtp-Source: ABdhPJzPE/VIPxB5BtQOm53Z531/3bq0GIn3TATCJb4Fkb0yQXA0yz2x6HTeLa+stD5UMjNVUttscw==
X-Received: by 2002:a17:906:6882:: with SMTP id n2mr8901334ejr.50.1616673301376;
        Thu, 25 Mar 2021 04:55:01 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id q10sm2554598eds.67.2021.03.25.04.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 04:55:00 -0700 (PDT)
Date:   Thu, 25 Mar 2021 11:54:59 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v5 5/6] backlight: rt4831: Adds support for Richtek
 RT4831 backlight
Message-ID: <20210325115459.k5lj5wgype5skh57@maple.lan>
References: <1608217244-314-1-git-send-email-u0084500@gmail.com>
 <1608217244-314-5-git-send-email-u0084500@gmail.com>
 <CADiBU38aafx9H1Skz_hHmmkQgCGJSssE1VYBC6WddnGfR3ux1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADiBU38aafx9H1Skz_hHmmkQgCGJSssE1VYBC6WddnGfR3ux1w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 04:22:11PM +0800, ChiYuan Huang wrote:
> Dear reviewers:
> 
>            Didn't get any response about this backlight patch.
> Is there any part need to be refined?

Thanks for the reminders and sorry for the delay. Have just replied
to the original message!


Daniel.
