Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7CA330E89
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhCHMkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhCHMkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:40:06 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5736BC06174A;
        Mon,  8 Mar 2021 04:40:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w11so11273553wrr.10;
        Mon, 08 Mar 2021 04:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEvH+ho1jJ9uDUGcwbTQ5qoQT0ami0ZoGldbsH646BE=;
        b=WNUirTW29nsQyOQi2ge66YCvLSO8rJ5AnbYE1gS6T6Wv51tpYLh9ZB/Kisjhr1IWdO
         vUvWnmgFVfbJJkjbVj2LFKJXxwq3L54qPhOFG19SgHd4pY0O0d8Dp0n8Osgk1sNAaemB
         JwOF8GAwK0S5HtEUFQ5trzQfN+dxNEj5GdeMiyFmaT4wW9xvEuAzRjq5KV28MtNFlTFk
         ChM2MStFc9nH3Vnjw22nbo8qywHVKjd98fQAIsmUJQd6D/to2bPKItZkDeCEMEGxWSYg
         IZcY+gjQMMIISn4qgY4egkwZuBr+S/VaVfp4f6G+Fu5UZEmI1MsQMhd1lJ3sEYNVuqqW
         mlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEvH+ho1jJ9uDUGcwbTQ5qoQT0ami0ZoGldbsH646BE=;
        b=UDmlReHwZ2aZ++YEEzp51BxnIL2+pjvstGYvyZ1XKOj8qwrRcMX52OKHGcXEmgORb1
         +qXwqbOJ9tLsSc94ebb/5eaeDDefACf/4pNYIz1Cb+/4YeljaD+l1IXW0xbIdTSAXvNw
         kNbIWjrw9CwoK9NJ7cFLa5y0RNgdQjZMeCE769FkByHhHhavBKI5RcUbE0H1qmGnxHmJ
         34O5EEP6+ISaz8mYXoYU6koPCI1RV6AebQObrbip65ulqdbyLJk0m7dmZ0pvkJ0o6lxX
         vVSKFrzRIdWOeK/zpqgtg718kIdOmqCE9tZ0gO03Ry7HqDBTnyr3QdQPPaawxOmFb7LV
         nBaw==
X-Gm-Message-State: AOAM530m6EmhE0sDWMbBix5luEDyDt9iLRwYyi3t1OP+4Slz4DyoZ7SQ
        aJkPsmIywcfEsV8tl4psTd86b/wQhuH0fg==
X-Google-Smtp-Source: ABdhPJxHMtMwYwHSq8TU3fj6j9HAYRcqiNUIHe3qPtPMp+EcXd+YB9eNQC+8dQy74vEqD4oNTI5E6w==
X-Received: by 2002:a05:6000:18f:: with SMTP id p15mr22804208wrx.23.1615207205027;
        Mon, 08 Mar 2021 04:40:05 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270095bc7625808eade0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:95bc:7625:808e:ade0])
        by smtp.gmail.com with ESMTPSA id l4sm12206118wrt.60.2021.03.08.04.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 04:40:04 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     devicetree@vger.kernel.org, will@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        krzk@kernel.org, robh+dt@kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, catalin.marinas@arm.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 0/1] arm64: dts: imx8mm-nitrogen-r2: add espi2 support
Date:   Mon,  8 Mar 2021 13:39:57 +0100
Message-Id: <20210308123958.254116-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a repost of a missing patch on a previous patch set [1].
This patch adds the support of the espi2 on the imx8mm-nitrogen-r2
board.

Thanks,

[1]: https://lore.kernel.org/linux-arm-kernel/20210223191652.436397-1-adrien.grassein@gmail.com/

Adrien Grassein (1):
  arm64: dts: imx8mm-nitrogen-r2: add espi2 support

 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

-- 
2.25.1

