Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAEF3A49AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhFKUBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 16:01:23 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:41555 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhFKUBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 16:01:23 -0400
Received: by mail-io1-f50.google.com with SMTP id p66so30567004iod.8;
        Fri, 11 Jun 2021 12:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2MShu2QtVsTqRdskB6+VsVqYV5HgLpTWfQ/M1na3eIs=;
        b=E1Ma9WpzJhqSe3RVBhvO3itkXeI3Te6JefbkrlCOZEDpkUNYOJErbc7Eoxt4wyZtOj
         JqK279HtoNfu9WhtTv39yiJHyYfo495zgBn1fk6QEHysb80aMQtjiYCr86ryZe4mjggI
         HMAG+2Ug3TCPl14REIQmsdS77cx8/pWndeNHrLA5/wJBaaOphLD4s0umAe0fzjcwdwkV
         4rmQ6PoePluj28ErzSHwwqg5DpmClefAJtyUW4PlPPuIL5brpsp37cqo/ZJUJ3gXZLhj
         dcfgysX3Zmw626JiS11jBrkoo/i5XPQMFJkPaQMTjhPah0+bKxU+Zv/kKt1EYv7nkk4G
         adaw==
X-Gm-Message-State: AOAM533y+IShVsc0Glpafl7Bmxzi9b0no6wUCS0uFO6GjfXBo3UqVCTG
        E/abXNhHyIRUFoB/JnhDNg==
X-Google-Smtp-Source: ABdhPJwTFpbeqD9YH9tBdz46jdLN4xy2ht/+rh8ETaVXV5osiP4uPcIJFDR/WZ+x0E7XuQBg0hr5tg==
X-Received: by 2002:a5d:9e41:: with SMTP id i1mr4454339ioi.72.1623441564508;
        Fri, 11 Jun 2021 12:59:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c11sm3971336ils.24.2021.06.11.12.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 12:59:24 -0700 (PDT)
Received: (nullmailer pid 1581560 invoked by uid 1000);
        Fri, 11 Jun 2021 19:59:22 -0000
Date:   Fri, 11 Jun 2021 13:59:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com
Subject: Re: [PATCH] ASoC: dt-bindings: fsl-sai: Add compatible string for
 imx8mm/8mn/8mp/8ulp
Message-ID: <20210611195922.GA1581497@robh.at.kernel.org>
References: <1622613770-10220-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622613770-10220-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021 14:02:50 +0800, Shengjiu Wang wrote:
> Add compatible string for imx8mm/8mn/8mp/8ulp, these platforms all
> support SAI IP.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
