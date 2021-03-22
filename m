Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D05D3448A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhCVPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhCVPFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:05:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2E7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:05:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id jy13so21816357ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nLv4fWtONtN4I3Bfk3ofpboxP6Eu1rlwkakjExW/W4I=;
        b=wT+yiRV0ypoItrgEtSky5xx2zUYlRaODot1VKECrUtAQEUdx+yEkJK97woBLbJPFWw
         ClSzsyo+s/COXZ9clSovoE8MMGW8pqDqFLg25QhJpA4XwpumbdUOeznMUuOVvZPtfUvb
         /ZUhWRaWAhw4smjcUNx8I7+8TxpoSETKeBxeK7FJxtc/KWaq9mK58hR+6KSfEF7crOSp
         DDnzJUPqs3VtG18t3/yv3dF5JKlSTXAdprR/D6d1XM5HATRw9qIup3Ea7C+vmz9fqNG8
         xhbKLXZgpjtoqrnsGk9hqKgdp+0734Dj+0NrvAcL5rPapDPEgxw0XYe2YuxkdPT7OGYH
         keAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nLv4fWtONtN4I3Bfk3ofpboxP6Eu1rlwkakjExW/W4I=;
        b=ARwDBI769eEKpjWq6eGuOl/Pl80WzXXRv3ZpOuvvUE77bAbnhd21L+FXTvsGh7RMeE
         LSv5arXndLbxQWV2fiX4KsOgY2BUIUWV79XeFmBgKbZMFIIbHXfqjbHYHQvRbP+v/GmZ
         XDkun1Y89hRD0xQEBBbRDJT1gH97lzjC9TLnI8C/EbR6q64mWdSojYTwB2kwkTAt1zD3
         T5smJ8K/ukwxsOFO2LCGxwZXFP5to0L52VryQGbe5hjYXgga0B9iryp1FTmEGlm+P3s3
         BFCoFON5099gJ/XV663GjGSFy5MfO9LiropGyoGWo8OWrl3Hx5MwJWPtbJWApF2ustVS
         tZVQ==
X-Gm-Message-State: AOAM53237D2pXT9f6VEmNmvmRHkjxyF5QYpHO/ZFBkOQRwVM1kvN2xGs
        pW27pM3LYVlobT05kE3yLgRSyCNlQWOW5Q==
X-Google-Smtp-Source: ABdhPJyz82BhNXxtlyO6PIEe0CE2L2G4H1U1PXBXaNAhUGxEzbjdK9Eryuvepj0oHH99SJyUoQLomw==
X-Received: by 2002:a17:906:27c7:: with SMTP id k7mr194550ejc.13.1616425528886;
        Mon, 22 Mar 2021 08:05:28 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id f9sm11349402edq.43.2021.03.22.08.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 08:05:28 -0700 (PDT)
Date:   Mon, 22 Mar 2021 15:05:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: rn5t618: Do not cache various USB related registers
Message-ID: <20210322150526.GA2916463@dell>
References: <20210314110236.5149-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210314110236.5149-1-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2021, Andreas Kemnade wrote:

> These register get reset to their OTP defaults after USB plugging.
> And while at it, also add a missing register for detecting the
> charger type.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/rn5t618.c       | 3 +++
>  include/linux/mfd/rn5t618.h | 1 +
>  2 files changed, 4 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
