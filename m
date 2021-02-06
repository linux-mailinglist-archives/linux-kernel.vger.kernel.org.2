Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B294311CE0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 12:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhBFLXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 06:23:36 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:37193 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhBFLXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 06:23:32 -0500
Received: by mail-wm1-f50.google.com with SMTP id m1so8075711wml.2;
        Sat, 06 Feb 2021 03:23:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kzfW6WiMXjYesYGQDPS9JlxcoI8ehYDfNNhAn2oCINo=;
        b=ivAEhPK3tshecoqiJC7NNwr2fmp5M2VSB6IJaGWfXlaChrSGLZ4eBqRMFn8tnUlFCG
         OntBP/0lh7xgbsWWXU/9B9nWQuU1tUkVX3/t4ijDwWq+uQkAYykSVrDKfKeupreRpQb8
         0EylE602v6Ft+nzde+wOm8V995eR3p+hyhst1M4g/b93n/Mzv8n+eo13IRa7DvQgU8Cf
         JR7oebtuO4N2vMIrTrA5fNOG8sC4GpwGSFpH9nONzVbxt6DTKB8iitgccvvGQ4ltp9Qw
         4vnjidDKZDMIa5gaVoA7oh+Z10k2yusEx0O0LA6vmHvFhFAl8QDseBKzetgqcmxlJfQr
         xueg==
X-Gm-Message-State: AOAM53274Qr0MEoz1p6U6anbJcvffVrVfL95DWDGgtnvoTVkUndYmpSx
        o3ea3T+RLfeLhEMzoYALmxs=
X-Google-Smtp-Source: ABdhPJx/PULiReV/Ud1AL6i1KrbGmnDJ71+PJK0aFK0m8pp7f7Rc+WTdnksS7oxvvQrgkVLOqySbbA==
X-Received: by 2002:a05:600c:2d44:: with SMTP id a4mr2111357wmg.95.1612610570887;
        Sat, 06 Feb 2021 03:22:50 -0800 (PST)
Received: from kozik-lap (194-95-143-94.dyn.cable.fcom.ch. [94.143.95.194])
        by smtp.googlemail.com with ESMTPSA id s4sm14916348wrt.85.2021.02.06.03.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 03:22:49 -0800 (PST)
Date:   Sat, 6 Feb 2021 12:22:47 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] dt-bindings: arm: fsl: add ls1021a-tsn board
Message-ID: <20210206112247.lososkktc4b624lu@kozik-lap>
References: <20210205234734.3397-1-leoyang.li@nxp.com>
 <20210205234734.3397-2-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210205234734.3397-2-leoyang.li@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 05:47:20PM -0600, Li Yang wrote:
> Add the missing board in the binding docuemnt.

It's not necessarily missing as there are no DTS (in tree) using this
compatible, so maybe rephrase it to:

"Add board compatible for ls1021a-tsn board".

Best regards,
Krzysztof


> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
