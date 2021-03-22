Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7710D3439D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 07:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhCVGm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 02:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhCVGma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 02:42:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418A9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 23:42:29 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 75so19477908lfa.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 23:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BI0SksBVekDhNITTbd2OyLPTeuWAqdIXr4zw5rdgDY4=;
        b=rT1pLGlHXedIj85ivo2NKoO59YJztakYqTe+dhD32r6ny3S06AZhob70HZqZM8s2Yz
         f0lFGUORbhblFPlGFLphGfzvdxaK0IG/KAXFy6shmR/77l2wBc0KMtKuYdClxxAFuhI/
         gMRQt6d7UCxFae1FIOPHWchMIQt7BjYYZVP1bf2M0QydXy+QlGNo/TEo5KjwaCJ+Ym/Z
         rPGAn5DakEeEI864ydhJUUcDXObh/BbawkW4zkcbFJn3cFy2290lYtiQtDqeFq3K1IBm
         SDzICMtzivFsgw0NqOS51e13H5kUyi1cytcHdOcWNLIHhljiortHpdlcsOMUNIIF+ONd
         tLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BI0SksBVekDhNITTbd2OyLPTeuWAqdIXr4zw5rdgDY4=;
        b=OHBtDviRqsLCX58lkKXsJQBiqDNqiZTvV1l762bCCNi/1zhYSTE9pVs99MIy5O50Di
         Y/xPeibzDQAp6Bqp9rbpD1KM06JIEt25rb3FElzWXMGOBtxo7Xl1HHEZNI61myqufRgQ
         El6ZRYXnfFK2sUuHb3fb0rptNuq3tGs+OTnWVgC++wU7XPHc52nvFRLq+4dby6Ej6n8e
         L9lMzKiq19lS1hnOq5a+7zw6b1zxkPKGdw9Yju6ISgyF5DVixey6XtDFdD818qPylIDk
         kMs7D6k0rcxpLUYIEKCHv1fkun9sz9kVYf9INPW4tU63cxwgvOValRxTsLCjes8H5Kpb
         C1uA==
X-Gm-Message-State: AOAM531A9sKwBTrKxk/4Br0nFhxNIVSdrwCZADBg1O6zM4fybdS9PEm5
        6Tj1p8ie3TWRD1alUAGadTE=
X-Google-Smtp-Source: ABdhPJytMY9FE++IzFC4eBjorMrv71QtnAgWazPcZNgq541q/MuwaP4N+cGzhlePja3FotJpNpSwRw==
X-Received: by 2002:a05:6512:3089:: with SMTP id z9mr3894636lfd.496.1616395347774;
        Sun, 21 Mar 2021 23:42:27 -0700 (PDT)
Received: from grain.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id m24sm1462623lfq.184.2021.03.21.23.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 23:42:27 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 2B4B45600A0; Mon, 22 Mar 2021 09:42:26 +0300 (MSK)
Date:   Mon, 22 Mar 2021 09:42:26 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrey Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] prctl: fix overwrite last but one entry in auxv vector
Message-ID: <YFg8UgvzADiUyDoe@grain>
References: <YFeuWsnb6qKEU8+h@grain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFeuWsnb6qKEU8+h@grain>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 11:36:42PM +0300, Cyrill Gorcunov wrote:
> Alexey reported that current PR_SET_MM_AUXV (and PR_SET_MM_MAP) overwrite
> too many entries on non 64bit kernels. This is because auxv is defined
> as an array of longs and in result access to AT_VECTOR_SIZE - 2 entry
> is not a type of auxv entry but rather an entry before the last one.

Drop this patch, please. I'll make a new version.
