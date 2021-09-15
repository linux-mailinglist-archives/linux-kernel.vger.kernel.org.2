Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D68140C602
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhIONQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:16:01 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:39740 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbhIONP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:15:59 -0400
Received: by mail-oi1-f174.google.com with SMTP id v2so4124592oie.6;
        Wed, 15 Sep 2021 06:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U9iLK0tSsVvo6qJp9SXqhRSLxjtC8EBYGrmrwLb7z0c=;
        b=mNZj7F35/KCNMqxE6Qmt+5yS1J8LjbW6iJ026yUb7jPjuco+Zi+5zk+6WMRACpujXz
         46kbOkPLytIMNfrXLI+aEdLfsKtSeiRT97EKfrurn1/0WLzCU5gKLvUfYRximxsNOnT4
         2u+rqwX6z6IK6ksuCM8g12b6HDGg9SDL9i9JkpB+Lo3jqt2QoxpDboiC4Y/5Px4DFbFr
         +kqs0R/rSAFDVeAsAH7lwUsdR0SNw+anYoW0PhBZOTPT+YNF27PsufklgVcDAX51m+Ue
         uEeseQLbrlj3YnVe08vpoUTvE1PWrli2mTDsp4HE9XiPiGIH14spj9xPKxdM9+OZO5Nf
         OKxA==
X-Gm-Message-State: AOAM530lMnjPk/NewGYGCTuvlgx0rMAchwENagccmIRzWtXAl1LQONnk
        JdVIKAKSVhIo3mRwmMbcDjHezR56Hw==
X-Google-Smtp-Source: ABdhPJxPf15TR81HATeLKU2Ba7ICbL6jj8tpMqVBQurZaztf6SDQQzi4phZ26RCNWb1JtYmRIr5Y+Q==
X-Received: by 2002:aca:645:: with SMTP id 66mr5114955oig.145.1631711679745;
        Wed, 15 Sep 2021 06:14:39 -0700 (PDT)
Received: from robh.at.kernel.org ([12.252.7.226])
        by smtp.gmail.com with ESMTPSA id r13sm3304574oti.80.2021.09.15.06.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 06:14:38 -0700 (PDT)
Received: (nullmailer pid 957931 invoked by uid 1000);
        Wed, 15 Sep 2021 13:14:37 -0000
Date:   Wed, 15 Sep 2021 08:14:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        kernel-team@android.com, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "of: property: fw_devlink: Add support for
 "phy-handle" property"
Message-ID: <YUHxvf7/nAhjnBn+@robh.at.kernel.org>
References: <20210915081933.485112-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915081933.485112-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021 01:19:32 -0700, Saravana Kannan wrote:
> This reverts commit cf4b94c8530d14017fbddae26aad064ddc42edd4.
> 
> Some PHYs pointed to by "phy-handle" will never bind to a driver until a
> consumer attaches to it. And when the consumer attaches to it, they get
> forcefully bound to a generic PHY driver. In such cases, parsing the
> phy-handle property and creating a device link will prevent the consumer
> from ever probing. We don't want that. So revert support for
> "phy-handle" property until we come up with a better mechanism for
> binding PHYs to generic drivers before a consumer tries to attach to it.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Applied, thanks!
