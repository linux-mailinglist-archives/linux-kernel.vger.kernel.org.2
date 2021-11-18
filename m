Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943994565CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 23:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhKRWq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 17:46:56 -0500
Received: from mail-oo1-f47.google.com ([209.85.161.47]:35553 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhKRWqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:46:55 -0500
Received: by mail-oo1-f47.google.com with SMTP id e17-20020a4a8291000000b002c5ee0645e7so3021433oog.2;
        Thu, 18 Nov 2021 14:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PxnCVezNopKR+k8ykkz9LIWuyHdpRUeIr4oh8AQBA8c=;
        b=gK0kNMqwtQxMmX9RmF2Onztdli379xCtyNXWrYfU2PRXskujm8YKs3zWnoRIxe0gAO
         MvoxIN+8gzECDAvUJHokdxDK962ElLkvW1nJgL+hNgwoVFFiFhELByk2pDXbcb59feER
         3b4j5qyjjsoWLBxrHuU6kq3GPUZZOiWpnZgsz0yzy9nv0jrbn8ZM2STonYXiTpf3RzxK
         RCL7GMhcbS2QU4tmfoB09icyn4Byhshlyg1/jYN3AMUPMniuumXEbto0dMZrgbSccRBy
         5c2Yx8enqzDrViR+UOe8taFDftn8T0LmhfUGdnEMZA1PoiWPnAOSk/eXZIFZHEOG8Pym
         bV1g==
X-Gm-Message-State: AOAM530lRmMVYDYQfS7bndNskcAPJiDEnXVmwtKWAaxQ8YjDPsoXRmvg
        3eqReu9zGFG7etLHKsl1Ag==
X-Google-Smtp-Source: ABdhPJwZEiszKbwpz6hrqsSazqPPFsRt5w9KZlN+9P1OkdeFkB3Fa/RXJCmk5rFKGcrFWAaqmNBKsA==
X-Received: by 2002:a4a:9292:: with SMTP id i18mr15333917ooh.90.1637275433084;
        Thu, 18 Nov 2021 14:43:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r26sm222958otn.15.2021.11.18.14.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 14:43:52 -0800 (PST)
Received: (nullmailer pid 1897260 invoked by uid 1000);
        Thu, 18 Nov 2021 22:43:51 -0000
Date:   Thu, 18 Nov 2021 16:43:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     James Lo <james.lo@mediatek.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v15 1/4] dt-bindings: spmi: remove the constraint of reg
 property
Message-ID: <YZbXJ3/C+ovlYEF0@robh.at.kernel.org>
References: <20211115042030.30293-1-james.lo@mediatek.com>
 <20211115042030.30293-2-james.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115042030.30293-2-james.lo@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 12:20:27PM +0800, James Lo wrote:
> 'reg' is controller specific so we shouldn't even be specifying it here.
> Just remove it.
> 
> Signed-off-by: James Lo <james.lo@mediatek.com>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/spmi/spmi.yaml | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
