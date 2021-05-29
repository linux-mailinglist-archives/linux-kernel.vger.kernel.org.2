Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB13394DEB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 21:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhE2T2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 15:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhE2T2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 15:28:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9EAC061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 12:26:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ci15so6937264ejc.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 12:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V0BYx3SvFjfF5mgipNiR/CmM4QVtDRpEmfCJNxJ0jIQ=;
        b=QncXPMM+d5Fru8vrS87mpDXZYKvVHcoSX+OEAuEpP2M+m/ZVbuU+kEoElP/D5T0ZnG
         056l1xhNSZFAJ8B2X14UbOcvvWVSJX3tyhnL9W846jWB2FscbEAa5Ybj6IqaQYLcfGsi
         UP5Xqn39hznSP3W136yFWDVi/SHV8NECevPiewJDy5DAA3f7Qr8pyav6dNvNqFNGIoxC
         oStDokW6ZtlCm/6023afG5oABy6cUdXIz/LS579gJ5qgpCNJVWA6Y2F32lMNYLCQuU4U
         Eg4WYD2M2Cm1QApXYTi5+iomGhUG//DACpKZKi48RJIGqn9it8RUuL5XSriTAuWvbt5v
         +ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V0BYx3SvFjfF5mgipNiR/CmM4QVtDRpEmfCJNxJ0jIQ=;
        b=gxjKexY6H+iTxXIHGiWmx48YBapfvGS/rIa7QyXW0UUoPEBejPCxwhOSeAIqAC0wlB
         hmf3WIXVe8Ox0cYqLCpLIeistb3unOeFi3rUX64IYQTRGJMwL0bq50itb+IdqY7S6dCe
         jJGF8UqzU+JqhOuPcX+V/QrU/zi9CFMBMl70FP5bd+mpsxqBHGFUG8bYVUAX1CQmsRwE
         iRMWLEl856heDcgD1ttpZw1mEl5N4wv7vqQsMyL/KdCxxGJ+A13cWqwU8fn2Sd3Sycuc
         pb7EJQWxYLX6O/9RIX26VZr/ebDjk4bzFyoOcGaY68DxCGeKLJT7M4EK3+EZHVghydmI
         BqKA==
X-Gm-Message-State: AOAM531raIeu3ouzUIThJF+V/Pnsr+qXTYbUezIZJGYYsVsxzo3nhCca
        WpcOQpUbXdDCKnnDOIf85n4=
X-Google-Smtp-Source: ABdhPJxf0ioTgxOlKzf6AeGO+RDdiPgAwuc54OxZaFBeBKX6gZSA2HymWvbgnWeUwi75nZMoIb0MTw==
X-Received: by 2002:a17:907:75e9:: with SMTP id jz9mr14977078ejc.314.1622316417489;
        Sat, 29 May 2021 12:26:57 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id l11sm3873370ejd.103.2021.05.29.12.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 12:26:57 -0700 (PDT)
Date:   Sat, 29 May 2021 22:26:54 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-actions@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: atc260x: Fix n_voltages and min_sel for
 pickable linear ranges
Message-ID: <20210529192654.GA538773@BV030612LT>
References: <20210528230147.363974-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528230147.363974-1-axel.lin@ingics.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2021 at 07:01:47AM +0800, Axel Lin wrote:
> The .n_voltages was missed for pickable linear ranges, fix it.
> The min_sel for each pickable range should be starting from 0.
> Also fix atc260x_ldo_voltage_range_sel setting (bit 5 - LDO<N>_VOL_SEL
> in datasheet).
> 
> Fixes: 3b15ccac161a ("regulator: Add regulator driver for ATC260x PMICs")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> v2: Fix atc260x_ldo_voltage_range_sel setting (bit 5 - LDO<N>_VOL_SEL
> in datasheet).
>  drivers/regulator/atc260x-regulator.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
