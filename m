Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153FB3FCAB8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 17:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbhHaPWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 11:22:20 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:44660 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238853AbhHaPWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 11:22:17 -0400
Received: by mail-ot1-f50.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so23215991otg.11;
        Tue, 31 Aug 2021 08:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iydkFq95FEpeivoCRrL3REow4ynVkrvAtNhFWXbXqTc=;
        b=BiwTmisMolOpUQ5AQZDym1NY2gbhfeEKV1vwdCRRrY8rSb2GRz7VQlC5kmv22q4/JZ
         SEg1AG9v++0xKLYOuFmYANdujWFP8jQY+4kOmsAQhuhDUJ0v6Z5N30+UnWC4oJzwLTW6
         pfJ2EApoIAoQrG0RlBcZRQyIXu3ik/X9573yw2T12MEgL6fh9Hn/rpCxQPhdaCUTRG8b
         PZV++N3P/3RoxnlvbjyH49aee8Wgi+sBK3qhCczpjfuUVZ4KdY9UrX/XDKIsI3LCyEbd
         dsUsIaQx/6nCeDJBgFUjKlXni78MJsi24mn6TVUYhdeNvjdJvsAbG1D7APWDfXxi6hSf
         2tZw==
X-Gm-Message-State: AOAM532qbORgHy6B3uXOf9YSw4DLtiQW+FJNyYTJBICjZ3+Gmf2qHkre
        +xjUgkcPhkHhgv4njVqG9w==
X-Google-Smtp-Source: ABdhPJzdVROAeEU60vayUamOQJIwnsjKstVyAXj2+wmKDPAnvUXvFgPYR3Q3dX73SimpxZFuMmoWhQ==
X-Received: by 2002:a9d:d35:: with SMTP id 50mr24066094oti.22.1630423281834;
        Tue, 31 Aug 2021 08:21:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f126sm3711466oob.9.2021.08.31.08.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 08:21:20 -0700 (PDT)
Received: (nullmailer pid 181416 invoked by uid 1000);
        Tue, 31 Aug 2021 15:21:20 -0000
Date:   Tue, 31 Aug 2021 10:21:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, daniel@ffwll.ch,
        Shawn Guo <shawnguo@kernel.org>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, wanghaibin.wang@huawei.com,
        robh+dt@kernel.org, Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH] dt-bindings: display: remove zte,vou.txt binding doc
Message-ID: <YS5I8OHKifmH9N/O@robh.at.kernel.org>
References: <20210831034924.86-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831034924.86-1-yuzenghui@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021 11:49:24 +0800, Zenghui Yu wrote:
> The zte zx platform was removed in commit 89d4f98ae90d ("ARM: remove zte
> zx platform") and the zxdrm driver is going to be removed in v5.15 via
> drm tree. Let's remove the now obsolete binding doc.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jun Nie <jun.nie@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  .../devicetree/bindings/display/zte,vou.txt   | 120 ------------------
>  1 file changed, 120 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/zte,vou.txt
> 

Applied, thanks!
