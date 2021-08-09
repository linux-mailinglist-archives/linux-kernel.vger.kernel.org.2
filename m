Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9533E4176
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhHIIS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbhHIIS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:18:26 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602CFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 01:18:06 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id c3so10478419ilh.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 01:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=751eA1uQO4HF5gHFweY3ZmO6ePS/SCnXrLp5FdNhCLU=;
        b=oRnrFLcsRXR4V3rAX9P3z6Y0njga//lPW14J4slgAP33NqxYT7dbkDsgX1tD8RKhho
         +VssYbgVwq07VOTLq6X4SNMgX0iZF5lGVtU5l3Z79DTFROA/cmopRVml/x4Yke6GPfXs
         mNzyyE/1sFZ3QC2uvykHxn5urr+6YkUH1R7mqZ/SJaZl8uYPgctTAdd1tNco8uoAdCZK
         +7ybbW2h3wYdUy/OeY5HCZlPYXLgiQnZwqbTs/xoi4PLdxPRwgD1w7waNbUNtVjD/wFw
         y8gELOCPuJLtW27gfwo/zLc+qGZ94JfuvRgM2tMqcsJup/zcbDhgCD2TEl/d2vG59IZU
         xLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=751eA1uQO4HF5gHFweY3ZmO6ePS/SCnXrLp5FdNhCLU=;
        b=oxQqyQJZVwiQqqtRhSWVMutAuO61BpYqI3xX6ae6M4d9wA9fidKCf8SvtCqaLcuyD+
         w74i1FtkLjrnfAHUtWUqLqJliA6tzAtZdhyCnhCIcc92k3VCCEif8aag2Vk6cNr4wKU5
         I4/buh6XLOF+KVPt43QQPKBVbFGIzn/frQDdGk96UU4D68Fy3NOj3HxQk1Hxg9POuHyL
         K1KykvnscPowsE2lY7opB2MoHmcHf0c7EOsbQ4+K6IvKIUyNR6262pdicYZn2VPDHa+i
         EusxVPbFbfTrHWsElv0SMv4ECNj752pbFJ/36QLCRnFCHpW3BoqIznfRaEIquaYsQjCg
         Naow==
X-Gm-Message-State: AOAM530U1a8VJAKcJiLIrl3dIIExeeW05BhB6IdttE4OdQBWNCE1iEzo
        CpbDGU77PloFG0UBIAWgKxpTMtlDTymqmWwRI7wu9aHLwM0=
X-Google-Smtp-Source: ABdhPJwUpad/wTCFCcLmRKVX3CBaujek8ydGzwciiessjKDUj2IqKiKh2Uiin8VuGPW3J4j0FbQ2mtFKbzBhahBpob4=
X-Received: by 2002:a92:dd12:: with SMTP id n18mr280956ilm.180.1628497085560;
 Mon, 09 Aug 2021 01:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAK=B_CvNi1O93Sjy_WG5VSH_+njHsKrOk9ZwHDh5VH8MNTCTGg@mail.gmail.com>
In-Reply-To: <CAK=B_CvNi1O93Sjy_WG5VSH_+njHsKrOk9ZwHDh5VH8MNTCTGg@mail.gmail.com>
From:   EJ Choi <ejpiper308@gmail.com>
Date:   Mon, 9 Aug 2021 17:17:54 +0900
Message-ID: <CAK=B_Ct98PFTZHJg7XYy9BJCV9eawM-nfmbfU=Ky+PE++i0dNw@mail.gmail.com>
Subject: Fwd: Registering the supplementary patch of CVE-2013-0290 as CVE
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm Eunji Choi, and I'm working on incomplete security patch detection for OSS.

While I was looking for some cases, I found commit
add05ad4e9f5c4efee9b98535db5efa32b0d0492
which is the supplementary patch for commit
77c1090f94d1b0b5186fb13a1b71b47b1343f87f (fixes CVE-2013-0290).

It seems that the problem related to system call failure occurred
due to the previous patch and has been fixed.
(Incomplete fix for CVE-2013-0290)

I searched the multiple public security vulnerability database(such as NVD),
and couldn't find any information about the patch(add05a).

Registering the problem and its patch commit as new CVE seems to be
helpful for people using Linux.
Because some people can apply the previous patch to their SW to fix
CVE-2013-0290.

I'd like to hear your opinion.

Thank you,
Eunjin Choi.
