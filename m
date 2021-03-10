Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E85A3346DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhCJSdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 13:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhCJSdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:33:37 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692D6C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=LfVlUlw5suK4W8vYwc+2GNun5VrRntz8pvlKBIYi2Kw=; b=yZN3F8NNy4k/sX42ljAYq1kB6D
        gZ+4CdOERAit6VrckPxwZQCwVL3IunN+jj6eB8MZ5UmtpqZTZVH+PIgUbTaGgsJxd49GCa+rl/4dv
        SMB8ndi75P4Jz5tf4GlEFPiHL2wE6q1aj8XyiCfLwwSKXLp58m65tKGTCWw1gx9qEN28J8RRkfe1b
        Ov8lYlasgKi64b4JCWwOEMy/yiHnkBodQLXgXDmRtTjCon4cA2/vO6PPQrwGOYCxktpC9SewSGfLx
        7o0C2PhyHx1SSXVN+ikG4Q1w6k8DBzjvJIkY0EZ3InNoW+YA7QuRA5E4HvDxswfEVj7hJDM2406Gt
        lqsq4OKw==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lK3eG-000q51-7u; Wed, 10 Mar 2021 18:33:32 +0000
Subject: Re: [PATCH] docs: don't include Documentation/Kconfig twice
To:     Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>
References: <20210307140018.757576-1-slyfox@gentoo.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fc2a235f-01bd-e00b-5459-d903e03b3ed8@infradead.org>
Date:   Wed, 10 Mar 2021 10:33:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210307140018.757576-1-slyfox@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/21 6:00 AM, Sergei Trofimovich wrote:
> Before the change there were two inclusions of Documentation/Kconfig:
>     lib/Kconfig.debug:source "Documentation/Kconfig"
>     Kconfig: source "Documentation/Kconfig"
> 
> Kconfig also included 'source "lib/Kconfig.debug"'.
> 
> Noticed as two 'make menuconfig' entries in both top level menu
> and in 'Kernel hacking' menu. The patch keeps entries only in
> 'Kernel hacking'.
> 
> CC: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> CC: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>

Hi,
OK, it shouldn't be there in 2 places.

The current usage is good under Kernel Hacking (development),
but I can easily foresee cases where we would want user-selectable
Documentation/Kconfig options, so IMO it would be better to be
more independent (i.e., not in lib/Kconfig.debug).

Anyway, for either way that it's fixed:

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Kconfig b/Kconfig
> index 745bc773f567..97ed6389c921 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -28,5 +28,3 @@ source "crypto/Kconfig"
>  source "lib/Kconfig"
>  
>  source "lib/Kconfig.debug"
> -
> -source "Documentation/Kconfig"
> 

thanks.
-- 
~Randy

