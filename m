Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB97372096
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 21:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhECTie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 15:38:34 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:41640 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhECTid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 15:38:33 -0400
Received: by mail-oi1-f175.google.com with SMTP id i11so6476211oig.8;
        Mon, 03 May 2021 12:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1M4X3PlavrXfj4K2ARAUh/7AJZF733FINdqmRwAWbVQ=;
        b=C+rq9AGoG9D34+spo98rHRphOGgUvAnmPYXe/lXKtrKYFew3t1QDtJn6SFXu0ky5ki
         v0AXpTWjJXnalWdjL1QkLyg4OddBlKAW/2e8oX4h6EEAf5znRSAn+jBwbCnodT7xW8OX
         Tpx+IBV9MtGy9hPe1A8lMqEfQcOSMZB8Rn2uJWZKc+WM1bDfUR9g81FRr7J+CsowMf/P
         inpDFUNFagW6RP221QnHcVwltbhr+qoRigKAPjUUsd8whxT8JVg6gg9fkSlYEv5/UZYX
         NuEWCIadraRCWycessXO0y0J013v6pj5dx+uoU83VMWQND3vtux8oAJRgpj+5l8DomO1
         WYZw==
X-Gm-Message-State: AOAM530AD8Y8p7uPd2HuI0YSxES75ftZIJrKeymACRiq6wF4uz8sf18E
        B+E8gX9sw2jxM4dPLe3Yiw==
X-Google-Smtp-Source: ABdhPJwANRe9ajZFRG/0xGwHB7Ts5GDPDpmJPLKS1fTxzzsju7eGTlMMhWPVvoo49ef8496RXAK+iA==
X-Received: by 2002:aca:6505:: with SMTP id m5mr1295817oim.93.1620070659296;
        Mon, 03 May 2021 12:37:39 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a19sm204889otk.31.2021.05.03.12.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 12:37:38 -0700 (PDT)
Received: (nullmailer pid 2257228 invoked by uid 1000);
        Mon, 03 May 2021 19:37:37 -0000
Date:   Mon, 3 May 2021 14:37:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     corbet@lwn.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: Add Texas Instruments TMP1075
Message-ID: <20210503193737.GA2257169@robh.at.kernel.org>
References: <20210429121150.106804-1-robert.marko@sartura.hr>
 <20210429121150.106804-2-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429121150.106804-2-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 14:11:50 +0200, Robert Marko wrote:
> Document the DT compatible for TI TMP1075 which
> is a LM75 compatible sensor.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  Documentation/devicetree/bindings/hwmon/lm75.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
