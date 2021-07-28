Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D72C3D8A84
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhG1JZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231434AbhG1JZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:25:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C772160EBB;
        Wed, 28 Jul 2021 09:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627464318;
        bh=IBlns9NcmkQHY/oLquP04kg6L5T5fEK5F2I7nhC18Ho=;
        h=References:From:To:Cc:Subject:In-reply-to:Date:From;
        b=Ag/GMedNKluZVj4VTlaTho53RqR3RsKWA+/VXIvKOjo+uMmKEz71oeyEm+sCirFWs
         ZVe1TpmSzYzSad7+15nahFxQChyaMbUNv3j/8zIPROjYGTzFcycTqv5FY7I24+mClP
         Haq4bObOKhLqiE+2LmoMYEBbPaDRMf9uy+46WE+cYcQWXgmh4fn0ta+U/TeuJYBNgs
         kujFuYtw2KaJh2CLobsUNGg90w9b9KJ4BWxwXMAd4Hj0oPMbq3ygssJgQUr3QOzgHv
         R8RUr6h0BA8LopWYEvOrspaimBoQjV1hF6b/2Awgx4evwuVv3bkaPzkvJy3E3QL80A
         4YCgs8eTNUKLw==
References: <20210728092052.4178-1-rikard.falkeborn@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: pxa25x_udc: Constify static struct
 pxa25x_ep_ops
In-reply-to: <20210728092052.4178-1-rikard.falkeborn@gmail.com>
Date:   Wed, 28 Jul 2021 12:25:14 +0300
Message-ID: <87h7geu6x1.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rikard Falkeborn <rikard.falkeborn@gmail.com> writes:

> The struct pxa25x_ep_ops is only assigned to the ops field in the
> usb_ep struct, which is a pointer to const struct usb_ep_ops.
> Make it const to allow the compiler to put it in read-only memory.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

-- 
balbi
