Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195CC443E5F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhKCIaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230352AbhKCIaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:30:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3D8E60EB4;
        Wed,  3 Nov 2021 08:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635928061;
        bh=oHF2e/KmpSG5va0Ijp0HP/V8p2BNk44fMgv8UkXCN6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K0qm1lzGxnPxLyM2PyQuruubl0XBHxeVSAifIImVR9NBcbP7ZrX2JqWSInWhdVCT3
         /WC5emf/TBhIBa80Km7irBkV4pGE2/FcC0svwQcz8nchHIVQie9ItGEuxS4p20brO+
         MiRp0ncs9SPkePVpjJrrQchmy+Rr1BDblwcNWrFKit2iukq4JYaRzsYx0otVdo145Z
         wkoqTltqawRJrz6shxMVCBmmkv1L+mA4try6RhDwhIwNQlKg6g9obxQgLAooNWyQ1+
         9XqxO3eCIa7ElVKLAxKOuZKBcLl6A33GoD5ARYPSIYgTUZDsNQ3w9TJJnQUYq4raaO
         l1Vz7AH4ftpLA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1miBcU-0000hk-Cs; Wed, 03 Nov 2021 09:27:42 +0100
Date:   Wed, 3 Nov 2021 09:27:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Jing Yao <yao.jing2@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drivers: most: replace snprintf in show functions with
 sysfs_emit
Message-ID: <YYJH/lYLQJdM2H1p@hovoldconsulting.com>
References: <20211103082313.27570-1-yao.jing2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103082313.27570-1-yao.jing2@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 08:23:13AM +0000, cgel.zte@gmail.com wrote:
> From: Jing Yao <yao.jing2@zte.com.cn>
> 
> coccicheck complains about the use of snprintf() in sysfs show
> funcitons:
> WARNING use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf, snprintf or sprintf makes more
> sense.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>

Again, no need to include "drivers: " in the Subject, even if in this
case the single commit adding this file also got this wrong.

Johan
