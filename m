Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3917E3294EF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 23:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245197AbhCAW2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 17:28:50 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:37035 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238616AbhCAReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:34:24 -0500
Received: by mail-oi1-f181.google.com with SMTP id l133so18859319oib.4;
        Mon, 01 Mar 2021 09:34:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SWoA/EVGe64a09ttKHxs6/Dq9zt4tqFzVWgiJaUUDGY=;
        b=BMKOT0kCK7za39ZfRDlIvUIrA4eOyl90dAhH0vYWTjse9NdzMYpYtZlUShAFcDag0I
         WuaAcZXsUgTK06uXADB0vc0aQZsFYfIa88FIfv3tA3k3nxQ6OGqPDWXetl59bePM3J5k
         dk/AsFR2bxJYHGWGdeUMKD9fyjOeG+/NjiSsFe+GbNDKk2IyA8HtoPHHYsdroQH8E0jk
         l8A2bLon0S50pTNFUhgyGewnKODVVeJD6snP2IPKX3qS7N3MYaoU60+xDtfHre7UARvK
         G0uVItWUGCfSGZS8Vdo6DLKCpOGV5BtXdTwAKZjhEqrkqgOn7SaBdhAAejRrWR/Iakrv
         6XLg==
X-Gm-Message-State: AOAM532BD7zc1Q61NQ+kz1Mi6PERZNUfhT3vsN1dSrUqoRLJeNkJ1WEC
        4wMs2Igi7oFm8P02BiGSYw==
X-Google-Smtp-Source: ABdhPJzLaTyv/xQECBkGlZhg26tB4XjSM84gMKEG/XGmkko9nHReB3asuXl6qCGpYDa9RmpXn3JaOA==
X-Received: by 2002:aca:3886:: with SMTP id f128mr11984722oia.127.1614620022393;
        Mon, 01 Mar 2021 09:33:42 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y27sm3444219oix.37.2021.03.01.09.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 09:33:41 -0800 (PST)
Received: (nullmailer pid 295304 invoked by uid 1000);
        Mon, 01 Mar 2021 17:33:40 -0000
Date:   Mon, 1 Mar 2021 11:33:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        andreas@kemnade.info, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] dt-bindings: mfd: ricoh, rn5t618: Trivial: Fix
 spelling mistake of 'additionally'
Message-ID: <20210301173340.GA295251@robh.at.kernel.org>
References: <20210301103309.2404426-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301103309.2404426-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2021 10:33:09 +0000, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/ricoh,rn5t618.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
