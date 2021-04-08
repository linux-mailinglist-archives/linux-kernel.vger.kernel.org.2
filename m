Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0671359019
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 01:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhDHXBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 19:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhDHXBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 19:01:49 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2020CC061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 16:01:38 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso2215055pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bMrE4GiUoOivb2bToZQgjp/sVzfX0cAOSgbBK8yv3Rw=;
        b=cii3FE4MB8S8UrXrkif8XXeLL1Mwzb08ZPDQd51qU2KVaRmBoyPGM0ofeaQm3g4YI/
         WXjb7fnwr0EoUzeIa65Jym8Dn3ZuOU3ocqQOVi51W76xCFaBwJVQoJQ921adRrHFV782
         1/pJDHZF7Fq5g8reyvsZcnXhuXqD5KBwo24ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bMrE4GiUoOivb2bToZQgjp/sVzfX0cAOSgbBK8yv3Rw=;
        b=SEkM30KXuUfl6KlI4PQ38v2runFKuurhe7gwSSGN+1tX7TXLrHnd046FmypjDuea0t
         1yV8NnzseqX5mwkbxnYCCZ20AkFXknxvhc/g84TofNDD7APd10o/1al3cYDF9iBfjWVH
         9eAL+dlV04SqNVA+KWbaNEdKuarNiPZbOgeQvcLleM9OnTcPnCkzVgXPiW8m+FAFJdxF
         24+8SUhTNdJ/cBFfuyoHOA5Bm6T3RVgFuDFPttWbIBq0NgOHWMRdOusBK3UmnZ/g7eGN
         Ht9m0IDxirLP6FNOxakqszNdFHWsPHJvuPyN8QyjljlH/9kwoO+QT4EQsUwGUPhmsf6j
         l3Hg==
X-Gm-Message-State: AOAM530dgBB1B9w6+VCYjSdYXdWXJQf8z8zFGd1GOAFUsBZGbWSgCwqf
        f6csm0PXYW0EuStrZ4iioadCPw==
X-Google-Smtp-Source: ABdhPJyEsPr4uBS5yJ3CtibMEZDiJEdrrDZQ2RqP03A+XSaeEUdrXB0sUbmtgzamZphqtZWujV4KcA==
X-Received: by 2002:a17:902:da8d:b029:e5:c7d9:81f2 with SMTP id j13-20020a170902da8db02900e5c7d981f2mr9818988plx.21.1617922897699;
        Thu, 08 Apr 2021 16:01:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d013:d350:4066:89b8])
        by smtp.gmail.com with UTF8SMTPSA id j16sm409909pfa.213.2021.04.08.16.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 16:01:37 -0700 (PDT)
Date:   Thu, 8 Apr 2021 16:01:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v6 3/5] of/platform: Add stubs for
 of_platform_device_create/destroy()
Message-ID: <YG+LUARmg8Dhf1UK@google.com>
References: <20210405201817.3977893-1-mka@chromium.org>
 <20210405124900.v6.3.I08fd2e1c775af04f663730e9fb4d00e6bbb38541@changeid>
 <20210408152112.GA1493009@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210408152112.GA1493009@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 10:21:12AM -0500, Rob Herring wrote:
> On Mon, Apr 05, 2021 at 01:18:15PM -0700, Matthias Kaehlcke wrote:
> > Code for platform_device_create() and of_platform_device_create() is
> 
> platform_device_create()?

ack, should be of_platform_device_destroy()

> > only generated if CONFIG_OF_ADDRESS=y. Add stubs to avoid unresolved
> > symbols when CONFIG_OF_ADDRESS is not set.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > 
> > Changes in v7:
> > - none
> > 
> > Changes in v6:
> > - patch added to the series
> > 
> >  include/linux/of_platform.h | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
> > index 84a966623e78..d15b6cd5e1c3 100644
> > --- a/include/linux/of_platform.h
> > +++ b/include/linux/of_platform.h
> > @@ -61,16 +61,18 @@ static inline struct platform_device *of_find_device_by_node(struct device_node
> >  }
> >  #endif
> >  
> > +extern int of_platform_bus_probe(struct device_node *root,
> > +				 const struct of_device_id *matches,
> > +				 struct device *parent);
> 
> This is also only built for CONFIG_OF_ADDRESS. But there's no need for 
> an empty function as it is powerpc only and should never have a new 
> user.

ok
