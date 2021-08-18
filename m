Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C9F3F0B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 20:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhHRSgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 14:36:24 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:33729 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhHRSgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 14:36:20 -0400
Received: by mail-oi1-f171.google.com with SMTP id n27so4778314oij.0;
        Wed, 18 Aug 2021 11:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G6OJpccSRXfwKCZCc3v21OUpyBNmgZToXNskmRIyk7I=;
        b=DU7D2/zjL71jyLspabULUhCyk+NgBAfaPbH2FcPZgMyJRX6uipNhdAfsQt/FCm7v1k
         YUOBIiq0vaK9UvQ3dsMVx3t1iY0P8oclF2pshaCQZqnFm2lZ/TXkCM/m4p3wl2BKBNj0
         nAHywyroMqb+omVMRfEZ9TTr/CDVr3R0rBFhgC14zGEnMHnsrrrUriRCOzkrVg66Yf+V
         hBrFiICIHsrQ4oEr8BPKGpdV67T/Kb9lqAtjOEP26iaJfUbSPfrvE+l8B1qAFEUOEh9M
         di4qtL+QkvZkG3e24TBquIVwbZSdsTyDMUbPHBx+3ZG4v+0Rmwgp7Wa66UFgC7ujx7c9
         oWNA==
X-Gm-Message-State: AOAM532XqZHrgeOe50kjbgVCgB+/LD/TBS/MSLJYaWShtzNddWcqXEH6
        oog4cxYoZkUyvu+Ll/JscA==
X-Google-Smtp-Source: ABdhPJzDmcf9pWIusWZYcIOPJehR9AWfMAQtPdaXvaovn8dyE8l2BM61R1bHHaOJCkoCYlGGuc4Tyg==
X-Received: by 2002:aca:dd0a:: with SMTP id u10mr8087681oig.41.1629311744758;
        Wed, 18 Aug 2021 11:35:44 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i188sm193215oih.7.2021.08.18.11.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 11:35:44 -0700 (PDT)
Received: (nullmailer pid 2883079 invoked by uid 1000);
        Wed, 18 Aug 2021 18:35:43 -0000
Date:   Wed, 18 Aug 2021 13:35:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        linux-kernel@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        devicetree@vger.kernel.org,
        Cory Tusar <cory.tusar@pid1solutions.com>
Subject: Re: [PATCH v2] dt-bindings: eeprom-93xx46: Convert to json schema
Message-ID: <YR1S/3dQBHBygnOL@robh.at.kernel.org>
References: <20210818105626.31800-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818105626.31800-1-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021 16:26:21 +0530, Aswath Govindraju wrote:
> Convert eeprom-93xx46 binding documentation from txt to yaml format
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> Changes since v1:
> - removed unnecessary '\' from the subject line
> - removed nodename property
> - added type as boolean for read-only property
> - corrected the node name of spi in example
> 
>  .../bindings/misc/eeprom-93xx46.txt           | 29 --------
>  .../bindings/misc/eeprom-93xx46.yaml          | 70 +++++++++++++++++++
>  2 files changed, 70 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/eeprom-93xx46.yaml
> 

Applied, thanks!
