Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840C331466B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhBICdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 21:33:36 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:38027 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBICdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:33:33 -0500
Received: by mail-oi1-f182.google.com with SMTP id h6so17931203oie.5;
        Mon, 08 Feb 2021 18:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YP9H2kzr/vTSeYjwcofC7D1lobSyVWitvsOWLEGknl4=;
        b=DrauMqVXgug4TJj8aWoZMq9QiFqj9PTjFm0i2JFuHNxTIyZxnMOOsM3xI9BIXsF7GY
         wZtLPYRFfujx4cqJqD9rSLv79Bczes2Ah944Snebpc/yhi6yjuZhATE0Lj7cthq/AiSs
         WC+cI5NMZnds6pCwvYfdNeqNJY81TGrO7d8RXGjxc06OeV23IAQbxs/CmxVUOhljxvzh
         UYfANS6zFAYCJqQGf7HMQwsXA35GxSbOPwgXwyPWiLpfcnJzkcJjXHEU5ULv9BSjcCKD
         /BYbi5VWOMaExjJr0PqcX7lVnhhmtiia0iuIoGAA5adcuq+qgd/dnRlh8Sxxb4nUVlvW
         vGIw==
X-Gm-Message-State: AOAM533PgmqCnYBw8PwiFoEj2jUT/z/HoIvzWfEFW3SzO8TTWPIrA6qt
        WTSf9Ef3PoD4xv+NELJ5ZQ==
X-Google-Smtp-Source: ABdhPJwTjedOokuNw7WiMMGvYnGm7XHgCJ9N26N5tqJrfhaqNtdCHzRKUaXFrJkQzGWJc6jjHzsyUQ==
X-Received: by 2002:a05:6808:1390:: with SMTP id c16mr1070281oiw.27.1612837972353;
        Mon, 08 Feb 2021 18:32:52 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r4sm1984751oig.52.2021.02.08.18.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 18:32:51 -0800 (PST)
Received: (nullmailer pid 2561689 invoked by uid 1000);
        Tue, 09 Feb 2021 02:32:50 -0000
Date:   Mon, 8 Feb 2021 20:32:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: add ebang vendor prefix
Message-ID: <20210209023250.GA2561635@robh.at.kernel.org>
References: <20210120194033.26970-1-michael@walle.cc>
 <20210120194033.26970-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120194033.26970-2-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 20:40:31 +0100, Michael Walle wrote:
> Add vendor prefix for Zhejiang Ebang Communication Co., Ltd.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
