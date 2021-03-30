Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3828234F429
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 00:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhC3WVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 18:21:09 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:33481 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhC3WUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 18:20:46 -0400
Received: by mail-oi1-f181.google.com with SMTP id w70so18104524oie.0;
        Tue, 30 Mar 2021 15:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mcyjEU9ez+tE1XbLqzdhNG48XxctHrMvJR0/lCn8Z44=;
        b=mRNJNLsQPYbPgqnNlWiV5qAEuJ5m/O2u4B6KgJpdnyNETDQeacicpfkUFdDjyu7ezs
         f7+SGsLUuX5lK01iu8CAWpuKV/v30fn42pnHKBQLUK0gZvwoShEMQbhQhu+Bg7OyC9J3
         KJI/Sf8ydzVp7fpcd7/d1IZ/6R39/QI6MCbbpSkIjbIvd+cY1xaBkOf8pWnulexwyKL6
         zjIkVDXfQkqQDDWCHiZP03PBkWbKn36IW7KCE71wx/mnsbGWtcWI42fZKoeocYS9GXby
         Rr1YuE25l9t4RXlQBWZX/DQSY24R8vrnYisjq5gPU4fGW5Fwtn3hboFlP3A5H0Wlt4ao
         amFg==
X-Gm-Message-State: AOAM5317j7zeLgP+lfNkduyR1GqafAJ1SvayaGQGQAlgFsjNYAent/tm
        2leC7CwnykYDxaw/1WalFuZB03RMZw==
X-Google-Smtp-Source: ABdhPJw8Ax1lZspkldAtH9xF0BBrq8cT8LiJTaiFF2YvkOxM+a/WlpNVMVBhumcTmAA0vGFd0oJ22Q==
X-Received: by 2002:aca:a8c3:: with SMTP id r186mr80139oie.129.1617142846066;
        Tue, 30 Mar 2021 15:20:46 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o10sm48333ote.5.2021.03.30.15.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 15:20:45 -0700 (PDT)
Received: (nullmailer pid 817400 invoked by uid 1000);
        Tue, 30 Mar 2021 22:20:44 -0000
Date:   Tue, 30 Mar 2021 17:20:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Drazen Spio <drazsp@gmail.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: amlogic: add MeCool KII/KIII Pro
 bindings
Message-ID: <20210330222044.GA817353@robh.at.kernel.org>
References: <20210329154753.30074-1-christianshewitt@gmail.com>
 <20210329154753.30074-2-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329154753.30074-2-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 15:47:51 +0000, Christian Hewitt wrote:
> Add the board bindings for the MeCool (Videostrong Technology Co., Ltd)
> KII-Pro (S905D) and KIII-Pro (S912) devices.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
