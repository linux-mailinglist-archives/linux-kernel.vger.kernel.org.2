Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A0D3A8CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhFOXn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:43:28 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:38558 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhFOXnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:43:25 -0400
Received: by mail-il1-f173.google.com with SMTP id d1so697901ils.5;
        Tue, 15 Jun 2021 16:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EWFEdVpcxqJ4YsYToxwDqwB2/ISDZb6lR4H0UELvE1I=;
        b=uHxnGl3VCZV0nsWmukMMmBaIZraUaxHr/5+Nkcunvjdm6HABxo+WAnD7JixGUhMZmH
         spcjtgNQBCrz4OtNXoSI+ltKRZyGjd118+gGXnCpe9KEWL+qcyk0Bf2dCtU0Fj9kxsua
         zuLCSJ7oDcCiqzyO+DSHHy2DTwMPV+ZMOT/20jpM7qSIAnNPdEPss4n6i77T9wCc59k6
         BcsRa1xAjTVz1t9o2h1+GzE+yKWDT0zZXlptugThObwkZAJdja48GEgKKYp6XFBkxlFN
         6uIHtjQkab27zhmZwU6P47HX3li+XqwoBwUwmBcEUjdO/OFmUyRYP2wvNAR+6oD+R9NU
         wUAg==
X-Gm-Message-State: AOAM533QoDqPiD2kN/rP8JvMo4+xSTS6UyWryWTTpTyPg0FqtBm7mGif
        bg20suIObz9dNG58yxNLKg==
X-Google-Smtp-Source: ABdhPJywlkSMCEA2eP7CvoATeqTddCXProQipK70vaaoS5osZvCNpAL48tCmeZXKTCV2f/VaCSMzEQ==
X-Received: by 2002:a05:6e02:150:: with SMTP id j16mr1282315ilr.95.1623800479860;
        Tue, 15 Jun 2021 16:41:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k4sm277725ior.55.2021.06.15.16.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 16:41:18 -0700 (PDT)
Received: (nullmailer pid 1681649 invoked by uid 1000);
        Tue, 15 Jun 2021 23:41:15 -0000
Date:   Tue, 15 Jun 2021 17:41:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rudi Heitbaum <rudi@heitbaum.com>
Cc:     pgwipeout@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, ezequiel@collabora.com,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenjh@rock-chips.com
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add support for TCS4526
Message-ID: <20210615234115.GA1681602@robh.at.kernel.org>
References: <20210602112452.GA98@5f9be87369f8>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602112452.GA98@5f9be87369f8>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021 11:24:53 +0000, Rudi Heitbaum wrote:
> Add a compatible string to support the TCS4526 device,
> which is compatible with Fairchild FAN53555 regulators.
> 
> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
> ---
>  Documentation/devicetree/bindings/regulator/fan53555.txt | 2 +-
>  1 file changed, 1 insertions(+), 1 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
