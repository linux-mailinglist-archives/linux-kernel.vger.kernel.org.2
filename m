Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B223F3A86
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 14:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhHUMLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 08:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhHUMLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 08:11:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D340C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 05:11:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u14so978197ejf.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 05:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tpw2AuoZ5uilE8E10lWdNIvs/omFPqAAG7Y/I75dW9M=;
        b=leRLTPB9gTHR0pX0nav9Z01iyQai2iWOg7SmSihwePLc3cJsOol8QJtwQGgzHu96/c
         orQkXXDWt+pYRujIvlVxz0EBTr5BLlyOaGIKEfDFnKFhTBSO7UOcFmCrTlmAgWPdYGOX
         tb+l8aHdq9GzT9RczvYp3r2zaphq4ScgDqcl22wbtBXBYIhbukJnz7LNFrWaYX8B93+3
         6ZEaKqodGuvl0S1WakUZvvFF0wtXI+OlN2fYaIHorzEIom0wS6WpTLLLd/q3qEAqg2IM
         YKG++IM0+xVOgByfnOStDWsDxza+wbQ/AiPFJOwMgGMhNrFlwkINyDQemu34Sig0a/+4
         AAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tpw2AuoZ5uilE8E10lWdNIvs/omFPqAAG7Y/I75dW9M=;
        b=PmAKVanbg0Gb2FAKWHud4Net0ZOTyeO+WfSoUE3gwmyqxph8zJ99pX1mBXS1xB/VVA
         6k1C4UYoDaf2dJ2wk6WcaIlBlBtGBGSvFjrGEAErN9sNTDnArHbr/hZWaWtFaGf0tQb9
         qNOVbeUdAl3L+wcOmpv2DmNlvBLfTGzpWdXhEgIUAdL3LjKRb4rM3+PJAUdCF3CD8XPB
         RWkBvWAq0d5g5UmL3jM95A/MIfMDzr4WrnYj+xRbwxxz1Glvt5XMYYS7zkm+Z02b37uJ
         564eWfIIEVFcMrq/0aY8aUXe84cCUZq5l+/l6dY2DiNp0DB9tFHy/rgP2TkhoJT8GF6m
         xcJw==
X-Gm-Message-State: AOAM530UxgJwctYDnjBUGnK7hGmp84LVKsC8Jh1t8xzimoTWMnvZ2xpN
        C3Uq5khxRihebjnxSdh2GiA=
X-Google-Smtp-Source: ABdhPJybNMq0exV3RFmKZfRNZoQ51Q/aCHPVCu7Rhydr20wNiL9EJ6KEKtWZcJegkkKuzk/1f0bOnw==
X-Received: by 2002:a17:906:781:: with SMTP id l1mr26450485ejc.289.1629547869042;
        Sat, 21 Aug 2021 05:11:09 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id v6sm4222010ejk.117.2021.08.21.05.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 05:11:08 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] staging: r8188eu: add proper rtw_read* error handling
Date:   Sat, 21 Aug 2021 14:11:07 +0200
Message-ID: <1985029.ipg07BJOT0@localhost.localdomain>
In-Reply-To: <31d61caa-d07d-193f-cd8e-adfbda1ff9e2@gmail.com>
References: <cover.1629479152.git.paskripkin@gmail.com> <5720270.rXTAdOU5UK@localhost.localdomain> <31d61caa-d07d-193f-cd8e-adfbda1ff9e2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 21, 2021 12:35:48 PM CEST Pavel Skripkin wrote:
> On 8/21/21 8:55 AM, Fabio M. De Francesco wrote:
> > On Friday, August 20, 2021 7:07:36 PM CEST Pavel Skripkin wrote:
> >> rtw_read*() functions call usb_read* inside. These functions could fail
> >> in some cases; for example: failed to receive control message. These
> >> cases should be handled to prevent uninit value bugs, since usb_read*
> >> functions blindly return stack variable without checking if this value
> >> _actualy_ initialized.
> >> 
> >> To achive it, all usb_read* and rtw_read*() argument list is expanded
> > 
> > []
> >
> >> --- a/drivers/staging/r8188eu/core/rtw_io.c
> >> +++ b/drivers/staging/r8188eu/core/rtw_io.c
> >> @@ -34,44 +34,44 @@ jackson@realtek.com.tw
> >>  #define rtw_cpu_to_le16(val)		cpu_to_le16(val)
> >>  #define rtw_cpu_to_le32(val)		cpu_to_le32(val)
> > 
> > Not related to your patch, these macros are useless and misleading.
> > 
> 
> Sorry, I don't get it. I didn't touch these macros, it's part of diffstat.

Yes, correct; in fact I wrote: "not related to your patch".

I just saw those macros while reading your patch. The code is  I just noticed 
that those macros are useless (in case someone wanted to
address that issue). 

Obviously, if you find it interesting, you shouldn't do that in your series,
because it is entirely unrelated to the purpose of your work.

I hope now I've made it clearer, sorry.

Regards,

Fabio 


