Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0472D31DB72
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhBQO0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:26:23 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:44783 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbhBQO0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:26:18 -0500
Received: by mail-ed1-f50.google.com with SMTP id g3so14190219edb.11;
        Wed, 17 Feb 2021 06:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n/JhxruoJmAMeWtv4ga801HTbk6pWNp64q7e4OsylUQ=;
        b=hwKRQGDcQefJMip7OQeRCbPix58GGsiVW1AAkwVCuJ0YvjMXcY3rpoAa1sDVg2e0yl
         Gr4W8hHf+u4Zq0JYMcAJ6HrtnKziEfyTDuh06xS8UUZj7cYEMq/j+fflXklkAVq6UhEc
         NGdzxbMNnK11qD9r1QYrqE8EULZZ/EzHMne2RRVrNY/cyeIXx+JiU+xJ20BtqvE9X2S6
         Wu6x9PnEPGaRymkFTN6uDYF2A3TeQgGJszwZUBspR/uzr+6oKMfwrCwVO5ZGNExSkA4u
         K9Tlc73oP5Jn5JfHoX0Liqaae8T5zVukaV2Tu9oa8agsynqJqii6rMSJQgqesSkXqyEc
         WIWg==
X-Gm-Message-State: AOAM5326Qtu0a05hJWjlKlK6bgR5QbcCfeFERuSzv842pjeRYOsuVC+p
        RhaD03sPkHXKjLwLb+vm4nktl5gdYFg=
X-Google-Smtp-Source: ABdhPJylY1Gmi42zawEy/OiViXqCfXUfP5QxwTnpl3yIOY1nT55RYCNuRWxnSkbCV4cKsox1JfuqrQ==
X-Received: by 2002:a05:6402:27cd:: with SMTP id c13mr26455336ede.263.1613571936475;
        Wed, 17 Feb 2021 06:25:36 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id r11sm1197146edt.58.2021.02.17.06.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 06:25:35 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:25:33 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] arm64: dts: imx8mm-nitrogen-r2: add pwms
Message-ID: <20210217142533.fhfzooquljahyutk@kozik-lap>
References: <20210215231943.36910-1-adrien.grassein@gmail.com>
 <20210215231943.36910-6-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215231943.36910-6-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:19:40AM +0100, Adrien Grassein wrote:
> Add description for the four pwms.

In title and msg: PWM is an acronym, so "four PWMs", "add PWMs".

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
