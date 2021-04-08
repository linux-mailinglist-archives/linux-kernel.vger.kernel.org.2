Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966A2358EA0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 22:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhDHUm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 16:42:28 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:46820 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhDHUm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:42:26 -0400
Received: by mail-ot1-f43.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso1717592otb.13;
        Thu, 08 Apr 2021 13:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ksMNUkynqwh36NE05zFBaJrSirKhcoFilHBF+Zu5wHo=;
        b=EZcLYfUfAZuHr3Arff5jHb4HWu78jjkM7w3Uiqe6Ekoqk/vcy2W3b5tcMW2RxKDKji
         UyCx/nfOfqTYJcuOT3caINsBBwQjmEbVF4pN48uBtZeO9hhm7iH1o+sQSdI1VPbToScA
         gCG7TCfg9QvHJL+Q6qHXL0PO+smQs5tWosWZAlF+DRwlQ2AXGAkjp0cMZnO7K4eDE4KW
         rsnhm1KgQdu0WMEfup/nyhG17BPBOS/S3dy0dLtFO8GUSQGGQsQCa+KLEGi8UJah0SLa
         IR/CNSYgamDVUhGmBwKzewsGddrZ60sYB+UemvZ6wCdVa/Ee3HJ/QreLHZGHroi62qzz
         L/Pw==
X-Gm-Message-State: AOAM530iE9jZUex0XUXgUqcAmnzOCvyqmKwS0nKqOIbEx6BAk4n5q7aE
        Jp4zfYmC8j/U7d1a130hDw==
X-Google-Smtp-Source: ABdhPJypfQrcSFzDkeShPblZvM8C4X4an3XFIiS3xHbUv9F//szZVrktAcA4t9YWKwCXT8r3/RIZZA==
X-Received: by 2002:a05:6830:2105:: with SMTP id i5mr9189763otc.215.1617914534437;
        Thu, 08 Apr 2021 13:42:14 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j18sm103820oou.43.2021.04.08.13.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 13:42:13 -0700 (PDT)
Received: (nullmailer pid 1925503 invoked by uid 1000);
        Thu, 08 Apr 2021 20:42:12 -0000
Date:   Thu, 8 Apr 2021 15:42:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v2 2/2] ASoC: dt-bindings: renesas, rsnd: Clear warning
 'ports' does not match any of the regexes
Message-ID: <20210408204212.GA1924190@robh.at.kernel.org>
References: <20210331091616.2306-1-thunder.leizhen@huawei.com>
 <20210331091616.2306-3-thunder.leizhen@huawei.com>
 <20210401202056.GA947212@robh.at.kernel.org>
 <a1aed23d-a9d2-5e05-b1f5-3b48ac8d17f1@huawei.com>
 <15a406ba-b288-c98c-46f1-36933c11fb11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15a406ba-b288-c98c-46f1-36933c11fb11@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 08:28:08PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/4/7 10:04, Leizhen (ThunderTown) wrote:
> > 
> > 
> > On 2021/4/2 4:20, Rob Herring wrote:
> >> On Wed, Mar 31, 2021 at 05:16:16PM +0800, Zhen Lei wrote:
> >>> Currently, if there are more than two ports, or if there is only one port
> >>> but other properties(such as "#address-cells") is required, these ports
> >>> are placed under the "ports" node. So add the schema of property "ports".
> >>
> >> A given binding should just use 'ports' or 'port' depending on it's 
> >> need. Supporting both forms is needless complexity.
> 
> Hi Rob:
> I don't think of a good way to avoid "port" and "ports" to be used at the same time.
> Should I disable the use of "port"? Convert the two usages of "port" into "ports".
> But usually no one will use both of them in one dts file. And even if it's used at
> the same time, it's not a big mistake. So I decided not to test it.

I think the Renesas folks need to comment on this.

Rob
