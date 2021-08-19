Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC6F3F1F56
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhHSRqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhHSRqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:46:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B34C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 10:45:40 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id j187so6177680pfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ufpNhd6+rrWKC5+UFilYsJLqSuItwRR6d8n3K5gnsGw=;
        b=LyNS3jvkZgwrwpSXosxldaTme5JQtxa2gs/o3OGG58t9x4s8A+hD+/A9JzmqloLo7u
         6lwhhNt0WYfh+QuThbqQuydccL3tIHm/BagKp8XoKe/Wd7iGaGkD5F5NgGWfW3LacsJZ
         RPCdEaE2+bsL5PIZNg3EoVDcRJ//GwiKI129I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ufpNhd6+rrWKC5+UFilYsJLqSuItwRR6d8n3K5gnsGw=;
        b=pTSsccx5LFB+39cS94HpSevoDC4KCFU8HkZJ4F1dI35JCRxxiS2Kly7u8ngCitKvvu
         Wf8q9uwdFTmF2EKqER7urCAb7I6nzSoAiWlwBKZ9A2ZKxvB+cyKBz4sNLhJWmj6AFIfb
         eplH1OtVuRwl3HG/A7D8BeI1ZbvOMkmdUy/WQ75Cyp1HaTlvKJja7nxs6rvLSEQamqjc
         iohPBgtWkaGIqVzMz2X2cKlwjpdRBjQkKrf6vo1lEyfxl0lc/3NOFncVUj0JBFbakpXp
         9WsnYOoC+4VmqIiobXC+FQ7aPapaFERwZFLBN257JYvrkWeq+fcUwYUm95diDFyxYL7d
         Dvmw==
X-Gm-Message-State: AOAM531QNpgxAB64KNJZ3fM5cXTRj3t3HpLyXsRfkGOp4Wp5R85Wyjvb
        x7Ry6igfe8LBO1XvNubNPeZFRQ==
X-Google-Smtp-Source: ABdhPJwZK+4DmFZsdZH9az+GwtllIm7jZibajF0J1+iF5hMPJdlIFdminUvblG2zPXTki2bvUMu/wA==
X-Received: by 2002:a65:6487:: with SMTP id e7mr14807588pgv.27.1629395140408;
        Thu, 19 Aug 2021 10:45:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j11sm4280368pfa.10.2021.08.19.10.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 10:45:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Romain Perier <romain.perier@gmail.com>,
        Chen Lin <chen.lin5@zte.com.cn>,
        Ivan Safonov <insafonov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Abheek Dhawan <adawesomeguy222@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ashish Kalra <eashishkalra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] staging: wlan-ng: Avoid duplicate header in tx/rx frames
Date:   Thu, 19 Aug 2021 10:45:35 -0700
Message-Id: <20210819174537.3499227-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201; h=from:subject; bh=8OStBXHy7B9kAGi+UGwcbZ2RH4+fReQWXZcSpIRuXt4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHpjATbR39fBP9yxnyweB1s6zvW5R8KaIbuk4m4zs ICyCDyaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYR6YwAAKCRCJcvTf3G3AJuNJD/ 91TDijsRrsOxCL/Uhykei38ufaolN72yyWTxGYhjF0nwPy1KAEKZ3XGhvRplVMv2czoY0xOSWk7t2+ lSpCwoXQp2c7HUPaH4v2TeBKKhjBSsc90YCUx0fBaPnw63z9hf3QaMP/e8hO+q90lbig25FPNMOJWA igq4nQ09IMd1QHEYsRdM3nqIL7WrKVSBpAe0XPAhOO+wM5m7TXSFgTswPN5NxbRK9IZi4kxRIToi7r ZsOAs60LbGC3THb5f42pvZOlIz3K0fmJ+SVjw9WlPjp7U/vYWFVGv0Y0i+j9aSl+aE8ityCQIGzh2D SkA4su3gRPLadq9N1WGAuaZYoFJ5rqRuiyrvt3eZ9Fjv/BFgWeytKypq+RONMeipHA9smZoIqActJ6 OE+iDaCvAzyucj+WCj2hmXPpDNgvPfVJX6I9oJ+B92uxXRc35Cn6EljM+khRXsIbpO3hL4HLyW8kj8 NDtu3sHW38sDbuwSSHUonTavTR2bzQVjrm3tIVdx07TpI+flaW9ZgtCIHvWvhVioyOrLDw5fji0djM IALvZJn1ozGx/6IzWzFZy9qH53Bt6/fWRrESW69K4liEePIUZxej4stvN78xCCPiAVsyoCgLcCGpwa DMQKavJv0y8KgWjLhx1aqvTLFvAQI+28XNAJq2IR/dbKGFIhOTm7+cB0H6oA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

In this case, there is a lot of redundant struct member declarations,
and everything can be made smaller, more description, and drop a
field-spanning memcpy() call all at the same time. The result is no
warning from the future FORTIFY_SOURCE and identical machine code.

Thanks,

-Kees

Kees Cook (2):
  staging: wlan-ng: Remove pointless a3/a4 union
  staging: wlan-ng: Avoid duplicate header in tx/rx frames

 drivers/staging/wlan-ng/hfa384x.h      | 19 ++--------
 drivers/staging/wlan-ng/hfa384x_usb.c  | 13 ++++---
 drivers/staging/wlan-ng/p80211conv.c   | 48 +++++++++++++-------------
 drivers/staging/wlan-ng/p80211conv.h   |  2 +-
 drivers/staging/wlan-ng/p80211hdr.h    | 30 +++++-----------
 drivers/staging/wlan-ng/p80211mgmt.h   | 24 ++++++-------
 drivers/staging/wlan-ng/p80211netdev.c | 12 +++----
 drivers/staging/wlan-ng/p80211netdev.h |  2 +-
 drivers/staging/wlan-ng/prism2sta.c    |  6 ++--
 9 files changed, 64 insertions(+), 92 deletions(-)

-- 
2.30.2

