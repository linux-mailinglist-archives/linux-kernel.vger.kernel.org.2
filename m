Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68AF45D7B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 10:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354240AbhKYJ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 04:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347793AbhKYJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:55:24 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CFDC061756;
        Thu, 25 Nov 2021 01:52:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l16so10300443wrp.11;
        Thu, 25 Nov 2021 01:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LubwOIycbs75WP/0QNBKRsHGq+GD5WppuGlmADCSChY=;
        b=M49MUuzVEN2wten8Ow2ZJxr5fn8ozedMlUDS5Vhguf7tIXQSyT1uqTEDcvSjYcByLI
         Q3gv3O5RNUO0frlPadFHGafDi5oWig+LRvD4DZgNN71igoJfB3Azr5DLhkAw+PZCYK+g
         PbQlOhXAddLIFxc7m265nk8SRdVJUa9otaqqnWgiUTGD3+oBzBKjY2bkMxf+vyhLCru9
         bMybH1rLnlwNkCqEbB0tcvlt0PCC2rgrP3YPmh68SnDp+lXVjZWW3bk8RUGZWOrXAQ0r
         5557YqH+KvpIw95HPSt2O6ju9+PL/BkO7vGxIx/NCnlbsDXwMhFZJxRB63rT0qTr9br/
         4SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LubwOIycbs75WP/0QNBKRsHGq+GD5WppuGlmADCSChY=;
        b=Vvadt0XAJ53Al3XJc0yNUyv5C8NfUnciYzfc4ejL8dvhDcPDXNQ11dbg7pxOBhMm28
         YUfKsZuShbhNLzs+g7trmIT/MTFJ3lVVP+u0fDq3+DJjPLXiQixwbrVWJd/sDks9Kylm
         XC0bRppEFMXSd5jGSlWxSsn/iOdn4Ct9n65vm86vC0ZQytyI3letQ7TKsXcp/fG4CM7E
         ZcecGrC0YtPs7bIF8T9B4GpV5Bo01NT4PsKaEtxvWa2KT/TVm/JolTo/e4L0oJ4Mc1Pc
         P7BU1WMkZ3RePSwfLn/YjUUJb30nz+8xdNuAqwUwJkACAUdo6RVX5e4DBG3/KMatfykS
         LDxA==
X-Gm-Message-State: AOAM531+j4GlLcAfg9v0V5LGIVMcO4KEAFObBAKWQQh6jSTZDwYvPec/
        1dc38OeYIKt49VZB1vSv+g0=
X-Google-Smtp-Source: ABdhPJz5zAa8xgSOacNbN1QEP4WUOE0mulQoH6wZbGntvCmTU1aJI3geojJMrx5vchJS3EnAJ8blsA==
X-Received: by 2002:adf:cd09:: with SMTP id w9mr4919379wrm.619.1637833931579;
        Thu, 25 Nov 2021 01:52:11 -0800 (PST)
Received: from localhost.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id c1sm2310853wrt.14.2021.11.25.01.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 01:52:10 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/2] Kconfig symbol clean-up for sound
Date:   Thu, 25 Nov 2021 10:51:56 +0100
Message-Id: <20211125095158.8394-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear sound maintainers,

The script ./scripts/checkkconfigsymbols.py warns on invalid references to
Kconfig symbols (often, minor typos, name confusions or outdated references).
This is a patch series addressing the issues reported by
./scripts/checkkconfigsymbols.py in the ./sound/ directory for Kconfig files,
quickly filtered down with:

  ./scripts/checkkconfigsymbols.py | grep "sound.*Kconfig" -B 1


This patch series addresses:

  SND_SOC_UNIPHIER_AIO_DMA
  Referencing files: sound/soc/uniphier/Kconfig


  SND_SOC_WCD937X
  Referencing files: sound/soc/codecs/Kconfig


This patch series does not address:

  CLK_FIXED_FCH
  Referencing files: sound/soc/amd/Kconfig, sound/soc/amd/acp/Kconfig

  Rationale: config definition has been submitted, but is still pending for
    inclusion through another tree.


  SND_SOC_AC97_BUS_NEW
  Referencing files: sound/soc/pxa/Kconfig

  Rationale: waiting for response; the kernel developer has been informed here:
    https://lore.kernel.org/all/CAKXUXMzqgyNGEnxAMQqZiXJYSK-X8uB-nxHWwPg41H6yS0GWNg@mail.gmail.com/


Both patches in this series can be discussed and applied individually. They are
sent in one patch series, as they orginate from the investigation guided by the
same tool and hence share similar topics and resolutions.

Please pick this series of minor clean-up patches. It applies cleanly on next-20211124.


Best regards,

Lukas


Lukas Bulwahn (2):
  ASoC: uniphier: drop selecting non-existing SND_SOC_UNIPHIER_AIO_DMA
  ASoC: codecs: wcd938x: add SND_SOC_WCD938_SDW to codec list instead

 sound/soc/codecs/Kconfig   | 3 +--
 sound/soc/uniphier/Kconfig | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

-- 
2.26.2

