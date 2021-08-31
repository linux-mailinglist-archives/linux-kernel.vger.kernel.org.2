Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE873FC789
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhHaMq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 08:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhHaMq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 08:46:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C029C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 05:46:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x16so8895206pll.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 05:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norberthealth-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+EFI6GnSelcnpgoeb+deAAklW3NRFaUm26pY4E+w0k=;
        b=ioSemb3JD5Y1eOx3s8QHMULwaxNxq90XekgXbUYN3MIi4wPew/JByeaeSULeT4nbEa
         cKzIZ4/H6afFFvkg5Qwx3+83wPYHyGoSruTzZfnNZE0FeHolHwnaOEg2GmzOv1uRu5Zc
         veTsu8tUiQaMChhjarmaZ79IoIj9BKQmJN9YxQpsfR87xdgfmE2Mdr4BP/SfuBq3QZO5
         CFNQEtJI6Hb80splvXF/qFEsjirZ8eAbKuCALFyGg3Gktbehfx02UaG6vAg19br4r1Vj
         dUTIgoZG1HoHuB6CFQRkhLi5jMqsLLj76GXn4TgVbRl7x/vgSTM0uCggygyXE89Lvi0J
         xRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+EFI6GnSelcnpgoeb+deAAklW3NRFaUm26pY4E+w0k=;
        b=dNfKQbsqy/olQo80priUih40/tXhe0T3MuXiHyIZuGCQVlkV6vs1a4EntWsTUuQ14B
         o09OpV7KMQTQ5d78bWSBDeLXThMOfsjZkqrGoAsN0cFMqux/KWhMieSmhlHxgHNi8aIe
         2myDYNH7OlydwBhmWoC+wPAp9XO4Q1Tf+jUBd6zhEcejyUHT8X0eXgFnt/RaeGzN42bc
         SuvQ3QwyKBppJepbhhaZIJU3tMDxxKK3Lw1etFn+X/OA6aCqyNDci1a55GKXsDQum+Ek
         UV5AAD3RwPqhZ1ITVWirjbrfwXtNKUqeic2wDp/y5helkt6rae/t3TRRcNB5iHqBeWuQ
         53NA==
X-Gm-Message-State: AOAM532kWSXa3mc6klpXaT/r6m6JMuikAFZO4l3bBq4XrVsG1IkXhsON
        KfctM5NKMOtIgEjIZ5awl4Bxy5MmbJxpYQAjFCYbcg==
X-Google-Smtp-Source: ABdhPJzp0DSkkGaQ+vQsAfxzLKLGMRlAgWHiJnqZvPuKn9KmYDA8wE3e08OvWWQvIXbffne6YSWjWMRfm0H3l1lj0SQ=
X-Received: by 2002:a17:90a:6ac2:: with SMTP id b2mr5341365pjm.36.1630413961661;
 Tue, 31 Aug 2021 05:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210830163324.12537-1-roger@norberthealth.com> <20210830185714.GK12231@kadam>
In-Reply-To: <20210830185714.GK12231@kadam>
From:   Roger Knecht <roger@norberthealth.com>
Date:   Tue, 31 Aug 2021 14:45:50 +0200
Message-ID: <CAO_iFwp7s4ZAAiyektJgi1bWV5arTmtqGJuNqgkyOrYoZTUDUw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] Trivial comment fix for the CRC ITU-T polynom
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jiri Kosina <jkosina@suse.cz>, Jiri Kosina <trivial@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks for pointing this out. I will fix and resend it shortly.

Regards,
Roger
