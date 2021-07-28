Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819D43D87F2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhG1GbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231484AbhG1GbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:31:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E25AE60187;
        Wed, 28 Jul 2021 06:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627453866;
        bh=Eg03bw3ffGrNT2FoElYDtXMNQBAAyVJssDTCNB1kxfk=;
        h=References:From:To:Cc:Subject:In-reply-to:Date:From;
        b=iQslEKMb2Uw7bYrF+u7c30kBSLrL/gn8zYciiuaRT6ZSDzzysx1mX0Bqpqkk1hoY4
         0MyHmOasWPqtP35cJFBMBASO/QnFrYRDLF6X+XTrpBfqVjoejUifEnOadRfjqX1A7W
         nzD7VSDlRVm8Pxfg2NJZk7+nz4V8zsTNgVTRzcR6RmOgVk4JJ+sJqdk7kbpInbfLeX
         U4fvALYGRl5JpJaNm+GqrOVNFzJC/Oj4ZmW5BQhqg1W9vbgbAL+9obzFIkxsPmeSNF
         StGdl/fAmHoFCjDzbbQMYu/LaNPi5CZ1NkeO32chycikHt2SIxed9vOMo/pWk2H3bx
         Ppq8LoM10XNpA==
References: <20210727185800.43796-1-mdevaev@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     gregkh@linuxfoundation.org, sandeen@redhat.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_hid: idle uses the highest byte for
 duration
In-reply-to: <20210727185800.43796-1-mdevaev@gmail.com>
Date:   Wed, 28 Jul 2021 09:31:02 +0300
Message-ID: <87mtq7t0ex.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Maxim Devaev <mdevaev@gmail.com> writes:

> SET_IDLE value must be shifted 8 bits to the right to get duration.
> This confirmed by USBCV test.
>
> Signed-off-by: Maxim Devaev <mdevaev@gmail.com>

with Greg's Fixes addition:

Acked-by: Felipe Balbi <balbi@kernel.org>

-- 
balbi
