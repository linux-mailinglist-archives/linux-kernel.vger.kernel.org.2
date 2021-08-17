Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368FC3EE0A3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhHQACc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbhHQAC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:02:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0AAC061764;
        Mon, 16 Aug 2021 17:01:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w6so15620118plg.9;
        Mon, 16 Aug 2021 17:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=78YHZHnJSjDKWg8zjTZj0BCLoUOSU1vHhIJ7lXSskDk=;
        b=gpANUohhW5ovntoe5a6jBaIVPw2LBbR7fbbt73KQZgAs0ckFkkw2W2WCF4C6rjRWoJ
         N72su3YB9tQUFR13DjKz5C0qPCcZ5XGFvTFE6ZKpXS69a8JeSeJjhZuVwMwmDjukcfYx
         eECKeiwLw5dIpPKYIndQMOzcfWVr6sKOweM9DOo9jA7Rz/mojP0HPvcch+W3U+IdShot
         nhkg09h/sO6GvsJwxHVTY2Nf96gNxxfHJUGKWF//3YCcND23x4WHW9pFC50LNrRNFjQA
         jS9wqjaPWHsiBhySp6/pOHJOLJMDb4sjJFHXSzXe8G/tzlk6tIsgUNVPdWmNhs5/PbbV
         llAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=78YHZHnJSjDKWg8zjTZj0BCLoUOSU1vHhIJ7lXSskDk=;
        b=PsYEwicG5pkCUaAwp6FeRoCpg/I0JGS+BUuJy+fSinO6yVS22h65li0gvHHru6SSYe
         k2G3CdnxoWjcb+6ain3iPqUXYOE1XHyXuERYJavMkIWZgSd08n5fmUysPpXeA/zc2zqj
         CtaJPu2pm8mU+P8P3enrBts9mC6JvxjqBYoAjMgY3xm2pSd+ta/PfMPMGWTIq/5oG3Qz
         vhC3K3rIBrErBpkhmhZlxsjLqwNl/bzGNp8meT4swmL3amWA7I/ox6FDJE6Z+GxQ8hDG
         4lcRaNRFBDeWZA62NqLAnx/VHd7a/nk3HtGzuA36GV6eKw75y5CewRkJkd/G/7/ODFlw
         hCPQ==
X-Gm-Message-State: AOAM531HrhLsP03RyQiv1CkxLcysV3VGKpbU3zRzJ7YZteeUk6CmZ7u5
        5thqZitxQs7KxNUNgsjl7MI=
X-Google-Smtp-Source: ABdhPJz8QcDhSLV5QJ2of0M+kIIloIKlQbjPLtgWVbRmX9qZFVxr85khXu2QMr15qvlR6/rQmhhl9Q==
X-Received: by 2002:a17:90a:e88:: with SMTP id 8mr489071pjx.108.1629158516781;
        Mon, 16 Aug 2021 17:01:56 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-92-48-112.hsd1.ca.comcast.net. [73.92.48.112])
        by smtp.gmail.com with ESMTPSA id k22sm260946pff.154.2021.08.16.17.01.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Aug 2021 17:01:56 -0700 (PDT)
Date:   Mon, 16 Aug 2021 17:01:49 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Subject: Re: [PATCH v2 4/6] ARM: dts: aspeed: Add Facebook Cloudripper
 (AST2600) BMC
Message-ID: <20210817000148.GA7547@taoren-ubuntu-R90MNF91>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
 <20210805222818.8391-5-rentao.bupt@gmail.com>
 <CACPK8XcV5On2D4D+SXnfw1M0owwfCL4Su19jOEA7yWpq+T3jLw@mail.gmail.com>
 <20210813034016.GA21895@taoren-ubuntu-R90MNF91>
 <YRaFpq1LvRzMYr/A@lunn.ch>
 <20210814052228.GA1298@taoren-ubuntu-R90MNF91>
 <YRfgv5OknMluW7jj@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRfgv5OknMluW7jj@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 05:26:55PM +0200, Andrew Lunn wrote:
> > Thanks for jumping in. We are using BCM5389 and the MDIO bus is used to
> > access BCM5389 MDC/MDIO interface in Pseudo-PHY mode.
> > 
> > I didn't know drivers/net/dsa, but let me check out the drivers and see
> > if it works in the Cloudripper environment.
> 
> The b53 driver knows about this switch, so please make use of that
> driver. See Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
> for how you describe it in DT.
> 
>     Andrew

Thank you Andrew for looking into it. I will update dts and send out
followup patch after validation (perhaps after v5.15 merge window).


Thanks,

Tao
