Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CBE33B4A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCONfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhCONe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:34:59 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FFAC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 06:34:59 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id z9so9351171iln.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPNmMCei7+pSoUpF832oIo6Tpa5YlCYD81Jhp4gH57I=;
        b=quc2p6iK1+m/vt3w6Xu+p8fIIKtRq0fzSxA7ABwq5EUvvJMj90FDYo1ksXbRhtg4Ho
         mKQsUpSUngRGKMw+y6NvH3kRtHFzo9LEBnAsX7H+16Dt3vVVBGYIAQ/Wu/y+PLLOPFUC
         f9iK6TB9pd7PlHEMvYxudVxzov8XUmQWpvc/vU9LCVFz9GbPz3VXsa7xr9NtDavCFna7
         BGEia+HOqTVMMOW6UV6LDt5Lch7dBC5vCgPW2wOiWslOkxZvwpMJ8OAsg3VwAsTpiVKr
         RXoMP++eSlq9Pg8exo0dmb3oDNes/NEsTwEH9MjE4TVjZGbfyL6sFnbT6BkC1fvWpn5U
         cZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPNmMCei7+pSoUpF832oIo6Tpa5YlCYD81Jhp4gH57I=;
        b=ooJCfFefs4xM9obVxWaExlty+4Ti5uqLIsTfvilBMeUzmBakDY6S2hUrKxwGYmHu/E
         bdoxW/FibaO5ODPGAP97pqSsGGMv1faY7SLyDfoYnKb6SUbx+wKWoC0EYergTlKsO23D
         hWcZ/5SYWzjIECV4ilhRMkoHLTRViCFcLJzFVySjjfaxgdd67XWXRQ+7Q6eXfVh2jBPr
         63EQWnrPZ8fmVhGQRlZfJdnk3CQo31xBjyonLR0U5v2HylqQ4gMB9RL99oMawTzaf9bp
         g2VrEvgsUDcHlO459sGqs+s0K85JHMkuYY5C7UcUW/wKP0Xf0wA86PtC8MxpMTPN5wGa
         tSLQ==
X-Gm-Message-State: AOAM533MwkCt6s5AP8XJZ8HQMe3PE4CqlU88d1Zoy+cERJD5uEMu9JAj
        SNYHgSiu+OrjEzrSjOuQGdUuZOrdiGFcMQ==
X-Google-Smtp-Source: ABdhPJweYfeBz/mqZ7g1hNS6h28dJzOl31h9z0kfBhUCkHLdRWmR+3ni5JnA675NdbzfYlGKefi1aA==
X-Received: by 2002:a92:b70c:: with SMTP id k12mr12423418ili.60.1615815299104;
        Mon, 15 Mar 2021 06:34:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o23sm7127672ioo.24.2021.03.15.06.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 06:34:58 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     sharathv@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        David.Laight@ACULAB.COM, olteanv@gmail.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/6] net: qualcomm: rmnet: stop using C bit-fields
Date:   Mon, 15 Mar 2021 08:34:49 -0500
Message-Id: <20210315133455.1576188-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main reason for version 4 of this series is that a bug was
introduced in version 3, and that is fixed.

But a nice note from Vladimir Oltean got me thinking about the
necessity of using accessors defined in <linux/bitfield.h>, and I
concluded there was no need.  So this version simplifies things
further, using bitwise AND and OR operators (rather than, e.g.,
u8_get_bits()) to access all values encoded in bit fields.

This version has been tested using IPv4 with checksum offload
enabled and disabled.  Traffic over the link included ICMP (ping),
UDP (iperf), and TCP (wget).

Version 3 of this series used BIT() rather than GENMASK() to define
single-bit masks, and bitwise AND operators to access them.

Version 2 fixed bugs in the way the value written into the header
was computed in version 1.

The series was first posted here:
  https://lore.kernel.org/netdev/20210304223431.15045-1-elder@linaro.org/

					-Alex

Alex Elder (6):
  net: qualcomm: rmnet: mark trailer field endianness
  net: qualcomm: rmnet: simplify some byte order logic
  net: qualcomm: rmnet: kill RMNET_MAP_GET_*() accessor macros
  net: qualcomm: rmnet: use masks instead of C bit-fields
  net: qualcomm: rmnet: don't use C bit-fields in rmnet checksum trailer
  net: qualcomm: rmnet: don't use C bit-fields in rmnet checksum header

 .../ethernet/qualcomm/rmnet/rmnet_handlers.c  | 10 +--
 .../net/ethernet/qualcomm/rmnet/rmnet_map.h   | 12 ----
 .../qualcomm/rmnet/rmnet_map_command.c        | 11 +++-
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 60 ++++++++---------
 include/linux/if_rmnet.h                      | 65 +++++++++----------
 5 files changed, 69 insertions(+), 89 deletions(-)

-- 
2.27.0

