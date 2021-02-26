Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C520C3265AD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhBZQjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhBZQjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:39:02 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309C9C061574;
        Fri, 26 Feb 2021 08:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=cJovxi5fmivlMzTNFK7Hd5WeerVzqJFBxjTpoKstnCE=; b=XZPpJxh2rt+EtM7F9/8orkDvql
        c48+bn9P+Jx5tgPDS4YA2jYTdMgNUCFYmV5RMiQObH8/i0ZqpsYdVjBKY9gfk79xNxj4MwkTLjOv1
        TtHkJePZ+d+Tzo8AR76MvgknBWL4+NMIifuapua/lzBY8/14zFcRXEidPhikakfSVICX92+ksNN8y
        BB0KL/7QxTEyx4+5q9XgBH0Avk7KlWqaqQVyQ7zGR5AEGO9/l2JOvk3PLVJ1Il9x1UM620k592pMk
        gOPQ27t1MMFBnZzjAguz92FFIR89l9ITBBBHnWhuaWSCHFdksr2vNCG5yDA9l+nbkuifjAMQXgvWX
        DL2rf+kw==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lFg80-0004FD-MQ; Fri, 26 Feb 2021 16:38:09 +0000
Subject: Re: [PATCH -next] fbdev: atyfb: use LCD management functions for
 PPC_PMAC also
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <20210226000537.8674-1-rdunlap@infradead.org>
 <YDjlkzg7/qnPBIKI@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <03364ba0-8266-99e5-9315-34d8820e8732@infradead.org>
Date:   Fri, 26 Feb 2021 08:38:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDjlkzg7/qnPBIKI@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/21 4:12 AM, Ville Syrjälä wrote:
> On Thu, Feb 25, 2021 at 04:05:37PM -0800, Randy Dunlap wrote:
>> Include PPC_PMAC in the configs that use aty_ld_lcd() and
>> aty_st_lcd() implementations so that the PM code may work
>> correctly for PPC_PMAC.
>>
>> Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Cc: linux-fbdev@vger.kernel.org
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Cc: Sam Ravnborg <sam@ravnborg.org>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>> ---
>> Daniel- We also need this patch:
>> https://lore.kernel.org/dri-devel/20210224215528.822-1-rdunlap@infradead.org/
>> to fix a kernel test robot build error.
>>
>>  drivers/video/fbdev/aty/atyfb_base.c |    8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> --- linux-next-20210219.orig/drivers/video/fbdev/aty/atyfb_base.c
>> +++ linux-next-20210219/drivers/video/fbdev/aty/atyfb_base.c
>> @@ -132,8 +132,7 @@
>>  #define PRINTKI(fmt, args...)	printk(KERN_INFO "atyfb: " fmt, ## args)
>>  #define PRINTKE(fmt, args...)	printk(KERN_ERR "atyfb: " fmt, ## args)
>>  
>> -#if defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_GENERIC_LCD) || \
>> -defined(CONFIG_FB_ATY_BACKLIGHT)
>> +#if defined(CONFIG_PPC_PMAC)
> 
> Did you send an old version by accident? That's definitely
> not what we want since it would break everything except PPC_PMAC.


Yikes!

Yes, thanks for catching that.
I'll get the newer version out soon.

>>  static const u32 lt_lcd_regs[] = {
>>  	CNFG_PANEL_LG,
>>  	LCD_GEN_CNTL_LG,
>> @@ -175,8 +174,7 @@ u32 aty_ld_lcd(int index, const struct a
>>  		return aty_ld_le32(LCD_DATA, par);
>>  	}
>>  }
>> -#else /* defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_BACKLIGHT) \
>> -	 defined(CONFIG_FB_ATY_GENERIC_LCD) */
>> +#else /* defined(CONFIG_PPC_PMAC) */
>>  void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
>>  { }
>>  
>> @@ -184,7 +182,7 @@ u32 aty_ld_lcd(int index, const struct a
>>  {
>>  	return 0;
>>  }
>> -#endif /* defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) */
>> +#endif /* defined(CONFIG_PPC_PMAC) */
>>  
>>  #ifdef CONFIG_FB_ATY_GENERIC_LCD
>>  /*
> 


-- 
~Randy

