Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38100349EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhCZB2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:28:53 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:34793 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhCZB2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:28:25 -0400
Received: by mail-io1-f46.google.com with SMTP id x16so3864025iob.1;
        Thu, 25 Mar 2021 18:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QSYctUWgrS4hsfJrFWdQ031cafGGcQTwDybQFBolhng=;
        b=ocj0W9w7wZitsaLKGNIHX88KfMXSXm739mYRAvfLWk4uSkKUSElKOKByeERqARl3GE
         60JieCWP1zhDTJ+VMq8dnNixf628k4oVaks6foCjdjlECSvxhPD8w+mJ3+yR6TzgRpY4
         0rPv00nuYRXbanr900WX1CHyelz3J5A7I/ue3n6NVdb4XuZA6RZWeQ0HeulwecWOBfbB
         khkvrbQF1kY21et8cFGLEonvG8WVQj2mAM1pEfe1Ry/3RqLcp/YzNnwbGZTfY/fPYcJt
         07GQR3dQT6jCyK1JbPe7gVoohDKZA+Ourrfraf18VTOUVbU01pXFqop2nRU2qRWH0pGy
         qqiQ==
X-Gm-Message-State: AOAM531iFTEzrzOCap8SMLIATC5Xf1AtlY/EHwPVhyVVesZFU6aQLqiN
        jW7rjgb+vcczmj8ANergPw==
X-Google-Smtp-Source: ABdhPJzataTwDlairQa1NXvTo4LHeZf5zB4V8U+eO/jqQgu/aPFfCA2K7zZR9AcauFTmLiVN9FVnSA==
X-Received: by 2002:a05:6638:371f:: with SMTP id k31mr9959664jav.143.1616722104414;
        Thu, 25 Mar 2021 18:28:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k17sm3541112ilr.57.2021.03.25.18.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:28:23 -0700 (PDT)
Received: (nullmailer pid 2126079 invoked by uid 1000);
        Fri, 26 Mar 2021 01:28:22 -0000
Date:   Thu, 25 Mar 2021 19:28:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Add trivial device entry for TPS53676
Message-ID: <20210326012822.GA2125974@robh.at.kernel.org>
References: <20210318212441.69050-1-erik.rosen@metormote.com>
 <20210318212441.69050-2-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318212441.69050-2-erik.rosen@metormote.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 22:24:40 +0100, Erik Rosen wrote:
> Add trivial device entry for TPS53676
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
