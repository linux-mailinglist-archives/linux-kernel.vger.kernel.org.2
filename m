Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166B13F2B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 13:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbhHTLit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbhHTLir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:38:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4BAC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 04:38:09 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k5so20003555lfu.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 04:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EVr+GNugLlc0xK2l3OQNOEkKJ5gDmo5J6cp/NzY4KIo=;
        b=teGFNMwfNYiDbZa8jlXPP9eyEUKSTpehSED6V5qrXNMcXc47d7QBAPrCc50Qh0orPx
         jGbu9a+Se+OiV1f6YvGP7oeFD3bg8NPc6t9jUIdruuy0ihaicyA419RoY9k49UyD3oh8
         QTwLlcQeh6YQ3THh1/dv8EP2ANhDJk9cMlBpy6N7k0AT56UZxhxxKrJSLI0kksxbKNBN
         zRxYTG63SLCkSxFSclVpnneqESceLBF+BHdfyaFhGNH5pzDS6K09Fos+I9m1L7S0iXnd
         hrfETm46mGt/t7QVn8phpwC/SW1WcJ054Cr2dhsU4VvgimKKJzoWQKoOcPQQ9PMhnbZf
         YmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=EVr+GNugLlc0xK2l3OQNOEkKJ5gDmo5J6cp/NzY4KIo=;
        b=d3DNbGjxoqMGlp2r6Qq8aHKIsYhFzE9s5FOjxsvf34D/QExRvO2wtXlDF1NbV8R4ez
         3tD+ZGkQVj51l1wh0F57wIj/aLO0fbs0SbkX2Yja0Ab5Ex3TxfANB/k0pGesRl9nWAO1
         gKeo3t+qU1igk4Sfz68pLUmNFaxpwGokf8EDOL4fFzhE0lSE+zqqKBdufGXmsgxDQ+iW
         fN75wPtbE53CdRG28E5STDllPZvWzvUlxNdfpX/eFrbH0bCE5N2zmpP81pZJtl1WmerD
         8aXXETzrfPwDZOyecVbI3WdTIdI5HDwoeQGYGs7Uip835j3wt57NdMyCkK+4lc6Dk1K9
         yuIg==
X-Gm-Message-State: AOAM531lw9zfOoOs/E/asUymOBYy6j9iEhPMNW6ciu2XV8KM7H2Mc2Aq
        YzeHq1BVttVEyAGvMQCbYsLnrshOblChkBQacU0=
X-Google-Smtp-Source: ABdhPJz8joyuXzflOEr9/YJ5v2EIrCTOGPxvGHYRfTZl/Rw+v/YOKgometM+oBfLNPqraQqCOrEsgOmvtcWhYxqiq/c=
X-Received: by 2002:a05:6512:e83:: with SMTP id bi3mr4811206lfb.10.1629459488271;
 Fri, 20 Aug 2021 04:38:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac2:443b:0:0:0:0:0 with HTTP; Fri, 20 Aug 2021 04:38:07
 -0700 (PDT)
Reply-To: frankedwardjnr100@gmail.com
From:   Frank Edwardjnr <dcurtis2030@gmail.com>
Date:   Fri, 20 Aug 2021 12:38:07 +0100
Message-ID: <CAPdAYp4dX_Fmyh4-+OV4auP3ANemixCgQqK9GXL3_GO35yUyTA@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQpJIGNhbGxlZCB0byBrbm93IGlmIHlvdSByZWNlaXZlZCBteSBwcmV2aW91cyBlbWFp
bCwgcmVwbHkgdG8gbWUNCmFzYXAuDQpGcmFuaw0KDQrslYjrhZXtlZjshLjsmpQNCuuCnCDri7ns
i6DsnbQg64K0IOydtOyghCDsnbTrqZTsnbzsnYTrsJvsnYAg6rK97JqwIOyVjOqzoCDsoITtmZQs
IOuCmOyXkOqyjCDtmozsi6ANCuu5qOumrC4NCuyGlOynge2VmOuLpA0K
