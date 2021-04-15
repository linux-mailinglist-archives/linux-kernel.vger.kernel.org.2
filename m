Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B513613E9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 23:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbhDOVLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 17:11:03 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:35745 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbhDOVLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 17:11:02 -0400
Received: by mail-ot1-f47.google.com with SMTP id a2-20020a0568300082b029028d8118b91fso5402913oto.2;
        Thu, 15 Apr 2021 14:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RFTUM3kpVHMQpKJp0D5n10g3xIRWhyl1mr2GUAA9wF0=;
        b=S98vKhG7kk1bPSE82kZFOxBu8VbLnUJeJs2VfUDPxaDc0W3qPEStbU/uWDrl6VWSup
         EWzrZvmCb6XaqBk2coF54zwbJuExr60uT4noJwO3++yfbtyZUz22QZpkAB1PEO8ifGX1
         85Ax4MklzsdR4JHJLFJ9ucy9EwCS4zl7pbDsdMbI3fPbVAB1H8qB9/qQ2Gl159HdRZ98
         Tf9WceGz4dmpXVnjDvEQEPanL3qdvDtHYG/GGhzoVVciLvwGWcZIELgZm0B5pUboWdC+
         foHXs4A9AnqEtS7e244yN+W4gImmhAwqSzvTfcOmVVCwg6EjIcJcjFiCCd4/DLoFnwx1
         Uh5Q==
X-Gm-Message-State: AOAM533C2RpswXCvY95ZWZ3hN0h5/3zir/7WcHjdGKDMDP5R1rvZMbYr
        FKennLlyBP0OqArHhPDNnijx/H+Lkg==
X-Google-Smtp-Source: ABdhPJzJsMok13R3dFBFr48Crt0PrRbspXU0BIMyXh1qcCf9TGdlIws1Yacqg0liv02qLnPp8CXLBw==
X-Received: by 2002:a9d:3424:: with SMTP id v33mr880764otb.137.1618521038900;
        Thu, 15 Apr 2021 14:10:38 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 128sm777263oog.37.2021.04.15.14.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 14:10:38 -0700 (PDT)
Received: (nullmailer pid 1888360 invoked by uid 1000);
        Thu, 15 Apr 2021 21:10:37 -0000
Date:   Thu, 15 Apr 2021 16:10:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     Christian Eggers <ceggers@arri.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] nvmem: eeprom: add documentation for FRAM
Message-ID: <20210415211037.GA1888312@robh.at.kernel.org>
References: <20210413131848.63597-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413131848.63597-1-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2021 15:18:48 +0200, Jiri Prchal wrote:
> Added dt binding documentation.
> 
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
> -v2: fixed dt_binding_check warnings thanks to Rob Herring
> ---
>  .../devicetree/bindings/eeprom/at25.yaml      | 31 +++++++++++++++----
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
