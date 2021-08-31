Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE5B3FCA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 17:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbhHaPHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 11:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbhHaPHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 11:07:40 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037BCC061764
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 08:06:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v1so697177plo.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 08:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norberthealth-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RsOKy2MEQrop4eqCyXW//Fh3GI8a5H2xV4Ty8vmEwew=;
        b=y0+a4DO/Xlt8nbMYhHpc0983QjMDMEKxJbWHtOfcleKDslcmihhvO2xxWFpPAQAQ3o
         3L/ukw1x0aK650u334xoQ0h3NuSxITCEu/oBAGExEpcQR1+pQi77oAslVc8Os2kIVFbN
         lOqgNqov/YaatrKH9AftPpbgGa2/Ksm0AJkzMBHvYa16TjYRqx86nbXpCQczkRpvIBGl
         RuV/nVjsejhWgHz8mfaicc3aB0nz4LmdWsFoH6O6xuLVxHTNZnIFXpySxlVb02vJSfcS
         Oln6/BY1QclZE3VhMCzNfmgwChoDOrO2Z8dc3f7CwUbaOloMzq/4xrpcsi0vaGgnDIp0
         wTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsOKy2MEQrop4eqCyXW//Fh3GI8a5H2xV4Ty8vmEwew=;
        b=cIydgbvkCp+0Ed69PJJ0Hsx4J1iQps5vz6zA+QSz+u7qbygn4BGnt0PbPPFkJiI3Ix
         zDgc3LMJzrXxB4SVADek0f4aBCX1zTsrkvn3TvvGrA0Fm27HKIcE7sp2bDrr0HH6OepP
         LbUDQ504Jyzv2njcX1rOw1uNYPnMCXEzbTpBM7pTtzzbE3cLq9OP5lqrKS7pdLIlaaxM
         5NS8CsmabdUe8ePGsY6U/1GPm6jXbuKXJyprzA58Hihni4kTapphfBjjyv3YHbTNKrXd
         KTMrFZnkm4aozpOip6s+TJHokXaDDWSpkOeiJHJAvXWLKkfsVltXhNNhz3vOze5RhdzK
         g76A==
X-Gm-Message-State: AOAM530ljn6FP7A5M3LtOXbt27xApgF7shF4R+l5kKu0UGjfiPjiHdz3
        Yxnqn28CKX45h0I87/TZJYWaXma6efPJj+07T/lnLg==
X-Google-Smtp-Source: ABdhPJw7oHRPloH8oVj8QcwmZ4bllvFY3xsCSVV5hpT/HlAmNN8D75hn/EMnwDIZwmJ0qy4N6QLYK87K9dFlUm3HIUU=
X-Received: by 2002:a17:902:9a04:b029:12b:8d54:7c2 with SMTP id
 v4-20020a1709029a04b029012b8d5407c2mr5241397plp.62.1630422404327; Tue, 31 Aug
 2021 08:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210831130702.31526-1-roger@norberthealth.com> <6ba219b5-0a9d-610e-0670-232e5d3d4ad3@infradead.org>
In-Reply-To: <6ba219b5-0a9d-610e-0670-232e5d3d4ad3@infradead.org>
From:   Roger Knecht <roger@norberthealth.com>
Date:   Tue, 31 Aug 2021 17:06:33 +0200
Message-ID: <CAO_iFwpJ_1GqnW+eAfZ5bhVn3uF-0MqFQ30=iPBX_WM4fOTUNQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] Trivial comment fix for the CRC ITU-T polynom
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

No problem, I will update the patch.

Regards,
Roger
