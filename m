Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3A04422B1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhKAVfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:35:00 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:38499 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhKAVe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:34:59 -0400
Received: by mail-ot1-f51.google.com with SMTP id c2-20020a056830348200b0055a46c889a8so6475974otu.5;
        Mon, 01 Nov 2021 14:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hCy5/rdH3EP/f0UY0j7JtyNiYST+yJ1udugsOF/LEYE=;
        b=gXoyjFSHXii7YiVRMZj1GG115Y4EFwLMEVRTc8xT4xdSjlMf/95l/J1nAtttKUW4pz
         56c2m5FL3WsV1O+tQUpti4uLnG3fadxP40tEmHjxcQVXPsbP3vPrCeL6lYwqtrf9Dhxx
         +MQDoEhPzgppGsDrD0QvgKxdRyOtuxp8ziTPplW6RgQlxiVi2mZjS57vw3feoe/FB4T/
         F1NpE0WGoLByyBbQeUILByynVRlNAovoah49yCmiYHyK2WoVMRt0gN4GHULOM891Bf9s
         2X0ZCzEh7UTWSVlzPNLGtkeD13z95phlbhsV141CwLuEHsiih2qCxww7epB8mZdNn8hi
         Ljgg==
X-Gm-Message-State: AOAM532EFWsxPJhkDFbxHE+oZ46Bq69RwGMedSBITGkOzRShjqfipTYF
        TFx01Uos4kHqByNH9jETPzIAt9h8dA==
X-Google-Smtp-Source: ABdhPJzbfKMCsIhJntczuawzfOIxUC7Vv7zBS5V4IJzEi/WktKP+H/BlI4ncV/CpLisSsb9yeh0KIg==
X-Received: by 2002:a9d:2ac2:: with SMTP id e60mr18743852otb.369.1635802345210;
        Mon, 01 Nov 2021 14:32:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 90sm4352796otj.70.2021.11.01.14.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 14:32:24 -0700 (PDT)
Received: (nullmailer pid 1101334 invoked by uid 1000);
        Mon, 01 Nov 2021 21:32:23 -0000
Date:   Mon, 1 Nov 2021 16:32:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     amelie.delaunay@foss.st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandre.torgue@foss.st.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, linux-usb@vger.kernel.org, hminas@synopsys.com
Subject: Re: [PATCH v2] dt-bindings: usb: dwc2: document the port when
 usb-role-switch is used
Message-ID: <YYBc59SlC+reg1T9@robh.at.kernel.org>
References: <1635336752-14796-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635336752-14796-1-git-send-email-fabrice.gasnier@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 14:12:32 +0200, Fabrice Gasnier wrote:
> Document the "port" property, which is used with "usb-role-switch"
> to describe the bus connector.
> Definition is inspired from mediatek,mtu3.yaml.
> 
> This fixes some errors seen when running "make dtbs_check":
> ... 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
>         From schema: ... Documentation/devicetree/bindings/usb/dwc2.yaml
> 
> Note: add dependencies so that 'usb-role-switch' without port is valid or
> both must be present.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in v2:
> Rob's review comments:
> - drop reference to graph.txt
> - drop unneeded quotes
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
