Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC153EEAFB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhHQKbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235204AbhHQKb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:31:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA027600CC;
        Tue, 17 Aug 2021 10:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629196257;
        bh=BxxNEfEkon7WthJuxGlsYjRnS9m+9ksjcTGePwqMEgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NuVPytyt0SZu3yHNad9pEQrINoIXaagtLFgVrlJwGS1mZxrBVnZNxLLrwNiQkKEn0
         4yoymzhT7NhUfeiq4ERTqojSUIfXjxSmS++U/ykel11QHLIYyvWgDZJs7yXmGcgg0c
         EMQyZ8nc5UWo3c67PlkKAe9cnw0RZTKyuJf5naGm95JKCg2eFej1C7TrGfMvwjB+At
         PW84oV393djGxTMWgFJMjQi5K5S/smp0F92ZR+W7j/fg4tPsWNYOvaV1wHZgYuiRbU
         WKEC+a7kmjkb2Q1btZ2cP0CRzwTYOC7kdr1M0YCRxfUTkshQET7lEY60ivJc/vT0f0
         Q0ZWZhkQX5jLw==
Date:   Tue, 17 Aug 2021 16:00:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Brian Kim <brian.kim@hardkernel.com>
Subject: Re: [PATCHv3 5/6] phy: amlogic: meson8b-usb2: Power off the PHY by
 putting it into reset mode
Message-ID: <YRuP3D6EMlaKJOx7@matsya>
References: <20210817041548.1276-1-linux.amoon@gmail.com>
 <20210817041548.1276-6-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817041548.1276-6-linux.amoon@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-08-21, 09:45, Anand Moon wrote:
> Power off the PHY by putting it into reset mode.

Applied, thanks

-- 
~Vinod
