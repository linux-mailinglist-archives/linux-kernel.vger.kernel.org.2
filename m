Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41DB3568AC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350531AbhDGKDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:03:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:43624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350484AbhDGKC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:02:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617789766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TLGsEfIq3wKbs6ZbBvf+ZatbkwXb7TlSnPIiD3sLXOI=;
        b=aaEHV0JtLfkohjGyNyemPWMcejrDl8cZmSqYAC7wUgphMBhGElVzDVxa1Uetb87Fd8NkWx
        OgmhRX4z+MKtGy0wLKyTDnfUoI9y6zkvul4e5R2m41ZT3KuNS2agbVHSExoqUSz9uVuOSG
        yKjDC+dvh5uxFXFHeYohSCEZ6p2Yvb4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E1A2CB066;
        Wed,  7 Apr 2021 10:02:45 +0000 (UTC)
Date:   Wed, 7 Apr 2021 12:02:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Joe Perches <joe@perches.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Eric Biggers <ebiggers@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH V2 0/4] kernel/watchdog: Modify the explanation and doc
 related to watchdog thread
Message-ID: <YG2DRKf6YDApaH/1@alley>
References: <1617247900-23813-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617247900-23813-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-04-01 11:31:30, Wang Qing wrote:
> "watchdog/%u" threads has be replaced by cpu_stop_work. The current 
> description is extremely misleading, so we need to modify the 
> explanation and documentation related to this.
> 
> Wang Qing (4):
>   kernel: watchdog: Modify the explanation related to watchdog thread
>   doc: watchdog: Delete the explanation about "watchdog/%u".
>   doc: watchdog: Modify the explanation related to watchdog thread
>   doc: watchdog: Modify the doc related to "watchdog/%u"

All four patches make sense to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
