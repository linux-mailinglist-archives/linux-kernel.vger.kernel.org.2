Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8315F460BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 02:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376686AbhK2BGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 20:06:40 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:39671 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376638AbhK2BEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 20:04:38 -0500
Received: by mail-oi1-f174.google.com with SMTP id bf8so31440027oib.6;
        Sun, 28 Nov 2021 17:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gkyjuo6MmtLiwh7POxoNoQdP1NjooIZOrMils/hYYIE=;
        b=ugnm2Cha7yT7FL49ifJEl7wk3mZMMCpehzthGBrRI09JX0+uryTbTu1HVXT56jyuEq
         G8o4eD+cDfhxLX6guaZTl5SWKY32OAsYoI+LdVkMjmouNK2+4+/dFjxqvScY0F3NMaSG
         LisENgsZEYAOYFkoy9BJE0ZiDdEQkg6Kxv2zRSuvcQ41k43FdD/mIAxRAF4OIbmNOvTx
         ASfT0QUinicICrztDlcPRRkAGWXJsspYe3w2aVW2RwLHC2Bgt03S+QGvca12xdyPxg7E
         APRqs1v14sMYgL2Er89JDM+1zqc83tNnda8aWIsGd18y4bKlFcuroXdwDNdEwHfBPZb2
         r57A==
X-Gm-Message-State: AOAM531lLr600Xe8PauAzaNObj9WAbSYH7/WQ4OQvxkKf8CpHi5Gw8as
        eNGn5ApEmmWr/OhZe4cdAw==
X-Google-Smtp-Source: ABdhPJwr/v9hFcvb1N+bf6bPHrQUb9xfuS63o4Gq1N5QJ09K6S+ZDqeDG+Ki8ve08g69OHSEAFdsTw==
X-Received: by 2002:aca:afc6:: with SMTP id y189mr37224521oie.46.1638147681830;
        Sun, 28 Nov 2021 17:01:21 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.99.229])
        by smtp.gmail.com with ESMTPSA id r22sm2635197oij.36.2021.11.28.17.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 17:01:21 -0800 (PST)
Received: (nullmailer pid 2935047 invoked by uid 1000);
        Mon, 29 Nov 2021 01:01:19 -0000
Date:   Sun, 28 Nov 2021 19:01:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
Cc:     xen-devel@lists.xenproject.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Julien Grall <julien@xen.org>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH V3 6/6] dt-bindings: xen: Clarify "reg" purpose
Message-ID: <YaQmX/OlHFa0F4kD@robh.at.kernel.org>
References: <1637787223-21129-1-git-send-email-olekstysh@gmail.com>
 <1637787223-21129-7-git-send-email-olekstysh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637787223-21129-7-git-send-email-olekstysh@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 22:53:43 +0200, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Xen on Arm has gained new support recently to calculate and report
> extended regions (unused address space) safe to use for external
> mappings. These regions are reported via "reg" property under
> "hypervisor" node in the guest device-tree. As region 0 is reserved
> for grant table space (always present), the indexes for extended
> regions are 1...N.
> 
> No device-tree bindings update is needed (except clarifying the text)
> as guest infers the presence of extended regions from the number
> of regions in "reg" property.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
> According to the recent update to Xen's guest.txt:
> https://xenbits.xen.org/gitweb/?p=xen.git;a=blob_plain;f=docs/misc/arm/device-tree/guest.txt;hb=refs/heads/master
> 
> Changes V2 -> V3:
>    - new patch
> ---
>  Documentation/devicetree/bindings/arm/xen.txt | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
