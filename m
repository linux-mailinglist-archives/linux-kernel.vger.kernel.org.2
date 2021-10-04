Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4EE4216D8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbhJDS5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:57:34 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:38877 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbhJDS5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:57:33 -0400
Received: by mail-oi1-f181.google.com with SMTP id u22so22979426oie.5;
        Mon, 04 Oct 2021 11:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UEd/IS2p4s5rX/rYBoB39vVWlsyCBCLryum1tYzyxp4=;
        b=kYw8BZHVIoBa9kD86BEIoZTTVdCtWexy9lA5v31NwkOJWYqFPbRR4X2q22UbGQ8g/c
         XvFuPhIcIevHIFRkg4z6S44ljkOmS3PmnBIyKUIKzZUL84EFNkklD8miSpVmJCKqprq2
         g9VzH8LvKSvDxKJRdHwLRX1WejNhGpAY3RT58adOr+LMxFgVXlTRqR9mPhXfoan8mWgb
         JeFqlvSwWh7fHsdteK1iYjQ6ZDvUb71aiIntBzhjf6TF8zkXWveocTv/4lXjvll1OhX4
         5faZTvL/ptKLmJZa2nQuRPNyaST6evrEpYZGtLSCM7krxr0uSk++USUIBvIzfL5qb1SB
         ipfA==
X-Gm-Message-State: AOAM533EDb2lfTUisnUHBKrsgew1Dz0ufcOVlpi8kKSMhwSXy+7KenZE
        lgXZ/LZdSqp8QFgcp68Y3Wv5NlKJ0w==
X-Google-Smtp-Source: ABdhPJwPR3roneNzQc8Q8oMR4mc+NOgb47AXAP9Wzw3uNHf/WI+AEPLAcGFU5M+464vIGOXaLAdiyQ==
X-Received: by 2002:aca:ebd5:: with SMTP id j204mr14440580oih.14.1633373743507;
        Mon, 04 Oct 2021 11:55:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u2sm3086365otg.51.2021.10.04.11.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:55:43 -0700 (PDT)
Received: (nullmailer pid 1655351 invoked by uid 1000);
        Mon, 04 Oct 2021 18:55:42 -0000
Date:   Mon, 4 Oct 2021 13:55:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Simon Glass <sjg@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 1/2] docs: dt: Fix a few grammar nits in the
 binding/schema docs
Message-ID: <YVtOLlv1mQlYrWED@robh.at.kernel.org>
References: <20211003124936.1.Idc7beddc77250bca0cfb5912b56be719d9073bc4@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211003124936.1.Idc7beddc77250bca0cfb5912b56be719d9073bc4@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Oct 2021 12:50:06 -0600, Simon Glass wrote:
> Add missing hyphens and reword one sentence for clarity.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  .../devicetree/bindings/example-schema.yaml   | 14 ++++-----
>  .../devicetree/bindings/writing-bindings.rst  |  2 +-
>  .../devicetree/bindings/writing-schema.rst    | 29 ++++++++++---------
>  3 files changed, 23 insertions(+), 22 deletions(-)
> 

Applied, thanks!
