Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABE5366098
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhDTUFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:05:15 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:45804 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhDTUFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:05:14 -0400
Received: by mail-ot1-f51.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so31822360otf.12;
        Tue, 20 Apr 2021 13:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/HxOtJjXRLRSor/ODsPfy5BZOXhp79IDyQZu4OyaTbM=;
        b=c11/Tyzbc+k/SgLwCJMyBg9SiF8uUDbp1iN9UR+zf+dNgoW88GWJe2t1BlfQro6bav
         Y+QKim0QoO52ZXjKnkMmKCeOWcFtEOZNVGDMWwKPe2OAekCZK0vz/osZQ7X8P0+UMB+e
         KQhIyGasE58LFrC/TWL/DTkOGjWSemp5FwSo79puo6YlipHRiNd8KAhAE3RDGY6BlfIS
         dBMN9ghdPS1a8vzZFxQYbVq0jTVNvWRUscxuv7OvfWRBVq0TZba2TzNWnj0y04+MAtxS
         eKYJ/2WOumsq4wGLQ1Sf9cdM6bwdcAsQ6ufr78nVveNzJvm1egtZZdXvkBLybRnQTFN3
         sSdQ==
X-Gm-Message-State: AOAM532JqN8f/PG9TJ1S6OEcb2V3YQtVji/P2saAlU0tTzQ0VcwVixdC
        XPqXNToXiSPVn2C9lSgAelROUpecCw==
X-Google-Smtp-Source: ABdhPJwfhMsGLd8dCI8UsdaTln+zjv3z7qFHlTK2dy8VLuAY3ZbTsa1fQZ1mSQcT3X05kHEMYafhWg==
X-Received: by 2002:a9d:64b:: with SMTP id 69mr20371216otn.63.1618949081968;
        Tue, 20 Apr 2021 13:04:41 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l1sm16447oot.40.2021.04.20.13.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 13:04:41 -0700 (PDT)
Received: (nullmailer pid 3722585 invoked by uid 1000);
        Tue, 20 Apr 2021 20:04:40 -0000
Date:   Tue, 20 Apr 2021 15:04:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org, jagan@amarulasolutions.com,
        Marek Vasut <marex@denx.de>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        arnd@arndb.de, robh+dt@kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Ahmad Fatoum <a.fatoum@pengutronix.de>, kuba@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 04/13] dt-bindings: mfd: stm32-timers: remove
 #address/size cells from required properties
Message-ID: <20210420200440.GA3722536@robh.at.kernel.org>
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
 <20210415101037.1465-5-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415101037.1465-5-alexandre.torgue@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 12:10:28 +0200, Alexandre Torgue wrote:
> address-cells and size-cells can't be declared as "required" properties
> as they are not needed if subnodes don't have a "reg" entry.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 

Acked-by: Rob Herring <robh@kernel.org>
