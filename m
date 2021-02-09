Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A90D315976
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 23:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbhBIW3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 17:29:25 -0500
Received: from mail-oo1-f41.google.com ([209.85.161.41]:42741 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbhBITmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:42:25 -0500
Received: by mail-oo1-f41.google.com with SMTP id g46so4525109ooi.9;
        Tue, 09 Feb 2021 11:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6b5y2jfonq8mD3bhapQvrVV6hIqyDO03kDayMwI1f7o=;
        b=qhhVuFQWDgFxXhxFA+jYBAPahLEBN6OJaY7eKhokl13lflsEp08vga+Dq67cz/5IjG
         7dMwEPNpgy7GpeOc24V2w0MTasrf32H0w0qpnuaiVjrzMpybk/yQKPx3oXGP15TiAuNs
         dn4D/9LqJKq9h0YbDkSVfoY3OHU/QB9MrIQ7S2Q21Ci54g5XhBcKg8i7XcdltMGp4NXJ
         GV7Py3I3ME+0xqAszT1s/rSH6yNSfzeKiZXvs0JLeUZmE6Vz28tkHG/x3qS1HQZRCAfS
         J6oOFG57VqE9mNqBQix2zXkYOVH5koMWxp1m4sF52MRHDQAXAt2HzG6UCl2v5o3r4FRL
         mnpg==
X-Gm-Message-State: AOAM530mhzl3/rgvq8t6wt7ja0Q/l69h3QGK8YI+TmYM8+ceWffJrtjF
        U5SS4QPvUdiUIwu2NOfnNpecds2fOg==
X-Google-Smtp-Source: ABdhPJzEb+6TOW87AfnKdxzZ9Ldho7rHViFKpHVw9B1UL+E21N3MUSbFop1cbCOjs26U1Y0Df5Qfxg==
X-Received: by 2002:a4a:dc99:: with SMTP id g25mr11403336oou.14.1612897731815;
        Tue, 09 Feb 2021 11:08:51 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w10sm738842ote.29.2021.02.09.11.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 11:08:49 -0800 (PST)
Received: (nullmailer pid 4168444 invoked by uid 1000);
        Tue, 09 Feb 2021 19:08:48 -0000
Date:   Tue, 9 Feb 2021 13:08:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        devicetree@vger.kernel.org, stefan@agner.ch, kernel@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com, kernel@puri.sm,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mxsfb: Add interconnect bindings for LCDIF
 path
Message-ID: <20210209190848.GA4168414@robh.at.kernel.org>
References: <20210127114901.26259-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127114901.26259-1-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 12:49:01 +0100, Martin Kepplinger wrote:
> Add optional interconnect properties for the dram path requests.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
