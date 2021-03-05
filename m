Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418D132F6AD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 00:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCEXhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 18:37:34 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:43888 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhCEXha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 18:37:30 -0500
Received: by mail-ot1-f51.google.com with SMTP id v12so3453558ott.10;
        Fri, 05 Mar 2021 15:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=avIgaCjZx7xZP5xD7lCoiVIwwMsR+J1WotAliURSl0o=;
        b=AnUp1YJmFAdbVacWOFxaIHCVmfFq6uH6frL1lw267602F91Wml9jXmM8LpruzMreTX
         0D8fIAMAAilJ+sP5PyUNYkJSf1/VSevCTld+nJlEi1j2xRYi45gSq4Ly1P2FomKg6Ty2
         eHTmylS3Q5+xQ0F12Se764aP4tHPDLt0T/0Dolsh/0yqkm+RgXg7im5oN5xo3BmeukuQ
         GTFj+5N2OmhAfH1CktESMZCcDxjrrugM+aidQ3Fwnu5AAH9Srmkr5dWNuQ+yqGFNvXQu
         RzAB7lji6huQhxCAPKPUWpRRXZcyFrheprS5WNXQVRK7JIACBge99VEvn1ztAwXZuipu
         1aLg==
X-Gm-Message-State: AOAM533NEiUKvLwTNrIRJWpGBJTOd8utdV0Tr98SteYBAtUMnhFbBjlF
        8V7r+ZryrDRulrJjy9gz9w==
X-Google-Smtp-Source: ABdhPJxovQ8qpv7JyGxgqOTDP3NnTNV7W7I55n/ucnyD7O2E6RtW5mx/WJ8qNayfgPWDymD8DWh2uA==
X-Received: by 2002:a9d:7e8d:: with SMTP id m13mr2818607otp.54.1614987450202;
        Fri, 05 Mar 2021 15:37:30 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z13sm973264oth.48.2021.03.05.15.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 15:37:28 -0800 (PST)
Received: (nullmailer pid 850673 invoked by uid 1000);
        Fri, 05 Mar 2021 23:37:26 -0000
Date:   Fri, 5 Mar 2021 17:37:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, airlied@linux.ie, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, pihsun@chromium.org,
        thierry.reding@gmail.com, drinkcat@google.com,
        marcheu@chromium.org, jitao.shi@mediatek.com, daniel@ffwll.ch
Subject: Re: [PATCH 1/2] dt-bindings: display: Add STARRY 2081101QFH032011-53G
Message-ID: <20210305233726.GA850643@robh.at.kernel.org>
References: <20210222153454.20198-1-xiazhengqiao@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222153454.20198-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 23:34:54 +0800, Zhengqiao Xia wrote:
> Add dt-bindings for 10.1" TFT LCD module called STARRY 2081101
> QFH032011-53G.
> 
> Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
> ---
>  .../display/panel/innolux,himax8279d.yaml     | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,himax8279d.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
