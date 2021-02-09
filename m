Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A611E315B46
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhBJAdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:33:07 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:45387 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbhBIU5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:57:45 -0500
Received: by mail-ot1-f53.google.com with SMTP id o12so18742297ote.12;
        Tue, 09 Feb 2021 12:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kh/pXJurcIRAYyv8QUbj8W1saTq+ts50VPz/kq0Apmo=;
        b=jCeH/1VLXXcB9M6utehOV1Httf5cHQxy+xylkFSmZI+VFErKx6sGlhwFQFVx4BqSRo
         ZWommOIAd6+O9n/+CLJtzvquUnK2AUjPpEnv5ZZiy9/WpiGOxQkH578ju/OWJ3MPavvG
         bFDpd/Arlv3tyWWyHURYlKQaus6QHsMCNK6y69pgzYj+AyMy7IQWlGqQ0l33bLF8ugsj
         NZQLrXtYoUX4MihDYDjNBc17ApBrMbqL00giBjbyuWVTN6BsshO6P636D2vrkpf3AeFW
         0nQ1x7O2mJoy4S/yaqCLkpW8qG1sMXg7ubErQvz8cv2XIFu+ifVYesQeQffVJ+vIBqUl
         v8+g==
X-Gm-Message-State: AOAM533yQDu20n8HFJ9kORPFA+yFYwfyPPJTo63w++bQ5A7PtsYYItfc
        NBtN79we55YIlwiIbSUySw==
X-Google-Smtp-Source: ABdhPJxThPHlo1ipIaJeoCSyG5mpxGkKBRusWuqdlzGL7BiAGXmACOmsC6EienP1d80u6hXjDG5T1A==
X-Received: by 2002:a05:6830:1bcf:: with SMTP id v15mr5043763ota.232.1612904224590;
        Tue, 09 Feb 2021 12:57:04 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i12sm2731005ots.17.2021.02.09.12.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:57:03 -0800 (PST)
Received: (nullmailer pid 167154 invoked by uid 1000);
        Tue, 09 Feb 2021 20:57:02 -0000
Date:   Tue, 9 Feb 2021 14:57:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Andrei Ziureaev <andrei.ziureaev@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Subject: Re: [PATCH] dt-bindings: Use portable sort for version cmp
Message-ID: <20210209205702.GA167097@robh.at.kernel.org>
References: <20210201165829.58656-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201165829.58656-1-iskren.chernev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Feb 2021 18:58:28 +0200, Iskren Chernev wrote:
> sort -C is like sort -c >/dev/null but less portable. It fails on
> busybox sort (i.e alpine linux).
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> Fixes: ea5b8b5eb004 ("dt-bindings: Add a minimum version check for dtschema")
> ---
>  Documentation/devicetree/bindings/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
