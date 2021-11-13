Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B0544F130
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 05:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbhKME3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 23:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhKME3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 23:29:10 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1597C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 20:26:18 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id r130so10142300pfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 20:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BuTmni9+blzLOTRIMKhCJ1nxNvt0c6aYg/O8i2nIy3k=;
        b=NplehF98oenMincve60Zvm8BE7vi4DI1cc+GlVi1c1zsRyUCoYLZDhdVj+/AtT4KWF
         KfIH471shgv+ywejG8QrBLogFxu66CCrPXS49BbFoiu4A0E7joV2fvzXcf1GbSgNtOq4
         kUvyUUUeAdflv5AuYaLw4geOjsp/JqcoXnTn3E5JFFsuvsfTc5u52Yv6BwQuVbFIDSk+
         CgulRKIOQNacmsRmlJYiGIZhXiGYAlyBcAS4XgrElQo1hDCu6iTO+YCv2d+otsRLD+TC
         XNbnP+uuWm+j+ZLE+yLGrNEq2QjE1m3nKV/9vBw4aApp6ikSF00whFI207Z6/NXfLikA
         A/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BuTmni9+blzLOTRIMKhCJ1nxNvt0c6aYg/O8i2nIy3k=;
        b=RSQMNwQsAtQXdky8iH9gxAdw7EZiOFaVwlWA1Adbhb9Jh3OUYRHMzdGwliL5RUIhAo
         UdCfszsITL5HwhHPz9c0wy8Q33ReyYYmVrOaBhry9x+5TgtICAqPsOptgADMJnkzeUM0
         ZstfUNq22IzmQUOq4sN1eiEHMtmFRurRy9qYCdUU66L2zFdJuNnwKQpPYPiUGv2u2MYr
         qIl2LXPOTYa3JzOAC9nN2/WMctM+Vr85KefSc4+aBF8XpHvSmBZWncK1TA+CC7qm5uw+
         sA04NcNZ7hlCu15ixmg/kyqp79Q7qhSbnqNIrzg8RAK9y33eWy+R0cK/uE0VjiGXH9nH
         cU1Q==
X-Gm-Message-State: AOAM532+q9kl+3IYhd6GrESvdq6goUsAJJ2txdXXDcacmGNZ6TPH6k51
        0R9PPTlOWU42Xt7h3iFEM/I=
X-Google-Smtp-Source: ABdhPJzBFkovYPgKIdkl/wQbr+0auIH9AY2hwYcIkuEn5/HGY1ve1tGvLvjyR7NEL7laEAAyOwI5ig==
X-Received: by 2002:a63:171a:: with SMTP id x26mr13315501pgl.323.1636777578227;
        Fri, 12 Nov 2021 20:26:18 -0800 (PST)
Received: from [10.230.0.248] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id t13sm7783806pfl.98.2021.11.12.20.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 20:26:17 -0800 (PST)
Message-ID: <4c99502a-d1fa-0752-77e6-28ca928e4ddf@gmail.com>
Date:   Fri, 12 Nov 2021 20:26:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/2] ARM: multi_v7_defconfig: Enable Broadcom STB USB
 drivers
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Joel Stanley <joel@jms.id.au>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Saravana Kannan <saravanak@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20211030025715.13296-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211030025715.13296-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/2021 7:57 PM, Florian Fainelli wrote:
> Enable CONFIG_PHY_USB_BRCM (USB PHY driver) and CONFIG_USB_BRCMSTB which
> allows us to enable the Broadcom STB USB drivers (OHCI, EHCI and XHCI).
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to defconfig/next.
-- 
Florian
