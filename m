Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7653DD187
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 09:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhHBHu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 03:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhHBHuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 03:50:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3AFC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 00:50:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z4so20358803wrv.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 00:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=C+DU4wn47mhR6/BppBpfoHFr7cDt97ix6Cas51Bn3S0=;
        b=vaGCdEG4gfOc3CCT0/Jid2mMLgFAVdbrnSYFF/YRwDk48CjmEdg8wur7WXzmkpwyqJ
         QFhNpwbdP3z4ThYycHRJFB2q/YB8L7q5k9hF9q2NgQuC+FVciFou0cEGl9buS+aKYuO/
         4N87CjX2RUNssZusukmpiO6WfnZDZeEVHH+JOqtVQlAal+f2Djr5OqTxT0uKf8KwiNEK
         mUhuzBP87bnfDN89Q9apHMhiVTKVgU1P9NUeGeKqmdev7O9uSj19H6NsOkp26A+3alP0
         S7mLxvNgv6bGCismfjZs4KTkglOeabwZVN8z2jRzVMs/MLmNcv0HZJDRN6AMk+ThcJdK
         gJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=C+DU4wn47mhR6/BppBpfoHFr7cDt97ix6Cas51Bn3S0=;
        b=fF1/F4vedXj64y52cQQRcr7G6+xmTsjW3fRzIWNPyXT2Ms8QsCkZhh/7NVYjkcKpax
         tPHsT3VcVkmfTlA+NHzC8PrMTbbiN8MP8FWPyJXQ8YqGKfU65XpSlbzwM1+cyjbQHxxc
         buVeLP0CdY4p+wiqeq4ozPeS2VsV5LFyhffiZ6/nVxKwRoDt5TrQMatTYLhDqpijxuh+
         ZBlY7RLrrFYlYz1uRLVL64PRCm2l9t4rhCTFY4qmEapHnTcsQSK1QNwkWPuZTfAq0TPE
         v6TmgVo+7mm1479kGnxonJzVaouS5qv/WewXdni186440fVyDC145SlExM9tfpsNpF4V
         eDEg==
X-Gm-Message-State: AOAM531dsiPX5eR+RVk0mV7u2LxP9J24ilWZe432TaTkgS/Piwbq6TYr
        d9tgvCzXWFUUqRznqMdOoB7njQ==
X-Google-Smtp-Source: ABdhPJyXFkzMsnCoWrMW5F+KKyitkAuZTMGrmA2bkBjRA+pL+bYfoHDb6u5PWjx2loVcMNakBdKSqw==
X-Received: by 2002:adf:e601:: with SMTP id p1mr16586780wrm.14.1627890609173;
        Mon, 02 Aug 2021 00:50:09 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id n30sm11958971wra.1.2021.08.02.00.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 00:50:08 -0700 (PDT)
Date:   Mon, 2 Aug 2021 08:50:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH] scripts: merge_config: add strict mode to fail upon any
 redefinition
Message-ID: <YQejrh2FBCvyPJjI@google.com>
References: <20201202151238.3776616-1-maennich@google.com>
 <CAF2Aj3jS6+RN5mEeF+65MRsyMR9BMecMmxwr3sfjwd64zA6Acw@mail.gmail.com>
 <CAF2Aj3hWWoQvezD4Ma01LrhUwGLobNk40H9ArvjT5+XeNE3vMw@mail.gmail.com>
 <CAK7LNATRc4kJ9vvC1Y6xt88t8w-qKjdZMg_tK+9nZqHqa4bX_g@mail.gmail.com>
 <CAF2Aj3hS0kxrnf+kePWmYAT3A-+PTVQ7_6yWj1nO8BLjwGZGQg@mail.gmail.com>
 <CAK7LNAQh1UR0_04FuiTz5U7b4jthdLoP97K=oJ2c=-E0Qiqh5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQh1UR0_04FuiTz5U7b4jthdLoP97K=oJ2c=-E0Qiqh5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I know of multiple entities who make good use of the script and this extension.
> >
> > My vote is to merge it, but ultimately this is your train set.
> 
> OK, I decided to not care about it too much.
> 
> Now applied to linux-kbuild. Thanks.

Thanks Masahiro.  Much appreciated.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
