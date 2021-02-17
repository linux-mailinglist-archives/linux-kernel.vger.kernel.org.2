Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB08F31DB77
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhBQO2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:28:25 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:36019 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbhBQO2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:28:22 -0500
Received: by mail-wm1-f44.google.com with SMTP id a207so3816912wmd.1;
        Wed, 17 Feb 2021 06:28:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UXBoDPISouaMa7eLM8k6lUzxbpY9bndW+3v2lMk9lKQ=;
        b=LvUtTsjF2d1FfP0jkjA5jKySR42C7QfqFZfHWquOZkw2FK4gDoQZGN0HBDvTbs0ZtH
         y8mYCV3OWsmmTZmqNYpJU7G6CtNBn9tAoynFFgIvNfBqO1eMO1y6t/oYSAThwIylUHrt
         cyCDwKk9HLxo3JA/JffGWOGJ9cfjM9FiXW0qukanLBHpE7BTc74EHctlnzC1rTjvMEp4
         XFiqviCgnrmqGdnx5XxZRycGUHnLuPVYpTfbNV2E4kaWXj3JY8y+hQUAvjhn2J4cD2li
         vlXc0dkolM35cwvj3lHSLZDhc+T2q680EJgjANXG1V2JgsuEieSU47qx1mH2phAzN5Nm
         czoQ==
X-Gm-Message-State: AOAM530Gdri+v+aekDyCvOzeWeFKSZF4WPOJUMdC7hjouTcSRQn6I/Se
        3Z/psyKfrNdWKdn5+NPa+as=
X-Google-Smtp-Source: ABdhPJxnNkUw1C1PinRQrQH2D0h8Qb/4wE9B61raywRQJrotKfawBl08wLau90F2rpLogNUobo9Rqg==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr7547142wmh.114.1613572060958;
        Wed, 17 Feb 2021 06:27:40 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id j16sm4069536wra.17.2021.02.17.06.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 06:27:39 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:27:37 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] arm64: dts: imx8mm-nitrogen-r2: add flexspi
Message-ID: <20210217142737.ksvdg6xkfbsaoty2@kozik-lap>
References: <20210215231943.36910-1-adrien.grassein@gmail.com>
 <20210215231943.36910-7-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215231943.36910-7-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:19:41AM +0100, Adrien Grassein wrote:
> Add flexspi description an pinmuxing.

FlexSPI, pin muxing (with a space).

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
