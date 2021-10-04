Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD60421586
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbhJDRwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:52:50 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:36763 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhJDRwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:52:47 -0400
Received: by mail-oi1-f173.google.com with SMTP id y201so22685622oie.3;
        Mon, 04 Oct 2021 10:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6zRZuNIT+xjrODYlZtB6u3cOYxu5UNok+M2nhNfTu0k=;
        b=14o9uS8+i56NQv0n6CmoCpsIRLF9+pmNEET3h7m33ydvLSpfUdf2y/Ge1mhYtAhAXc
         1qJd4zb6xh2K6e+rfs5kuexZZHXayVyKJpcGy/dmPfaExY7Z+evT5eVYgQhQ9rrBEoEE
         pO01MhpeIQ1ElcOc1efqYG8K4zGqEHmExi2t4WtCgXojerF8QXn3FFrX06TDbbvgGofb
         Y2cubm/FRVQyS8O5T81NNEXR1IZ5nwFcVXwTh1u5tQ1xFmBmo7HmraYdXkGo0OyOIkyk
         n2+SMylk/scq8T8nRQ0bcQEo45MIZkBU8xFSBoHRq4h3VwehzJ6OIzR3HU25P1P4Gjhu
         8xGw==
X-Gm-Message-State: AOAM531UR14aoUCAThRe5g4x+3TnEMeCuGe3N0YZ8CLG//MkggNycA1c
        eyVyjd6jEVo/lu4+yLH8Og==
X-Google-Smtp-Source: ABdhPJxR8ab8KCaznBErFa6cOhc5HDtYnjYmeKqBUv+UFudLPe9JWsiqSQbzpiHh09qzFc8a+E22sg==
X-Received: by 2002:a05:6808:16a4:: with SMTP id bb36mr14511171oib.91.1633369858426;
        Mon, 04 Oct 2021 10:50:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p18sm3105821otk.7.2021.10.04.10.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:50:57 -0700 (PDT)
Received: (nullmailer pid 1552482 invoked by uid 1000);
        Mon, 04 Oct 2021 17:50:57 -0000
Date:   Mon, 4 Oct 2021 12:50:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, lee.jones@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jbx6244@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: mfd: syscon: Add rk3368 QoS register
 compatible
Message-ID: <YVs/AZa2c6PTf6Bg@robh.at.kernel.org>
References: <20210925090405.2601792-1-heiko@sntech.de>
 <20210925090405.2601792-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925090405.2601792-2-heiko@sntech.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2021 11:04:04 +0200, Heiko Stuebner wrote:
> Document rk3368 compatible for QoS registers.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> changes in v2:
> - new patch
> 
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
