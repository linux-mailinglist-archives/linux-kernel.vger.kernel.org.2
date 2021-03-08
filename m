Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989E43314CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhCHR0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:26:07 -0500
Received: from mail-il1-f175.google.com ([209.85.166.175]:32964 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhCHRZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:25:47 -0500
Received: by mail-il1-f175.google.com with SMTP id e2so9577921ilu.0;
        Mon, 08 Mar 2021 09:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yx+PQVScsIGkwKCNWq831zfr2nU5g1aEQH/FRbp+2eo=;
        b=kFXicHgWWapI08+G5oGDizk6xgRchx9FZFb49o0OnzFFtz9HloLaJszrdZXhmRRrSb
         8qxbfEd5sYnntKUrGLxflsCIXoWQEPq2bHSSD4yRIeeJoMeFuutxHWTkg/oOuCjgUUrR
         7MycBiT6NroCPkYGjCa/oaW0JmLdCVyfbzMNW8OjkpVZDLcI8+vrj3nvSdF9vsx/jo79
         Fx3NQypZz+ysxIY8NN0ZpMeRgqyXC6W8eUldkmuGqV8BeRJt2h/gbwGcKzZ+CRh7fzeN
         ipKmDd5yPzMgX7WMdtS3UttoBGqtYp+aZjs7PBljqqJuLQU+sjqfa8jm/HSf53eSogke
         Ii7Q==
X-Gm-Message-State: AOAM533FsOe7yldwiGDoBBSzAcxeTYEjWd7nfbfuRGyJtgBxhJVQISQl
        8ad3k8XtD8RxcBcnGlU1yw==
X-Google-Smtp-Source: ABdhPJzzebSLlyB1KvnxCnKMS5WtyQfuusgxeFMojohDlmql8ZD1Mw9P3Dgavl14XuEy1pp8KcDSDw==
X-Received: by 2002:a05:6e02:1a0f:: with SMTP id s15mr21965899ild.244.1615224344976;
        Mon, 08 Mar 2021 09:25:44 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id e4sm6385124ilc.47.2021.03.08.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:25:44 -0800 (PST)
Received: (nullmailer pid 2660915 invoked by uid 1000);
        Mon, 08 Mar 2021 17:25:41 -0000
Date:   Mon, 8 Mar 2021 10:25:41 -0700
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        Jiri Kosina <trivial@kernel.org>, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: trivial-devices: Add infineon,ir36021
Message-ID: <20210308172541.GA2660862@robh.at.kernel.org>
References: <20210301035954.16713-1-chris.packham@alliedtelesis.co.nz>
 <20210301035954.16713-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301035954.16713-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2021 16:59:53 +1300, Chris Packham wrote:
> Add infineon,ir36021 to trivial-devices.yaml.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
