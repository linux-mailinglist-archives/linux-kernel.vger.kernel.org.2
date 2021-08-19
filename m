Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCBE3F1028
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 04:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbhHSCBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 22:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbhHSCBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 22:01:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A774FC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 19:00:28 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b15so9211917ejg.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 19:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IjykLTW5bWXHap6cNd2RLArWAcm8vCbGmYW9Q2CZ23E=;
        b=l2z+o/j1RL87n1mk8Ke/8+bO6OdMOYMBOHMHvfPK7hzoGXj+jMn56G/7Yw1o6Bsh4M
         oGTv45imw2fybnJ/7HiO5FQLOK4MTZCelmJJFMCZlKRfB7CKAeU37YICf3zTuStygHdl
         L0hC/YZgZaCSok53g4u+ty6GoOWmuYMRlmMpmCFKef74koWU2fTzJ6bI7yPbSSKIeGrT
         AgCqtfQV13uOz8hqhaZOGO87mwv52Xkru3CGBJpp9Mun4wM2pQ7qjd3RouOmrJRf7d7S
         Ps2D3ajLlZnWI8TVkWcAwRMyZhr0Zi6bUOfHJ7hC1Sne0RVAOy57HSnE1EDs1MigOHhf
         eMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IjykLTW5bWXHap6cNd2RLArWAcm8vCbGmYW9Q2CZ23E=;
        b=TG3DGbB2RJx6T+HXb/uJgcFjG7lEPqXbq1bIttclP+Vq9gJOx2hOI95U8HRMr1tB9G
         RAG102taCSR2jhokmqSYj6MYKgc2bkHXFLK8hr1jLEnOvyTkKzw14o8WTDTXlIO1pKp+
         pVARByBN6ARk+ZrRrKGY/qcCDk6bkod1pLMIXXTM3GOxma143MWNPqeSB/BL5kDt6IeT
         ButkuP92cRAJAuM1O3mrFg57K17YV2OOrui0WXb2XSOF20n81RAXgD0m6RGxvWH1FJE+
         52eRJUBkfSV7l4EJfrd+TYvQXtDf+j93jYR1pHowzSBislkaEy6DvtHhgy2eO9Q+b999
         DQvQ==
X-Gm-Message-State: AOAM530NtQXYqLw/DdS/jTFceqseCUn7IcwvEdxAz0C1P7odKq//YEaN
        7hrwHvWf3NyIivsPc7J9bWo=
X-Google-Smtp-Source: ABdhPJx4PKwe+zyqeJFROuE20yp45TzzbKuGvmRHDE1nMO9B703n7+gldzNR0j8x/pHeFfYQ4G69zA==
X-Received: by 2002:a17:906:c443:: with SMTP id ck3mr12545874ejb.195.1629338427326;
        Wed, 18 Aug 2021 19:00:27 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id r16sm936755edt.15.2021.08.18.19.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 19:00:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: Re: [PATCH 4/6] staging: r8188eu: remove empty function rtl8188eu_free_xmit_priv
Date:   Thu, 19 Aug 2021 04:00:25 +0200
Message-ID: <3783001.X7UpCbk0Mo@localhost.localdomain>
In-Reply-To: <20210818234253.208271-5-phil@philpotter.co.uk>
References: <20210818234253.208271-1-phil@philpotter.co.uk> <20210818234253.208271-5-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 19, 2021 1:42:51 AM CEST Phillip Potter wrote:
> Remove empty function rtl8188eu_free_xmit_priv from hal/rtl8188eu_xmit.c
> and its declaration from include/rtl8188e_xmit.h, as well as the one
> place where it is stored in the free_xmit_priv function pointer of the
> HalFunc struct inside padapter. This is safe, as the wrapper function
> checks for NULL before calling this function via the function pointer.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/r8188eu/hal/rtl8188eu_xmit.c    | 4 ----
>  drivers/staging/r8188eu/hal/usb_halinit.c       | 1 -
>  drivers/staging/r8188eu/include/rtl8188e_xmit.h | 1 -
>  3 files changed, 6 deletions(-)
> 
It looks good, so...

Acked-by: Fabio M. De Francesco

Thanks,

Fabio


