Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F854111D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 11:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhITJXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 05:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhITJXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:23:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D361B60F56;
        Mon, 20 Sep 2021 09:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632129729;
        bh=pgBWr3VMYg+9NOEyV+8YGWFEOP1xM+Mi1Kfav9tmjLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGfJaV93Sopa681fFkeEa1QDQ+FaomSpwOvZOEJBneQwcZVs8h2ksgiBNaY7ekcok
         pJKE/6rH/DtS5T1AyfJMiIGwE/Sm9bspYvzoj8auG+LW0Iy8yJqo3ZBjkYAV/8d4Qs
         /39BxIIiIjcf8Soxpf2bR0F3vLqK2x1m9NuT/XPOQ9XJJArb7J8hKNEMZNIWd0Lrqn
         bTm3v9xiZ3ox7U5nu3FajcCtxAYnHJHWqNEXK5qPoXet18NmetGsEv+H02mDcK7eZf
         w+BH+Vd32PjRkjwIlsoKuAYoBgU/MH76lyy71oNIaAvo5TydtEQ9CYGLneWgL8pOfb
         pvgCTWPbJiahw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mSFV2-0000kk-F4; Mon, 20 Sep 2021 11:22:08 +0200
Date:   Mon, 20 Sep 2021 11:22:08 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] USB: serial: option: remove duplicate USB device ID
Message-ID: <YUhSwKGEWMUILbXf@hovoldconsulting.com>
References: <20210917091849.18692-1-krzysztof.kozlowski@canonical.com>
 <20210917091849.18692-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917091849.18692-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 11:18:48AM +0200, Krzysztof Kozlowski wrote:
> The device ZTE 0x0094 is already on the list.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

I've picked up the two usb-serial patches in the series now. Thanks.

Johan
