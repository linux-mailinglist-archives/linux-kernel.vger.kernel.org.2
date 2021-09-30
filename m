Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB8F41D9AA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349850AbhI3MVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:21:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60730 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349818AbhI3MVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:21:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2CACD1FD57;
        Thu, 30 Sep 2021 12:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633004403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nHxpXHCLxzXUq4zLBCcv7SDB8+nncA+x6uOxbV4M+B8=;
        b=jK2Swl5vnnBAg2JdG0Y2dm+M4VBJyPGXtGg2FOE/aHvXj+rnYx8nU/LDox61hjF5TcdHvg
        LX9OrPeGrXdyoldwPciWQMZ1e0Zoct+7QjqjRM0DJ184zaXhqZHEbjyJfMwvxmBFCWOOuZ
        jDBl2QxgrGz1HDjxMzmRt3BhrJdQvtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633004403;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nHxpXHCLxzXUq4zLBCcv7SDB8+nncA+x6uOxbV4M+B8=;
        b=2QBy2wo1aEPLiGUrFdtZ/4DjAFD23rboJEUvYhbbv3tbgAYdAEyUhhRe9K/p0Pw3ZUx/Vy
        r4SZQz8EU38VoZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C6F013B05;
        Thu, 30 Sep 2021 12:20:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RKXpBnOrVWGYNwAAMHmgww
        (envelope-from <bp@suse.de>); Thu, 30 Sep 2021 12:20:03 +0000
Date:   Thu, 30 Sep 2021 14:19:54 +0200
From:   Borislav Petkov <bp@suse.de>
To:     unknown <weidonghui@allwinnertech.com>
Cc:     akpm@linux-foundation.org, maz@misterjones.org, will@kernel.org,
        rabin@rab.in, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scripts/decodecode: fix faulting instruction no print
 when opps.file is DOS format
Message-ID: <YVWrahfHnM95cHy+@zn.tnic>
References: <20210930020439.3605-1-weidonghui@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210930020439.3605-1-weidonghui@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 10:04:39AM +0800, unknown wrote:
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

You don't just add Signed-off-by of other people when sending a patch -
please don't *ever* do that.

If you don't know what you're doing, *don't* do it but *read* the damn
docs first:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> Cc: Marc Zyngier <maz@misterjones.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Rabin Vincent <rabin@rab.in>
> Cc: lkml <linux-kernel@vger.kernel.org>
> Signed-off-by: weidonghui <weidonghui@allwinnertech.com>
> ---
>  scripts/decodecode | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/decodecode b/scripts/decodecode
> index 31d884e35f2f..77a3b518aacc 100755
> --- a/scripts/decodecode
> +++ b/scripts/decodecode
> @@ -126,7 +126,7 @@ if [ $marker -ne 0 ]; then
>  fi
>  echo Code starting with the faulting instruction  > $T.aa
>  echo =========================================== >> $T.aa
> -code=`echo $code | sed -e 's/ [<(]/ /;s/[>)] / /;s/ /,0x/g; s/[>)]$//'`
> +code=`echo $code | sed -e 's/\x0d//;s/ [<(]/ /;s/[>)] / /;s/ /,0x/g; s/[>)]$//'`

So that link I pointed you to says:

"That character is matched with \r by sed. Use:

sed -e "s/\r//g" input-file"

I have no clue how you did not see it?!

But I guess \x0d works too.

To quote from the sed info manual:

"5.8 Escape Sequences - specifying special characters
 ====================================================

 ...

'\r'
     Produces or matches a carriage return (ASCII 13).

...

'\xXX'
     Produces or matches a character whose hexadecimal ASCII value is
     XX."

In any case, I'd prefer \r because it is more readable.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
