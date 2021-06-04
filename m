Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A4139BF7C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 20:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhFDSXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFDSXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:23:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8466CC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 11:21:34 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 11so5069563plk.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 11:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J4cr3GvXSuG4D3gzKE/kKLrguvdOyGMMtXTZNVjyaB8=;
        b=NkPmSJ17gUmq9yi5wiRooIBIzKdAZstsqbh8VlI/FD1HCoPstrCFA6+fL+Hj6ejXdh
         6bk3sGxJH6mEAk5JY9PmL8U96bJ9kF4eBnTY1NxQDR94dfrxRGHeHeSBaLS1qQdc0ZCQ
         LdUlijfmP2qf+mXtR1DEWDqlQyiZ2ibBzqdbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J4cr3GvXSuG4D3gzKE/kKLrguvdOyGMMtXTZNVjyaB8=;
        b=p+iAj1qTJ5TfnnMAK4OuHvnVJU0q78gugxOTuzmEMHrDB1L+JnVB3AmxEJDImaE/JJ
         e9zR6y786FSzVszx/g/96lIuSUBtcOKm8/aJlZKfyg8u3qf1cL2O/LF46ebTNyrjvu/q
         K16UyDyoJo2knhGj6V/mZGWMN+9lks8wCM0WX2Mj3xnoOyXQGxVI6eWmrGQ7hlSvfdSQ
         OoJs3wgSBQxXfge9ylsVkjidRuE2cjAJMN8m3ZvX9AQf7zwf5D+JAZuqs0sOID692ZdH
         SYkOpDZm0xA8FCNUTQZ79HcYqo4ebaYiUNiO2asqT4aqNC1Vloy3Q2nfJeOI3GlkM3+X
         efOw==
X-Gm-Message-State: AOAM533ubezZ6TYymM9G4Pc3QZuluRFuGiAjVSVn89795A4O+fp6LT/9
        SBioz6/soRmEXoP8exBcv5yhCg==
X-Google-Smtp-Source: ABdhPJxwmuqGUaEMbhWFHdKZGCTvFvIHvNRyJQOSzn13N6LUaSNNjxuVa76ohg77rSq7qDKhPYEfSA==
X-Received: by 2002:a17:902:7043:b029:104:8fa9:7443 with SMTP id h3-20020a1709027043b02901048fa97443mr5636864plt.64.1622830894023;
        Fri, 04 Jun 2021 11:21:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o7sm2773948pgs.45.2021.06.04.11.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 11:21:33 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:21:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: NCR5380: Fix fall-through warning for Clang
Message-ID: <202106041121.990FFB1387@keescook>
References: <20210604022752.GA168289@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604022752.GA168289@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 09:27:52PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix
> a fall-through warning by replacing a /* fallthrough */ comment
> with the new pseudo-keyword macro fallthrough;
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
