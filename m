Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38EE3C8BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhGNTfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:35:02 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:44606 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhGNTfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:35:01 -0400
Received: by mail-il1-f172.google.com with SMTP id r16so2705075ilt.11;
        Wed, 14 Jul 2021 12:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z54s5QhYSOExzuzpvOFtLoRAPtUfWrEsWWGSgU1PAnE=;
        b=AwWkinJgtIbiWmASnL2jzUSlFIDh8QBCyZF/yxuVJeKg3YnEZXAC7a5PN22UBRdFfP
         1NmLqnt2UhIHs2Ok2/isarH/pKsjPXgnAolZY0v418kJt6OtENbw7s/MUlACrbtz5xO3
         wu/gNhfxC4repz+Qy00FiGSQ45abmcGCC6dy7FC2mmZbp9bPzz9B3CJ1I7uVWnufa+Fp
         ajxwUKn5LjWcziL/ShG+tViOeCNAi2mftVVuKGGrxUAP1b/Va+bhRUobD2YewRky/5mX
         PJvf3Aw4dZVoG0m+4Hy2W/EvYLuME7f+goemKWpLFY2FBAsiDz9qzHH3mW7dgGhIuZ1X
         WavQ==
X-Gm-Message-State: AOAM533FlmX+sQz7Ji0PcEQVo3E+p/ui3Ki3qm1F1d8zuAK9TTxMxrJO
        3XSgVvukxhzRgZXQ3YK3GA==
X-Google-Smtp-Source: ABdhPJx1+SSjmVRQRaFw07erbQbWbdwhTQo0pfdQDmm2BTFj8K/kX7s0rEeQqYhCGvFqwZrjQfskTg==
X-Received: by 2002:a05:6e02:106d:: with SMTP id q13mr7436201ilj.164.1626291128089;
        Wed, 14 Jul 2021 12:32:08 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w10sm1726955ilo.17.2021.07.14.12.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:32:07 -0700 (PDT)
Received: (nullmailer pid 3129884 invoked by uid 1000);
        Wed, 14 Jul 2021 19:32:05 -0000
Date:   Wed, 14 Jul 2021 13:32:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     cl@rock-chips.com
Cc:     linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        zhangqing@rock-chips.com, jbx6244@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, heiko@sntech.de,
        lee.jones@linaro.org
Subject: Re: [PATCH v1 2/3] dt-binding: mfd: syscon: add rk3568 QoS register
 compatible
Message-ID: <20210714193205.GA3129835@robh.at.kernel.org>
References: <20210624114719.1685-1-cl@rock-chips.com>
 <20210624114719.1685-3-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624114719.1685-3-cl@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 19:47:18 +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> Document rk3568 compatible for QoS registers.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
