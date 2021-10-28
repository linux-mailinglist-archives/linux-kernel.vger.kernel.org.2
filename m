Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAF443E85B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 20:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhJ1ShU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 14:37:20 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:56352 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1ShT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:37:19 -0400
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Oct 2021 14:37:18 EDT
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id BD8835F5;
        Thu, 28 Oct 2021 20:24:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wL4LvsFsFY4r; Thu, 28 Oct 2021 20:24:55 +0200 (CEST)
Received: from begin.home (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id A6521256;
        Thu, 28 Oct 2021 20:24:53 +0200 (CEST)
Received: from samy by begin.home with local (Exim 4.95)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1mgA55-00CyhS-Va;
        Thu, 28 Oct 2021 20:24:51 +0200
Date:   Thu, 28 Oct 2021 20:24:51 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Colin Ian King <colin.i.king@googlemail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speakup: Fix typo in documentation "boo" -> "boot"
Message-ID: <20211028182451.baizgvczghh37zfl@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Colin Ian King <colin.i.king@googlemail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211028182319.613315-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028182319.613315-1-colin.i.king@gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: hera
Authentication-Results: hera.aquilenet.fr;
        none
X-Rspamd-Queue-Id: BD8835F5
X-Spamd-Result: default: False [1.90 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         HAS_ORG_HEADER(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         FREEMAIL_TO(0.00)[googlemail.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_LAST(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         SUSPICIOUS_RECIPS(1.50)[]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King, le jeu. 28 oct. 2021 19:23:19 +0100, a ecrit:
> There is a typo in the speakup documentation. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

> ---
>  Documentation/admin-guide/spkguide.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/spkguide.txt b/Documentation/admin-guide/spkguide.txt
> index 977ab3f5a0a8..1265c1eab31c 100644
> --- a/Documentation/admin-guide/spkguide.txt
> +++ b/Documentation/admin-guide/spkguide.txt
> @@ -543,7 +543,7 @@ As mentioned earlier, Speakup can either be completely compiled into the
>  kernel, with the exception of the help module, or it can be compiled as
>  a series of modules.   When compiled as modules, Speakup will only be
>  able to speak some of the bootup messages if your system administrator
> -has configured the system to load the modules at boo time. The modules
> +has configured the system to load the modules at boot time. The modules
>  can  be loaded after the file systems have been checked and mounted, or
>  from an initrd.  There is a third possibility.  Speakup can be compiled
>  with some components built into the kernel, and others as modules.  As
> -- 
> 2.32.0
> 
