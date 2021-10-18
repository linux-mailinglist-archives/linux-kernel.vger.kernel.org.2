Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47851431A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 15:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhJRNEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 09:04:01 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:43526 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhJRNEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 09:04:00 -0400
Received: by mail-oi1-f176.google.com with SMTP id o4so24198027oia.10;
        Mon, 18 Oct 2021 06:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YOnWZ/OrL/0Z+7JLpRLhZqEqf75DoO0tvuNb7ZTFIP8=;
        b=GrEN/5dlKlKH8JBe+Wz06SnkLZ8z6/yxJmoDjJZb4fgIFfUweWzbHGkjJ+9KAl1zyO
         79LcjQwa3CgUqBhlHYtoD2iCYeNCZwW3xFs/pXdXOwe/FzJHxAYUymGwjMOWL1ZZj6lE
         hnkhYYa7NAuJEAo/y0NRZEU61v/AyOgSes1COTjwDKHtX8JteB4A2X1D+eXccfU7CCpl
         F/Gv704pCltKB/QZx9AduyGpIgCh4qN3GtY4/lOZ/8Qrp0lIyVvXBQeqb9LCSKNnCLGM
         jitsqukv7wCAFE1H0OeZVHEztJM5IdELOyYosSGB1KaQyZPn7f+URwj/H8UG9z5rSezE
         UTLw==
X-Gm-Message-State: AOAM532ZBT+78+y3F0QGQOpb+FZOfHabo2O3p5tD1N6kiW4AG1yJ6Q6s
        75z2pdayjlkhV2h7Zrh3Kg==
X-Google-Smtp-Source: ABdhPJzKQpu7czzBnVHdLk/3U2YU+oZYjU8hF2Yh/Uf7gAb8z8CCbR7NffEJrdAlo3eBJCQOYK6/9A==
X-Received: by 2002:aca:5d07:: with SMTP id r7mr20134466oib.138.1634562108671;
        Mon, 18 Oct 2021 06:01:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bk8sm2405733oib.57.2021.10.18.06.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 06:01:48 -0700 (PDT)
Received: (nullmailer pid 2159227 invoked by uid 1000);
        Mon, 18 Oct 2021 13:01:47 -0000
Date:   Mon, 18 Oct 2021 08:01:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~okias/devicetree@lists.sr.ht,
        Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>
Subject: Re: [PATCH v3 4/4] dt-bindings: reserved-memory: ramoops: Convert
 txt bindings to yaml
Message-ID: <YW1wO+68XoJtoF19@robh.at.kernel.org>
References: <20211017141700.61201-1-david@ixit.cz>
 <20211017141700.61201-4-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017141700.61201-4-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2021 16:17:00 +0200, David Heidelberg wrote:
> Convert ramoops driver to the YAML syntax.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>  - inherit reserved-memory properties
>  - switch to unevaluatedProperties
> v3:
>  - add type references
>  - enum -> oneOf
>  - define maximum for max-reason
>  - fixed max-reason node and remove accidentally created param: node
>  - example: add root node
> 
>  .../bindings/reserved-memory/ramoops.txt      |  66 --------
>  .../bindings/reserved-memory/ramoops.yaml     | 145 ++++++++++++++++++
>  2 files changed, 145 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reserved-memory/ramoops.txt
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> 

Applied, thanks!
