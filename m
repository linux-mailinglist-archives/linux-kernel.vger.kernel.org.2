Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E38D3C6341
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhGLTLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:11:47 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:33455 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbhGLTLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:11:46 -0400
Received: by mail-io1-f44.google.com with SMTP id z11so2285632iow.0;
        Mon, 12 Jul 2021 12:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CAts2agLd/mnZviBBFETzZ77DFMUAMf4FEiPP0zP5RQ=;
        b=prQQ36rv4Sw12MuIyi1LgST7z1Jj47rQ9uIfZS5YzXrJ/MftZH2TgUMoWF4L0eyjVW
         AY31O/sAAA8UTnR37WNy2I0L4p/bQrkNyA5TCZZkilTVKPlweGy/O92km9GTsSafQGhH
         xHP8Or87496IGtYTIJJs9EtQVY+dxhM7pZdNuPpaIgLRMaq60cOsFilRdoYDSi3BHpeU
         rxX7oJjM7Qz1aOVnX91NIwhgZ2C92vUXqnkaXkw3nhi2qfbFjll4un4i9/XVeF06SGVV
         Fnw54UFiIymICN3HMMmOBsuIgrTI8OiMtSgMMtogVXTOLR3qsCzcDaaWrivMLj0df9gn
         HZSw==
X-Gm-Message-State: AOAM533yNTabmm03RQg7dQA+ukSXM3Ni2poJ1ffHFMwiUoFIXrrb0yU2
        E3WIdY/JrMwGYBhQEnBJfw==
X-Google-Smtp-Source: ABdhPJwjUsnO9+0Rr9NHf6pQZ9akG6i4y38MYh/3uuw8waRTheMGMZgLA8Exn9crR+H/HHiCNGNOXw==
X-Received: by 2002:a02:a68e:: with SMTP id j14mr463927jam.104.1626116937046;
        Mon, 12 Jul 2021 12:08:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b8sm8308873ils.74.2021.07.12.12.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 12:08:56 -0700 (PDT)
Received: (nullmailer pid 2312971 invoked by uid 1000);
        Mon, 12 Jul 2021 19:08:54 -0000
Date:   Mon, 12 Jul 2021 13:08:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 03/13] dt-bindings: usb: mtu3: add support property
 role-switch-default-mode
Message-ID: <20210712190854.GA2312937@robh.at.kernel.org>
References: <1624008558-16949-1-git-send-email-chunfeng.yun@mediatek.com>
 <1624008558-16949-4-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624008558-16949-4-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 17:29:08 +0800, Chunfeng Yun wrote:
> Add support optional property of role-switch-default-mode,
> used to set default mode while usb role is USB_ROLE_NONE when use
> usb-role-switch to switch mode.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: no changes
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
