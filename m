Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220F4433CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhJSQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:48:07 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:44992 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhJSQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:48:05 -0400
Received: by mail-oi1-f170.google.com with SMTP id y207so5820808oia.11;
        Tue, 19 Oct 2021 09:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tQRdO30lj1+smqS1GfVOmkIefuaVGSlkhExkZ6oireI=;
        b=gRnXiuEhBKVDTN2ETjnA6bEikL7b/Y9CezLJsvtA4zfeqaxEVU8UTpa5gcr9KpAcRO
         YKcBAmd5MSVz9uTKrWXmlU0d9S6BoISN4kpvfJatFXJPSFcHJcIcYtLIiPp0r1OXC4Jh
         pkUIiJgVJA66+ROWCRSnfcfVpzpnkoYfAcae6C6FAGUhuS/QWl6SSwzoKphTtengfvg5
         CvBngEXZvnUZoU18HIknH0iAKTCSBzGr7JMHWYfITTBt0Xnw9DNgUPLDbgB4BKjgNvWc
         GHVesl28H6dSsYvjCbAkz5QawcVtJCFcD8SO2Dl8ARhm6nx6G5ji2vMFg/3Xf0o+PaTB
         PsEg==
X-Gm-Message-State: AOAM531bxYemRmCYG+bCmV8V16J7C7oMulK1DxvdaVeNOOHpfFLaY+5I
        DLHPl5etNrO0FNv5UearPg==
X-Google-Smtp-Source: ABdhPJzh54Bo2MTsWZnfKNk+oUeP7XcHkWt03ZDHvqokiB3CeLL5spn0SGPXftB+ZDn5SxJsf98axQ==
X-Received: by 2002:a05:6808:23c2:: with SMTP id bq2mr5005898oib.32.1634661951911;
        Tue, 19 Oct 2021 09:45:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x28sm3942680ote.24.2021.10.19.09.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 09:45:50 -0700 (PDT)
Received: (nullmailer pid 414336 invoked by uid 1000);
        Tue, 19 Oct 2021 16:45:50 -0000
Date:   Tue, 19 Oct 2021 11:45:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        David Heidelberg <david@ixit.cz>,
        Colin Cross <ccross@android.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 23/23] dt-bindings: reserved-memory: ramoops: update
 ramoops.yaml references
Message-ID: <YW72PlGRB56vM84h@robh.at.kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
 <bccd9c181b68a1ebbaefd5dcce63e1b8a4b1596c.1634630486.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bccd9c181b68a1ebbaefd5dcce63e1b8a4b1596c.1634630486.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 09:04:22 +0100, Mauro Carvalho Chehab wrote:
> Changeset 89a5bf0f22fd ("dt-bindings: reserved-memory: ramoops: Convert txt bindings to yaml")
> renamed: Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> to: Documentation/devicetree/bindings/reserved-memory/ramoops.yaml.
> 
> Update the cross-references accordingly.
> 
> Fixes: 89a5bf0f22fd ("dt-bindings: reserved-memory: ramoops: Convert txt bindings to yaml")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> To mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/
> 
>  Documentation/admin-guide/ramoops.rst | 2 +-
>  MAINTAINERS                           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
