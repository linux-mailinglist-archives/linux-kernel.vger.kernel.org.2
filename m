Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A34350A5B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhCaWno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhCaWne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:43:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A09C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:43:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m11so42981pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YrSMleKSbg2hGfW2GjIs965FPlWSY5ydLUSNL+d/gGc=;
        b=MzX3JU0OUs5G8IfZrnQry1tgAyUjHud5si38mxPwDNwcltJQLMVZkMBc0dQ7ugSF3z
         jtIfEpm4k9628RqdVhX5Dm++zoawQ8jwTCDnuLHBl+4N4sOyhN4vQrNJkUDXALEy4o0K
         MAOoa6PYnBkarCAaO2FoRnz6pnMgAgzF2uI35fbikZbK/mYutCfA4tTYAVjBfCoOblBF
         Xsmi7Dps5AvRmB6YWgWm9RrVQrBpMcoVC4Mjt1DEnBzEawkPEk5gqBDacpg0kxBWVyOM
         1KfGB274OTv2uHXhLaAtTwvRL6x1deiRk/XLb4RR579LbCZCkldRCGkGEFzaEoDJ91xX
         iQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YrSMleKSbg2hGfW2GjIs965FPlWSY5ydLUSNL+d/gGc=;
        b=W3MXVJXmSJsHsyNzvWNfwAPlOfhEEVnspVzZTxzy+tostX25dkzeSH42FV4Xc3zhg7
         +k53FCHSSg3Of3py3Ol1nGI/rnz1vQ8Rrv0LdANp4avo4WnC3DEVw5X8A98604L/D7lf
         /612vDJi6iqp4sEjRPminXXy+AmXOR7RUq/Fqtd3Qg9ToxjXHP7Qzjc72b7oH3GOVDE9
         YalomPcUCzM0GDWAravce8Ll2GFj52OY1cwXsayn/xi54M8fDME7hLLIcmjvHamMhace
         KhujxWCA95ZVJcCFq9UHozTpv/DQbwpFosuI6bPf1RUBmpOVsEHJuqd82NUxRINX0PUx
         Iv0A==
X-Gm-Message-State: AOAM531hlqpEXn68rBw4ty09w86BkCx/uH52FsTMD4SKncLCFayEyvhi
        K3FvEEPmWTRPV5SbevJfAHU=
X-Google-Smtp-Source: ABdhPJy4joYsZUDmbjQXkjgCHVUKydZ7R94HEcBVQPj+4DuJDsDMrtttVb/X/crSAogqTrDfK3kFKw==
X-Received: by 2002:a05:6a00:2da:b029:202:7800:567 with SMTP id b26-20020a056a0002dab029020278000567mr4775723pft.71.1617230614000;
        Wed, 31 Mar 2021 15:43:34 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id h19sm3338830pfc.172.2021.03.31.15.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 15:43:33 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, fabioaiuto83@gmail.com,
        dan.carpenter@oracle.com, phil@philpotter.co.uk,
        amarjargal16@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH v2 1/3] staging: rtl8723bs: core: add comma within a comment
Date:   Wed, 31 Mar 2021 15:42:29 -0700
Message-Id: <2944d1a0e8769edb489bb336423625a61d314d05.1617229359.git.deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1617229359.git.deborahbrouwer3563@gmail.com>
References: <cover.1617229359.git.deborahbrouwer3563@gmail.com>
In-Reply-To: <cover.1617229359.git.deborahbrouwer3563@gmail.com>
References: <cover.1617229359.git.deborahbrouwer3563@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comma to separate repeated words in a comment. The comma preserves
the meaning of the comment while also stopping the checkpatch warning:
WARNING: Possible repeated word: 'very'.

Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 2daf5c461a4d..3878caf0b56c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -1700,7 +1700,7 @@ Calling context:
 If we turn on USE_RXTHREAD, then, no need for critical section.
 Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
 
-Must be very very cautious...
+Must be very, very cautious...
 
 */
 struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pfree_xmit_queue) */
-- 
2.17.1

