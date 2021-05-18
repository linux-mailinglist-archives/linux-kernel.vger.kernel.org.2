Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CB0386F04
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 03:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbhERBRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:17:20 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:37490 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhERBRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:17:17 -0400
Received: by mail-oi1-f180.google.com with SMTP id h9so8264515oih.4;
        Mon, 17 May 2021 18:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vWrYxkhiNpE6IERfqfAJPWaNhb4OcjWZKmlcXbqdkTk=;
        b=oa24HIUlxfKEYSVt6BuWSlhdhxFamXlhLpl6D9e4EDSN5Sm9Qd5I3d79A+/amtSxg4
         Faf+WOHAcozsvB9oIE4KhscJN7IcKQbTbB/BmYbGLesVKQ+T6C5nCmxXdKTD6N2jVLVN
         kFpeRlRy7Jzj5fgiiOpL/bwVCQLMpaGpaMRhu1rN5Sx87Br4aOy0ZqJSypYQNybUjkYn
         5vGDKrEVe4IAfAy8t83ux8MmOo8o/PLjgkaEcdakAFLNCpqXiYyGi8QwbmOyj9uTmxBL
         SCnFJqhJ0e67BN70+mEO+1/00TDAtzbJ4a58bQvdU/yWJPH8EaqujgMnOnj74DeMpZb6
         LRGg==
X-Gm-Message-State: AOAM532Z9n+LEHBT2+aLmyTaMWamxIW6890O977PK5nh+x4rE3ORbT1Y
        CDVn+q60KrXIiSaNIY6mcQ==
X-Google-Smtp-Source: ABdhPJx3WYsEtW/o8RvtlR1yLcZyjHt0PWDM9RLbaNceJyBgykElYBVJ0Oo/kRn6Wyb2iiTqnLi6Wg==
X-Received: by 2002:a05:6808:8cb:: with SMTP id k11mr1449159oij.103.1621300558895;
        Mon, 17 May 2021 18:15:58 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a12sm3466132oti.12.2021.05.17.18.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 18:15:58 -0700 (PDT)
Received: (nullmailer pid 3581134 invoked by uid 1000);
        Tue, 18 May 2021 01:15:57 -0000
Date:   Mon, 17 May 2021 20:15:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: allwinner: add v3s pwm
 compatible
Message-ID: <20210518011557.GA3581104@robh.at.kernel.org>
References: <20210513203527.2072090-1-t.schramm@manjaro.org>
 <20210513203527.2072090-2-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513203527.2072090-2-t.schramm@manjaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 22:35:26 +0200, Tobias Schramm wrote:
> The Allwinner V3s pwm peripheral is compatible with the pwm peripheral
> inside the Allwinner A20.
> This patch adds a compatible string for it.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  .../devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
