Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DBF438F55
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhJYGYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:24:38 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:39999 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230342AbhJYGYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:24:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 45A6C5806AF;
        Mon, 25 Oct 2021 02:22:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 Oct 2021 02:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=JywPCBZYzdtAw
        axfdlfIJvAK7AMRix2BJvcwxpfDjfY=; b=g8qjJv4Iz6wHPsNPu3cjDgtn5rx8f
        5sMWSkU6udQRGIfO4AJzCX5ZScmlQmZhJeWqtCWj0+1/p1RIMwTTsNICB7csz9bC
        pFzUPXZW7v/85yZuBonrJRm8ApVEC4QskAgZCcvpC5ykD0ObHoVaJyDeJMdZbEEd
        gTR0HMp3eMWNKoNq3XAIP3gIPILIMBbYBqKy/nJbstEQ8tSrycx5KAOAaizQe/6J
        n9LSIH7FyUWXW/RtjsbXjdqyL4fS0gA7umcLz7YhaWzPzwCuGEk/gF4LXnBFlSSD
        aNzwsc6Ct8/P0o5YAFpwBKE5DVpRh6D85p+ESIja0ta973DZv2d9rEJNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=JywPCBZYzdtAwaxfdlfIJvAK7AMRix2BJvcwxpfDjfY=; b=C/a4Q4XB
        7YiHgKRRO86mmm2VQ3z705ch0xA5OYA6H1uKfMg1o/X6fnlpCRBMB1K3JUPSXudY
        kEMhDLtJJrgqHpSsr5lRRJiaiWm1Cz2hMhQEnSiWEglZv28XssZvYjfI6CbThsdq
        jOtPIzqQzerYGV2kSj9j/h0Cf1U3pvtpRkpiJDcdFKPxc9LeSkjKKzMQU+y9XuBP
        OfWkJZSFNhoGM1iv+n2IRBpal7cvoNNDK276Un9XtjHOZPf8Xx8S078gd/FkWd+N
        JidF1DkzthObZLkJUsoJj4hspoH1pdBLJsEC8ZLHDZMBtr7p5KF2bb1SUDoRpXBP
        qVWAFkexf+HUQg==
X-ME-Sender: <xms:FE12YWmSCcEqQkCDfH_UI3_uJVtFlvwyeZFX1tl9pfLROXQkjdk1tw>
    <xme:FE12Yd3IXxmSB8yLTHvFJVwCjC-1TN-R_i6UY3Bk01xQGBoUKNNdBkzolvo1ECv0z
    eGnG9sMqxz1dTqysLA>
X-ME-Received: <xmr:FE12YUpsW6WFbSwW3yH4O9wkczwgAH9owlRfiWX-jFjpHkL2q3wDGuDw2RE13vXDn6IJpJrdLYj8N2H2fUKfGZaPlxLF62-jEMdTCcRFcgM1-YOrMmOAvLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefgedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeeggeegteekveduueeglefhieefkedvueetgffgkeekgeehhfegtdfgieehheeg
    keenucffohhmrghinhepohhfthgtrdhnvghtpdhgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghn
    phgvthgvrhdruggvvh
X-ME-Proxy: <xmx:FE12YakDU9AnKMT_3fQ098_67zHWr-_yA2iow37FQKW4w8iWjeqqpw>
    <xmx:FE12YU0psnLitovFnQiJYX1ZdUvS_OtrasLMRLv3az50r8nzLVXgpQ>
    <xmx:FE12YRtg2UAEON_XFKlMEqpSUpbhgcMiW2sjjnUukk7khqcIR9123g>
    <xmx:Fk12YaxgxLCX2dW4DigT6N8oxguYMQDI2CTTE21MU6l1speInWvffA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 02:22:10 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] MAINTAINERS: Add Apple mailbox files
Date:   Mon, 25 Oct 2021 08:22:02 +0200
Message-Id: <20211025062204.1517-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211025062204.1517-1-sven@svenpeter.dev>
References: <20211025062204.1517-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Apple mailbox files under the ARM/APPLE MACHINE SUPPORT entry.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
As mentioned in the cover letter, there are very likely going to be
conflicts in MAINTAINERS when the various patches that are in-flight
in different subsystems will be merged.

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a4a0c2baaf27..e149f7d7258a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1723,11 +1723,14 @@ C:	irc://irc.oftc.net/asahi-dev
 T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/irqchip/irq-apple-aic.c
+F:	drivers/mailbox/apple-mailbox.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
 F:	include/dt-bindings/pinctrl/apple.h
+F:	include/linux/apple-mailbox.h
 
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
-- 
2.25.1

