Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AF8399003
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhFBQeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:34:03 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:33684 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhFBQeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:34:00 -0400
Received: by mail-oi1-f181.google.com with SMTP id b25so3291733oic.0;
        Wed, 02 Jun 2021 09:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MO5sg3R6o1x/9JmMk+EKls+YpaHK7tepx48C4f80n+A=;
        b=i7d9RSBvs62JiNOAqDfjuoVfAo5JeNuhPOYNlaPQAT2OR0ytTYNSQqoBKP1oi+WUjq
         oAxNkn6hHgphluzUOKXrJ8mFpqggrvvtahve8d/OX2wDwXDohVsuaecux3XrC10VtstJ
         0Md1/OSqqsu/wuw7sSc+BggMwea1XzrqvpdBZavauwbx14zOZeiB0JBLRmjtpWvv4cNW
         k98k8HyXMT6v8nz72J6ll0zBmsKAJTNMwTIQDLk6W0B6g7VFzF7bVz8ZMINfUPtLm1bE
         ljH8aDabgLeRccegAygLYEloRwyGtPUXKkpT9mbLZk/SvtbuPVLyoU//iXVgs4i/8yvK
         flcw==
X-Gm-Message-State: AOAM530FIWJ3zq+/Ae4xps3Pwk1o4eGTdaVoM8bmXbhOgzIW2myGYEE8
        HU1/D+qkdOWgHMa9JXyzyqCQMFT0tw==
X-Google-Smtp-Source: ABdhPJyAG4p0jwLnN1ofA4m44S5VEYgXz5lQc6yagy/fLTcVyTgwzmoQO9wjPExDeKRuuN7Km4okxQ==
X-Received: by 2002:aca:1718:: with SMTP id j24mr4148451oii.81.1622651521987;
        Wed, 02 Jun 2021 09:32:01 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 88sm86095otb.7.2021.06.02.09.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 09:32:01 -0700 (PDT)
Received: (nullmailer pid 3514071 invoked by uid 1000);
        Wed, 02 Jun 2021 16:32:00 -0000
Date:   Wed, 2 Jun 2021 11:32:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Drew Fustini <drew@beagleboard.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Max Merchel <Max.Merchel@tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH] dt-bindings: add StarFive Technology Co. Ltd.
Message-ID: <20210602163200.GA3513985@robh.at.kernel.org>
References: <20210531070415.269667-1-drew@beagleboard.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531070415.269667-1-drew@beagleboard.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021 00:04:18 -0700, Drew Fustini wrote:
> Add vendor prefix for StarFive Technology Co. Ltd [1]. StarFive was
> formed in 2018 and has now produced their first SoC, the JH7100, which
> contains 64-bit RISC-V cores [2]. It used in the BeagleV Starlight [3].
> 
> [1] https://starfivetech.com/site/company
> [2] https://github.com/starfive-tech/beaglev_doc
> [3] https://github.com/beagleboard/beaglev-starlight
> 
> Signed-off-by: Drew Fustini <drew@beagleboard.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
