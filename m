Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B2933EFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhCQLv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231368AbhCQLvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:51:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAD3164F6B;
        Wed, 17 Mar 2021 11:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615981882;
        bh=NPq4u2l1f+23kOYUCiTwv95sdXqk+USJtP07Jz8mjHA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=eooErSJ6K1Zu0uwoXnc7dExqT0dnzC2R5RYivrApyYB+7KLR5pTAXmIHsWKQ/6Bhq
         u/ABg7Rg+uc7crguWJgr73PvcX9aVfug1gNkOSANOloOHqrP2qGG/ximwK7BTMhVjK
         j7LjzFp8FipbvV0xFbSFfx2qP9UFQA40DKfXro4UsEmxmHWgMNZgH3QTluVVKUmGEU
         VTA9d/gdEOor0un+Y2eTB+EsM+ISRbMiR4FHk3J115z5Ftv6ISo5Td83EwEBM6d7gB
         n8+NwaoLv3zFOepZU3nrTuY8Ukhktr7piTTPLvasJHKid6vQJ4Z+hQevMWEcqKe6BQ
         hKeKNncd4p4qw==
Received: by mail-oi1-f171.google.com with SMTP id o22so31755251oic.3;
        Wed, 17 Mar 2021 04:51:22 -0700 (PDT)
X-Gm-Message-State: AOAM530rzDawciiJ8HoGsXPs/Ln/WzDjn3Tia96NYrCaR7QFZ0PEB6TH
        /P7sJm3rIPL3QRHUE6r514ahqOKcecRZUhSKn0U=
X-Google-Smtp-Source: ABdhPJymH8BAGvuTGTD684QFZl7/VRQdde+NgiT4xcGP8fp9qKEHToCpMN+URa5hhEQ2BZMJrCL7sbPcTQtgJJf2s00=
X-Received: by 2002:a05:6808:f12:: with SMTP id m18mr2317376oiw.62.1615981881960;
 Wed, 17 Mar 2021 04:51:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:4793:0:0:0:0:0 with HTTP; Wed, 17 Mar 2021 04:51:21
 -0700 (PDT)
In-Reply-To: <20210317093658.5370-1-colin.king@canonical.com>
References: <20210317093658.5370-1-colin.king@canonical.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 17 Mar 2021 20:51:21 +0900
X-Gmail-Original-Message-ID: <CAKYAXd--pk3eo5X0hsUjfPRuSHXFyrtw9yNDSCAjqZ7OSwCLqQ@mail.gmail.com>
Message-ID: <CAKYAXd--pk3eo5X0hsUjfPRuSHXFyrtw9yNDSCAjqZ7OSwCLqQ@mail.gmail.com>
Subject: Re: [PATCH][next] cifsd: Fix a handful of spelling mistakes
To:     Colin King <colin.king@canonical.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021-03-17 18:36 GMT+09:00, Colin King <colin.king@canonical.com>:
> From: Colin Ian King <colin.king@canonical.com>
>
> There are several spelling mistakes in various ksmbd_err and
> ksmbd_debug messages. Fix these.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Applied. Thanks for your patch!
