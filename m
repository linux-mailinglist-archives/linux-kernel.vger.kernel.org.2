Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C956B366B42
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbhDUMwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:52:44 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:42523 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240016AbhDUMwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:52:34 -0400
Received: by mail-oi1-f174.google.com with SMTP id n140so42263125oig.9;
        Wed, 21 Apr 2021 05:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zwO8vsC3WF0Gf7xPYT37EC+0RIGJQlGIPk45BXNQjoI=;
        b=grvdIkWuf3ZT8DGVkXokuG4yJmlqziGnXWdZaMxujn/yRddNSVjYOQ56PYcmeC/6QP
         4Y1mfu6OjDFFg8Be8oUKumZu6WUW2Sw66HzGN9jOis0qty2cD5KFgIliGyDzAyqm5fxb
         dW8vYT6qLJiha/y5iwyIYlEQTi55QxxAu7pgXgQc5NL79nin3fH25xLmvJ54OD0wB67i
         hjJthjvKqkw5Fi5YlSqAAy7SpiEtuyT1KFruo5n7zoSvUv1Z5DQjtZEVcgQBqL9+p1kZ
         L99qniCpODaX6HdJpIBiJy7skCpgkp6Cwd7nSE44+zYHIzTwA2jbUiPfdOzvpnS5yEfZ
         Ii+g==
X-Gm-Message-State: AOAM533FA4BY6arVXyH5nFmpSQqnRL3N44oxZ7Fl5IEtNAdxp+tBm/Xe
        QwjNqiz4kJGhy08Cqxct9A==
X-Google-Smtp-Source: ABdhPJwuXxmsp6awIny76czSvcTY/qAULnw3HztMD4Vy1/7UEk9JaKovoI9nMVJars5LmQkTsmaVZQ==
X-Received: by 2002:aca:c74c:: with SMTP id x73mr6718116oif.100.1619009520597;
        Wed, 21 Apr 2021 05:52:00 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c13sm487459otr.51.2021.04.21.05.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 05:51:59 -0700 (PDT)
Received: (nullmailer pid 967440 invoked by uid 1000);
        Wed, 21 Apr 2021 12:51:57 -0000
Date:   Wed, 21 Apr 2021 07:51:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     aik@ozlabs.ru, Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] of/pci: Add IORESOURCE_MEM_64 to resource flags for
 64-bit memory addresses
Message-ID: <20210421125157.GA967343@robh.at.kernel.org>
References: <20210415180050.373791-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415180050.373791-1-leobras.c@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 15:00:51 -0300, Leonardo Bras wrote:
> Many other resource flag parsers already add this flag when the input
> has bits 24 & 25 set, so update this one to do the same.
> 
> Some devices (like virtio-net) have more than one memory resource
> (like MMIO32 and MMIO64) and without this flag it would be needed to
> verify the address range to know which one is which.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> ---
>  drivers/of/address.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Applied, thanks!
