Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9421A39BF7D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 20:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFDSYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFDSYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:24:04 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAE7C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 11:22:18 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t9so8543204pgn.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 11:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UX1G2MyuSMoI9qtV/IxvY2Ox2XX3g0K693XM4XnGuQs=;
        b=brEmXwIeWk511PUJq83cxnT/omO9wa73pzK4DBRRfyw6IWWvIhLLWGnHkQu0cTXiId
         osUMl3zdzBrUmpwlIil/zSWrkJ02MAiC0TmLGGOkxs0YiRQNoKaQ23SXe129ISop5J0w
         psq9IuXjXRSwfDxo+lWbs78DFv2LT0K2q7H8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UX1G2MyuSMoI9qtV/IxvY2Ox2XX3g0K693XM4XnGuQs=;
        b=MvEIE+7rjuJwMDKK02h602AIHXqaAcPrTrjmD5vcYGEvG2PfwFRr89kXCsdQfiEJXM
         y0MMz5q8iv3XSOjjbgyBKE7/jYzjk9FQRj0cQeyZBt5qc96jiHMSMw0sPx304RYfo8Wt
         2A03J5l4tNz1nZ25KeOP3Il4srDuRYeYZOn4Ls2HSbLEDWGKxzqQYeL7nxVmQLvP8Dhw
         bGGpLvWOx6vLMOlPpbglb1EP7s6MUschyOmEq0SNjidvV9huVuG3BAygDqjmJSSlSFm3
         bSQ1lwJ/9hZc0E+eYddhlRBudXtp0zOW8RJb3rwl7/tHSChvT6NDcEqzkXPdlNVCIzG+
         HMaA==
X-Gm-Message-State: AOAM530bdd89McMxuaSEPzzt1/FYucu5oU9dCoxeDHEvwp3fFOnkc5FY
        d51qd69OyA9QTk1UM6RUsCpoCA==
X-Google-Smtp-Source: ABdhPJx/yQn8DS3AzA7xRJxe/WtzLqKi+h8G2XgHEWQGo8dMvTira3vRnBtv6+zBFbCRjJOcdsXa1w==
X-Received: by 2002:a62:148e:0:b029:2e4:e5a5:7e33 with SMTP id 136-20020a62148e0000b02902e4e5a57e33mr5846985pfu.9.1622830937626;
        Fri, 04 Jun 2021 11:22:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t13sm2352888pfh.97.2021.06.04.11.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 11:22:17 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:22:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: mpi3mr: Fix fall-through warning for Clang
Message-ID: <202106041121.41CF254@keescook>
References: <20210604023530.GA180997@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604023530.GA180997@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 09:35:30PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a
> fall-through warning by explicitly adding a break statement instead
> of just letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks right.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
