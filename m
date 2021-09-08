Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166DD4031FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 02:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343725AbhIHAud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 20:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243920AbhIHAua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:50:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8EFC60F92;
        Wed,  8 Sep 2021 00:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631062163;
        bh=7Wrz7jbq4ZQpZbwmyQgxeFbh9DIedMdFxmZ4tupnR8g=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=loxhqFx2E6wvRf5U+77Vgq/G4KD4QYGjNxv/XXwguJR7h+SGcMNdeCalOVlWBVmlv
         XpxOnyIjCYt9iNy/57iu/a55l7C51KbUdnvtZqrf8owUP8ymQHDG5/8v6I9y/iqKNY
         2Rf/pUzL1rOqvX0AVjQX0rz4UvQ4jlhnBPXO5zEVnwSZezdW8uLbTh9tv9pXTXtqam
         5CbGn/QNfcrdITpjLzz71QHXWDUfIXt98Ln6hHjz9PJdrlzA8yokvcxNB1M37+gZzx
         YdyMRfDizU/B1oCc1Vg/7S3x3J97fGgH9rBTDpNXNERBLNINInx5C4/DFrzXpKGjTK
         yMstLYGXAQWIA==
Date:   Tue, 7 Sep 2021 17:49:21 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Jan Beulich <jbeulich@suse.com>
cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] xen/pvcalls: backend can be a module
In-Reply-To: <54a6070c-92bb-36a3-2fc0-de9ccca438c5@suse.com>
Message-ID: <alpine.DEB.2.21.2109071745270.14059@sstabellini-ThinkPad-T480s>
References: <54a6070c-92bb-36a3-2fc0-de9ccca438c5@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2021, Jan Beulich wrote:
> It's not clear to me why only the frontend has been tristate. Switch the
> backend to be, too.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Actually although the frontend is a tristate, it cannot really work as a
module. Specifically see pvcalls_stream_ops in the enabling patch (still
not upstream):

https://github.com/lf-edge/runx/blob/master/kernel/patches/0001-patch-pvcalls_enable.patch


So I had to change tristate to bool for XEN_PVCALLS_FRONTEND in our
internal kernel tree.

That said, the PVCalls backend could very well be a module and
technically I don't see any reasons why not. So:


Acked-by: Stefano Stabellini <sstabellini@kernel.org>



> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -214,7 +214,7 @@ config XEN_PVCALLS_FRONTEND
>  	  implements them.
>  
>  config XEN_PVCALLS_BACKEND
> -	bool "XEN PV Calls backend driver"
> +	tristate "XEN PV Calls backend driver"
>  	depends on INET && XEN && XEN_BACKEND
>  	help
>  	  Experimental backend for the Xen PV Calls protocol
> 
