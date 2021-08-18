Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF823F0466
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbhHRNOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233634AbhHRNOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:14:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E6FB61053;
        Wed, 18 Aug 2021 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629292427;
        bh=8IJq03RMdqeG/eCNav7p0tdBwUpOJakfrHP5oq/kqZA=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=EhJPN9uUxzFB727ikx0q/V0ZPA17Lodxq83IaXNr5HzZTYKp2V7fCnbKMZsW/5/qQ
         HoFSYQPlfkzQil2CzN0T+kqbBkXgGb3pWgMHWm+SXtJ1z2WU0AipoAYw1Ki9NcEjss
         hVZdKi8m5tU/rP8aWlD87FfV70pr0loUbWZCB2vpHdDq+/hX8R5b+3AiC6RJW9OmGR
         0994smDLpgUwOzc7gipILdX3XMT2W5h6syHRLq0ZLABkQyetgNU24ZrNZrBU7Tgr8D
         m0SVBJ3p+5jkktAGGBEcOGNEAJMF3OmzW7cuhAThn1Um14s6xZYcKVmQmygSACizYh
         LFSJoLwHoZXQA==
References: <20210818130135.575-1-lutovinova@ispras.ru>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Nadezda Lutovinova <lutovinova@ispras.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] usb: gadget: mv_u3d: Change functon call in mv_u3d_probe()
Date:   Wed, 18 Aug 2021 16:10:55 +0300
In-reply-to: <20210818130135.575-1-lutovinova@ispras.ru>
Message-ID: <87mtpegak8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

(first of all, your subject could be a little more descriptive,
something like:

	usb: gadget: mv_u3d: request_irq() after initializing UDC

as that would better detail what you're doing)

Nadezda Lutovinova <lutovinova@ispras.ru> writes:

> If IRQ occurs between calling  request_irq() and  mv_u3d_eps_init(),
> then null pointer dereference occurs since u3d->eps[] wasn't
> initialized yet but used in mv_u3d_nuke().
>
> The patch puts registration of the interrupt handler after
> initializing of neccesery data.
>
> Found by Linux Driver Verification project (linuxtesting.org).

this looks like an important bug fix, it probably deserves a stable tag
here. Which commit introduce this problem? Otherr than that, commits
looks good.

-- 
balbi
