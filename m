Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7C03EBC52
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhHMS6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:58:42 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:35428 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhHMS6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:58:36 -0400
Received: by mail-ot1-f44.google.com with SMTP id r19-20020a0568301353b029050aa53c3801so13183263otq.2;
        Fri, 13 Aug 2021 11:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ahbi0HxPkdDvGYRdzmdU3KAyAbBbSPVHz7hpfMgNRg=;
        b=OLWQaiRL6B6wDQfO/ETzoSt2N1zIUnqe5XW+BRkFykjiiRFqrVn5506MftqKdfES6l
         TNHv9oZnuJSFkMQd3D8FCsWvbykoKM74ocLGvVX2gN0CNmcnJuEJfUkySw0+tUn6qj6v
         b51l0k7RmgtKScsL2w6DpZFYaSFvf8DkVWp0ftyhzSzpn7M7G32ESQCZlJ/nQIaDHRye
         n8Vz4VI3eHJsveTryHhFUVupUYrltNBxyU9DyIU/h99cAXDm5Qh+GsutBSRJDvy4DdCh
         X4u2r/hKt7az3MARCqTkxVkqFX2bgw6o9PaNcCRLCcJ0Bh6LhpJ254cCjuDD5LRU7fGX
         iiRA==
X-Gm-Message-State: AOAM532jxgGQ6cYb4l5kmAjZr91JuCNgfjsn1jmcVRlwXdAuHw/Raqc0
        8CN/bJUs1WI/nE5os7e5qoHQiAiiag==
X-Google-Smtp-Source: ABdhPJzHZj/ieyh/1MFb88kr2BlhZDymgMcPqE6HFAZ0U5SqKihtA60K+j/60g02HxtLR08j4ubh8A==
X-Received: by 2002:a05:6830:411c:: with SMTP id w28mr3166930ott.298.1628881087252;
        Fri, 13 Aug 2021 11:58:07 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j6sm431196ooj.11.2021.08.13.11.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 11:58:06 -0700 (PDT)
Received: (nullmailer pid 3864269 invoked by uid 1000);
        Fri, 13 Aug 2021 18:58:05 -0000
Date:   Fri, 13 Aug 2021 13:58:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com,
        olof@lixom.net, arnd@arndb.de, soc@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/7] dt-bindings: ARM: at91: document exegin q5xr5 board
Message-ID: <YRbAvRPdU3qdwkPi@robh.at.kernel.org>
References: <20210805155357.594414-1-claudiu.beznea@microchip.com>
 <20210805155357.594414-4-claudiu.beznea@microchip.com>
 <YRbAOYoRoMCtxuGL@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRbAOYoRoMCtxuGL@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 01:55:53PM -0500, Rob Herring wrote:
> On Thu, 05 Aug 2021 18:53:53 +0300, Claudiu Beznea wrote:
> > Document Exegin Q5xR5 board.
> > 
> > Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > ---
> >  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>

I take that back...
