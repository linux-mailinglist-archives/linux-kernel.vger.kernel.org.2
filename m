Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D93399470
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 22:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhFBUUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 16:20:15 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:41751 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhFBUUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 16:20:08 -0400
Received: by mail-ot1-f45.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so3606974oth.8;
        Wed, 02 Jun 2021 13:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vebdrboMoxJ2ynNOUtSmhS7DhcvaGbi5PHtwTdpbVzE=;
        b=AEq/feYukUlNhR1iKw66fB3+L7niVAYrEFBuSAQc9CCZN1hMq1tST1cBPbW+s5Lr/O
         25yj/iR6MIy7H7sRkyA3DZ+YP5og1nUPWHqWZXz5CcEDj40s4awJnHXduLbmh3tszySh
         6NUFJPGthg8waLFCjqSKk6K0tWmQM5dv40JB/IrEt1X8rGedeqzBOQj5jVZJVWkiH74X
         O04hfTCdbSGQ0vgJh40shanWFOhd7LELlW4h5m70A96JyJfBvEOK2EH0VZM6prDLXmdx
         revBVji0bZf/puo5U7+llxcDMJQbNdZHFrLN4Z7R1NThPFPWKIg3KrzC1HBGdLPRxC66
         9hRA==
X-Gm-Message-State: AOAM5310Nib5hblKcS6Zn7ZUEN4vLRPyXWLnBIvwT2VD42uqf2FyANgP
        KEBjKN84mjeyNf351bUQ1g==
X-Google-Smtp-Source: ABdhPJyL41S7wu7tm5ifBbDvtH+KbGHTrj50SiTVbGkKjb/4ZeZo/1f9jl+cjS7m3RF8q+2GcPxsQg==
X-Received: by 2002:a9d:ea2:: with SMTP id 31mr28317972otj.200.1622665104285;
        Wed, 02 Jun 2021 13:18:24 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u13sm197929oop.40.2021.06.02.13.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:18:23 -0700 (PDT)
Received: (nullmailer pid 3922309 invoked by uid 1000);
        Wed, 02 Jun 2021 20:18:22 -0000
Date:   Wed, 2 Jun 2021 15:18:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, badhri@google.com, robh+dt@kernel.org,
        heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2] dt-bindings: connector: Replace BIT macro with
 generic bit ops
Message-ID: <20210602201822.GA3922246@robh.at.kernel.org>
References: <20210527121029.583611-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527121029.583611-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 20:10:29 +0800, Kyle Tso wrote:
> BIT macro is not defined. Replace it with generic bit operations.
> 
> Fixes: 630dce2810b9 ("dt-bindings: connector: Add SVDM VDO properties")
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
> Changes since v1:
> - re-word the commit message
> 
>  include/dt-bindings/usb/pd.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
