Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFAF34D6F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhC2SXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:23:50 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:42894 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhC2SXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:23:16 -0400
Received: by mail-ot1-f47.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so13160694ota.9;
        Mon, 29 Mar 2021 11:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i6ynXVk+/YzfMY8VhF078Q7isoOF+jLX9ajpFiAIr+c=;
        b=Ps9Vn44fINw9UT7dKlnggvDEDglD/gG7phF605vtrAjL74ejFL5VQJTZ3tW/GsEgXk
         jyar8CPEv5Twv+Zc6rpBjA9x3sF7ODhowKZkZL78bApvmH9rMdOI6x6zYDomiiBf+Gi6
         l5r8/SJUCZzm8zMQT847L+h54tZcTWwoJ9UxWrAs4/xNSLV8nSNQ/aOx9lrAL7GpzUcT
         Bs0T4+m8K1Jbc1cej6CnmHObLNL+eG47PJoCiLwM+NKIkaaPE6AfVV0QCJjhO+H4SzGY
         tmdoJEbvBK3or3DQI+aUlvlfMxXfWl9XdR3+UYPE486S54+stc9BIXuP+Inuh9qfS6oy
         Iv9Q==
X-Gm-Message-State: AOAM530GeGC/Sz8DbZW5oILbdAOLa2pJtSqD0OPaDheqPl0VAKiVUzFO
        e0QYfVzzqQC/MjgDbzizLo0h0mmOlg==
X-Google-Smtp-Source: ABdhPJygvWzAAUWR66fWaUD5TINsfeJoHy/KBJTKIWyO8wq6fm60SuHyD/qFSPHQ8nGSbj3l2czKWg==
X-Received: by 2002:a9d:73d0:: with SMTP id m16mr23416722otk.172.1617042196266;
        Mon, 29 Mar 2021 11:23:16 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 10sm3222603otq.10.2021.03.29.11.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 11:23:15 -0700 (PDT)
Received: (nullmailer pid 2830115 invoked by uid 1000);
        Mon, 29 Mar 2021 18:23:14 -0000
Date:   Mon, 29 Mar 2021 13:23:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 1/1] of: base: Fix spelling issue with function param
 'prop'
Message-ID: <20210329182314.GA2829976@robh.at.kernel.org>
References: <20210329152435.900225-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329152435.900225-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 16:24:35 +0100, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/of/base.c:1781: warning: Function parameter or member 'prop' not described in '__of_add_property'
>  drivers/of/base.c:1781: warning: Excess function parameter 'prob' description in '__of_add_property'
>  drivers/of/base.c:1804: warning: Function parameter or member 'prop' not described in 'of_add_property'
>  drivers/of/base.c:1804: warning: Excess function parameter 'prob' description in 'of_add_property'
>  drivers/of/base.c:1855: warning: Function parameter or member 'prop' not described in 'of_remove_property'
>  drivers/of/base.c:1855: warning: Excess function parameter 'prob' description in 'of_remove_property'
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/of/base.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks!
