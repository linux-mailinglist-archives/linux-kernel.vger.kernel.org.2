Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A1C3206D7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 20:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBTTPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 14:15:12 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:43793 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhBTTPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 14:15:05 -0500
Received: by mail-wr1-f41.google.com with SMTP id n8so14504572wrm.10;
        Sat, 20 Feb 2021 11:14:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YZeVadYjVm5fl6THRixql0EGjRkzdEYGNwbzuTXysLA=;
        b=dAJ5fOWX372nJZuRCnPzKxVth5IBzM7Sf3eZ4OTx0FeM5mA64eNdZKdOQd9KqNlp0o
         Py+MFrPJW4T75Ia7ie5h5ILRLEfmfKmGf558eqLpNw9RhCIDs2ffV6qA+r/8v0sa30Ky
         mhOsui9VrCF2oqMa02IkR/FcTLuwJ0UTxlpgYGbOowHpq1tlg5KDIIQIirqXDdi4RN/P
         EAH5ZEHQsAEAmJ1J6puMMo5glhN98iN/yzLAkrDrRf7cPjz2jC0hNgu08bQ9FQcAujtg
         SWLYggwY2dqfV0v5n3mbCfHGNk+fFUchoEAEkpFo5Vdh1WrLHhDPKGfakyRpz3kF7q9o
         dwlw==
X-Gm-Message-State: AOAM5327Uq81k1UqawrEl1KXNw4tgBWnvWpf4CYfQUOXPkrWOwLiRW8L
        YSi0Mvxa3kdJkd6fD54hMLk=
X-Google-Smtp-Source: ABdhPJw7Tjcb4OP73cghimnh1YCj6A0STIsTqSlvlPSisiKkPmxpsnSNQ7GhYVESTADUwxKhn9yx7A==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr15264556wrr.361.1613848464144;
        Sat, 20 Feb 2021 11:14:24 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id 4sm19483753wrr.27.2021.02.20.11.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 11:14:23 -0800 (PST)
Date:   Sat, 20 Feb 2021 20:14:21 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Angus Ainslie <angus@akkea.ca>
Subject: Re: [PATCH v3 4/5] arm64: dts: librem5: protect some partitions of
 the nor-flash
Message-ID: <20210220191421.zrof6p6d4edbjqq6@kozik-lap>
References: <20210219100439.9428-1-martin.kepplinger@puri.sm>
 <20210219100439.9428-5-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219100439.9428-5-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:04:38AM +0100, Martin Kepplinger wrote:
> From: Angus Ainslie <angus@akkea.ca>
> 
> These sections should be read only as they contain important data.
> 
> Signed-off-by: Angus Ainslie <angus@akkea.ca>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  .../boot/dts/freescale/imx8mq-librem5.dtsi      | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
