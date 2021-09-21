Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D64413D59
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 00:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhIUWJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 18:09:39 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:40764 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhIUWJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 18:09:37 -0400
Received: by mail-oi1-f179.google.com with SMTP id t189so1363166oie.7;
        Tue, 21 Sep 2021 15:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d1ajkDzMxUdAsr+oENQBXBUU9C5k6BbB8KcPeHP1jeo=;
        b=L1HvgG6mOopjeGM6UNwoovUlKBPnol/C30Inyb0M1CW7FYJP+hdGovwBmlBkT3bOKk
         8bhbGqo/RoSorm7PSfI5JqUdDQRR1p0J93wqHiCP4Xs2NQmo6qG4UJVPb8WTOkRu9tXr
         Jw2eMZGwmMNpKH4g06p2zl+A0gql3ou9FUnxbbAyVrK/as5zGp+vzZ0hbRk2H6tImn6g
         zMJlXoiwCnoFlEgQlK2wMV6+ZQwHJzeP+Lkq9o2ZNFkxEvyLAEhgpENM9pc4yni0azwG
         eEljp7w5/9UMKZNFVuVm9SKflef0mnGLbx+W/bFNVkasAcyaeTRn9kTJ8zv5yCv6QFyL
         LY7Q==
X-Gm-Message-State: AOAM533EbUgBhPzGjuW6zuX645WXcQ6e0vQB9aLZJOEN5JpEcXaHaL3s
        xkUsugRs3B/gGsl378Srm4u8ujRGGQ==
X-Google-Smtp-Source: ABdhPJx7tF4POtth2GJo+rtqsfDF4MRf8Z0WWJWNRcrexRKM690xE6BYi9mhaMgDXmw+Ufv4z/FUxw==
X-Received: by 2002:a05:6808:2002:: with SMTP id q2mr5460957oiw.1.1632262088659;
        Tue, 21 Sep 2021 15:08:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 9sm69296oir.10.2021.09.21.15.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:08:07 -0700 (PDT)
Received: (nullmailer pid 3384758 invoked by uid 1000);
        Tue, 21 Sep 2021 22:08:06 -0000
Date:   Tue, 21 Sep 2021 17:08:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 1/2] dt-bindings: mailbox: Add Apple mailbox bindings
Message-ID: <YUpXxgKFXI7uTWRw@robh.at.kernel.org>
References: <20210916154911.3168-1-sven@svenpeter.dev>
 <20210916154911.3168-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916154911.3168-2-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 17:49:10 +0200, Sven Peter wrote:
> Apple mailbox controller are found on the M1 and are used for
> communication with various co-processors.
> 
> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../bindings/mailbox/apple,mailbox.yaml       | 84 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
