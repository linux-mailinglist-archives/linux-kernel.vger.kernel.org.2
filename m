Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F59C3DB8F6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 14:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbhG3NAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:00:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35028 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbhG3NAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:00:00 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8596D22439;
        Fri, 30 Jul 2021 12:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627649994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AI0V//2zVsMuZfneHsqsJSM47qAEWrYYFG5ZTnS57nQ=;
        b=jCTDWOnB11Qu+LiY9hT/SMCuSYWu8qF4qe5iDT0gqwp2nvpINvd5P1Fa34BkVHSTBakZv2
        umylYmr1i17mOqKDiIZeXln+s4a+yoGl0AzjAEGEflSTDnngkIRJ5wf6Wgpwjl4SLbMIsR
        azpPdj4M7JIqNTAHIOQff/Jtxxns/k0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627649994;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AI0V//2zVsMuZfneHsqsJSM47qAEWrYYFG5ZTnS57nQ=;
        b=oz7qRTux81XL/3fBk68FzWDX3UjutEyewmRo3uC5rDLJaOFGpya7p7qed2d0CIn/BCJvN5
        apxGpS1vcA6z0yCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 396C1137E1;
        Fri, 30 Jul 2021 12:59:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id dM2yC8r3A2HDXwAAGKfGzw
        (envelope-from <jdelvare@suse.de>); Fri, 30 Jul 2021 12:59:54 +0000
Date:   Fri, 30 Jul 2021 14:59:53 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: drivers/firmware/dmi_scan.c:151:9: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <20210730145953.43308750@endymion>
In-Reply-To: <20210729164533.48fed217@endymion>
References: <202107242204.IbnaQfeL-lkp@intel.com>
        <81c31d99-82dc-feb6-1213-2b2fbae7c867@loongson.cn>
        <20210729164533.48fed217@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2021 16:45:33 +0200, Jean Delvare wrote:
> On Mon, 26 Jul 2021 20:53:42 +0800, Tiezhu Yang wrote:
> > I think the following change can make the above warning silent:
> > 
> > diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> > index f191a1f..9e254d9 100644
> > --- a/drivers/firmware/dmi_scan.c
> > +++ b/drivers/firmware/dmi_scan.c
> > @@ -148,7 +148,7 @@ static int __init dmi_walk_early(void 
> > (*decode)(const struct dmi_header *,
> > 
> >          add_device_randomness(buf, dmi_len);
> > 
> > -       dmi_early_unmap(buf, orig_dmi_len);
> > +       dmi_early_unmap((u8 __iomem *)buf, orig_dmi_len);
> >          return 0;
> >   }
> > 
> > If it is OK, I can send a patch later.  
> 
> Explicit pointer casting is almost always the wrong way to make
> warnings go away. I can't confirm because I'm not able to get sparse to
> work at the moment, but more likely the correct fix would be something
> along the lines of:
> 
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -137,7 +137,7 @@ static phys_addr_t dmi_base;
>  static int __init dmi_walk_early(void (*decode)(const struct dmi_header *,
>  		void *))
>  {
> -	u8 *buf;
> +	u8 __iomem *buf;
>  	u32 orig_dmi_len = dmi_len;
>  
>  	buf = dmi_early_remap(dmi_base, orig_dmi_len);
> @@ -754,7 +754,7 @@ static BIN_ATTR(DMI, S_IRUSR, raw_table_
>  static int __init dmi_init(void)
>  {
>  	struct kobject *tables_kobj;
> -	u8 *dmi_table;
> +	u8 __iomem *dmi_table;
>  	int ret = -ENOMEM;
>  
>  	if (!dmi_available)
> @@ -1101,7 +1101,7 @@ EXPORT_SYMBOL(dmi_get_bios_year);
>  int dmi_walk(void (*decode)(const struct dmi_header *, void *),
>  	     void *private_data)
>  {
> -	u8 *buf;
> +	u8 __iomem *buf;
>  
>  	if (!dmi_available)
>  		return -ENXIO;
> 
> (Note sure why there are only 2 sparse warnings when the same issue is
> present 3 times in the file.)
> 

I took a deeper look at the code. There's currently no easy way to fix
these sparse warnings because different architectures have different
prototypes for dmi_early_remap() and dmi_early_unmap(). Some have
__iomem and some do not. So, for the time being, fixing warnings on
some architectures would introduce new warnings on other architectures.

I'd rather leave the code as is until this is sorted out (if it can be).

-- 
Jean Delvare
SUSE L3 Support
