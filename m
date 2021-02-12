Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87C231A5CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhBLUFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhBLUFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:05:52 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A05C061786
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:05:12 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id z11so1146487lfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nExWR88RkPeOkqISGn/jpVoXJu9W7N0qKFDCio4UzKU=;
        b=U5PQPNXrgUjJcMKwLFquE94Fo6SR6+QexZmX+lUZ54tGZpEYsW/pFvUfW9NzR3s02L
         3RxyCVEarkwE9pjzzkd2fYKmSf8YglBxbWhUCf/C7d+fRAlmTXehalOyLy3peBXnrtZv
         PHDZzrCWgToC8mkDkPlgx3Cw5gRjWLX5H65BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nExWR88RkPeOkqISGn/jpVoXJu9W7N0qKFDCio4UzKU=;
        b=QN+P7nt1balJx+8HG96IVj0Pb9RJlhz0Ff9AlnGPK3S7OM+YtlVGEHJ0xsHRKIz4Mo
         Py99N8+7lPZencl+6SdWtZAXtxF2FQ8RttCH22mGoMiwBbvNIx8xWSPDArXzu0goAHDq
         HekdFvXd6K99qlPKvpALQRDQfo3Du/eBBEHuit2+qGSX++06zZG2OUDxyog5KU9+AFgp
         f9YaP27Q4szJ1VZRXnAWYvLEM4cUZapCWZp4NRE2irUw9o2G3b+2cXZbrP2ZwDBFFrq3
         YLPP5YD1YJ3hqo926Q7QiRD0288zwLeZt34dgr9nAQO1kZSVipT57rhQp+b6wpj+Sr97
         3HRQ==
X-Gm-Message-State: AOAM530sObgzlTjiJwzPuvbnwYKCw7T+J1SdUXfXPqUAIi5a/BFuPfXS
        RFlL6iQMzwkRcYUT/SqFW1E4SmH7DgJBEg==
X-Google-Smtp-Source: ABdhPJwv7HXW3h4l7Lzl8xAA9D5ftPsuAiasid7CUfr4ofnhQL7OMJ2j4PWT1lJ38Se5UUZe5q0AVQ==
X-Received: by 2002:a19:e85:: with SMTP id 127mr2453496lfo.292.1613160310196;
        Fri, 12 Feb 2021 12:05:10 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id c14sm1269636lft.0.2021.02.12.12.05.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 12:05:09 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id x1so444894ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:05:09 -0800 (PST)
X-Received: by 2002:a2e:8049:: with SMTP id p9mr2544160ljg.411.1613160308969;
 Fri, 12 Feb 2021 12:05:08 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mtYEj+WLy+oPSXEwS5sZ8+TNk_dU3PVx3ieBz2DFS94Sg@mail.gmail.com>
In-Reply-To: <CAH2r5mtYEj+WLy+oPSXEwS5sZ8+TNk_dU3PVx3ieBz2DFS94Sg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Feb 2021 12:04:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wja1Y8r5UKrmXcMFrS=VPkTPbkyK-vt8B9MBkEU4+-WLw@mail.gmail.com>
Message-ID: <CAHk-=wja1Y8r5UKrmXcMFrS=VPkTPbkyK-vt8B9MBkEU4+-WLw@mail.gmail.com>
Subject: Re: [GIT PULL] cifs fixes
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 10:16 AM Steve French <smfrench@gmail.com> wrote:
>
>   git://git.samba.org/sfrench/cifs-2.6.git tags/5.11-rc7-smb3

It looks like git.samba.org is feeling very sick and is not answering.
Not git, not ping (but maybe icmp ping is blocked).

Please give it a kick, or provide some other hosting mirror?

           Linus
