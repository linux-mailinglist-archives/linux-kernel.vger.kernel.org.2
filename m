Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32F83F05D2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbhHROLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:11:20 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:40460 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbhHROLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:11:19 -0400
Received: by mail-ot1-f48.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so3788554oth.7;
        Wed, 18 Aug 2021 07:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tqED2XFSCgXLMT9RVvhfNyDjVv93a0+pc2IUiiIQXGw=;
        b=MHx8VqjOo52hRmx6toESBB5RtdrJfq+NuWriyW3htt5lykyriv8jD18GkYFIEeQSJ/
         nQPFEvshu8q+H1fZeaSqnlaLWhhmNSP9UR5XZ7wCsSZFhqzaOyk1Rbz6z9NOqzcipVIH
         Fd8HiMxBWk0x6Mut9ARaPVdFCHCuM3BbrWojKntVK7KdTsmvzhQ10tlFAqAczvvToF8Y
         CXvNBfdoTsg+dMDIh7/a5AbyLnkj4lI9l7JKXME3HGCH37zpcz6qGhuXr3Jl3dQxG9zn
         FfM5zfKnKvN0jpgxAye+yTk0QGkxAciUGm5RRZT6PSavIFY8tGHlALA4lRab/ml+Zazl
         Gsog==
X-Gm-Message-State: AOAM532J8HcVqMfnF/XzY1nFeY4mRmxBVM53AoLYEZ+7xHWue3E7TWBE
        QNIhbRGpozeiFTJMW6+/9w==
X-Google-Smtp-Source: ABdhPJydLRhTyxC612CzNagoCp20Xdt7VcCSkeTxxqNVNohU7xCnXV+ABAwS/hFimq1cZBHDMGFuGQ==
X-Received: by 2002:aca:171a:: with SMTP id j26mr7075944oii.69.1629295844074;
        Wed, 18 Aug 2021 07:10:44 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l8sm1070165oom.19.2021.08.18.07.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 07:10:43 -0700 (PDT)
Received: (nullmailer pid 2532627 invoked by uid 1000);
        Wed, 18 Aug 2021 14:10:42 -0000
Date:   Wed, 18 Aug 2021 09:10:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        linux-usb@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RESEND 1/9] dt-bindings: usb: mtk-xhci: add optional
 property to disable usb2 ports
Message-ID: <YR0U4irxNbITU2R5@robh.at.kernel.org>
References: <1629189389-18779-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629189389-18779-1-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2021 16:36:21 +0800, Chunfeng Yun wrote:
> Add support to disable specific usb2 host ports, it's useful when
> a usb2 port is disabled on some platforms, but enabled on others for
> the same SoC, another case is that the different package may support
> different number of ports.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
