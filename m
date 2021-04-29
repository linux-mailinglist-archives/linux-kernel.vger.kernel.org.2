Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9313836F17C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbhD2VAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:00:01 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:46672 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbhD2VAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:00:00 -0400
Received: by mail-ot1-f47.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso60732420otb.13;
        Thu, 29 Apr 2021 13:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=obh49y+1a3byoenIm3e/beiu4zdzYImuom9/0sNbr00=;
        b=GNx5ecgqSVTcMOIOuNCcGxBFe8ZAxVRc+BUnXN09zupfd4EJQYuirwafaHbsbxp388
         WM7oiicdyy6luUzC1wa2GzpI2D0BoO7sbAltCUFtENqektU67HRpjV32UY1akpUYfEMG
         8W+sLsh8M14BOe2dtBfr25/IuSiPgBBmsQCM5bHnwoz18dkoVVPSevlj9iv6XzAJmpnK
         T1qkVOGPvQaL17Tgbix3tJppaVcsoAY908k/wml8K7/PCk81gE9kDvb+bWIMEBQ2ckNQ
         u5x1aOyz9w1Fu53P/f22O5D+FIXvGW4h3IY99QwndKlo2Udq/koKxbumZfQs5EpYbC12
         S4TQ==
X-Gm-Message-State: AOAM530W0VRH0QUaCed9jwFvjcTc2H7amt/3Q+lvKjpaXp0N1uByWMSP
        L8UMqb+KFYCsfFI+FakQyg==
X-Google-Smtp-Source: ABdhPJxAjA6/oSOntfg+xpDF1G5G8lYBZjGcGs046yjziy6G4ZKxK0/ldNbEtwrvPm+K4kBIv7ufzg==
X-Received: by 2002:a05:6830:1db9:: with SMTP id z25mr1024968oti.155.1619729953024;
        Thu, 29 Apr 2021 13:59:13 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k16sm241447ooa.36.2021.04.29.13.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 13:59:11 -0700 (PDT)
Received: (nullmailer pid 1766256 invoked by uid 1000);
        Thu, 29 Apr 2021 20:59:11 -0000
Date:   Thu, 29 Apr 2021 15:59:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] dt-binding: interrupt-controller: Add missing interrupts
 property
Message-ID: <20210429205911.GA1765201@robh.at.kernel.org>
References: <20210427224201.32285-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427224201.32285-1-tsbogend@alpha.franken.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2021 00:42:00 +0200, Thomas Bogendoerfer wrote:
> Interrupts property is required, so add it.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  .../bindings/interrupt-controller/idt,32434-pic.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Applied, thanks!

All fine in my build, so not sure what happened to the bot...
