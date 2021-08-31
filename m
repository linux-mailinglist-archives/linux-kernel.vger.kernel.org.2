Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7956C3FCAB5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 17:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbhHaPWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 11:22:03 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:39628 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbhHaPWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 11:22:01 -0400
Received: by mail-oo1-f51.google.com with SMTP id t2-20020a4ae9a2000000b0028c7144f106so5764947ood.6;
        Tue, 31 Aug 2021 08:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KnChAEVxrTS2vGzkfYVhyoU2I80vTd9T7Di2ebg3zxI=;
        b=sfFKBTZMk1S8RuGu/1DdZKXqfyj51EIG3MbQuUl0Oi1livP5GkICiLxQxaKJQtFZ9l
         8zseeTMIfFBFX54HrlwZihrFjxDdh9S5xOHKPRJF+u3H7H+Ivg8fi02N6Xwof5wtSF8q
         imah6Mq1cnn7hfvO7HEgpq5qdsafywMU4kgCLSZEVdPP1F/PMbWB0lbzmeieIYgKDVhE
         1zjorlrcxe/wSa7MP1yJFdiwW/ZQKryZf8GCTjhNBxfedWa0LvyKmKa7wVtYfgH0j5F3
         bwf7uBEwPqQAZIaYBb5DrDUUyKvQwtNj1lI7X50sXTjDUVN8xJeOr3es2EBuD1aHSam7
         jpbA==
X-Gm-Message-State: AOAM531kOZZzTI++D/t1a+dV+Uywb1HHN0wZnggbcC0dhGx44MIn/zue
        lTIdqgtEnZX88AN89sVhjQ==
X-Google-Smtp-Source: ABdhPJxySEK7R7tL98lG7f6HZhd8Ohuj5CDfyoa0kfcVz+hW0QykAQMxZpAefkImAqGZKgT0GBH+iw==
X-Received: by 2002:a4a:c214:: with SMTP id z20mr14989972oop.74.1630423266179;
        Tue, 31 Aug 2021 08:21:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i1sm3574274ooo.15.2021.08.31.08.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 08:21:05 -0700 (PDT)
Received: (nullmailer pid 180861 invoked by uid 1000);
        Tue, 31 Aug 2021 15:21:04 -0000
Date:   Tue, 31 Aug 2021 10:21:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Jiri Kosina <trivial@kernel.org>, linux-hwmon@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: merge max1619 into trivial
 devices
Message-ID: <YS5I4HmcDAUhTUP6@robh.at.kernel.org>
References: <20210819182544.224121-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819182544.224121-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 20:25:43 +0200, Krzysztof Kozlowski wrote:
> Ther Maxim max1619 bindings are trivial, so simply merge it into
> trivial-devices.yaml.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/hwmon/max1619.txt  | 12 ------------
>  .../devicetree/bindings/trivial-devices.yaml         |  2 ++
>  2 files changed, 2 insertions(+), 12 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/max1619.txt
> 

Applied, thanks!
