Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A86362712
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243449AbhDPRoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbhDPRoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:44:30 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD52C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:44:04 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id 6so23760028ilt.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nAwR2ChdoR1l7gTvdncfKx38CKMoOLhEECIurSht2lE=;
        b=mVNS+VxDQ0VKtc6XO4Sey80chkf01vEECzbwyiu+LDcJzr4SfcFQhakTrsJg1aO5OG
         wEMY5bpNaGAf0gTJZNVLdmBr0YLZJN7aMeo97lQDxdhlez7XNnw+bKToaRHrtOL28McD
         aTU9NcIZUjLynFHyBeqGesGApIFc9GpOb92odgRMKBo8CipbLIMV2lFot4HMsJt+0ti7
         Pfr4yiAfATBGrT9OPAP4efaHiZa8P71Xf5/g6wL9P9CVi9SEHflprnqri3kCwfPnCl+F
         n5n8pADBDuVnh3nnIjsRNlEdjh6Upu9PITknGXiup9gjWZmRjPQ2FHcjuCaAtZZMIzZQ
         /1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nAwR2ChdoR1l7gTvdncfKx38CKMoOLhEECIurSht2lE=;
        b=rRd92kUqirotSi/kCfQNLypw6sF+k0Y2s7pRrnMJa6XZK9bxFoq2kv/dxQ7yiEKUqN
         GOMizst8gtziRnAQA60PbW+2aBE+mnWSrACYiRF7rmPVqTeswqLQkFH4esFh4/EKZfgv
         ILGCRGOw3Py7BzAVSqWNPpwGKAJjfqfwALAC8ydOAfNShNJVqO6Fe/tusP/gzQx6WUDl
         OzwK28K+m8WTfBvDdoZiVSob9+fpGWQLu5sLExKz9fBiqD2PgEfdFJdXdjZdUd0jNaI3
         3Ocd8jyJzwxiRmtHY65LaXXdRqA/8VivzOyUdxg8AsUXAhv1IFBW//cKTsvNV6om6flb
         /akg==
X-Gm-Message-State: AOAM532bBjz+RjBgXJpxOXfCa6MPW28LPxUb971iwOlnuRD2KEO1ENOu
        iiQvRf99dK+YlGVDSFH1ujDTCAhHfx1qgAVvEKh/eoqxtA99cg==
X-Google-Smtp-Source: ABdhPJwO+gHJ/FE4d3Xw0m61uTEe7zuCys7ArYbfXlJxmd7SeSXGtf3E8qxwowkTuLnCblZK8yYFc3K0nCR7SJbgUBY=
X-Received: by 2002:a92:1943:: with SMTP id e3mr7758117ilm.166.1618595043564;
 Fri, 16 Apr 2021 10:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <CALY-g84i=WPVT7OKwKa1xJaORPwMUyjdX0ewqqoVsC2ihbpvtg@mail.gmail.com>
 <48806d4c-743a-8c63-fd86-04babb149744@infradead.org> <e39e346d-6d4c-f265-67ca-736d51f16266@infradead.org>
In-Reply-To: <e39e346d-6d4c-f265-67ca-736d51f16266@infradead.org>
From:   Drew Abbott <abbotta4@gmail.com>
Date:   Fri, 16 Apr 2021 13:44:34 -0400
Message-ID: <CALY-g85_8RE3-LMGdekOm++o-HHaJGMLHHsPeiK19UxdPajRZg@mail.gmail.com>
Subject: Re: Page BUGs
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> so linux-mm@kvack.org would be better IMO.
Thank you, I will try this message there instead.

> [7] tells me:
> SyntaxError: JSON.parse: unexpected non-whitespace character after JSON data at line 1 column 16 of the JSON data
I'll put my log up on another paste host, thanks again.
