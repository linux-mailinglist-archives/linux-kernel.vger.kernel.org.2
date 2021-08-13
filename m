Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1FF3EBA02
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 18:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhHMQ2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 12:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbhHMQ2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 12:28:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60900C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 09:27:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id b15so19232788ejg.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ImhGSizu51qcAiPtd7HLBN22Lau/TM3KbSolcI8f00k=;
        b=RWKHnEj+1M8YE0PLOqaDZVnZjruu6unn14Hg9b/LdOWYpftRNvPZjMNs//UKcqArUM
         dzrwBBifdrrijisFAqQf0rcJv56lQ243uUSSD3M7E5kYWtbrIijb0k7b2DTumc+RUR+d
         hdxPl+vCudjouRaI7Porl5ikUztuZQMxKnrjMWAzPMtB0swUU+riAaswfA024ly8E/5Y
         6TThc4WNFh5/FnpOGBjTx6lLtogvgWsk37h/FhiAXOYSX+qiZWo8fPKT/3VnX3uh5rkg
         mtc4rpcOyNWoih8x/A99IMM4BXVFM4faB7BmyPoLhFlQYmifWPt/k8QlO6W4Spxf4x8W
         F/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ImhGSizu51qcAiPtd7HLBN22Lau/TM3KbSolcI8f00k=;
        b=PLdK43KNNI968DP881m6n6oN5ku6NqvCoWHlGx/q5hdwZ1YTGbo4uJvxRkMSwkhq0w
         Y7OO/U5rziTP/HgWhhKf/X8S6Fkt8pfRhvX/fx4GMJpWfUObeWIlZ6oPjVP99XJE2NCl
         W69h6bq3YCF1DKIervwYcGq/jAunqnfnOY68Rs/lb6xFoRMNhSPDQrnDgTPjYtHWIuea
         FHrvUx9dVzDa3y1t2K9W8/+GM6/kS8TcX9bwleSp212gc18g9etTBMCUO2gPw0Qg+ngE
         2OFkjjraDy8X72fU8jPidlJrEQnjyoS0PAJvCHprATki3c48V+/Xm9lPfyJlTKzoG613
         56TQ==
X-Gm-Message-State: AOAM533vGlQGfnOi6gaNa+gj8XpM7S7Lb4+BS6MJ2KtfY9LOwGUDiT8D
        tdIsGL+VOnYHvsaiqu56CkU=
X-Google-Smtp-Source: ABdhPJwJGwcRLMAAg/iwe4fePXNNMSVl91JwT+NeusWxvJeP2w1mp3sT0YiWL86TjZi6ORQS2PAMbA==
X-Received: by 2002:a17:906:4f03:: with SMTP id t3mr3364891eju.369.1628872069951;
        Fri, 13 Aug 2021 09:27:49 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id h19sm821013ejt.46.2021.08.13.09.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 09:27:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: Re: [PATCH 1/4] staging: r8188eu: remove 5GHz code from Hal_GetChnlGroup88E()
Date:   Fri, 13 Aug 2021 18:27:48 +0200
Message-ID: <7543688.ql1GSxUkq4@localhost.localdomain>
In-Reply-To: <20210813073109.25609-2-straube.linux@gmail.com>
References: <20210813073109.25609-1-straube.linux@gmail.com> <20210813073109.25609-2-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 13, 2021 9:31:06 AM CEST Michael Straube wrote:
> Remove 5GHz code from Hal_GetChnlGroup88E().
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 62 +++++--------------
>  1 file changed, 14 insertions(+), 48 deletions(-)

I missed those lines in my "Remove 5GHz band related code" series.
Nice work, so...

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

Fabio


