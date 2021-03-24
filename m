Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694B4347B26
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbhCXOvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:51:09 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:39693 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbhCXOuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:50:46 -0400
Received: by mail-io1-f44.google.com with SMTP id k25so9662094iob.6;
        Wed, 24 Mar 2021 07:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QY39YouPVNLFxxgepgOlsbrnAYheJKoDtXKK2f2Stuk=;
        b=O92PMtVQixkOrb7mly/ZKIvPMyiD5oN9uBiBr/A/jYGwPVc1EenPuhp/6tfFieO+s8
         dZ+vSXY05VoAcA+dkpkU1UqoL/+vXGcSyWf739J4JwZc6223YCfCxAEWjcliNhXmw/XB
         N0KaDkK6g7LY5FTB1ZAurwjLAKMn1RqRll/KN7drnveGxZanttrJ47aZqZik5E8ncLcx
         +MC8bXh6wfeE6ZRutQcnqePWvzuj0V1lcybRPVNTeMbUucVa1GOsTszOEIvfHKA029Qm
         6P/++spRRs9um9ujDeQRN30b5Ghhk8lRd1i6e2sDGDj8pj4txzat0Gydit9l80iu4BCs
         YPDA==
X-Gm-Message-State: AOAM531bALPb7kvsocQjbGUcLXyDfFakJvvavYeebf7/AWtGXcG727Gt
        M6hfcyY38ofG1Q3xUeqyDQ==
X-Google-Smtp-Source: ABdhPJxnCgeUZbH3x2EEcuMejosC56uKWRGil4qG0hK3Uxj+im+R6tTC06xiJ9xqCGlMvwBFKmxqOg==
X-Received: by 2002:a05:6638:dc3:: with SMTP id m3mr3253704jaj.130.1616597445692;
        Wed, 24 Mar 2021 07:50:45 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k125sm1215133iof.14.2021.03.24.07.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 07:50:45 -0700 (PDT)
Received: (nullmailer pid 3041380 invoked by uid 1000);
        Wed, 24 Mar 2021 14:50:42 -0000
Date:   Wed, 24 Mar 2021 08:50:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: usb: Add chg-psy-name property Maxim
 33359 binding
Message-ID: <20210324145042.GA3036037@robh.at.kernel.org>
References: <20210311100313.3591254-1-badhri@google.com>
 <20210311100313.3591254-4-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311100313.3591254-4-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 02:03:13AM -0800, Badhri Jagan Sridharan wrote:
> chg-psy-name is an optional string property used to indicate the
> power supply object for which the current/voltage_max limits have
> to be set.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> index 93a19eda610b..3a278969109e 100644
> --- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> +++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> @@ -28,6 +28,11 @@ properties:
>      description:
>        Properties for usb c connector.
>  
> +  chg-psy-name:
> +    description: Power supply whose current/voltage_max values to be
> +      configured.
> +    $ref: /schemas/types.yaml#definitions/string

If you want a non-vendor specific property, this needs to be documented 
in a common binding. I think this needs a better explaination and 
examples of multiple chargers.

Rob
