Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F623D1BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 04:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGVCDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 22:03:12 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:35332 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhGVCDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:03:11 -0400
Received: by mail-io1-f48.google.com with SMTP id d9so4696195ioo.2;
        Wed, 21 Jul 2021 19:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6sstflDi3MceJtIHFwONk/lvZMH4MUOVSwrKCIiFyZQ=;
        b=b36uUHDU7DaoV2kcUUz7943qKicjJXcoYagBtLOE/wgUSVL+SOwmY1j/xQaoKdkW8X
         YNrgcT/1yhe2vVL3hEvlg38FC04JHAPxenckOaHeIs6DAzzIaJfsDNdz3BgKmaVemZEV
         256JP6CK3lBOj5VBfPK+8VFRz09fnB7CWIhGiYQx49bkd80gdbT2Z39oVUyRnEGdYl/P
         O4wToeOWVZuNkTy3juST8iPQmH+isuZOAEM76k09F/z8JhVj9XiQv+opHcBRk3h7HThG
         08/bD/7SrJa8rqpsTKt12C+n12TYQ+SWsWt37fO8p9oaI1KsqZClsDDzklauunjg338b
         LydA==
X-Gm-Message-State: AOAM5316sN2FR8MFgCy5kritaLoIAeHlb16hZlQy7v7S9gl0557cC/nl
        7JnRstsDV2u0WN8T0xc6HA==
X-Google-Smtp-Source: ABdhPJzN9m6CX5jHqO9i8bxgqSuU29i0p7rAhuVMkn2k0nkV36pevPVnZY9zB1Vjk2gU3KqHoraNtw==
X-Received: by 2002:a05:6638:39c2:: with SMTP id o2mr33032388jav.87.1626921826438;
        Wed, 21 Jul 2021 19:43:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i2sm13985246ilq.83.2021.07.21.19.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 19:43:45 -0700 (PDT)
Received: (nullmailer pid 3193118 invoked by uid 1000);
        Thu, 22 Jul 2021 02:43:43 -0000
Date:   Wed, 21 Jul 2021 20:43:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Michael Auchter <michael.auchter@ni.com>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 2/2] dt-bindings: extcon: usbc-tusb320: Add TUSB320L
 compatible string
Message-ID: <20210722024343.GA3193066@robh.at.kernel.org>
References: <V8qR7ITKe7vHKON9lWSnEHZpmCB0ir2RDmvbaENmH4@cp3-web-021.plabs.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <V8qR7ITKe7vHKON9lWSnEHZpmCB0ir2RDmvbaENmH4@cp3-web-021.plabs.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 17:43:35 +0000, Yassine Oudjana wrote:
> Add a compatible string for TUSB320L.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../devicetree/bindings/extcon/extcon-usbc-tusb320.yaml       | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
